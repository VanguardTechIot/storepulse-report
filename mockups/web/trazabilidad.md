# Trazabilidad User Stories → Pantallas (Web App)

Aplicación web del **Gallery Administrator**. 33 pantallas en `mockups/web/`, cada una con versión mock-up y wireframe (`?mode=wire`).

## Cobertura

- User stories del administrador cubiertas: **44 de 44**.
- Las historias del **inquilino** (US-20, 22, 24, 25, 27, 29, 31, 33, 34, 36, 37, 43, 51, 52 y 58) corresponden a la aplicación móvil.
- Las historias del **visitante** (VS-01 a VS-11) están en la Landing Page (5.3).
- Las Technical, Device Maker y Spike Stories (TS, MS, SP) no tienen interfaz propia; su efecto se refleja en las pantallas (por ejemplo, TS-17 escalamiento simultáneo → “inquilino también notificado” en la alerta).

| User Story | Título | Pantalla(s) | Evidencia en el diseño |
| :--- | :--- | :--- | :--- |
| US-01 | Registro de administrador | `03-register` | Formulario con nombre, correo y contraseña; error de contraseña débil (mín. 8 caracteres y un número). |
| US-02 | Inicio de sesión | `02-login` | Formulario de correo y contraseña. |
| US-03 | Recuperación de contraseña | `02a-forgot-password` | Código de 6 dígitos con vigencia de 15 min y error de código incorrecto sin revelar el correcto. |
| US-04 | Cierre de sesión | `04b-user-menu` | Opción Cerrar Sesión en el menú de usuario y en Mi perfil; redirige a Iniciar Sesión. |
| US-05 | Control de acceso por rol | `02-login` | La web es solo para el administrador (vista consolidada); se informa que el inquilino usa la app móvil. |
| US-06 | Visualizar perfil de usuario | `12-profile` | Nombre, foto (imagen predeterminada), correo y rol. |
| US-07 | Editar perfil de usuario | `12-profile` | Edición con error de correo inválido y subida de foto. |
| US-08 | Registro de la galería comercial | `03b-register-gallery` | Nombre, dirección y cantidad de locales; campo obligatorio vacío señalado. |
| US-09 | Registrar local de la galería | `05-commercial-units`, `05a-unit-form` | Modal de registro con error de número de local duplicado. |
| US-10 | Editar local de la galería | `05-commercial-units`, `05a-unit-form` | Mismo formulario en modo edición (botón Editar en tabla y panel). |
| US-11 | Eliminar local de la galería | `05-commercial-units`, `05c-unit-delete` | Baja lógica bloqueada al tener 3 dispositivos vinculados. |
| US-12 | Invitar o asignar inquilino a un local | `05-commercial-units`, `05b-tenant-invite` | Invitación por correo con vigencia de 7 días; invitación expirada y reenvío. |
| US-13 | Consultar información del inmueble | `04d-dashboard-empty`, `05-commercial-units`, `05d-property` | Resumen del inmueble y listado de locales con estado; estado vacío en galería nueva. |
| US-14 | Registrar dispositivo IoT | `06a-device-register` | Identificador y local; error de identificador duplicado. |
| US-15 | Visualizar estado de dispositivos | `06-devices` | Estados Activo, Inactivo y Con falla; filtro Con falla. |
| US-16 | Desactivar dispositivo | `06b-device-deactivate` | Confirmación de desactivación que detiene la recepción de datos. |
| US-17 | Reactivar dispositivo | `06-devices` | Botón Reactivar en el dispositivo inactivo. |
| US-18 | Recibir alerta de falla de dispositivo | `06-devices` | Voltaje 4.31 V fuera de 4.5–5.5 V; alerta de falla técnica con dispositivo y local. |
| US-19 | Visualizar estado de seguridad de la galería | `04-dashboard`, `09-security-incidents` | Mapa por local: sin incidentes, incidente activo, sin monitoreo; fecha del último incidente. |
| US-21 | Recibir alerta de intrusión de la galería | `04c-alert-modal`, `09-security-incidents`, `09b-incident-common-area` | Alerta con tipo, local, fecha y hora, recibida en 12 s, sin imagen del local. |
| US-23 | Consultar historial de incidentes de la galería | `09-security-incidents` | Historial con tipo, ubicación, fecha, hora y estado. |
| US-26 | Consultar detalle de un incidente de la galería | `09a-incident-detail`, `09b-incident-common-area` | Detalle sin imagen para locales y con imagen para áreas comunes. |
| US-28 | Visualizar consumo de servicios de la galería | `04d-dashboard-empty`, `04-dashboard`, `07-utility-meters` | Totales consolidados por servicio (energía y agua); estado sin mediciones. |
| US-30 | Consultar historial de consumo | `07-utility-meters` | Consumo acumulado, promedio histórico y desviación respecto de la línea base; “comparación aún no disponible”. |
| US-32 | Generar información para facturación | `08-billing`, `08c-generate` | Cálculo por consumo real con advertencia de mediciones incompletas antes de confirmar. |
| US-35 | Notificar un incidente al inquilino afectado | `09a-incident-detail`, `09b-incident-common-area` | Botón Notificar al inquilino (local) y Notificar a todos los inquilinos (área común). |
| US-38 | Atender reclamos de facturación | `10-communication` | Desglose de consumo del local para sustentar la respuesta y botón Resolver reclamo. |
| US-39 | Identificar pérdida de conectividad de un dispositivo | `06-devices` | Alerta de pérdida de conectividad (sin reporte por 15 min) con dispositivo y local. |
| US-40 | Visualizar estado de conectividad de dispositivos | `06-devices` | Conectado/Desconectado con fecha y hora del último reporte; desconectados primero. |
| US-41 | Continuidad de detección sin conexión | `06-devices` | Aviso de detección local durante la desconexión y eventos retenidos en búfer. |
| US-42 | Sincronización automática al recuperar conexión | `06-devices` | Eventos por sincronizar y último reintento de los registros no confirmados. |
| US-44 | Activar suscripción | `11a-checkout` | Selección de plan y método de pago al finalizar el registro. |
| US-45 | Visualizar estado de la suscripción | `12-profile`, `11-subscription`, `11c-renewal-cancelled` | Plan, estado y fecha de expiración en Suscripción y en Mi perfil; aviso de renovación próxima. |
| US-46 | Cancelar renovación automática | `11b-cancel-renewal` | Confirmación que mantiene la vigencia hasta el vencimiento. |
| US-47 | Reactivar renovación automática | `11c-renewal-cancelled` | Botón Reactivar renovación con la suscripción vigente. |
| US-48 | Renovación automática de suscripción | `11-subscription` | Renovación automática activa con fecha del próximo cobro. |
| US-49 | Centro de notificaciones | `04a-notifications` | Listado cronológico con tipo, local y hora. |
| US-50 | Visualizar dashboard consolidado | `04d-dashboard-empty`, `04-dashboard` | Incidentes activos, consumo del periodo y dispositivos desconectados; estado inicial sin datos. |
| US-53 | Confirmar la atención de una alerta | `04c-alert-modal`, `09-security-incidents`, `09a-incident-detail` | Confirmar atención (Pendiente → En atención), registro de hora y resultado para pasar a Resuelto. |
| US-54 | Configurar tarifas y periodo de facturación | `08b-tariffs` | Tarifa por kWh, por m³ y día de cierre; error de tarifa ≤ 0; aplica desde el periodo siguiente. |
| US-55 | Descarga e historial de facturas | `08-billing` | Fecha de emisión, periodo, monto y estado; filtros por rango de fechas y estado; descarga. |
| US-56 | Registrar el pago de una factura | `08-billing`, `08a-payment` | Fecha y medio de pago; la factura pasa a Pagada y se notifica al inquilino. |
| US-57 | Registrar área común de la galería | `05d-property`, `05e-common-area` | Listado de áreas comunes y modal con error de nombre duplicado. |
| US-59 | Recibir alerta de humo de la galería | `04c-alert-modal`, `09-security-incidents` | Incidente de humo en el historial y en notificaciones. |

