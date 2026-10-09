# 5.4. Applications UX/UI Design

En esta sección se presenta la propuesta visual y de interacción de las aplicaciones que conforman la experiencia de usuario de StorePulse: la **aplicación web**, orientada al administrador de la galería comercial (User Persona *Benjamín Montenegro*), y la **aplicación móvil**, orientada al inquilino del local comercial (User Persona *Juana Flores*). El diseño traduce las decisiones de la arquitectura de información (5.2) y de la guía de estilos (5.1) en pantallas concretas, priorizando la atención inmediata de alertas de seguridad, la lectura clara del consumo de luz y agua y la facturación sustentada en datos medidos.

Los wireframes, wireflows y mock-ups fueron elaborados en Figma, y se organizan en tres secciones internas: wireframes de las aplicaciones (5.4.1), wireflow diagrams por User Goal (5.4.2) y mock-ups de alta fidelidad (5.4.3).

## 5.4.1. Applications Wireframes

Los wireframes definen la estructura de cada pantalla antes de aplicar el diseño visual definitivo. Se trabajaron en escala de grises para concentrar la evaluación en la distribución de los componentes, la jerarquía de la información y la ubicación de las acciones principales, sin la distracción del color ni de la marca.

En la propuesta se evidencian los siguientes criterios:

* **Principios y elementos de diseño:** jerarquía visual mediante tamaño y peso tipográfico, proximidad para agrupar datos relacionados (indicadores, tablas y paneles laterales) y alineación a una cuadrícula con espaciado modular de 8 px.
* **Diseño inclusivo:** etiquetas visibles sobre cada campo, mensajes de validación junto al campo con error, estados que no dependen solo del color (texto + ícono) y áreas táctiles amplias en móvil.
* **Arquitectura de información:** la web replica el sistema de navegación global definido en 5.2 (sidebar con los módulos Dashboard, Commercial Units, Devices, Utility Meters, Billing, Security & Incidents, Communication y Subscription, y topbar con galería activa, estado global, periodo, idioma y usuario), mientras que la app móvil usa una barra de navegación inferior con cinco destinos (Mi Local, Consumos, Alertas, Mensajes y Perfil).

### 5.4.1.1. Web Application

La aplicación web concentra la gestión integral de la galería. Sus wireframes están diseñados para una resolución de escritorio de 1440 px, con un área de contenido que prioriza los indicadores clave en la parte superior y las tablas de detalle debajo. Las acciones secundarias y las confirmaciones se presentan como modales sobre la pantalla de origen para no perder el contexto del usuario.

**W01 · Bienvenida**

Esquema de la pantalla de entrada a la plataforma, que presenta la propuesta de valor de StorePulse junto a los accesos para iniciar sesión, registrar una galería o, en el caso del inquilino, activar su cuenta por invitación.

![Wireframe W01 Bienvenida](../../assets/applications-ux-ui-design/web-wireframes/W01-bienvenida.jpg)

**W02 · Iniciar Sesión**

Esquema del formulario de acceso para el administrador, que organiza las credenciales, la recuperación de contraseña y una aclaración de que el inquilino ingresa desde la app móvil.

![Wireframe W02 Iniciar Sesión](../../assets/applications-ux-ui-design/web-wireframes/W02-iniciar-sesion.jpg)

**W03 · Recuperar contraseña**

Esquema del proceso de recuperación de acceso, en el que el administrador valida el código de seis dígitos enviado a su correo y define una nueva contraseña.

![Wireframe W03 Recuperar contraseña](../../assets/applications-ux-ui-design/web-wireframes/W03-recuperar-contrasena.jpg)

**W04 · Registro de cuenta**

Esquema del primer paso del registro, donde el administrador crea su cuenta y conoce desde el inicio los requisitos de seguridad de su contraseña.

![Wireframe W04 Registro de cuenta](../../assets/applications-ux-ui-design/web-wireframes/W04-registro-de-cuenta.jpg)

**W05 · Registro de galería**

Esquema del segundo paso del registro, destinado a recopilar los datos básicos de la galería comercial que se va a monitorear.

![Wireframe W05 Registro de galería](../../assets/applications-ux-ui-design/web-wireframes/W05-registro-de-galeria.jpg)

**W06 · Elegir plan y pago**

Esquema del paso final del registro, en el que el administrador elige el plan que mejor se ajusta al tamaño de su galería y activa la suscripción con su pago.

![Wireframe W06 Elegir plan y pago](../../assets/applications-ux-ui-design/web-wireframes/W06-elegir-plan-y-pago.jpg)

**W07 · Dashboard sin datos**

Esquema del primer ingreso a la plataforma, que guía al administrador a registrar sus locales y vincular sus dispositivos mientras aún no existe actividad que mostrar.

![Wireframe W07 Dashboard sin datos](../../assets/applications-ux-ui-design/web-wireframes/W07-dashboard-sin-datos.jpg)

**W08 · Dashboard**

Esquema del panel principal de la galería, que reúne en una sola vista los incidentes activos, el consumo de energía y agua, las alertas recientes, el estado de seguridad por local y el avance de la cobranza.

![Wireframe W08 Dashboard](../../assets/applications-ux-ui-design/web-wireframes/W08-dashboard.jpg)

**W09 · Centro de notificaciones**

Esquema del centro de notificaciones, que permite revisar en orden cronológico los eventos recientes de la galería y filtrarlos por categoría.

