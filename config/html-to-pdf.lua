-- Pandoc Lua filter for the StorePulse report PDF export (Pandoc + Typst).
-- Runs in six passes:
--   1. html:     converts the HTML embedded in the .md files (img, table, br, page breaks) to Pandoc elements.
--   2. center:   renders <div align="center"> blocks (cover) as centered Typst content.
--   3. document: replaces the manual index with the automatic outline, normalizes heading levels
--                from their numbering and adds page breaks before level 1 headings.
--   4. split:    turns images that share lines with text into numbered figures.
--   5. media:    fixes figures (captions, size, landscape pages, local PlantUML SVG) and table column widths.
--   6. landscape: puts top-level paragraphs that hold only one wide image on a landscape page.

local stringify = pandoc.utils.stringify

-- Page layout (A4, 2.5 cm margins), used to size images and tables.
local TEXT_WIDTH_CM = 16.0
local MAX_IMAGE_HEIGHT_CM = 19.0

-- Images at least this wide (px) and with at least this width/height ratio go on a landscape page.
local LANDSCAPE_MIN_WIDTH_PX = 1600
local LANDSCAPE_MIN_RATIO = 2.0

-- Table column rules.
local MIN_COLUMN = 0.08
local PHOTO_COLUMN = 0.18
local PHOTO_WIDTH = "2.4cm"
local PHOTO_HEIGHT = "3cm"
local SMALL_FONT_FROM_COLUMNS = 6

-- Must match resource-path in build.yaml.
local RESOURCE_DIRS = { ".", "docs", "docs/front-matter" }

-- Defined in pass 5, also used by pass 2.
local is_landscape

local function is_html(fmt)
  return fmt == "html" or fmt == "html5"
end

local function typst(text)
  return pandoc.RawBlock("typst", text)
end

local function pagebreak()
  return typst("#pagebreak(weak: true)")
end

local function file_exists(path)
  local f = io.open(path, "rb")
  if f then f:close() return true end
  return false
end

-- Resolves a relative image path the same way Pandoc does with resource-path.
local function resolve(src)
  for _, dir in ipairs(RESOURCE_DIRS) do
    local path = pandoc.path.normalize(pandoc.path.join({ dir, src }))
    if file_exists(path) then return path end
  end
  return nil
end