## Cumplimiento del Style Guide (5.1)

| Lineamiento | Aplicación en los mock-ups |
| :--- | :--- |
| Tipografía Plus Jakarta Sans / Inter / JetBrains Mono | Títulos y UI / tablas de datos / IDs, lecturas y montos |
| Paleta principal y semántica | Navy `#0F172A`, cyan `#0EA5E9`, fondos `#F8FAFC`; rojo, ámbar, verde, azul y morado según la matriz de estados del LED |
| Sidebar 260 px y topbar 64 px | Topbar con galería activa, estado global (Normal / Alerta), selector de periodo y centro de notificaciones |
| Cards | Radio 12 px, borde `#E2E8F0`, sombra `0 1px 3px rgba(15,23,42,.08)` |
| Grid y espaciado | Gutters de 24 px, padding de 32 px, sistema de 8 px |
| Botones | Primario, outline con borde 1.5 px navy y destructivo para acciones críticas |
| Formularios | Etiquetas superiores, anillo de foco cyan de 2 px y mensajes de validación |
| Tablas | Fila con hover `#F1F5F9`, flecha de ordenamiento y paginación al pie |
| Iconografía | Trazo lineal de 1.75 px en caja de 24 × 24 |
| Gráficos | Líneas guía punteadas y tooltip con timestamp |
| Matriz cross-platform | Intrusión/humo → alerta flotante modal; offline → “Offline · buffering” con eventos retenidos; batería → autonomía restante; falla de sensor → ticket técnico |
| Tono de comunicación | “Intrusión detectada en Local B-12 — Verificación requerida inmediatamente”; recibos con fórmula de cobro |
| Bilingüismo | Selector EN/ES en todas las pantallas |