![Wireframe W09 Centro de notificaciones](../../assets/applications-ux-ui-design/web-wireframes/W09-centro-de-notificaciones.jpg)

**W10 · Alerta de intrusión**

Esquema de la alerta de alta prioridad que interrumpe la navegación cuando se detecta una intrusión fuera del horario de atención, para que el administrador la confirme de inmediato.

![Wireframe W10 Alerta de intrusión](../../assets/applications-ux-ui-design/web-wireframes/W10-alerta-de-intrusion.jpg)

**W11 · Locales comerciales**

Esquema del módulo de locales, donde el administrador consulta la ocupación de la galería, busca locales y revisa el inquilino y los dispositivos de cada uno.

![Wireframe W11 Locales comerciales](../../assets/applications-ux-ui-design/web-wireframes/W11-locales-comerciales.jpg)

**W12 · Registrar local**

Esquema del formulario para incorporar o editar un local de la galería, que advierte cuando el número ingresado ya existe.

![Wireframe W12 Registrar local](../../assets/applications-ux-ui-design/web-wireframes/W12-registrar-local.jpg)

**W13 · Invitar inquilino**

Esquema del envío de una invitación por correo al inquilino, vinculada únicamente a su local y con una vigencia limitada.

![Wireframe W13 Invitar inquilino](../../assets/applications-ux-ui-design/web-wireframes/W13-invitar-inquilino.jpg)

**W14 · Inmueble y áreas comunes**

Esquema de la ficha general del inmueble, que resume los datos de la galería, la ocupación por piso y las áreas comunes que también se monitorean.

![Wireframe W14 Inmueble y áreas comunes](../../assets/applications-ux-ui-design/web-wireframes/W14-inmueble-y-areas-comunes.jpg)

**W15 · Registrar área común**

Esquema del registro de un área común, como un pasillo o una escalera, que queda bajo el monitoreo de la administración.

![Wireframe W15 Registrar área común](../../assets/applications-ux-ui-design/web-wireframes/W15-registrar-area-comun.jpg)

**W16 · Dispositivos IoT**

Esquema del panel de supervisión de los nodos IoT, que muestra su estado, conectividad, voltaje y último reporte, junto con los eventos pendientes de sincronizar.

![Wireframe W16 Dispositivos IoT](../../assets/applications-ux-ui-design/web-wireframes/W16-dispositivos-iot.jpg)

**W17 · Registrar dispositivo**

Esquema del registro de un nuevo nodo o medidor y su vinculación a un local, con la validación de identificadores duplicados.

![Wireframe W17 Registrar dispositivo](../../assets/applications-ux-ui-design/web-wireframes/W17-registrar-dispositivo.jpg)

**W18 · Consumo de luz y agua**

Esquema del módulo de medición, que compara el consumo de cada local con su historial y su línea base para detectar desviaciones fuera de lo habitual.

![Wireframe W18 Consumo de luz y agua](../../assets/applications-ux-ui-design/web-wireframes/W18-consumo-de-luz-y-agua.jpg)

**W19 · Seguridad e incidentes**

Esquema del módulo de seguridad, que reúne el incidente pendiente de atención, los indicadores de respuesta y el historial completo de intrusiones, humo y reportes manuales.

![Wireframe W19 Seguridad e incidentes](../../assets/applications-ux-ui-design/web-wireframes/W19-seguridad-e-incidentes.jpg)

**W20 · Detalle de incidente**

Esquema del seguimiento de un incidente, desde su detección hasta el registro del resultado de la atención, respetando la privacidad de las imágenes del local.

![Wireframe W20 Detalle de incidente](../../assets/applications-ux-ui-design/web-wireframes/W20-detalle-de-incidente.jpg)

**W21 · Facturación**

Esquema del módulo de facturación, que muestra el estado de cobro de los recibos de cada local, las tarifas vigentes y los reclamos abiertos.

![Wireframe W21 Facturación](../../assets/applications-ux-ui-design/web-wireframes/W21-facturacion.jpg)

**W22 · Configurar tarifas**

Esquema de la configuración de las tarifas de luz y agua y del día de cierre del periodo, que se aplican a partir de la siguiente facturación.

![Wireframe W22 Configurar tarifas](../../assets/applications-ux-ui-design/web-wireframes/W22-configurar-tarifas.jpg)

**W23 · Generar facturación**

Esquema de la confirmación previa a la emisión de recibos, que resume el periodo y advierte sobre los locales con mediciones incompletas.

![Wireframe W23 Generar facturación](../../assets/applications-ux-ui-design/web-wireframes/W23-generar-facturacion.jpg)

**W24 · Registrar pago**

Esquema del registro del pago de un recibo, que actualiza su estado y notifica al inquilino.

![Wireframe W24 Registrar pago](../../assets/applications-ux-ui-design/web-wireframes/W24-registrar-pago.jpg)

**W25 · Comunicación y reclamos**

Esquema del canal de comunicación con los inquilinos, que permite responder un reclamo apoyándose en el desglose real del consumo del local.

![Wireframe W25 Comunicación y reclamos](../../assets/applications-ux-ui-design/web-wireframes/W25-comunicacion-y-reclamos.jpg)

**W26 · Suscripción**

Esquema de la gestión de la suscripción, donde el administrador revisa su plan, la renovación automática, otros planes disponibles y sus pagos.

![Wireframe W26 Suscripción](../../assets/applications-ux-ui-design/web-wireframes/W26-suscripcion.jpg)

