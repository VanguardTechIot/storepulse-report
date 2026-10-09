/* StorePulse Web App — shell compartido (sidenav + toolbar), íconos y modo wireframe */
(function () {
  if (new URLSearchParams(location.search).get('mode') === 'wire') document.documentElement.classList.add('wire');
})();

const ICONS = {
  pulse: '<path d="M3 12h4l2-5 4 10 2-5h6"/>',
  dashboard: '<rect x="3" y="3" width="7" height="9" rx="1.5"/><rect x="14" y="3" width="7" height="5" rx="1.5"/><rect x="14" y="12" width="7" height="9" rx="1.5"/><rect x="3" y="16" width="7" height="5" rx="1.5"/>',
  store: '<path d="M3 9l1.5-5h15L21 9"/><path d="M4 9v11h16V9"/><path d="M3 9a3 3 0 0 0 6 0 3 3 0 0 0 6 0 3 3 0 0 0 6 0"/><path d="M10 20v-5h4v5"/>',
  chip: '<rect x="6" y="6" width="12" height="12" rx="2"/><rect x="9.5" y="9.5" width="5" height="5" rx="1"/><path d="M9 2v4M15 2v4M9 18v4M15 18v4M2 9h4M2 15h4M18 9h4M18 15h4"/>',
  gauge: '<path d="M12 14l4-4"/><path d="M3.3 19a10 10 0 1 1 17.4 0"/>',
  receipt: '<path d="M5 3h14v18l-3-2-2 2-2-2-2 2-2-2-3 2z"/><path d="M9 8h6M9 12h6M9 16h3"/>',
  shield: '<path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6z"/><path d="M12 8v4M12 16h.01"/>',
  shieldok: '<path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6z"/><path d="M9 12l2 2 4-4"/>',
  chat: '<path d="M4 5h12v9H8l-4 3z"/><path d="M16 9h4v9l-3-2h-7v-2"/>',
  sparkle: '<path d="M12 3l1.8 4.2L18 9l-4.2 1.8L12 15l-1.8-4.2L6 9l4.2-1.8z"/><path d="M19 15l.8 1.7 1.7.8-1.7.8L19 20l-.8-1.7-1.7-.8 1.7-.8z"/>',
  building: '<rect x="4" y="3" width="16" height="18" rx="1.5"/><path d="M9 7h1M14 7h1M9 11h1M14 11h1M9 15h1M14 15h1"/>',
  search: '<circle cx="11" cy="11" r="7"/><path d="M20 20l-3.5-3.5"/>',
  bell: '<path d="M6 8a6 6 0 0 1 12 0c0 7 3 8 3 8H3s3-1 3-8"/><path d="M10 20a2 2 0 0 0 4 0"/>',
  chevdown: '<path d="M6 9l6 6 6-6"/>',
  chevright: '<path d="M9 6l6 6-6 6"/>',
  updown: '<path d="M8 9l4-4 4 4M8 15l4 4 4-4"/>',
  menu: '<path d="M4 6h16M4 12h16M4 18h16"/>',
  bolt: '<path d="M13 2L4 14h7l-1 8 9-12h-7z"/>',
  drop: '<path d="M12 3s7 7.5 7 12a7 7 0 0 1-14 0c0-4.5 7-12 7-12z"/>',
  money: '<rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="2.5"/><path d="M6 12h.01M18 12h.01"/>',
  alert: '<path d="M12 3l10 18H2z"/><path d="M12 10v4M12 17h.01"/>',
  flame: '<path d="M12 22c4 0 7-3 7-7 0-4-3-6-4-9-1 2-2 3-4 3 0-2-1-4-2-5-1 4-4 6-4 11 0 4 3 7 7 7z"/>',
  door: '<path d="M4 21h16"/><path d="M6 21V4h12v17"/><path d="M14 12h.01"/>',
  plus: '<path d="M12 5v14M5 12h14"/>',
  filter: '<path d="M3 5h18l-7 8v6l-4 2v-8z"/>',
  download: '<path d="M12 3v12M7 10l5 5 5-5M4 21h16"/>',
  upload: '<path d="M12 21V9M7 14l5-5 5 5M4 3h16"/>',
  edit: '<path d="M4 20h4L19 9l-4-4L4 16z"/>',
  eye: '<path d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z"/><circle cx="12" cy="12" r="3"/>',
  more: '<circle cx="5" cy="12" r="1"/><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/>',
  wifi: '<path d="M2 9a15 15 0 0 1 20 0M5 12.5a10 10 0 0 1 14 0M8.5 16a5 5 0 0 1 7 0M12 19.5h.01"/>',
  wifioff: '<path d="M2 2l20 20M8.5 16a5 5 0 0 1 7 0M12 19.5h.01M5 12.5a10 10 0 0 1 5-2.7M2 9a15 15 0 0 1 4.2-2.7M16.8 10.3a10 10 0 0 1 2.2 2.2M22 9a15 15 0 0 0-11-3.9"/>',
  battery: '<rect x="2" y="7" width="17" height="10" rx="2"/><path d="M22 11v2"/><path d="M6 10v4M9 10v4M12 10v4"/>',
  batterylow: '<rect x="2" y="7" width="17" height="10" rx="2"/><path d="M22 11v2"/><path d="M6 10v4"/>',
  clock: '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
  user: '<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>',
  users: '<circle cx="9" cy="8" r="3.5"/><path d="M2 20a7 7 0 0 1 14 0"/><path d="M16 4.5a3.5 3.5 0 0 1 0 7M18 13.5a7 7 0 0 1 4 6.5"/>',
  mail: '<rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/>',
  lock: '<rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
  check: '<path d="M5 12l5 5 9-10"/>',
  checkcircle: '<circle cx="12" cy="12" r="9"/><path d="M8 12l3 3 5-6"/>',
  x: '<path d="M6 6l12 12M18 6L6 18"/>',
  send: '<path d="M22 2L11 13"/><path d="M22 2l-7 20-4-9-9-4z"/>',
  clip: '<path d="M21 11l-9 9a5 5 0 0 1-7-7l9-9a3.5 3.5 0 0 1 5 5l-9 9a2 2 0 0 1-3-3l8-8"/>',
  megaphone: '<path d="M3 10v4h4l8 5V5L7 10z"/><path d="M18 9a4 4 0 0 1 0 6"/>',
  card: '<rect x="2" y="5" width="20" height="14" rx="2"/><path d="M2 10h20M6 15h4"/>',
  calendar: '<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/>',
  settings: '<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1z"/>',
  logout: '<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9"/>',
  google: '<circle cx="12" cy="12" r="9"/><path d="M12 12h8M12 3v0"/>',
  map: '<path d="M9 4L3 6v14l6-2 6 2 6-2V4l-6 2z"/><path d="M9 4v14M15 6v14"/>',
  sliders: '<path d="M4 6h10M18 6h2M4 12h4M12 12h8M4 18h12M20 18h0"/><circle cx="16" cy="6" r="2"/><circle cx="10" cy="12" r="2"/><circle cx="18" cy="18" r="2"/>',
  layers: '<path d="M12 3l9 5-9 5-9-5z"/><path d="M3 13l9 5 9-5"/>',
  trend: '<path d="M3 17l6-6 4 4 8-8"/><path d="M15 7h6v6"/>',
  refresh: '<path d="M21 12a9 9 0 1 1-3-6.7L21 8"/><path d="M21 3v5h-5"/>',
  arrowright: '<path d="M5 12h14M13 6l6 6-6 6"/>',
  arrowleft: '<path d="M19 12H5M11 6l-6 6 6 6"/>',
  globe: '<circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18"/>',
  timer: '<circle cx="12" cy="13" r="8"/><path d="M12 9v4l2 2M9 2h6"/>',
  phone: '<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 1.9.7 2.8a2 2 0 0 1-.5 2.1L8 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.4c.9.3 1.8.6 2.8.7a2 2 0 0 1 1.7 2z"/>',
  link: '<path d="M10 13a5 5 0 0 0 7 0l3-3a5 5 0 0 0-7-7l-1 1"/><path d="M14 11a5 5 0 0 0-7 0l-3 3a5 5 0 0 0 7 7l1-1"/>',
  star: '<path d="M12 3l2.8 5.7 6.2.9-4.5 4.4 1 6.2L12 17.3 6.5 20.2l1-6.2L3 9.6l6.2-.9z"/>'
};