local function read_file(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local data = f:read("a")
  f:close()
  return data
end

-- Returns width and height in px of a local image, or nil.
local function image_size(src)
  if src:match("^https?://") then return nil end
  local path = resolve(src)
  if not path then return nil end
  local data = read_file(path)
  if not data then return nil end
  if path:lower():match("%.svg$") then
    local w, h = data:match('width="(%d+)p?x?"%s+[^>]-height="(%d+)p?x?"')
    if not w then w, h = data:match("width:(%d+)px;height:(%d+)px") end
    if w then return tonumber(w), tonumber(h) end
    return nil
  end
  local ok, size = pcall(pandoc.image.size, data)
  if ok and size and size.width and size.height then
    return size.width, size.height
  end
  return nil
end

---------------------------------------------------------------------------
-- Pass 1: embedded HTML
---------------------------------------------------------------------------

local function img_from_tag(tag)
  local src = tag:match('src%s*=%s*"([^"]+)"')
  if not src then return nil end
  local alt = tag:match('alt%s*=%s*"([^"]*)"') or ""
  local attrs = {}
  local width = tag:match('width%s*=%s*"([^"]+)"')
  if width and width ~= "auto" then
    if not width:match("%%$") and not width:match("px$") then width = width .. "px" end
    attrs.width = width
  end
  return pandoc.Image(alt, src, "", pandoc.Attr("", {}, attrs))
end

local html_pass = {
  RawInline = function(el)
    if not is_html(el.format) then return nil end
    local t = el.text
    if t:match("^<br") then return pandoc.LineBreak() end
    if t:match("^<img") then return img_from_tag(t) end
    return {}
  end,

  RawBlock = function(el)
    if not is_html(el.format) then return nil end
    local t = el.text
    if t:match("page%-break") or t:match('class="page"') then
      return pagebreak()
    end
    if t:match("^%s*<!%-%-") then return {} end
    return pandoc.read(t, "html").blocks
  end,
}

---------------------------------------------------------------------------
-- Pass 2: centered blocks (cover)
---------------------------------------------------------------------------

local center_pass = {
  Div = function(el)
    local style = el.attributes.style or ""
    if style:match("page%-break") or el.classes:includes("page") then
      return pagebreak()
    end
    if el.attributes.align == "center" then
      -- A centered wide image (wireflows, user flows) gets its own landscape page.
      local images = {}
      for _, b in ipairs(el.content) do
        local img = nil
        if b.t == "Para" or b.t == "Plain" then
          for _, il in ipairs(b.content) do
            if il.t == "Image" and not img then img = il
            elseif il.t ~= "Space" and il.t ~= "SoftBreak" and il.t ~= "LineBreak" then img = false break end
          end
        end
        if not img then images = nil break end
        table.insert(images, img)
      end
      if images and #images > 0 and is_landscape(images[1]) then
        local out = {}
        for _, img in ipairs(images) do
          img.attributes.width = "100%"
          img.classes:insert("landscape")
          table.insert(out, typst("#page(flipped: true)[#align(center)["))
          table.insert(out, pandoc.Plain({ img }))
          table.insert(out, typst("]]"))
        end
        return out
      end
      local blocks = el.content:walk({
        Header = function(h) return pandoc.Para({ pandoc.Strong(h.content) }) end
      })
      local out = { typst("#align(center)[") }
      for _, b in ipairs(blocks) do table.insert(out, b) end
      table.insert(out, typst("]"))
      return out
    end
  end,
}

---------------------------------------------------------------------------
-- Pass 3: index, heading levels and page breaks
---------------------------------------------------------------------------

local function is_chapter_title(text)
  local lower = pandoc.text.lower(text)
  return lower:match("^capítulo") ~= nil or lower:match("^capitulo") ~= nil
end

-- "4.2.4.1. Domain Layer" -> 4 (one level per number); nil when the title is not numbered.
local function numbering_depth(text)
  local num = text:match("^(%d+%.%d+[%.%d]*)")
  if not num then return nil end
  local depth = 0
  for _ in num:gmatch("%d+") do depth = depth + 1 end
  return depth
end

local function clamp(level)
  if level < 1 then return 1 end
  if level > 6 then return 6 end
  return level
end

-- Blocks of the manual index in 04-content.md that are dropped after the "Contenido" title.
local function is_manual_index_block(b)
  if b.t == "BulletList" or b.t == "OrderedList" then return true end
  if (b.t == "Para" or b.t == "Plain") and stringify(b):match("^%s*$") then return true end
  if b.t == "RawBlock" and b.format == "typst" and b.text:match("pagebreak") then return true end
  return false
end

local document_pass = {
  Pandoc = function(doc)
    local out = pandoc.Blocks({})
    local skipping_index = false
    local seen_chapter = false
    local in_annex = false
    local annex_shift = 0
    local last = nil -- { orig = level in the .md, new = normalized level } of the last numbered title

    for _, b in ipairs(doc.blocks) do
      if skipping_index and is_manual_index_block(b) then
        goto continue
      end
      skipping_index = false

      if b.t == "Header" then
        local text = stringify(b)
        local orig = b.level
        local depth = numbering_depth(text)

        if text == "Contenido" then
          out:insert(pagebreak())
          out:insert(typst('#outline(title: "Contenido", depth: 3)'))
          out:insert(typst("#pagebreak()"))
          skipping_index = true
          goto continue
        elseif is_chapter_title(text) then
          b.level = 1
          seen_chapter = true
          in_annex = false
        elseif text == "Anexos" then
          b.level = 1
          in_annex = true
          annex_shift = 0
        elseif in_annex then
          if text:match("^Anexo") then
            annex_shift = 2 - orig
          end
          b.level = clamp(orig + annex_shift)
        elseif depth then
          b.level = clamp(depth)
        elseif not seen_chapter then
          b.level = clamp(orig - 1)
        elseif orig == 1 then
          b.level = 1
        elseif last then
          b.level = clamp(last.new + math.max(1, orig - last.orig))
        end

        if not in_annex or text:match("^Anexo") or text == "Anexos" then
          if depth or b.level == 1 then
            last = { orig = orig, new = b.level }
          end
        end

        if b.level == 1 then
          out:insert(pagebreak())
        end
      end

      out:insert(b)
      ::continue::
    end

    doc.blocks = out
    return doc
  end,
}

---------------------------------------------------------------------------
-- Pass 4: figures, images and tables
---------------------------------------------------------------------------

-- Remote PlantUML diagrams are replaced by the SVG generated next to each .puml file.
local function local_plantuml(src)
  if not src:match("plantuml%.com") then return nil end
  local rel = src:match("assets/architecture/(.-)%.puml")
  if not rel then return nil end
  local svg = "../../assets/architecture/" .. rel .. ".svg"
  if resolve(svg) then return svg end
  return nil
end

local function clean_caption(text)
  if text:lower():match("%.png%s*$") or text:lower():match("%.jpe?g%s*$")
     or text:lower():match("%.svg%s*$") or text:lower():match("%.gif%s*$") then
    return ""
  end
  local stripped = text:gsub("^%s*[Ff]igura%s+%d+%s*[%.:%-]?%s*", "")
  return stripped
end

local function fix_image(img)
  local svg = local_plantuml(img.src)
  if svg then img.src = svg end
  return img
end

-- Keeps a tall image and its caption on one page.
local function limit_height(img)
  if img.attributes.width or img.attributes.height then return img end
  local w, h = image_size(img.src)
  if not w then return img end
  local full_width_height_cm = TEXT_WIDTH_CM * h / w
  if full_width_height_cm > MAX_IMAGE_HEIGHT_CM and h >= 700 then
    img.attributes.height = string.format("%.0fcm", MAX_IMAGE_HEIGHT_CM)
  end
  return img
end

is_landscape = function(img)
  local width = img.attributes.width
  if (width and width ~= "100%") or img.attributes.height then return false end
  local w, h = image_size(img.src)
  if not w then return false end
  return w >= LANDSCAPE_MIN_WIDTH_PX and (w / h) >= LANDSCAPE_MIN_RATIO
end

local function figure_image(fig)
  local found = nil
  fig.content:walk({ Image = function(i) found = found or i end })
  return found
end

-- Splits a paragraph where an image shares lines with text, so the image becomes a numbered figure.
local function split_para(para)
  local has_image, has_text = false, false
  for _, il in ipairs(para.content) do
    if il.t == "Image" then has_image = true
    elseif il.t ~= "SoftBreak" and il.t ~= "LineBreak" and il.t ~= "Space" then has_text = true end
  end
  if not (has_image and has_text) then return nil end

  local lines, current = {}, pandoc.Inlines({})
  for _, il in ipairs(para.content) do
    if il.t == "SoftBreak" or il.t == "LineBreak" then
      table.insert(lines, current)
      current = pandoc.Inlines({})
    else
      current:insert(il)
    end
  end
  table.insert(lines, current)

  local out, text = {}, pandoc.Inlines({})
  local function flush()
    if #text > 0 then table.insert(out, pandoc.Para(text)) end
    text = pandoc.Inlines({})
  end
  local split = false
  for _, line in ipairs(lines) do
    local only_image = #line == 1 and line[1].t == "Image"
    if only_image then
      flush()
      local img = line[1]
      table.insert(out, pandoc.Figure(pandoc.Plain({ img }), { pandoc.Plain(img.caption) }))
      split = true
    else
      if #text > 0 then text:insert(pandoc.SoftBreak()) end
      text:extend(line)
    end
  end
  flush()
  if not split then return nil end
  return out
end

-- Typst reads "(" or "[" right after #emph[...] or #strong[...] as a function call; escape it.
local function escape_after_markup(inlines)
  local out = pandoc.Inlines({})
  for i, il in ipairs(inlines) do
    local prev = inlines[i - 1]
    if il.t == "Str" and prev and (prev.t == "Emph" or prev.t == "Strong")
       and (il.text:sub(1, 1) == "(" or il.text:sub(1, 1) == "[") then
      out:insert(pandoc.RawInline("typst", "\\" .. il.text:sub(1, 1)))
      if #il.text > 1 then out:insert(pandoc.Str(il.text:sub(2))) end
    else
      out:insert(il)
    end
  end
  return out
end

-- Column widths -----------------------------------------------------------

local function cell_text(cell)
  return stringify(cell.contents)
end

-- A photo cell holds one image and no text (the image alt text does not count).
local function cell_is_photo(cell)
  local images = 0
  cell.contents:walk({ Image = function() images = images + 1 end })
  local text = stringify(cell.contents:walk({ Image = function() return {} end })):gsub("%s", "")
  return images == 1 and text == ""
end

local function longest_word(text)
  local longest = 0
  for word in text:gmatch("%S+") do
    local n = utf8.len(word) or #word
    if n > longest then longest = n end
  end
  return math.min(longest, 25)
end

local function all_rows(tbl)
  local rows = {}
  for _, row in ipairs(tbl.head.rows) do table.insert(rows, { row = row, head = true }) end
  for _, body in ipairs(tbl.bodies) do
    for _, row in ipairs(body.head) do table.insert(rows, { row = row, head = true }) end
    for _, row in ipairs(body.body) do table.insert(rows, { row = row, head = false }) end
  end
  return rows
end

local function compute_widths(tbl, ncols, small_font)
  local char_cm = small_font and 0.15 or 0.17
  local pad_cm = 0.45
  local total_len, samples, word, photo_cells, body_cells = {}, {}, {}, {}, {}
  for j = 1, ncols do
    total_len[j], samples[j], word[j], photo_cells[j], body_cells[j] = 0, 0, 0, 0, 0
  end

  for _, r in ipairs(all_rows(tbl)) do
    local j = 1
    for _, cell in ipairs(r.row.cells) do
      if j > ncols then break end
      local text = cell_text(cell)
      local len = math.min(utf8.len(text) or #text, 600)
      total_len[j] = total_len[j] + len
      samples[j] = samples[j] + 1
      word[j] = math.max(word[j], longest_word(text))
      if not r.head then
        body_cells[j] = body_cells[j] + 1
        if cell_is_photo(cell) then photo_cells[j] = photo_cells[j] + 1 end
      end
      j = j + (cell.col_span or 1)
    end
  end

  local widths, fixed, score, minimum, long_text, photo_column = {}, {}, {}, {}, {}, {}
  for j = 1, ncols do
    local avg = samples[j] > 0 and total_len[j] / samples[j] or 1
    long_text[j] = avg > 60
    score[j] = math.sqrt(math.max(avg, 1))
    minimum[j] = math.min(math.max(MIN_COLUMN, (word[j] * char_cm + pad_cm) / TEXT_WIDTH_CM), 0.35)
    -- Only a column made of photos alone (team profiles) is a photo column;
    -- a screenshot inside a text column (interview evidence) keeps its own size.
    photo_column[j] = body_cells[j] > 0 and photo_cells[j] == body_cells[j]
    if photo_column[j] then
      widths[j], fixed[j] = PHOTO_COLUMN, true
    end
  end

  -- Gives each free column a share of the remaining width by score, never below its minimum.
  for _ = 1, ncols do
    local remaining, score_sum = 1.0, 0
    for j = 1, ncols do
      if fixed[j] then remaining = remaining - widths[j] else score_sum = score_sum + score[j] end
    end
    if score_sum == 0 then break end
    local changed = false
    for j = 1, ncols do
      if not fixed[j] then
        widths[j] = remaining * score[j] / score_sum
        if widths[j] < minimum[j] then
          widths[j], fixed[j], changed = minimum[j], true, true
        end
      end
    end
    if not changed then break end
  end

  local sum = 0
  for j = 1, ncols do sum = sum + widths[j] end
  for j = 1, ncols do widths[j] = widths[j] / sum end
  return widths, photo_column, long_text
end

-- Short tables without explicit widths already look right with Typst automatic columns.
local function keeps_auto_width(tbl)
  for _, spec in ipairs(tbl.colspecs) do
    if type(spec[2]) == "number" and spec[2] > 0 then return false end
  end
  for _, r in ipairs(all_rows(tbl)) do
    for _, cell in ipairs(r.row.cells) do
      local text = cell_text(cell)
      if (utf8.len(text) or #text) >= 60 or cell_is_photo(cell) then return false end
    end
  end
  return true
end

local function fix_table(tbl)
  local ncols = #tbl.colspecs
  if ncols < 2 or keeps_auto_width(tbl) then return nil end
  local small_font = ncols >= SMALL_FONT_FROM_COLUMNS
  local widths, photo_column, long_text = compute_widths(tbl, ncols, small_font)

  -- Long text reads better left aligned than centered.
  for j = 1, ncols do
    local align = tbl.colspecs[j][1]
    if long_text[j] then align = "AlignLeft" end
    tbl.colspecs[j] = { align, widths[j] }
  end

  -- Photos of a photo column get the same size, cropped to fill it.
  for j = 1, ncols do
    if photo_column[j] then
      for _, body in ipairs(tbl.bodies) do
        for _, row in ipairs(body.body) do
          local cell = row.cells[j]
          if cell and cell_is_photo(cell) then
            cell.contents = cell.contents:walk({
              Image = function(img)
                img.attributes.width = PHOTO_WIDTH
                img.attributes.height = PHOTO_HEIGHT
                return img
              end
            })
          end
        end
      end
    end
  end

  if small_font then
    return { typst("#[#set text(size: 8pt)"), tbl, typst("]") }
  end
  return tbl
end

-- A paragraph holding only one wide image (e.g. <p align="center"><img></p>) gets a landscape page.
local function landscape_block(block)
  local img = nil
  for _, il in ipairs(block.content) do
    if il.t == "Image" and not img then img = il
    elseif il.t ~= "Space" and il.t ~= "SoftBreak" and il.t ~= "LineBreak" then return nil end
  end
  if not img or img.classes:includes("landscape") or not is_landscape(img) then return nil end
  img.attributes.width = "100%"
  img.classes:insert("landscape")
  return { typst("#page(flipped: true)[#align(center)["), pandoc.Plain({ img }), typst("]]") }
end

local split_pass = {
  Para = split_para,
}

local media_pass = {
  Inlines = escape_after_markup,

  Image = fix_image,

  Figure = function(fig)
    local img = figure_image(fig)
    if not img then return nil end

    local caption = clean_caption(stringify(fig.caption.long))
    if caption == "" then
      fig.caption = { long = pandoc.Blocks({}) }
    else
      fig.caption = { long = pandoc.Blocks({ pandoc.Plain(pandoc.Inlines(caption)) }) }
    end

    if is_landscape(img) then
      fig.content = fig.content:walk({
        Image = function(i) i.attributes.width = "100%" return i end
      })
      return { typst("#page(flipped: true)["), fig, typst("]") }
    end

    fig.content = fig.content:walk({ Image = limit_height })
    return fig
  end,

  Table = fix_table,
}

-- Only top-level paragraphs: Typst does not allow a page inside a container (table, list, align).
local landscape_pass = {
  Pandoc = function(doc)
    local out = pandoc.Blocks({})
    for _, b in ipairs(doc.blocks) do
      local replaced = (b.t == "Para" or b.t == "Plain") and landscape_block(b) or nil
      if replaced then out:extend(replaced) else out:insert(b) end
    end
    doc.blocks = out
    return doc
  end,
}

return { html_pass, center_pass, document_pass, split_pass, media_pass, landscape_pass }