**W27 · Cancelar renovación**

Esquema de la confirmación para cancelar la renovación automática, que aclara que el servicio continúa hasta su fecha de vencimiento.

![Wireframe W27 Cancelar renovación](../../assets/applications-ux-ui-design/web-wireframes/W27-cancelar-renovacion.jpg)

**W28 · Mi perfil**

Esquema del perfil del administrador, donde puede actualizar sus datos personales y revisar el estado de su suscripción.

![Wireframe W28 Mi perfil](../../assets/applications-ux-ui-design/web-wireframes/W28-mi-perfil.jpg)

**W29 · Menú de usuario**

Esquema del menú de cuenta, que da acceso rápido al perfil, la suscripción, el idioma y el cierre de sesión.

![Wireframe W29 Menú de usuario](../../assets/applications-ux-ui-design/web-wireframes/W29-menu-de-usuario.jpg)

**W30 · Desactivar dispositivo**

Esquema de la confirmación para desactivar un dispositivo, que advierte que el local quedará sin monitoreo y solicita el motivo.

![Wireframe W30 Desactivar dispositivo](../../assets/applications-ux-ui-design/web-wireframes/W30-desactivar-dispositivo.jpg)

**W31 · Eliminar local (bloqueado)**

Esquema del aviso que impide eliminar un local mientras tenga dispositivos vinculados, indicando los pasos necesarios para darlo de baja.

![Wireframe W31 Eliminar local bloqueado](../../assets/applications-ux-ui-design/web-wireframes/W31-eliminar-local-bloqueado.jpg)

**W32 · Renovación cancelada**

Esquema del estado de la suscripción luego de cancelar la renovación, con la opción de reactivarla antes del vencimiento.

![Wireframe W32 Renovación cancelada](../../assets/applications-ux-ui-design/web-wireframes/W32-renovacion-cancelada.jpg)

### 5.4.1.2. Mobile Application

La aplicación móvil está pensada para el inquilino, que necesita enterarse de inmediato de lo que ocurre en su local y revisar su consumo sin esfuerzo. Los wireframes se diseñaron para una pantalla de 390 × 844 px, con una sola columna, la acción principal fija en la parte inferior y una barra de navegación inferior al alcance del pulgar.

**M01 · Activar cuenta (invitación)**

Esquema de la activación de la cuenta del inquilino a partir de la invitación de la administración, ya vinculada a su local.

![Wireframe M01 Activar cuenta](../../assets/applications-ux-ui-design/mobile-wireframes/M01-activar-cuenta-invitacion.jpg)

**M02 · Iniciar sesión**

Esquema del acceso a la app móvil, pensado para que el inquilino ingrese y consulte solo la información de su local.

![Wireframe M02 Iniciar sesión](../../assets/applications-ux-ui-design/mobile-wireframes/M02-iniciar-sesion.jpg)

**M03 · Recuperar contraseña**

Esquema de la recuperación de contraseña desde el teléfono, mediante un código de seis dígitos enviado al correo.

![Wireframe M03 Recuperar contraseña](../../assets/applications-ux-ui-design/mobile-wireframes/M03-recuperar-contrasena.jpg)

**M04 · Mi Local**

Esquema de la pantalla principal del inquilino, que le confirma de un vistazo si su local está seguro, cuánto ha consumido y si sus dispositivos funcionan.

![Wireframe M04 Mi Local](../../assets/applications-ux-ui-design/mobile-wireframes/M04-mi-local.jpg)

**M05 · Mi Local sin dispositivos**

Esquema de la pantalla principal cuando el local aún no cuenta con dispositivos, que explica que el monitoreo se activará tras la instalación.

![Wireframe M05 Mi Local sin dispositivos](../../assets/applications-ux-ui-design/mobile-wireframes/M05-mi-local-sin-dispositivos.jpg)

**M06 · Alerta de intrusión**

Esquema de la alerta crítica que recibe el inquilino cuando se detecta una intrusión en su local, acompañada de la imagen capturada y el estado de la atención.

![Wireframe M06 Alerta de intrusión](../../assets/applications-ux-ui-design/mobile-wireframes/M06-alerta-de-intrusion.jpg)

**M07 · Alertas (historial)**

Esquema del historial de incidentes del local y de los avisos generales de la galería, desde donde el inquilino también puede reportar un problema.

![Wireframe M07 Alertas historial](../../assets/applications-ux-ui-design/mobile-wireframes/M07-alertas-historial.jpg)

**M08 · Detalle de incidente**

Esquema del detalle de un incidente, que permite al inquilino seguir paso a paso cómo lo atiende la administración.

![Wireframe M08 Detalle de incidente](../../assets/applications-ux-ui-design/mobile-wireframes/M08-detalle-de-incidente.jpg)

**M09 · Reportar incidente**

Esquema del formulario para reportar un incidente que los sensores no detectaron, enviado directamente a la administración.

![Wireframe M09 Reportar incidente](../../assets/applications-ux-ui-design/mobile-wireframes/M09-reportar-incidente.jpg)

**M10 · Mis reportes**

Esquema del seguimiento de los reportes enviados por el inquilino, que muestra en qué etapa de atención se encuentra cada uno.

![Wireframe M10 Mis reportes](../../assets/applications-ux-ui-design/mobile-wireframes/M10-mis-reportes.jpg)

**M11 · Consumos**

