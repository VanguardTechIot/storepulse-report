# StorePulse · Web App Mock-ups (5.4 Applications UX/UI Design)

33 pantallas de la aplicación web del **Gallery Administrator**, alineadas con las user stories del Capítulo III y el Style Guide (5.1). Cada pantalla tiene versión **mock-up** (alta fidelidad) y **wireframe** (escala de grises, `?mode=wire`).

- `index.html`: todas las pantallas agrupadas por flujo, con las user stories que cubre cada una.
- `trazabilidad.md`: tabla User Story → pantalla, cumplimiento del style guide, ajustes de contraste WCAG y decisiones tomadas. Lista para pegar en 5.4.
- `assets/styles.css` (tokens y componentes), `assets/auth.css` (pre-login), `assets/app.js` (sidebar, topbar, íconos, gráficos y modo wireframe).

## Flujos para los wireflows

1. **Registro:** 01 Bienvenida → 03 Cuenta → 03b Galería → 11a Plan → 04d Dashboard sin datos → 05a Registrar local
2. **Acceso:** 01 Bienvenida → 02 Iniciar Sesión → 04 Dashboard · 02 → 02a Recuperar contraseña → 02
3. **Intrusión:** 04c Alerta → Confirmar atención → 09a Detalle (En atención) → Registrar resultado → 09 Historial
4. **Locales:** 05 → 05a Registrar/editar · 05b Invitar inquilino · 05c Eliminar · 05d Inmueble → 05e Área común
5. **Dispositivos:** 06 → 06a Registrar · 06b Desactivar → Reactivar
6. **Facturación:** 08 → 08b Tarifas → 08c Generar → 08a Registrar pago · 08 → 10 Reclamo → Resolver
7. **Suscripción:** 11 → 11b Cancelar renovación → 11c Renovación cancelada → Reactivar
8. **Cuenta:** 04b Menú de usuario → 12 Mi perfil · Cerrar Sesión → 02

## Importar a Figma con html.to.design

1. Instala la extensión de Chrome **html.to.design** y activa **Permitir acceso a URLs de archivo** (chrome://extensions → Detalles).
2. Abre la pantalla en Chrome y captúrala con la extensión (viewport Desktop 1440).
3. En Figma abre el plugin **html.to.design** e importa la captura: llega como frame editable.
4. Repite con `?mode=wire` para la versión wireframe.
5. Ordena los frames según los flujos de arriba y conéctalos con el plugin **Autoflow**, escribiendo la acción del usuario en cada flecha.
