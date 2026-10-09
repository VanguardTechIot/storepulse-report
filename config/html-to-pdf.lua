-- Convierte el HTML incrustado en los .md (imágenes, tablas, saltos de página)
-- a elementos nativos de Pandoc, para que no se pierdan al exportar a PDF.

local function is_html(fmt)
  return fmt == "html" or fmt == "html5"
end

local function pagebreak()
  return pandoc.RawBlock("typst", "#pagebreak(weak: true)")
end

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

function RawInline(el)
  if not is_html(el.format) then return nil end
  local t = el.text
  if t:match("^<br") then return pandoc.LineBreak() end
  if t:match("^<img") then return img_from_tag(t) end
  return {}
end

function RawBlock(el)
  if not is_html(el.format) then return nil end
  local t = el.text
  if t:match("page%-break") or t:match('class="page"') then
    return pagebreak()
  end
  if t:match("^%s*<!%-%-") then return {} end
  return pandoc.read(t, "html").blocks
end

-- Cada archivo empieza en página nueva (capítulos de primer nivel)
function Header(el)
  if el.level == 1 then
    return { pagebreak(), el }
  end
end

-- Bloques <div align="center"> (carátula): centrados y sin entrar al índice
function Div(el)
  local style = el.attributes.style or ""
  if style:match("page%-break") or el.classes:includes("page") then
    return pagebreak()
  end
  if el.attributes.align == "center" then
    local blocks = el.content:walk({
      Header = function(h) return pandoc.Para({ pandoc.Strong(h.content) }) end
    })
    local out = { pandoc.RawBlock("typst", "#align(center)[") }
    for _, b in ipairs(blocks) do table.insert(out, b) end
    table.insert(out, pandoc.RawBlock("typst", "]"))
    return out
  end
end

-- 04-content.md tiene un índice escrito a mano con enlaces a los .md;
-- se reemplaza por el índice automático del PDF.
function Pandoc(doc)
  local out, skipping = pandoc.Blocks({}), false
  for _, b in ipairs(doc.blocks) do
    if b.t == "Header" and pandoc.utils.stringify(b) == "Contenido" then
      out:insert(pandoc.RawBlock("typst", '#pagebreak(weak: true)\n#outline(title: "Contenido", depth: 3)\n#pagebreak()'))
      skipping = true
    elseif skipping and b.t ~= "Header" then
      -- se omite la lista manual
    else
      skipping = false
      out:insert(b)
    end
  end
  doc.blocks = out
  return doc
end