Esquema de la consulta del consumo de energía y agua del local, con su evolución en los últimos meses y acceso al recibo del periodo.

![Wireframe M11 Consumos](../../assets/applications-ux-ui-design/mobile-wireframes/M11-consumos.jpg)

**M12 · Recibo y desglose**

Esquema del recibo del inquilino, que explica cómo se calculó el monto a partir de su consumo real y de las tarifas vigentes.

![Wireframe M12 Recibo y desglose](../../assets/applications-ux-ui-design/mobile-wireframes/M12-recibo-y-desglose.jpg)

**M13 · Presentar reclamo**

Esquema del formulario para presentar un reclamo sobre un recibo, con la posibilidad de adjuntar un sustento.

![Wireframe M13 Presentar reclamo](../../assets/applications-ux-ui-design/mobile-wireframes/M13-presentar-reclamo.jpg)

**M14 · Mensajes**

Esquema de la bandeja de mensajes, que reúne los comunicados de la administración, las respuestas a reclamos y los avisos del local.

![Wireframe M14 Mensajes](../../assets/applications-ux-ui-design/mobile-wireframes/M14-mensajes.jpg)

**M15 · Perfil**

Esquema del perfil del inquilino, desde donde accede a la configuración de su horario, sus notificaciones y su idioma.

![Wireframe M15 Perfil](../../assets/applications-ux-ui-design/mobile-wireframes/M15-perfil.jpg)

**M16 · Horario de atención**

Esquema de la configuración del horario de atención del local, que define en qué momentos se generan las alertas de intrusión.

![Wireframe M16 Horario de atención](../../assets/applications-ux-ui-design/mobile-wireframes/M16-horario-de-atencion.jpg)

**M17 · Preferencias de notificación**

Esquema de las preferencias de notificación, donde el inquilino elige qué avisos recibir, mientras las alertas de intrusión y humo permanecen siempre activas.

![Wireframe M17 Preferencias de notificación](../../assets/applications-ux-ui-design/mobile-wireframes/M17-preferencias-de-notificacion.jpg)

**M18 · Consumos sin conexión**

Esquema de la consulta de consumos sin conexión a Internet, en la que la app muestra en modo lectura los últimos datos sincronizados.

![Wireframe M18 Consumos sin conexión](../../assets/applications-ux-ui-design/mobile-wireframes/M18-consumos-sin-conexion.jpg)

## 5.4.2. Applications Wireflow Diagrams

Un wireflow combina los wireframes con las acciones del usuario que conectan una pantalla con la siguiente. Se elaboró un wireflow por cada User Goal de los User Persona del alcance: siete para el administrador en la aplicación web y seis para el inquilino en la aplicación móvil. Cuando una interacción cambia el estado de una pantalla (por ejemplo, al abrir un modal o mostrar un error), se agrega un nuevo paso con el wireframe que representa ese estado.

### 5.4.2.1. Web Application

**WF-01 · Registrar la galería y activar la suscripción**

**User Goal:** Como administrador, quiero registrar mi cuenta y mi galería y activar un plan para empezar a monitorear los locales.

Desde la bienvenida, el administrador crea su cuenta (la contraseña débil se señala en el mismo paso), registra los datos de la galería, elige el plan y paga. Llega al dashboard en estado inicial sin datos, desde donde registra su primer local.

![Wireflow WF-01](../../assets/applications-ux-ui-design/web-wireflows/WF-01-registrar-galeria-y-activar-suscripcion.jpg)

**WF-02 · Acceder a la plataforma y recuperar la contraseña**

**User Goal:** Como administrador, quiero iniciar y cerrar sesión de forma segura y recuperar mi contraseña si la olvido.

El administrador inicia sesión y accede al dashboard consolidado. Si olvidó su contraseña, valida un código de 6 dígitos con vigencia de 15 minutos y vuelve a Iniciar Sesión. Cierra sesión desde el menú de usuario.

![Wireflow WF-02](../../assets/applications-ux-ui-design/web-wireflows/WF-02-acceder-y-recuperar-contrasena.jpg)

**WF-03 · Atender una alerta de intrusión**

**User Goal:** Como administrador, quiero recibir la alerta de intrusión, confirmar su atención y registrar el resultado para resolver el incidente.

La alerta aparece como modal sobre cualquier pantalla y también puede consultarse desde el centro de notificaciones. Al confirmar la atención, el incidente pasa de Pendiente a En atención. En el detalle se notifica al inquilino y se registra el resultado, que lo pasa a Resuelto y lo deja en el historial.

![Wireflow WF-03](../../assets/applications-ux-ui-design/web-wireflows/WF-03-atender-alerta-de-intrusion.jpg)

**WF-04 · Gestionar locales e invitar inquilinos**

**User Goal:** Como administrador, quiero registrar y mantener los locales de mi galería e invitar a cada inquilino a su local.

Desde Commercial Units, el administrador registra un local (el número duplicado se rechaza), invita al inquilino por correo con vigencia de 7 días y consulta el inmueble para registrar áreas comunes. Un local con dispositivos vinculados no puede eliminarse.

![Wireflow WF-04](../../assets/applications-ux-ui-design/web-wireflows/WF-04-gestionar-locales-e-invitar-inquilinos.jpg)

**WF-05 · Supervisar los dispositivos IoT**

**User Goal:** Como administrador, quiero registrar, revisar y desactivar los dispositivos IoT para mantener el monitoreo operativo.