function icon(name, size, sw) {
  size = size || 18; sw = sw || 1.75;
  return '<svg width="' + size + '" height="' + size + '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="' + sw + '" stroke-linecap="round" stroke-linejoin="round">' + (ICONS[name] || '') + '</svg>';
}

const NAV = [
  ['dashboard', 'Dashboard', 'dashboard', '04-dashboard.html'],
  ['units', 'Commercial Units', 'store', '05-commercial-units.html'],
  ['devices', 'Devices', 'chip', '06-devices.html', '<span class="tag">ESP32</span>'],
  ['meters', 'Utility Meters', 'gauge', '07-utility-meters.html'],
  ['billing', 'Billing', 'receipt', '08-billing.html'],
  ['security', 'Security & Incidents', 'shield', '09-security-incidents.html', '<span class="dot" style="background:var(--red)"></span>'],
  ['communication', 'Communication', 'chat', '10-communication.html'],
  ['subscription', 'Subscription', 'sparkle', '11-subscription.html']
];

function brand() {
  return '<div class="brand"><div class="brand-mark">' + icon('pulse', 20, 2.4) + '</div><div class="brand-name">Store<span>Pulse</span></div><i class="live"></i></div>';
}

function buildShell() {
  const page = document.body.dataset.page;
  const main = document.getElementById('page');
  if (!page || !main) return;
  const mode = document.documentElement.classList.contains('wire') ? '?mode=wire' : '';
  const status = document.body.dataset.status || 'alerta';
  const nav = NAV.map(function (n) {
    const active = n[0] === page;
    const extra = active ? '<span class="dot" style="background:var(--cyan)"></span>' : (n[4] || '');
    return '<a href="' + n[3] + mode + '" class="' + (active ? 'active' : '') + '">' + icon(n[2], 18) + n[1] + extra + '</a>';
  }).join('');
  const statusPill = status === 'normal'
    ? '<span class="status-pill normal"><i></i>Sistema normal</span>'
    : '<span class="status-pill alerta"><i></i>Alerta · 1 incidente activo</span>';

  const shell = document.createElement('div');
  shell.className = 'app';
  shell.innerHTML =
    '<aside class="sidenav">' + brand() +
      '<span class="chip-scope">' + icon('building', 13) + 'Gallery Management</span>' +
      '<div class="nav-label">Módulos principales</div>' +
      '<nav class="nav">' + nav + '</nav>' +
      '<div class="side-foot">' +
        '<div class="account"><div class="avatar">GC</div><div><b>Galería Central</b><small>Jr. de la Unión 845</small></div><span style="margin-left:auto;color:var(--muted-2)">' + icon('updown', 16) + '</span></div>' +
        '<div class="copyright"><span>VanguardTech © 2026</span><code>v2.4.8</code></div>' +
      '</div>' +
    '</aside>' +
    '<div class="main">' +
      '<header class="topbar">' +
        '<span style="color:var(--slate)">' + icon('menu', 20) + '</span>' +
        '<div class="gal"><span class="li-ico ico-cyan" style="width:34px;height:34px">' + icon('building', 18) + '</span><div><b>Galería Central #04</b><small>92 locales · Cercado de Lima</small></div></div>' +
        statusPill +
        '<div class="spacer"></div>' +
        '<span class="select">' + icon('calendar', 16) + 'Oct 2026' + icon('chevdown', 16) + '</span>' +
        '<div class="lang"><span>EN</span><span class="on">ES</span></div>' +
        '<div class="icon-btn" style="' + (document.body.dataset.menu === 'notif' ? 'border-color:var(--cyan);outline:2px solid var(--cyan)' : '') + '">' + icon('bell', 18) + '<i class="badge-dot"></i></div>' +
        '<div class="user-mini" style="' + (document.body.dataset.menu === 'user' ? 'color:var(--cyan-t)' : '') + '"><div class="avatar">CM</div><div><b>Carmen Mendoza</b><small>Administradora</small></div><span style="color:var(--muted)">' + icon('chevdown', 16) + '</span></div>' +
      '</header>' +
      '<div class="content"></div>' +
    '</div>';
  shell.querySelector('.content').appendChild(main);
  main.style.display = 'contents';
  document.body.prepend(shell);

  if (document.body.dataset.menu === 'user') {
    shell.insertAdjacentHTML('beforeend',
      '<div class="dropdown" style="right:24px;top:60px;width:260px">' +
        '<div style="padding:14px 16px;display:flex;gap:10px;align-items:center"><div class="avatar">CM</div><div><b style="font-size:14px">Carmen Mendoza</b><div class="small muted">carmen.mendoza@galeriacentral.pe</div></div></div>' +
        '<div class="sep"></div>' +
        '<a class="di" href="12-profile.html' + mode + '">' + icon('user', 18) + 'Mi perfil</a>' +
        '<a class="di" href="11-subscription.html' + mode + '">' + icon('sparkle', 18) + 'Suscripción</a>' +
        '<div class="di">' + icon('globe', 18) + 'Idioma: Español</div>' +
        '<div class="sep"></div>' +
        '<a class="di danger" href="02-login.html' + mode + '">' + icon('logout', 18) + 'Cerrar Sesión</a>' +
      '</div>');
  }
}