## Ajustes para cumplir WCAG 2.1 AA (declarado en 5.1)

Varios pares de color de la guía no alcanzan 4.5:1 en texto normal. Se mantuvieron los colores de marca para fondos, íconos, gráficos y estados del LED, y se usaron variantes más oscuras **solo para texto y botones con texto blanco**:

| Uso | Color de la guía | Contraste | Variante aplicada | Contraste |
| :--- | :--- | :--- | :--- | :--- |
| Botón primario (texto blanco) | `#0EA5E9` | 2.77:1 | `#0369A1` | 5.93:1 |
| Botón destructivo (texto blanco) | `#EF4444` | 3.76:1 | `#DC2626` | 4.83:1 |
| Texto de badge ámbar | `#F59E0B` | 2.07:1 | `#B45309` | 4.84:1 |
| Texto de badge verde | `#10B981` | 2.41:1 | `#047857` | 5.21:1 |
| Texto de badge rojo | `#EF4444` | 3.44:1 | `#B91C1C` | 5.91:1 |
| Texto secundario | `#94A3B8` | 2.56:1 | `#5B6B82` | 5.43:1 |

Se recomienda actualizar 5.1 con estas variantes de texto. Se verificó automáticamente el contraste de todos los textos de las 33 pantallas (el logotipo está exento).

## Decisiones tomadas por conflicto con las user stories

- **Roles:** 5.2 menciona un técnico de mantenimiento y personal de seguridad, pero ninguna user story los usa. En la web todo lo hace el **administrador**.
- **Horario de atención:** lo configura el **inquilino** (US-52) desde la app móvil; en la web se muestra solo como dato de lectura.
- **Estados de incidente:** se usan Pendiente → En atención → Resuelto (US-53), en lugar de un SLA de guardias.
- **Imágenes:** solo se muestran en incidentes de áreas comunes; en locales se indica que no están disponibles (US-21, US-26).
- **Falla técnica:** se detecta por voltaje fuera de 4.5–5.5 V (US-18).
- **Precios de los planes** (S/ 290, 690 y 1,490): son de ejemplo, el informe aún no los define.