El administrador abre Devices desde el dashboard y revisa la conectividad, las fallas de voltaje y los eventos retenidos en búfer. Luego registra un nuevo dispositivo (el identificador duplicado se rechaza) y desactiva o reactiva un nodo.

![Wireflow WF-05](../../assets/applications-ux-ui-design/web-wireflows/WF-05-supervisar-dispositivos-iot.jpg)

**WF-06 · Facturar el consumo y registrar pagos**

**User Goal:** Como administrador, quiero configurar tarifas, generar recibos por consumo real, registrar pagos y atender reclamos.

Tras revisar el consumo frente a la línea base, el administrador configura las tarifas (una tarifa menor o igual a cero se rechaza), genera la facturación con la advertencia de mediciones incompletas y registra los pagos. Los reclamos se resuelven con el desglose de consumo.

![Wireflow WF-06](../../assets/applications-ux-ui-design/web-wireflows/WF-06-facturar-consumo-y-registrar-pagos.jpg)

**WF-07 · Gestionar la suscripción y el perfil**

**User Goal:** Como administrador, quiero consultar mi suscripción, controlar la renovación automática y mantener mis datos de perfil.

Desde el menú de usuario se accede a Suscripción. Ahí el administrador cancela la renovación (la suscripción sigue vigente hasta el vencimiento) y puede reactivarla. Mi perfil muestra el plan y permite editar los datos.

![Wireflow WF-07](../../assets/applications-ux-ui-design/web-wireflows/WF-07-gestionar-suscripcion-y-perfil.jpg)

### 5.4.2.2. Mobile Application

**WF-M1 · Activar la cuenta e ingresar a la app**

**User Goal:** Como inquilino, quiero activar mi cuenta con la invitación de la administración e ingresar para ver mi local.

El inquilino abre el enlace de invitación (vinculado a su local), crea su contraseña e inicia sesión (si la olvida, la recupera con un código de 6 dígitos). Luego ve el panel de su local; si aún no hay dispositivos, el panel indica que el monitoreo se activará tras la instalación.

![Wireflow WF-M1](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M1-activar-cuenta-e-ingresar.jpg)

**WF-M2 · Responder a una alerta de intrusión**

**User Goal:** Como inquilino, quiero recibir la alerta de intrusión de mi local con la imagen capturada y seguir su atención.

Fuera del horario de atención, el sensor detecta actividad y el inquilino recibe la alerta con imagen en 30 segundos o menos. Revisa el detalle y el seguimiento. El incidente queda en el historial del local junto a las advertencias de humo de la galería.

![Wireflow WF-M2](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M2-responder-alerta-de-intrusion.jpg)

**WF-M3 · Reportar un incidente y seguir su estado**

**User Goal:** Como inquilino, quiero reportar un incidente no detectado y saber si la administración ya lo atiende.

Desde Alertas, el inquilino reporta un incidente; la descripción es obligatoria. El reporte se registra como Pendiente y, cuando la administración cambia su estado, el inquilino recibe la notificación y lo ve en Mis reportes.

![Wireflow WF-M3](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M3-reportar-incidente-y-seguir-estado.jpg)

**WF-M4 · Revisar consumo, recibo y presentar un reclamo**

**User Goal:** Como inquilino, quiero ver mi consumo real y el desglose de mi recibo para reclamar si encuentro una discrepancia.

El inquilino consulta el consumo acumulado del periodo, abre el recibo con el desglose (consumo × tarifa) y presenta un reclamo vinculado a la factura. La respuesta y los comunicados de la administración llegan a Mensajes.

![Wireflow WF-M4](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M4-revisar-consumo-recibo-y-reclamar.jpg)

**WF-M5 · Configurar horario y notificaciones**

**User Goal:** Como inquilino, quiero definir el horario de atención de mi local y elegir qué avisos recibo en el teléfono.

Desde Perfil, el inquilino registra la apertura y el cierre por día (un cierre anterior a la apertura se rechaza) y ajusta sus preferencias. Las alertas críticas de intrusión y humo permanecen siempre activas.

![Wireflow WF-M5](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M5-configurar-horario-y-notificaciones.jpg)

**WF-M6 · Consultar el historial sin conexión**

**User Goal:** Como inquilino, quiero consultar mi historial de eventos y consumo aunque pierda la conexión a Internet.

Si el teléfono pierde la conexión, la app muestra en modo solo lectura los datos sincronizados con su fecha y hora. Al reconectarse, sincroniza automáticamente y vuelve a la vista normal.

![Wireflow WF-M6](../../assets/applications-ux-ui-design/mobile-wireflows/WF-M6-consultar-historial-sin-conexion.jpg)

## 5.4.3. Applications Mock-ups

Los mock-ups representan la versión de alta fidelidad de las pantallas definidas en los wireframes. En ellos se aplica el Design System de StorePulse establecido en 5.1, de modo que la web y la app móvil se perciben como un mismo producto:

* **Color:** Deep Slate Navy `#0F172A` como color institucional (sidebar, encabezados y fondos oscuros del acceso) y Electric Pulse Cyan `#0EA5E9` para acciones primarias, enlaces activos y estados de foco. Los colores semánticos comunican el estado de forma consistente con los LED del dispositivo IoT: rojo para intrusión y humo, ámbar para advertencias y pendientes, verde para estados normales y pagados, y azul para estados en atención.
* **Tipografía:** Plus Jakarta Sans para títulos y componentes de interfaz, Inter para tablas y bloques densos de datos, y JetBrains Mono para identificadores de dispositivos, códigos de incidente, lecturas y montos.
* **Componentes:** cards con radio de 12 px y borde sutil, botones primario, secundario (outline) y destructivo, chips de estado con punto de color y texto, formularios con etiqueta superior y mensaje de validación, y tablas con paginación al pie.
* **Espaciado y retícula:** sistema modular de 8 px; en web, sidebar fija y topbar de 64 px; en móvil, márgenes de 16 px y barra de navegación inferior.
* **Accesibilidad:** contraste mínimo de 4.5:1 en texto (WCAG 2.1 AA), estados acompañados de texto e ícono y no solo de color, y selector de idioma EN/ES en la web.

### 5.4.3.1. Web Application

**W01 · Bienvenida**

Pantalla de bienvenida que transmite la identidad de StorePulse con su fondo institucional y un plano de la galería que destaca el local con incidente, invitando a iniciar sesión o registrar la galería.

![Mock-up W01 Bienvenida](../../assets/applications-ux-ui-design/web-mockups/W01-bienvenida.jpg)

**W02 · Iniciar Sesión**

Pantalla de acceso limpia y directa, en la que el campo activo se resalta y un aviso informativo recuerda que la plataforma web es exclusiva para el administrador.

![Mock-up W02 Iniciar Sesión](../../assets/applications-ux-ui-design/web-mockups/W02-iniciar-sesion.jpg)

**W03 · Recuperar contraseña**

Pantalla de recuperación de acceso que facilita la lectura del código de verificación y señala con claridad cuando este no es válido.

![Mock-up W03 Recuperar contraseña](../../assets/applications-ux-ui-design/web-mockups/W03-recuperar-contrasena.jpg)

**W04 · Registro de cuenta**

Pantalla de creación de cuenta que muestra el avance del registro y confirma en tiempo real si la contraseña cumple los requisitos de seguridad.

![Mock-up W04 Registro de cuenta](../../assets/applications-ux-ui-design/web-mockups/W04-registro-de-cuenta.jpg)

**W05 · Registro de galería**

Pantalla de registro de la galería que acompaña al administrador en el segundo paso y le indica de forma visible qué datos faltan completar.

![Mock-up W05 Registro de galería](../../assets/applications-ux-ui-design/web-mockups/W05-registro-de-galeria.jpg)

**W06 · Elegir plan y pago**

Pantalla de selección de plan que resalta la opción elegida y muestra el total a pagar antes de activar la suscripción, transmitiendo confianza con un aviso de pago seguro.

![Mock-up W06 Elegir plan y pago](../../assets/applications-ux-ui-design/web-mockups/W06-elegir-plan-y-pago.jpg)

**W07 · Dashboard sin datos**

Pantalla de bienvenida al panel que orienta al nuevo administrador con una llamada clara a registrar su primer local y una guía que muestra su avance en la configuración.

![Mock-up W07 Dashboard sin datos](../../assets/applications-ux-ui-design/web-mockups/W07-dashboard-sin-datos.jpg)

**W08 · Dashboard**

Panel de control principal que ofrece una visión completa de la galería, destacando en rojo el local con incidente activo y mostrando la evolución del consumo frente al año anterior.

![Mock-up W08 Dashboard](../../assets/applications-ux-ui-design/web-mockups/W08-dashboard.jpg)

**W09 · Centro de notificaciones**

Centro de notificaciones que agrupa los eventos de la galería y los distingue con íconos y colores según su tipo y estado.

![Mock-up W09 Centro de notificaciones](../../assets/applications-ux-ui-design/web-mockups/W09-centro-de-notificaciones.jpg)

**W10 · Alerta de intrusión**

Alerta de seguridad de alta prioridad que se superpone a la pantalla al detectarse una intrusión, mostrando el tiempo transcurrido sin confirmar y protegiendo la privacidad del inquilino.

![Mock-up W10 Alerta de intrusión](../../assets/applications-ux-ui-design/web-mockups/W10-alerta-de-intrusion.jpg)

**W11 · Locales comerciales**

Vista de gestión de locales que permite identificar rápidamente la ocupación de la galería y consultar los datos del inquilino y los dispositivos de cada local.

![Mock-up W11 Locales comerciales](../../assets/applications-ux-ui-design/web-mockups/W11-locales-comerciales.jpg)

**W12 · Registrar local**

Formulario de registro de local que evita duplicados advirtiendo al administrador cuando el número ingresado ya existe en la galería.

![Mock-up W12 Registrar local](../../assets/applications-ux-ui-design/web-mockups/W12-registrar-local.jpg)

**W13 · Invitar inquilino**

Invitación al inquilino que deja claro a qué local queda vinculado el acceso y durante cuánto tiempo es válida.

![Mock-up W13 Invitar inquilino](../../assets/applications-ux-ui-design/web-mockups/W13-invitar-inquilino.jpg)

**W14 · Inmueble y áreas comunes**

Ficha del inmueble que resume la información de la galería y permite comparar visualmente la ocupación de cada piso y el estado de las áreas comunes.

![Mock-up W14 Inmueble y áreas comunes](../../assets/applications-ux-ui-design/web-mockups/W14-inmueble-y-areas-comunes.jpg)

**W15 · Registrar área común**

Formulario de registro de áreas comunes que valida que el nombre no se repita dentro de la galería.