function hydrateIcons() {
  document.querySelectorAll('i[data-i]').forEach(function (el) {
    const tmp = document.createElement('span');
    tmp.innerHTML = icon(el.dataset.i, +(el.dataset.s || 18), +(el.dataset.w || 1.75));
    const svg = tmp.firstChild;
    if (el.className) svg.setAttribute('class', el.className);
    if (el.getAttribute('style')) svg.setAttribute('style', el.getAttribute('style'));
    el.replaceWith(svg);
  });
  document.querySelectorAll('.brand-slot').forEach(function (el) { el.innerHTML = brand(); });
}

/* Gráfico de líneas/áreas simple en SVG: data-series='[[...],[...]]' */
function drawCharts() {
  document.querySelectorAll('[data-chart]').forEach(function (el) {
    const type = el.dataset.chart;
    const cs = getComputedStyle(el);
    const w = Math.floor(el.clientWidth - parseFloat(cs.paddingLeft) - parseFloat(cs.paddingRight)) || +el.dataset.w || 600, h = +el.dataset.h || 220;
    const series = JSON.parse(el.dataset.series);
    const labels = JSON.parse(el.dataset.labels || '[]');
    const colors = (el.dataset.colors || 'var(--cyan),var(--muted)').split(',');
    const pad = { l: 44, r: 12, t: 12, b: 28 };
    let max = +el.dataset.max;
    if (!max) { const raw = Math.max.apply(null, series.flat()) * 1.1; const step = Math.pow(10, Math.floor(Math.log10(raw / 4))); const nice = [1, 1.5, 2, 2.5, 4, 5, 7.5, 10].map(function (m) { return m * step; }).find(function (st) { return st * 4 >= raw; }); max = nice * 4; }
    const iw = w - pad.l - pad.r, ih = h - pad.t - pad.b;
    let s = '<svg width="' + w + '" height="' + h + '" viewBox="0 0 ' + w + ' ' + h + '" style="display:block;font-family:Inter,sans-serif">';
    for (let i = 0; i <= 4; i++) {
      const y = pad.t + ih - ih * i / 4;
      s += '<line x1="' + pad.l + '" x2="' + (w - pad.r) + '" y1="' + y + '" y2="' + y + '" stroke="var(--border)" stroke-dasharray="' + (i ? '3 4' : '0') + '"/>';
      s += '<text x="' + (pad.l - 8) + '" y="' + (y + 4) + '" text-anchor="end" font-size="11" fill="var(--muted)">' + Math.round(max * i / 4).toLocaleString('es-PE') + '</text>';
    }
    const n = series[0].length;
    labels.forEach(function (lb, i) {
      const x = type === 'bar' ? pad.l + iw * (i + .5) / n : pad.l + iw * i / (n - 1);
      s += '<text x="' + x + '" y="' + (h - 8) + '" text-anchor="middle" font-size="11" fill="var(--muted)">' + lb + '</text>';
    });
    if (type === 'bar') {
      const groups = series.length, slot = iw / n, bw = Math.min(18, slot * .7 / groups);
      series.forEach(function (ser, si) {
        ser.forEach(function (v, i) {
          const bh = ih * v / max, x = pad.l + slot * i + slot / 2 - (bw * groups + 3 * (groups - 1)) / 2 + si * (bw + 3);
          s += '<rect x="' + x + '" y="' + (pad.t + ih - bh) + '" width="' + bw + '" height="' + bh + '" rx="3" fill="' + colors[si] + '"/>';
        });
      });
    } else {
      series.forEach(function (ser, si) {
        const pts = ser.map(function (v, i) { return [pad.l + iw * i / (n - 1), pad.t + ih - ih * v / max]; });
        const d = pts.map(function (p, i) { return (i ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1); }).join(' ');
        if (si === 0) s += '<path d="' + d + ' L' + pts[n - 1][0] + ' ' + (pad.t + ih) + ' L' + pts[0][0] + ' ' + (pad.t + ih) + 'Z" fill="' + colors[0] + '" opacity=".12"/>';
        s += '<path d="' + d + '" fill="none" stroke="' + colors[si] + '" stroke-width="' + (si ? 1.6 : 2.4) + '"' + (si ? ' stroke-dasharray="5 4"' : '') + ' stroke-linejoin="round"/>';
        if (si === 0) { const p = pts[n - 1]; s += '<circle cx="' + p[0] + '" cy="' + p[1] + '" r="4" fill="var(--card)" stroke="' + colors[0] + '" stroke-width="2.4"/>'; }
      });
      if (el.dataset.threshold) {
        const y = pad.t + ih - ih * (+el.dataset.threshold) / max;
        s += '<line x1="' + pad.l + '" x2="' + (w - pad.r) + '" y1="' + y + '" y2="' + y + '" stroke="var(--amber)" stroke-width="1.4" stroke-dasharray="6 4"/>';
        s += '<text x="' + (pad.l + 6) + '" y="' + (y - 6) + '" text-anchor="start" font-size="11" font-weight="600" fill="var(--amber-t)">Línea base + tolerancia</text>';
      }
    }
    let tip = '';
    if (el.dataset.tip && type !== 'bar') {
      const t = JSON.parse(el.dataset.tip);
      const v = series[0][t.i], x = pad.l + iw * t.i / (n - 1), y = pad.t + ih - ih * v / max;
      s += '<line x1="' + x + '" x2="' + x + '" y1="' + pad.t + '" y2="' + (pad.t + ih) + '" stroke="var(--navy)" stroke-dasharray="3 3" opacity=".4"/>';
      s += '<circle cx="' + x + '" cy="' + y + '" r="5" fill="var(--card)" stroke="' + colors[0] + '" stroke-width="2.6"/>';
      const left = (x + 210 > w) ? x - 214 : x + 14;
      tip = '<div class="tooltip" style="left:' + (left + parseFloat(cs.paddingLeft)) + 'px;top:' + (Math.max(y - 30, 4) + parseFloat(cs.paddingTop)) + 'px"><b>' + t.title + '</b>' + t.lines.map(function (l) { return '<small>' + l + '</small>'; }).join('') + '</div>';
      el.style.position = 'relative';
    }
    el.innerHTML = s + '</svg>' + tip;
  });
}

document.addEventListener('DOMContentLoaded', function () {
  hydrateIcons();
  buildShell();
  drawCharts();
});