![Mock-up W15 Registrar área común](../../assets/applications-ux-ui-design/web-mockups/W15-registrar-area-comun.jpg)

**W16 · Dispositivos IoT**

Panel de supervisión de dispositivos que alerta sobre los nodos desconectados, destaca los voltajes fuera de rango y explica el significado de las luces del nodo.

![Mock-up W16 Dispositivos IoT](../../assets/applications-ux-ui-design/web-mockups/W16-dispositivos-iot.jpg)

**W17 · Registrar dispositivo**

Formulario de registro de dispositivos que vincula cada nodo o medidor a un local y advierte si el identificador ya está en uso.

![Mock-up W17 Registrar dispositivo](../../assets/applications-ux-ui-design/web-mockups/W17-registrar-dispositivo.jpg)

**W18 · Consumo de luz y agua**

Panel de consumo que permite detectar a simple vista los locales que superan su línea base y entender si el exceso ocurrió fuera del horario de atención.

![Mock-up W18 Consumo de luz y agua](../../assets/applications-ux-ui-design/web-mockups/W18-consumo-de-luz-y-agua.jpg)

**W19 · Seguridad e incidentes**

Módulo de seguridad que prioriza el incidente pendiente con un aviso destacado y permite revisar el historial y la rapidez de respuesta de la administración.

![Mock-up W19 Seguridad e incidentes](../../assets/applications-ux-ui-design/web-mockups/W19-seguridad-e-incidentes.jpg)

**W20 · Detalle de incidente**

Detalle del incidente que confirma su atención y muestra su trazabilidad en una línea de tiempo, preservando la privacidad de las imágenes del local.

![Mock-up W20 Detalle de incidente](../../assets/applications-ux-ui-design/web-mockups/W20-detalle-de-incidente.jpg)

**W21 · Facturación**

Módulo de facturación que muestra el estado de cobro de cada recibo con etiquetas de color y destaca los reclamos que requieren revisión.

![Mock-up W21 Facturación](../../assets/applications-ux-ui-design/web-mockups/W21-facturacion.jpg)

**W22 · Configurar tarifas**

Configuración de tarifas que impide guardar valores no válidos y aclara desde qué periodo se aplicarán los cambios.

![Mock-up W22 Configurar tarifas](../../assets/applications-ux-ui-design/web-mockups/W22-configurar-tarifas.jpg)

**W23 · Generar facturación**

Confirmación de facturación que advierte sobre las mediciones incompletas antes de emitir los recibos, evitando cobros sin sustento.

![Mock-up W23 Generar facturación](../../assets/applications-ux-ui-design/web-mockups/W23-generar-facturacion.jpg)

**W24 · Registrar pago**

Registro de pago que destaca el monto del recibo y confirma que el inquilino será notificado al completarse la operación.

![Mock-up W24 Registrar pago](../../assets/applications-ux-ui-design/web-mockups/W24-registrar-pago.jpg)

**W25 · Comunicación y reclamos**

Espacio de comunicación que permite resolver un reclamo con evidencia, mostrando el consumo diario del local y la fórmula del cobro junto a la conversación.

![Mock-up W25 Comunicación y reclamos](../../assets/applications-ux-ui-design/web-mockups/W25-comunicacion-y-reclamos.jpg)

**W26 · Suscripción**

Vista de suscripción que confirma que la renovación automática está activa y facilita comparar el plan actual con las demás opciones.

![Mock-up W26 Suscripción](../../assets/applications-ux-ui-design/web-mockups/W26-suscripcion.jpg)

**W27 · Cancelar renovación**

Confirmación de cancelación que tranquiliza al administrador al indicarle que su servicio sigue vigente hasta la fecha de vencimiento.

![Mock-up W27 Cancelar renovación](../../assets/applications-ux-ui-design/web-mockups/W27-cancelar-renovacion.jpg)

**W28 · Mi perfil**

Perfil del administrador que permite actualizar sus datos, valida el correo ingresado y recuerda la próxima renovación de su suscripción.

![Mock-up W28 Mi perfil](../../assets/applications-ux-ui-design/web-mockups/W28-mi-perfil.jpg)

**W29 · Menú de usuario**

Menú de cuenta que reúne las opciones personales y separa claramente la acción de cerrar sesión.

![Mock-up W29 Menú de usuario](../../assets/applications-ux-ui-design/web-mockups/W29-menu-de-usuario.jpg)

**W30 · Desactivar dispositivo**

Confirmación de desactivación que advierte sobre la pérdida de monitoreo del local antes de completar la acción.

![Mock-up W30 Desactivar dispositivo](../../assets/applications-ux-ui-design/web-mockups/W30-desactivar-dispositivo.jpg)

**W31 · Eliminar local (bloqueado)**

Aviso preventivo que impide eliminar un local con dispositivos vinculados y lleva al administrador directamente al módulo de dispositivos.

![Mock-up W31 Eliminar local bloqueado](../../assets/applications-ux-ui-design/web-mockups/W31-eliminar-local-bloqueado.jpg)

**W32 · Renovación cancelada**

Vista de suscripción tras cancelar la renovación, que informa la fecha de vencimiento y ofrece reactivarla con un solo clic.

![Mock-up W32 Renovación cancelada](../../assets/applications-ux-ui-design/web-mockups/W32-renovacion-cancelada.jpg)

### 5.4.3.2. Mobile Application

**M01 · Activar cuenta (invitación)**

Pantalla de activación que da la bienvenida al inquilino mostrando el local al que fue invitado y lo guía para crear su contraseña de forma segura.

![Mock-up M01 Activar cuenta](../../assets/applications-ux-ui-design/mobile-mockups/M01-activar-cuenta-invitacion.jpg)

**M02 · Iniciar sesión**

Pantalla de inicio de sesión sencilla y familiar, pensada para que el inquilino acceda rápidamente a la información de su local.

![Mock-up M02 Iniciar sesión](../../assets/applications-ux-ui-design/mobile-mockups/M02-iniciar-sesion.jpg)

**M03 · Recuperar contraseña**

Pantalla de recuperación que facilita ingresar el código desde el teléfono y definir una nueva contraseña sin salir de la app.

![Mock-up M03 Recuperar contraseña](../../assets/applications-ux-ui-design/mobile-mockups/M03-recuperar-contrasena.jpg)

**M04 · Mi Local**

Pantalla principal que tranquiliza al inquilino confirmando que su local está seguro y le muestra su consumo, sus dispositivos y la última alerta.

![Mock-up M04 Mi Local](../../assets/applications-ux-ui-design/mobile-mockups/M04-mi-local.jpg)

**M05 · Mi Local sin dispositivos**

Pantalla de estado vacío que explica al inquilino que el monitoreo se activará tras la instalación, evitando dudas mientras tanto.

![Mock-up M05 Mi Local sin dispositivos](../../assets/applications-ux-ui-design/mobile-mockups/M05-mi-local-sin-dispositivos.jpg)

**M06 · Alerta de intrusión**

Alerta crítica que notifica al inquilino una intrusión en su local con la imagen capturada, la hora del evento y el estado de la atención.

![Mock-up M06 Alerta de intrusión](../../assets/applications-ux-ui-design/mobile-mockups/M06-alerta-de-intrusion.jpg)

**M07 · Alertas (historial)**

Historial de alertas que reúne los incidentes del local y los avisos de la galería, con acceso rápido para reportar un nuevo problema.

![Mock-up M07 Alertas historial](../../assets/applications-ux-ui-design/mobile-mockups/M07-alertas-historial.jpg)

**M08 · Detalle de incidente**

Detalle del incidente que muestra la evidencia del evento y permite al inquilino seguir cómo avanza su atención.

![Mock-up M08 Detalle de incidente](../../assets/applications-ux-ui-design/mobile-mockups/M08-detalle-de-incidente.jpg)

**M09 · Reportar incidente**

Formulario de reporte que permite al inquilino informar a la administración sobre un incidente no detectado, adjuntando una foto si lo desea.

![Mock-up M09 Reportar incidente](../../assets/applications-ux-ui-design/mobile-mockups/M09-reportar-incidente.jpg)

**M10 · Mis reportes**

Seguimiento de reportes que informa al inquilino cada cambio de estado y le muestra en qué etapa de atención se encuentra su caso.

![Mock-up M10 Mis reportes](../../assets/applications-ux-ui-design/mobile-mockups/M10-mis-reportes.jpg)

**M11 · Consumos**

Vista de consumos que permite al inquilino comparar su gasto de energía y agua mes a mes y acceder a su recibo del periodo.

![Mock-up M11 Consumos](../../assets/applications-ux-ui-design/mobile-mockups/M11-consumos.jpg)

**M12 · Recibo y desglose**

Recibo detallado que explica al inquilino cómo se calculó su monto a partir de su consumo real, aportando transparencia al cobro.

![Mock-up M12 Recibo y desglose](../../assets/applications-ux-ui-design/mobile-mockups/M12-recibo-y-desglose.jpg)

**M13 · Presentar reclamo**

Formulario de reclamo vinculado al recibo, que permite al inquilino sustentar su caso y evita reclamos duplicados.

![Mock-up M13 Presentar reclamo](../../assets/applications-ux-ui-design/mobile-mockups/M13-presentar-reclamo.jpg)

**M14 · Mensajes**

Bandeja de mensajes que centraliza la comunicación con la administración y distingue comunicados, reclamos y avisos del local.

![Mock-up M14 Mensajes](../../assets/applications-ux-ui-design/mobile-mockups/M14-mensajes.jpg)

**M15 · Perfil**

Perfil del inquilino que reúne sus datos y las opciones de configuración de la app en un solo lugar.

![Mock-up M15 Perfil](../../assets/applications-ux-ui-design/mobile-mockups/M15-perfil.jpg)

**M16 · Horario de atención**

Configuración del horario de atención que ayuda al inquilino a definir cuándo su local está cerrado y le advierte si ingresa un horario inválido.

![Mock-up M16 Horario de atención](../../assets/applications-ux-ui-design/mobile-mockups/M16-horario-de-atencion.jpg)

**M17 · Preferencias de notificación**

Preferencias de notificación que permiten al inquilino personalizar sus avisos, garantizando que las alertas de intrusión y humo siempre lleguen.

![Mock-up M17 Preferencias de notificación](../../assets/applications-ux-ui-design/mobile-mockups/M17-preferencias-de-notificacion.jpg)

**M18 · Consumos sin conexión**

Vista de consumos sin conexión que mantiene disponible la información del local en modo lectura e indica cuándo fue la última sincronización.

![Mock-up M18 Consumos sin conexión](../../assets/applications-ux-ui-design/mobile-mockups/M18-consumos-sin-conexion.jpg)
