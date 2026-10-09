# 5.4. Applications UX/UI Design

En esta sección se presenta la propuesta visual y de interacción de las aplicaciones que conforman la experiencia de usuario de StorePulse: la **aplicación web**, orientada al administrador de la galería comercial, y la **aplicación móvil**, orientada al inquilino del local comercial. El diseño traduce las decisiones de la arquitectura de información y de la guía de estilos en pantallas concretas, priorizando la atención inmediata de alertas de seguridad, la lectura clara del consumo de luz y agua y la facturación sustentada en datos medidos.

Los wireframes, wireflows, mock-ups y user flows fueron elaborados en Figma, y se organizan en cuatro secciones internas: wireframes de las aplicaciones, wireflow diagrams por User Goal, mock-ups de alta fidelidad y user flow diagrams con sus rutas esperadas y alternativas.

## 5.4.1. Applications Wireframes

Los wireframes definen la estructura de cada pantalla antes de aplicar el diseño visual definitivo. Se trabajaron en escala de grises para concentrar la evaluación en la distribución de los componentes, la jerarquía de la información y la ubicación de las acciones principales, sin la distracción del color ni de la marca.

En la propuesta se evidencian los siguientes criterios:

* **Principios y elementos de diseño:** jerarquía visual mediante tamaño y peso tipográfico, proximidad para agrupar datos relacionados (indicadores, tablas y paneles laterales) y alineación a una cuadrícula con espaciado modular de 8 px.
* **Diseño inclusivo:** etiquetas visibles sobre cada campo, mensajes de validación junto al campo con error, estados que no dependen solo del color (texto + ícono) y áreas táctiles amplias en móvil.
* **Arquitectura de información:** la web replica el sistema de navegación global definido en la arquitectura de información (sidebar con los módulos Dashboard, Commercial Units, Devices, Utility Meters, Billing, Security & Incidents, Communication y Subscription, y topbar con galería activa, estado global, periodo, idioma y usuario), mientras que la app móvil usa una barra de navegación inferior con cinco destinos (Mi Local, Consumos, Alertas, Mensajes y Perfil).

### 5.4.1.1. Web Application

La aplicación web concentra la gestión integral de la galería. Sus wireframes están diseñados para una resolución de escritorio de 1440 px, con un área de contenido que prioriza los indicadores clave en la parte superior y las tablas de detalle debajo. Las acciones secundarias y las confirmaciones se presentan como modales sobre la pantalla de origen para no perder el contexto del usuario.

**W01 · Bienvenida**

Esquema de la pantalla de entrada a la plataforma, que presenta la propuesta de valor de StorePulse junto a los accesos para iniciar sesión, registrar una galería o, en el caso del inquilino, activar su cuenta por invitación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W01-bienvenida.jpg" alt="Wireframe W01 Bienvenida" width="640">
</p>

**W02 · Iniciar Sesión**

Esquema del formulario de acceso para el administrador, que organiza las credenciales, la recuperación de contraseña y una aclaración de que el inquilino ingresa desde la app móvil.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W02-iniciar-sesion.jpg" alt="Wireframe W02 Iniciar Sesión" width="640">
</p>

**W03 · Recuperar contraseña**

Esquema del proceso de recuperación de acceso, en el que el administrador valida el código de seis dígitos enviado a su correo y define una nueva contraseña.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W03-recuperar-contrasena.jpg" alt="Wireframe W03 Recuperar contraseña" width="640">
</p>

**W04 · Registro de cuenta**

Esquema del primer paso del registro, donde el administrador crea su cuenta y conoce desde el inicio los requisitos de seguridad de su contraseña.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W04-registro-de-cuenta.jpg" alt="Wireframe W04 Registro de cuenta" width="640">
</p>

**W05 · Registro de galería**

Esquema del segundo paso del registro, destinado a recopilar los datos básicos de la galería comercial que se va a monitorear.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W05-registro-de-galeria.jpg" alt="Wireframe W05 Registro de galería" width="640">
</p>

**W06 · Elegir plan y pago**

Esquema del paso final del registro, en el que el administrador elige el plan que mejor se ajusta al tamaño de su galería y activa la suscripción con su pago.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W06-elegir-plan-y-pago.jpg" alt="Wireframe W06 Elegir plan y pago" width="640">
</p>

**W07 · Dashboard sin datos**

Esquema del primer ingreso a la plataforma, que guía al administrador a registrar sus locales y vincular sus dispositivos mientras aún no existe actividad que mostrar.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W07-dashboard-sin-datos.jpg" alt="Wireframe W07 Dashboard sin datos" width="640">
</p>

**W08 · Dashboard**

Esquema del panel principal de la galería, que reúne en una sola vista los incidentes activos, el consumo de energía y agua, las alertas recientes, el estado de seguridad por local y el avance de la cobranza.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W08-dashboard.jpg" alt="Wireframe W08 Dashboard" width="640">
</p>

**W09 · Centro de notificaciones**

Esquema del centro de notificaciones, que permite revisar en orden cronológico los eventos recientes de la galería y filtrarlos por categoría.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W09-centro-de-notificaciones.jpg" alt="Wireframe W09 Centro de notificaciones" width="640">
</p>

**W10 · Alerta de intrusión**

Esquema de la alerta de alta prioridad que interrumpe la navegación cuando se detecta una intrusión fuera del horario de atención, para que el administrador la confirme de inmediato.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W10-alerta-de-intrusion.jpg" alt="Wireframe W10 Alerta de intrusión" width="640">
</p>

**W11 · Locales comerciales**

Esquema del módulo de locales, donde el administrador consulta la ocupación de la galería, busca locales y revisa el inquilino y los dispositivos de cada uno.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W11-locales-comerciales.jpg" alt="Wireframe W11 Locales comerciales" width="640">
</p>

**W12 · Registrar local**

Esquema del formulario para incorporar o editar un local de la galería, que advierte cuando el número ingresado ya existe.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W12-registrar-local.jpg" alt="Wireframe W12 Registrar local" width="640">
</p>

**W13 · Invitar inquilino**

Esquema del envío de una invitación por correo al inquilino, vinculada únicamente a su local y con una vigencia limitada.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W13-invitar-inquilino.jpg" alt="Wireframe W13 Invitar inquilino" width="640">
</p>

**W14 · Inmueble y áreas comunes**

Esquema de la ficha general del inmueble, que resume los datos de la galería, la ocupación por piso y las áreas comunes que también se monitorean.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W14-inmueble-y-areas-comunes.jpg" alt="Wireframe W14 Inmueble y áreas comunes" width="640">
</p>

**W15 · Registrar área común**

Esquema del registro de un área común, como un pasillo o una escalera, que queda bajo el monitoreo de la administración.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W15-registrar-area-comun.jpg" alt="Wireframe W15 Registrar área común" width="640">
</p>

**W16 · Dispositivos IoT**

Esquema del panel de supervisión de los nodos IoT, que muestra su estado, conectividad, voltaje y último reporte, junto con los eventos pendientes de sincronizar.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W16-dispositivos-iot.jpg" alt="Wireframe W16 Dispositivos IoT" width="640">
</p>

**W17 · Registrar dispositivo**

Esquema del registro de un nuevo nodo o medidor y su vinculación a un local, con la validación de identificadores duplicados.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W17-registrar-dispositivo.jpg" alt="Wireframe W17 Registrar dispositivo" width="640">
</p>

**W18 · Consumo de luz y agua**

Esquema del módulo de medición, que compara el consumo de cada local con su historial y su línea base para detectar desviaciones fuera de lo habitual.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W18-consumo-de-luz-y-agua.jpg" alt="Wireframe W18 Consumo de luz y agua" width="640">
</p>

**W19 · Seguridad e incidentes**

Esquema del módulo de seguridad, que reúne el incidente pendiente de atención, los indicadores de respuesta y el historial completo de intrusiones, humo y reportes manuales.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W19-seguridad-e-incidentes.jpg" alt="Wireframe W19 Seguridad e incidentes" width="640">
</p>

**W20 · Detalle de incidente**

Esquema del seguimiento de un incidente, desde su detección hasta el registro del resultado de la atención, respetando la privacidad de las imágenes del local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W20-detalle-de-incidente.jpg" alt="Wireframe W20 Detalle de incidente" width="640">
</p>

**W21 · Facturación**

Esquema del módulo de facturación, que muestra el estado de cobro de los recibos de cada local, las tarifas vigentes y los reclamos abiertos.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W21-facturacion.jpg" alt="Wireframe W21 Facturación" width="640">
</p>

**W22 · Configurar tarifas**

Esquema de la configuración de las tarifas de luz y agua y del día de cierre del periodo, que se aplican a partir de la siguiente facturación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W22-configurar-tarifas.jpg" alt="Wireframe W22 Configurar tarifas" width="640">
</p>

**W23 · Generar facturación**

Esquema de la confirmación previa a la emisión de recibos, que resume el periodo y advierte sobre los locales con mediciones incompletas.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W23-generar-facturacion.jpg" alt="Wireframe W23 Generar facturación" width="640">
</p>

**W24 · Registrar pago**

Esquema del registro del pago de un recibo, que actualiza su estado y notifica al inquilino.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W24-registrar-pago.jpg" alt="Wireframe W24 Registrar pago" width="640">
</p>

**W25 · Comunicación y reclamos**

Esquema del canal de comunicación con los inquilinos, que permite responder un reclamo apoyándose en el desglose real del consumo del local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W25-comunicacion-y-reclamos.jpg" alt="Wireframe W25 Comunicación y reclamos" width="640">
</p>

**W26 · Suscripción**

Esquema de la gestión de la suscripción, donde el administrador revisa su plan, la renovación automática, otros planes disponibles y sus pagos.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W26-suscripcion.jpg" alt="Wireframe W26 Suscripción" width="640">
</p>

**W27 · Cancelar renovación**

Esquema de la confirmación para cancelar la renovación automática, que aclara que el servicio continúa hasta su fecha de vencimiento.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W27-cancelar-renovacion.jpg" alt="Wireframe W27 Cancelar renovación" width="640">
</p>

**W28 · Mi perfil**

Esquema del perfil del administrador, donde puede actualizar sus datos personales y revisar el estado de su suscripción.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W28-mi-perfil.jpg" alt="Wireframe W28 Mi perfil" width="640">
</p>

**W29 · Menú de usuario**

Esquema del menú de cuenta, que da acceso rápido al perfil, la suscripción, el idioma y el cierre de sesión.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W29-menu-de-usuario.jpg" alt="Wireframe W29 Menú de usuario" width="640">
</p>

**W30 · Desactivar dispositivo**

Esquema de la confirmación para desactivar un dispositivo, que advierte que el local quedará sin monitoreo y solicita el motivo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W30-desactivar-dispositivo.jpg" alt="Wireframe W30 Desactivar dispositivo" width="640">
</p>

**W31 · Eliminar local (bloqueado)**

Esquema del aviso que impide eliminar un local mientras tenga dispositivos vinculados, indicando los pasos necesarios para darlo de baja.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W31-eliminar-local-bloqueado.jpg" alt="Wireframe W31 Eliminar local bloqueado" width="640">
</p>

**W32 · Renovación cancelada**

Esquema del estado de la suscripción luego de cancelar la renovación, con la opción de reactivarla antes del vencimiento.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireframes/W32-renovacion-cancelada.jpg" alt="Wireframe W32 Renovación cancelada" width="640">
</p>

### 5.4.1.2. Mobile Application

La aplicación móvil está pensada para el inquilino, que necesita enterarse de inmediato de lo que ocurre en su local y revisar su consumo sin esfuerzo. Los wireframes se diseñaron para una pantalla de 390 × 844 px, con una sola columna, la acción principal fija en la parte inferior y una barra de navegación inferior al alcance del pulgar.

**M01 · Activar cuenta (invitación)**

Esquema de la activación de la cuenta del inquilino a partir de la invitación de la administración, ya vinculada a su local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M01-activar-cuenta-invitacion.jpg" alt="Wireframe M01 Activar cuenta" width="260">
</p>

**M02 · Iniciar sesión**

Esquema del acceso a la app móvil, pensado para que el inquilino ingrese y consulte solo la información de su local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M02-iniciar-sesion.jpg" alt="Wireframe M02 Iniciar sesión" width="260">
</p>

**M03 · Recuperar contraseña**

Esquema de la recuperación de contraseña desde el teléfono, mediante un código de seis dígitos enviado al correo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M03-recuperar-contrasena.jpg" alt="Wireframe M03 Recuperar contraseña" width="260">
</p>

**M04 · Mi Local**

Esquema de la pantalla principal del inquilino, que le confirma de un vistazo si su local está seguro, cuánto ha consumido y si sus dispositivos funcionan.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M04-mi-local.jpg" alt="Wireframe M04 Mi Local" width="260">
</p>

**M05 · Mi Local sin dispositivos**

Esquema de la pantalla principal cuando el local aún no cuenta con dispositivos, que explica que el monitoreo se activará tras la instalación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M05-mi-local-sin-dispositivos.jpg" alt="Wireframe M05 Mi Local sin dispositivos" width="260">
</p>

**M06 · Alerta de intrusión**

Esquema de la alerta crítica que recibe el inquilino cuando se detecta una intrusión en su local, acompañada de la imagen capturada y el estado de la atención.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M06-alerta-de-intrusion.jpg" alt="Wireframe M06 Alerta de intrusión" width="260">
</p>

**M07 · Alertas (historial)**

Esquema del historial de incidentes del local y de los avisos generales de la galería, desde donde el inquilino también puede reportar un problema.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M07-alertas-historial.jpg" alt="Wireframe M07 Alertas historial" width="260">
</p>

**M08 · Detalle de incidente**

Esquema del detalle de un incidente, que permite al inquilino seguir paso a paso cómo lo atiende la administración.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M08-detalle-de-incidente.jpg" alt="Wireframe M08 Detalle de incidente" width="260">
</p>

**M09 · Reportar incidente**

Esquema del formulario para reportar un incidente que los sensores no detectaron, enviado directamente a la administración.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M09-reportar-incidente.jpg" alt="Wireframe M09 Reportar incidente" width="260">
</p>

**M10 · Mis reportes**

Esquema del seguimiento de los reportes enviados por el inquilino, que muestra en qué etapa de atención se encuentra cada uno.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M10-mis-reportes.jpg" alt="Wireframe M10 Mis reportes" width="260">
</p>

**M11 · Consumos**

Esquema de la consulta del consumo de energía y agua del local, con su evolución en los últimos meses y acceso al recibo del periodo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M11-consumos.jpg" alt="Wireframe M11 Consumos" width="260">
</p>

**M12 · Recibo y desglose**

Esquema del recibo del inquilino, que explica cómo se calculó el monto a partir de su consumo real y de las tarifas vigentes.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M12-recibo-y-desglose.jpg" alt="Wireframe M12 Recibo y desglose" width="260">
</p>

**M13 · Presentar reclamo**

Esquema del formulario para presentar un reclamo sobre un recibo, con la posibilidad de adjuntar un sustento.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M13-presentar-reclamo.jpg" alt="Wireframe M13 Presentar reclamo" width="260">
</p>

**M14 · Mensajes**

Esquema de la bandeja de mensajes, que reúne los comunicados de la administración, las respuestas a reclamos y los avisos del local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M14-mensajes.jpg" alt="Wireframe M14 Mensajes" width="260">
</p>

**M15 · Perfil**

Esquema del perfil del inquilino, desde donde accede a la configuración de su horario, sus notificaciones y su idioma.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M15-perfil.jpg" alt="Wireframe M15 Perfil" width="260">
</p>

**M16 · Horario de atención**

Esquema de la configuración del horario de atención del local, que define en qué momentos se generan las alertas de intrusión.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M16-horario-de-atencion.jpg" alt="Wireframe M16 Horario de atención" width="260">
</p>

**M17 · Preferencias de notificación**

Esquema de las preferencias de notificación, donde el inquilino elige qué avisos recibir, mientras las alertas de intrusión y humo permanecen siempre activas.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M17-preferencias-de-notificacion.jpg" alt="Wireframe M17 Preferencias de notificación" width="260">
</p>

**M18 · Consumos sin conexión**

Esquema de la consulta de consumos sin conexión a Internet, en la que la app muestra en modo lectura los últimos datos sincronizados.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireframes/M18-consumos-sin-conexion.jpg" alt="Wireframe M18 Consumos sin conexión" width="260">
</p>

## 5.4.2. Applications Wireflow Diagrams

Un wireflow combina los wireframes con las acciones del usuario que conectan una pantalla con la siguiente. Se elaboró un wireflow por cada User Goal de los User Persona del alcance: siete para el administrador en la aplicación web y seis para el inquilino en la aplicación móvil. Cuando una interacción cambia el estado de una pantalla (por ejemplo, al abrir un modal o mostrar un error), se agrega un nuevo paso con el wireframe que representa ese estado.

### 5.4.2.1. Web Application

**WF-01 · Registrar la galería y activar la suscripción**

**User Goal:** Como administrador, quiero registrar mi cuenta y mi galería y activar un plan para empezar a monitorear los locales.

Desde la bienvenida, el administrador crea su cuenta, registra los datos de su galería, elige un plan y realiza el pago. Si la contraseña no es segura, se le indica en el mismo paso. Al terminar, llega al dashboard todavía sin datos, desde donde registra su primer local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-01-registrar-galeria-y-activar-suscripcion.jpg" alt="Wireflow WF-01" width="100%">
</p>

**WF-02 · Acceder a la plataforma y recuperar la contraseña**

**User Goal:** Como administrador, quiero iniciar y cerrar sesión de forma segura y recuperar mi contraseña si la olvido.

El administrador inicia sesión y accede al dashboard consolidado. Si olvidó su contraseña, la recupera con un código de seis dígitos enviado a su correo, válido por 15 minutos, y vuelve a iniciar sesión. Al terminar, cierra sesión desde el menú de usuario.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-02-acceder-y-recuperar-contrasena.jpg" alt="Wireflow WF-02" width="100%">
</p>

**WF-03 · Atender una alerta de intrusión**

**User Goal:** Como administrador, quiero recibir la alerta de intrusión, confirmar su atención y registrar el resultado para resolver el incidente.

La alerta aparece sobre cualquier pantalla en cuanto se detecta la intrusión, y también puede abrirse desde el centro de notificaciones. Al confirmar la atención, el incidente pasa de Pendiente a En atención. Desde el detalle, el administrador notifica al inquilino y registra el resultado, con lo que el incidente queda resuelto en el historial.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-03-atender-alerta-de-intrusion.jpg" alt="Wireflow WF-03" width="100%">
</p>

**WF-04 · Gestionar locales e invitar inquilinos**

**User Goal:** Como administrador, quiero registrar y mantener los locales de mi galería e invitar a cada inquilino a su local.

Desde el módulo de locales, el administrador registra un nuevo local, invita a su inquilino por correo con una invitación válida por siete días y consulta el inmueble para registrar las áreas comunes. Si el número de local ya existe, el sistema no lo acepta, y un local con dispositivos vinculados no puede eliminarse.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-04-gestionar-locales-e-invitar-inquilinos.jpg" alt="Wireflow WF-04" width="100%">
</p>

**WF-05 · Supervisar los dispositivos IoT**

**User Goal:** Como administrador, quiero registrar, revisar y desactivar los dispositivos IoT para mantener el monitoreo operativo.

El administrador abre el módulo de dispositivos desde el dashboard y revisa su conectividad, las fallas de voltaje y los eventos pendientes de sincronizar. Luego registra un nuevo dispositivo, que el sistema rechaza si su identificador ya existe, y desactiva o reactiva un nodo cuando lo necesita.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-05-supervisar-dispositivos-iot.jpg" alt="Wireflow WF-05" width="100%">
</p>

**WF-06 · Facturar el consumo y registrar pagos**

**User Goal:** Como administrador, quiero configurar tarifas, generar recibos por consumo real, registrar pagos y atender reclamos.

Tras revisar el consumo frente a la línea base, el administrador configura las tarifas, genera la facturación del periodo y registra los pagos. El sistema no acepta tarifas menores o iguales a cero y advierte cuando hay mediciones incompletas. Los reclamos se resuelven apoyándose en el desglose del consumo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-06-facturar-consumo-y-registrar-pagos.jpg" alt="Wireflow WF-06" width="100%">
</p>

**WF-07 · Gestionar la suscripción y el perfil**

**User Goal:** Como administrador, quiero consultar mi suscripción, controlar la renovación automática y mantener mis datos de perfil.

Desde el menú de usuario, el administrador entra a su suscripción y cancela la renovación automática, sabiendo que el servicio sigue vigente hasta su vencimiento y que puede reactivarla cuando quiera. Desde su perfil revisa el plan contratado y actualiza sus datos.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-wireflows/WF-07-gestionar-suscripcion-y-perfil.jpg" alt="Wireflow WF-07" width="100%">
</p>

### 5.4.2.2. Mobile Application

**WF-M1 · Activar la cuenta e ingresar a la app**

**User Goal:** Como inquilino, quiero activar mi cuenta con la invitación de la administración e ingresar para ver mi local.

El inquilino abre el enlace de invitación, que ya está vinculado a su local, crea su contraseña e inicia sesión; si la olvida, la recupera con un código de seis dígitos. Luego ve el panel de su local, que le indica si el monitoreo todavía está pendiente de instalación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M1-activar-cuenta-e-ingresar.jpg" alt="Wireflow WF-M1" width="100%">
</p>

**WF-M2 · Responder a una alerta de intrusión**

**User Goal:** Como inquilino, quiero recibir la alerta de intrusión de mi local con la imagen capturada y seguir su atención.

Cuando el sensor detecta actividad fuera del horario de atención, el inquilino recibe la alerta con la imagen capturada en menos de 30 segundos. Desde ahí revisa el detalle y el seguimiento, y el incidente queda registrado en el historial del local junto a los avisos de humo de la galería.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M2-responder-alerta-de-intrusion.jpg" alt="Wireflow WF-M2" width="100%">
</p>

**WF-M3 · Reportar un incidente y seguir su estado**

**User Goal:** Como inquilino, quiero reportar un incidente no detectado y saber si la administración ya lo atiende.

Desde la sección de alertas, el inquilino reporta un incidente indicando obligatoriamente una descripción. El reporte se registra como Pendiente y, cada vez que la administración cambia su estado, el inquilino recibe un aviso y puede seguirlo en Mis reportes.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M3-reportar-incidente-y-seguir-estado.jpg" alt="Wireflow WF-M3" width="100%">
</p>

**WF-M4 · Revisar consumo, recibo y presentar un reclamo**

**User Goal:** Como inquilino, quiero ver mi consumo real y el desglose de mi recibo para reclamar si encuentro una discrepancia.

El inquilino consulta su consumo del periodo, abre el recibo para ver cómo se calculó el cobro y, si no está conforme, presenta un reclamo vinculado a esa factura. Tanto la respuesta como los comunicados de la administración le llegan a su bandeja de mensajes.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M4-revisar-consumo-recibo-y-reclamar.jpg" alt="Wireflow WF-M4" width="100%">
</p>

**WF-M5 · Configurar horario y notificaciones**

**User Goal:** Como inquilino, quiero definir el horario de atención de mi local y elegir qué avisos recibo en el teléfono.

Desde su perfil, el inquilino define el horario de apertura y cierre de cada día, y la app no acepta un cierre anterior a la apertura. Luego ajusta sus preferencias de notificación, teniendo en cuenta que las alertas de intrusión y humo permanecen siempre activas.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M5-configurar-horario-y-notificaciones.jpg" alt="Wireflow WF-M5" width="100%">
</p>

**WF-M6 · Consultar el historial sin conexión**

**User Goal:** Como inquilino, quiero consultar mi historial de eventos y consumo aunque pierda la conexión a Internet.

Si el teléfono pierde la conexión, la app pasa a modo solo lectura y muestra los últimos datos sincronizados con su fecha y hora. En cuanto la conexión vuelve, la información se sincroniza automáticamente y la vista regresa a la normalidad.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-wireflows/WF-M6-consultar-historial-sin-conexion.jpg" alt="Wireflow WF-M6" width="100%">
</p>

## 5.4.3. Applications Mock-ups

Los mock-ups representan la versión de alta fidelidad de las pantallas definidas en los wireframes. En ellos se aplica el Design System de StorePulse establecido en la guía de estilos, de modo que la web y la app móvil se perciben como un mismo producto:

* **Color:** Deep Slate Navy `#0F172A` como color institucional (sidebar, encabezados y fondos oscuros del acceso) y Electric Pulse Cyan `#0EA5E9` para acciones primarias, enlaces activos y estados de foco. Los colores semánticos comunican el estado de forma consistente con los LED del dispositivo IoT: rojo para intrusión y humo, ámbar para advertencias y pendientes, verde para estados normales y pagados, y azul para estados en atención.
* **Tipografía:** Plus Jakarta Sans para títulos y componentes de interfaz, Inter para tablas y bloques densos de datos, y JetBrains Mono para identificadores de dispositivos, códigos de incidente, lecturas y montos.
* **Componentes:** cards con radio de 12 px y borde sutil, botones primario, secundario (outline) y destructivo, chips de estado con punto de color y texto, formularios con etiqueta superior y mensaje de validación, y tablas con paginación al pie.
* **Espaciado y retícula:** sistema modular de 8 px; en web, sidebar fija y topbar de 64 px; en móvil, márgenes de 16 px y barra de navegación inferior.
* **Accesibilidad:** contraste mínimo de 4.5:1 en texto (WCAG 2.1 AA), estados acompañados de texto e ícono y no solo de color, y selector de idioma EN/ES en la web.

### 5.4.3.1. Web Application

**W01 · Bienvenida**

Pantalla de bienvenida que transmite la identidad de StorePulse con su fondo institucional y un plano de la galería que destaca el local con incidente, invitando a iniciar sesión o registrar la galería.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W01-bienvenida.jpg" alt="Mock-up W01 Bienvenida" width="640">
</p>

**W02 · Iniciar Sesión**

Pantalla de acceso limpia y directa, en la que el campo activo se resalta y un aviso informativo recuerda que la plataforma web es exclusiva para el administrador.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W02-iniciar-sesion.jpg" alt="Mock-up W02 Iniciar Sesión" width="640">
</p>

**W03 · Recuperar contraseña**

Pantalla de recuperación de acceso que facilita la lectura del código de verificación y señala con claridad cuando este no es válido.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W03-recuperar-contrasena.jpg" alt="Mock-up W03 Recuperar contraseña" width="640">
</p>

**W04 · Registro de cuenta**

Pantalla de creación de cuenta que muestra el avance del registro y confirma en tiempo real si la contraseña cumple los requisitos de seguridad.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W04-registro-de-cuenta.jpg" alt="Mock-up W04 Registro de cuenta" width="640">
</p>

**W05 · Registro de galería**

Pantalla de registro de la galería que acompaña al administrador en el segundo paso y le indica de forma visible qué datos faltan completar.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W05-registro-de-galeria.jpg" alt="Mock-up W05 Registro de galería" width="640">
</p>

**W06 · Elegir plan y pago**

Pantalla de selección de plan que resalta la opción elegida y muestra el total a pagar antes de activar la suscripción, transmitiendo confianza con un aviso de pago seguro.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W06-elegir-plan-y-pago.jpg" alt="Mock-up W06 Elegir plan y pago" width="640">
</p>

**W07 · Dashboard sin datos**

Pantalla de bienvenida al panel que orienta al nuevo administrador con una llamada clara a registrar su primer local y una guía que muestra su avance en la configuración.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W07-dashboard-sin-datos.jpg" alt="Mock-up W07 Dashboard sin datos" width="640">
</p>

**W08 · Dashboard**

Panel de control principal que ofrece una visión completa de la galería, destacando en rojo el local con incidente activo y mostrando la evolución del consumo frente al año anterior.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W08-dashboard.jpg" alt="Mock-up W08 Dashboard" width="640">
</p>

**W09 · Centro de notificaciones**

Centro de notificaciones que agrupa los eventos de la galería y los distingue con íconos y colores según su tipo y estado.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W09-centro-de-notificaciones.jpg" alt="Mock-up W09 Centro de notificaciones" width="640">
</p>

**W10 · Alerta de intrusión**

Alerta de seguridad de alta prioridad que se superpone a la pantalla al detectarse una intrusión, mostrando el tiempo transcurrido sin confirmar y protegiendo la privacidad del inquilino.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W10-alerta-de-intrusion.jpg" alt="Mock-up W10 Alerta de intrusión" width="640">
</p>

**W11 · Locales comerciales**

Vista de gestión de locales que permite identificar rápidamente la ocupación de la galería y consultar los datos del inquilino y los dispositivos de cada local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W11-locales-comerciales.jpg" alt="Mock-up W11 Locales comerciales" width="640">
</p>

**W12 · Registrar local**

Formulario de registro de local que evita duplicados advirtiendo al administrador cuando el número ingresado ya existe en la galería.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W12-registrar-local.jpg" alt="Mock-up W12 Registrar local" width="640">
</p>

**W13 · Invitar inquilino**

Invitación al inquilino que deja claro a qué local queda vinculado el acceso y durante cuánto tiempo es válida.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W13-invitar-inquilino.jpg" alt="Mock-up W13 Invitar inquilino" width="640">
</p>

**W14 · Inmueble y áreas comunes**

Ficha del inmueble que resume la información de la galería y permite comparar visualmente la ocupación de cada piso y el estado de las áreas comunes.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W14-inmueble-y-areas-comunes.jpg" alt="Mock-up W14 Inmueble y áreas comunes" width="640">
</p>

**W15 · Registrar área común**

Formulario de registro de áreas comunes que valida que el nombre no se repita dentro de la galería.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W15-registrar-area-comun.jpg" alt="Mock-up W15 Registrar área común" width="640">
</p>

**W16 · Dispositivos IoT**

Panel de supervisión de dispositivos que alerta sobre los nodos desconectados, destaca los voltajes fuera de rango y explica el significado de las luces del nodo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W16-dispositivos-iot.jpg" alt="Mock-up W16 Dispositivos IoT" width="640">
</p>

**W17 · Registrar dispositivo**

Formulario de registro de dispositivos que vincula cada nodo o medidor a un local y advierte si el identificador ya está en uso.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W17-registrar-dispositivo.jpg" alt="Mock-up W17 Registrar dispositivo" width="640">
</p>

**W18 · Consumo de luz y agua**

Panel de consumo que permite detectar a simple vista los locales que superan su línea base y entender si el exceso ocurrió fuera del horario de atención.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W18-consumo-de-luz-y-agua.jpg" alt="Mock-up W18 Consumo de luz y agua" width="640">
</p>

**W19 · Seguridad e incidentes**

Módulo de seguridad que prioriza el incidente pendiente con un aviso destacado y permite revisar el historial y la rapidez de respuesta de la administración.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W19-seguridad-e-incidentes.jpg" alt="Mock-up W19 Seguridad e incidentes" width="640">
</p>

**W20 · Detalle de incidente**

Detalle del incidente que confirma su atención y muestra su trazabilidad en una línea de tiempo, preservando la privacidad de las imágenes del local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W20-detalle-de-incidente.jpg" alt="Mock-up W20 Detalle de incidente" width="640">
</p>

**W21 · Facturación**

Módulo de facturación que muestra el estado de cobro de cada recibo con etiquetas de color y destaca los reclamos que requieren revisión.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W21-facturacion.jpg" alt="Mock-up W21 Facturación" width="640">
</p>

**W22 · Configurar tarifas**

Configuración de tarifas que impide guardar valores no válidos y aclara desde qué periodo se aplicarán los cambios.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W22-configurar-tarifas.jpg" alt="Mock-up W22 Configurar tarifas" width="640">
</p>

**W23 · Generar facturación**

Confirmación de facturación que advierte sobre las mediciones incompletas antes de emitir los recibos, evitando cobros sin sustento.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W23-generar-facturacion.jpg" alt="Mock-up W23 Generar facturación" width="640">
</p>

**W24 · Registrar pago**

Registro de pago que destaca el monto del recibo y confirma que el inquilino será notificado al completarse la operación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W24-registrar-pago.jpg" alt="Mock-up W24 Registrar pago" width="640">
</p>

**W25 · Comunicación y reclamos**

Espacio de comunicación que permite resolver un reclamo con evidencia, mostrando el consumo diario del local y la fórmula del cobro junto a la conversación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W25-comunicacion-y-reclamos.jpg" alt="Mock-up W25 Comunicación y reclamos" width="640">
</p>

**W26 · Suscripción**

Vista de suscripción que confirma que la renovación automática está activa y facilita comparar el plan actual con las demás opciones.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W26-suscripcion.jpg" alt="Mock-up W26 Suscripción" width="640">
</p>

**W27 · Cancelar renovación**

Confirmación de cancelación que tranquiliza al administrador al indicarle que su servicio sigue vigente hasta la fecha de vencimiento.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W27-cancelar-renovacion.jpg" alt="Mock-up W27 Cancelar renovación" width="640">
</p>

**W28 · Mi perfil**

Perfil del administrador que permite actualizar sus datos, valida el correo ingresado y recuerda la próxima renovación de su suscripción.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W28-mi-perfil.jpg" alt="Mock-up W28 Mi perfil" width="640">
</p>

**W29 · Menú de usuario**

Menú de cuenta que reúne las opciones personales y separa claramente la acción de cerrar sesión.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W29-menu-de-usuario.jpg" alt="Mock-up W29 Menú de usuario" width="640">
</p>

**W30 · Desactivar dispositivo**

Confirmación de desactivación que advierte sobre la pérdida de monitoreo del local antes de completar la acción.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W30-desactivar-dispositivo.jpg" alt="Mock-up W30 Desactivar dispositivo" width="640">
</p>

**W31 · Eliminar local (bloqueado)**

Aviso preventivo que impide eliminar un local con dispositivos vinculados y lleva al administrador directamente al módulo de dispositivos.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W31-eliminar-local-bloqueado.jpg" alt="Mock-up W31 Eliminar local bloqueado" width="640">
</p>

**W32 · Renovación cancelada**

Vista de suscripción tras cancelar la renovación, que informa la fecha de vencimiento y ofrece reactivarla con un solo clic.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-mockups/W32-renovacion-cancelada.jpg" alt="Mock-up W32 Renovación cancelada" width="640">
</p>

### 5.4.3.2. Mobile Application

**M01 · Activar cuenta (invitación)**

Pantalla de activación que da la bienvenida al inquilino mostrando el local al que fue invitado y lo guía para crear su contraseña de forma segura.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M01-activar-cuenta-invitacion.jpg" alt="Mock-up M01 Activar cuenta" width="260">
</p>

**M02 · Iniciar sesión**

Pantalla de inicio de sesión sencilla y familiar, pensada para que el inquilino acceda rápidamente a la información de su local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M02-iniciar-sesion.jpg" alt="Mock-up M02 Iniciar sesión" width="260">
</p>

**M03 · Recuperar contraseña**

Pantalla de recuperación que facilita ingresar el código desde el teléfono y definir una nueva contraseña sin salir de la app.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M03-recuperar-contrasena.jpg" alt="Mock-up M03 Recuperar contraseña" width="260">
</p>

**M04 · Mi Local**

Pantalla principal que tranquiliza al inquilino confirmando que su local está seguro y le muestra su consumo, sus dispositivos y la última alerta.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M04-mi-local.jpg" alt="Mock-up M04 Mi Local" width="260">
</p>

**M05 · Mi Local sin dispositivos**

Pantalla de estado vacío que explica al inquilino que el monitoreo se activará tras la instalación, evitando dudas mientras tanto.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M05-mi-local-sin-dispositivos.jpg" alt="Mock-up M05 Mi Local sin dispositivos" width="260">
</p>

**M06 · Alerta de intrusión**

Alerta crítica que notifica al inquilino una intrusión en su local con la imagen capturada, la hora del evento y el estado de la atención.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M06-alerta-de-intrusion.jpg" alt="Mock-up M06 Alerta de intrusión" width="260">
</p>

**M07 · Alertas (historial)**

Historial de alertas que reúne los incidentes del local y los avisos de la galería, con acceso rápido para reportar un nuevo problema.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M07-alertas-historial.jpg" alt="Mock-up M07 Alertas historial" width="260">
</p>

**M08 · Detalle de incidente**

Detalle del incidente que muestra la evidencia del evento y permite al inquilino seguir cómo avanza su atención.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M08-detalle-de-incidente.jpg" alt="Mock-up M08 Detalle de incidente" width="260">
</p>

**M09 · Reportar incidente**

Formulario de reporte que permite al inquilino informar a la administración sobre un incidente no detectado, adjuntando una foto si lo desea.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M09-reportar-incidente.jpg" alt="Mock-up M09 Reportar incidente" width="260">
</p>

**M10 · Mis reportes**

Seguimiento de reportes que informa al inquilino cada cambio de estado y le muestra en qué etapa de atención se encuentra su caso.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M10-mis-reportes.jpg" alt="Mock-up M10 Mis reportes" width="260">
</p>

**M11 · Consumos**

Vista de consumos que permite al inquilino comparar su gasto de energía y agua mes a mes y acceder a su recibo del periodo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M11-consumos.jpg" alt="Mock-up M11 Consumos" width="260">
</p>

**M12 · Recibo y desglose**

Recibo detallado que explica al inquilino cómo se calculó su monto a partir de su consumo real, aportando transparencia al cobro.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M12-recibo-y-desglose.jpg" alt="Mock-up M12 Recibo y desglose" width="260">
</p>

**M13 · Presentar reclamo**

Formulario de reclamo vinculado al recibo, que permite al inquilino sustentar su caso y evita reclamos duplicados.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M13-presentar-reclamo.jpg" alt="Mock-up M13 Presentar reclamo" width="260">
</p>

**M14 · Mensajes**

Bandeja de mensajes que centraliza la comunicación con la administración y distingue comunicados, reclamos y avisos del local.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M14-mensajes.jpg" alt="Mock-up M14 Mensajes" width="260">
</p>

**M15 · Perfil**

Perfil del inquilino que reúne sus datos y las opciones de configuración de la app en un solo lugar.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M15-perfil.jpg" alt="Mock-up M15 Perfil" width="260">
</p>

**M16 · Horario de atención**

Configuración del horario de atención que ayuda al inquilino a definir cuándo su local está cerrado y le advierte si ingresa un horario inválido.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M16-horario-de-atencion.jpg" alt="Mock-up M16 Horario de atención" width="260">
</p>

**M17 · Preferencias de notificación**

Preferencias de notificación que permiten al inquilino personalizar sus avisos, garantizando que las alertas de intrusión y humo siempre lleguen.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M17-preferencias-de-notificacion.jpg" alt="Mock-up M17 Preferencias de notificación" width="260">
</p>

**M18 · Consumos sin conexión**

Vista de consumos sin conexión que mantiene disponible la información del local en modo lectura e indica cuándo fue la última sincronización.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-mockups/M18-consumos-sin-conexion.jpg" alt="Mock-up M18 Consumos sin conexión" width="260">
</p>

## 5.4.4. Applications User Flow Diagrams

Los user flows muestran el recorrido completo que sigue cada usuario para cumplir un objetivo dentro de la aplicación, ahora con los mock-ups de alta fidelidad. Cada diagrama sigue el mismo recorrido de su wireflow correspondiente y le añade las condiciones que el sistema evalúa en el camino, de modo que se distingue con claridad lo que ocurre cuando todo sale bien y lo que ocurre cuando el usuario se equivoca, cambia de decisión o el sistema no puede completar la acción.

Para leer los diagramas se utiliza la siguiente convención:

* **Happy path (línea verde continua):** la ruta esperada, en la que el usuario cumple su objetivo sin contratiempos.
* **Unhappy paths (línea roja punteada):** las rutas alternativas, como errores de validación, cancelaciones, falta de conexión o caminos secundarios para llegar al mismo objetivo.
* **Rombos:** las decisiones o condiciones que determinan qué ruta sigue el flujo.
* **Inicio y fin:** el evento que da origen al flujo y el resultado que obtiene el usuario.

Se elaboró un user flow por cada User Goal de los User Persona del alcance: siete para el administrador en la aplicación web y seis para el inquilino en la aplicación móvil.

### 5.4.4.1. Web Application

**UF-01 · Registrar la galería y activar la suscripción**

**User Goal:** Como administrador, quiero registrar mi cuenta y mi galería y activar un plan para empezar a monitorear los locales.

El administrador llega a la bienvenida, crea su cuenta, registra los datos de su galería y elige un plan para activar la suscripción. Al completarse el pago, ingresa al dashboard vacío, que lo orienta a registrar su primer local.

Rutas alternativas:

* Si la contraseña es débil o el correo no es válido, el usuario permanece en el registro de cuenta hasta corregirlo.
* Si faltan datos obligatorios de la galería, el formulario se lo indica antes de continuar.
* Si el pago es rechazado, vuelve a la selección de plan para intentarlo nuevamente.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-01-registrar-galeria-y-activar-suscripcion.jpg" alt="User Flow UF-01" width="100%">
</p>

**UF-02 · Acceder a la plataforma y recuperar la contraseña**

**User Goal:** Como administrador, quiero iniciar y cerrar sesión de forma segura y recuperar mi contraseña si la olvido.

Desde la bienvenida, el administrador inicia sesión y, si sus credenciales son válidas, accede al dashboard consolidado. Al terminar su trabajo, cierra sesión desde el menú de usuario.

Rutas alternativas:

* Si las credenciales son incorrectas, regresa al inicio de sesión con el mensaje de error.
* Si olvidó su contraseña, ingresa el código de seis dígitos enviado a su correo y define una nueva; con la contraseña actualizada vuelve a iniciar sesión.
* Si el código es inválido o ya expiró, permanece en la recuperación para corregirlo o solicitar uno nuevo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-02-acceder-y-recuperar-contrasena.jpg" alt="User Flow UF-02" width="100%">
</p>

**UF-03 · Atender una alerta de intrusión**

**User Goal:** Como administrador, quiero recibir la alerta de intrusión, confirmar su atención y registrar el resultado para resolver el incidente.

Cuando se detecta una intrusión, la alerta aparece en tiempo real sobre el dashboard. El administrador confirma su atención, con lo que el incidente pasa de Pendiente a En atención, y desde el detalle registra el resultado para marcarlo como resuelto. El incidente queda entonces en el historial de seguridad.

Rutas alternativas:

* Si el administrador no confirma la atención, el incidente sigue Pendiente en el módulo de seguridad y el contador de tiempo continúa.
* Si intenta cerrar el incidente sin registrar el resultado, el sistema se lo exige antes de marcarlo como resuelto.
* La alerta también puede abrirse desde el centro de notificaciones.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-03-atender-alerta-de-intrusion.jpg" alt="User Flow UF-03" width="100%">
</p>

**UF-04 · Gestionar locales e invitar inquilinos**

**User Goal:** Como administrador, quiero registrar y mantener los locales de mi galería e invitar a cada inquilino a su local.

Desde el módulo de locales, el administrador registra un nuevo local, invita por correo a su inquilino y luego consulta la información del inmueble para registrar un área común. El flujo termina con el local y el área registrados.

Rutas alternativas:

* Si el número de local ya existe, el sistema no permite guardarlo hasta que se corrija.
* Si el nombre del área común ya está en uso, se solicita uno diferente.
* Si intenta eliminar un local que tiene dispositivos vinculados, el sistema lo impide y lo dirige al módulo de dispositivos para desvincularlos primero.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-04-gestionar-locales-e-invitar-inquilinos.jpg" alt="User Flow UF-04" width="100%">
</p>

**UF-05 · Supervisar los dispositivos IoT**

**User Goal:** Como administrador, quiero registrar, revisar y desactivar los dispositivos IoT para mantener el monitoreo operativo.

El administrador ingresa al módulo de dispositivos, revisa su estado y registra un nuevo nodo vinculándolo a un local. Más adelante, desactiva un dispositivo indicando el motivo; el nodo queda inactivo y puede reactivarse cuando sea necesario.

Rutas alternativas:

* Si el identificador del dispositivo ya está registrado, el sistema lo rechaza y el administrador debe ingresar otro.
* Si decide no confirmar la desactivación, vuelve a la lista de dispositivos sin cambios.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-05-supervisar-dispositivos-iot.jpg" alt="User Flow UF-05" width="100%">
</p>

**UF-06 · Facturar el consumo y registrar pagos**

**User Goal:** Como administrador, quiero configurar tarifas, generar recibos por consumo real, registrar pagos y atender reclamos.

Tras revisar el consumo de la galería, el administrador configura las tarifas de luz y agua, genera los recibos del periodo y registra los pagos a medida que los inquilinos cancelan. El flujo concluye con el recibo en estado Pagado.

Rutas alternativas:

* Si alguna tarifa es menor o igual a cero, la configuración no se guarda hasta corregirla.
* Si hay locales con mediciones incompletas, el sistema lo advierte y el administrador confirma la emisión solo para los locales completos.
* Si existe un reclamo abierto, el administrador lo revisa en el módulo de comunicación y lo resuelve apoyándose en el desglose de consumo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-06-facturar-consumo-y-registrar-pagos.jpg" alt="User Flow UF-06" width="100%">
</p>

**UF-07 · Gestionar la suscripción y el perfil**

**User Goal:** Como administrador, quiero consultar mi suscripción, controlar la renovación automática y mantener mis datos de perfil.

Desde el menú de usuario, el administrador abre su suscripción y cancela la renovación automática. Al confirmar, la suscripción se mantiene vigente hasta su fecha de vencimiento.

Rutas alternativas:

* Si se arrepiente antes de confirmar, mantiene la renovación y vuelve a la suscripción sin cambios.
* Luego de cancelar, puede reactivar la renovación desde la misma pantalla.
* Desde el menú también accede a su perfil para actualizar sus datos; si el correo no es válido, el sistema le pide corregirlo antes de guardar.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/web-userflows/UF-07-gestionar-suscripcion-y-perfil.jpg" alt="User Flow UF-07" width="100%">
</p>

### 5.4.4.2. Mobile Application

**UF-M1 · Activar la cuenta e ingresar a la app**

**User Goal:** Como inquilino, quiero activar mi cuenta con la invitación de la administración e ingresar para ver mi local.

El inquilino abre el enlace de invitación, crea su contraseña e inicia sesión. Si su local ya cuenta con dispositivos instalados, ve directamente el estado de seguridad y consumo de su local.

Rutas alternativas:

* Si la contraseña no cumple los requisitos, permanece en la activación hasta corregirla.
* Si las credenciales son incorrectas, vuelve al inicio de sesión.
* Si olvidó su contraseña, la recupera con un código de seis dígitos; si el código no es válido, puede corregirlo o solicitar otro.
* Si su local todavía no tiene dispositivos, la app le indica que el monitoreo se activará tras la instalación.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M1-activar-cuenta-e-ingresar.jpg" alt="User Flow UF-M1" width="100%">
</p>

**UF-M2 · Responder a una alerta de intrusión**

**User Goal:** Como inquilino, quiero recibir la alerta de intrusión de mi local con la imagen capturada y seguir su atención.

Cuando el sensor detecta actividad fuera del horario de atención, el inquilino recibe una notificación en menos de 30 segundos. Abre la alerta, revisa el detalle con la imagen capturada y sigue la atención del incidente desde su historial.

Rutas alternativas:

* Si la actividad ocurre dentro del horario de atención, no se genera una alerta.
* Si el inquilino decide revisar la alerta más tarde, regresa a Mi Local y luego puede consultarla desde la sección de alertas.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M2-responder-alerta-de-intrusion.jpg" alt="User Flow UF-M2" width="100%">
</p>

**UF-M3 · Reportar un incidente y seguir su estado**

**User Goal:** Como inquilino, quiero reportar un incidente no detectado y saber si la administración ya lo atiende.

Desde la sección de alertas, el inquilino reporta un incidente que los sensores no detectaron. El reporte se registra como Pendiente y, cuando la administración cambia su estado, el inquilino recibe el aviso y lo sigue en Mis reportes.

Ruta alternativa:

* Si el inquilino envía el reporte sin descripción, la app le indica que es obligatoria y no lo registra hasta completarla.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M3-reportar-incidente-y-seguir-estado.jpg" alt="User Flow UF-M3" width="100%">
</p>

**UF-M4 · Revisar consumo, recibo y presentar un reclamo**

**User Goal:** Como inquilino, quiero ver mi consumo real y el desglose de mi recibo para reclamar si encuentro una discrepancia.

El inquilino revisa su consumo del periodo, abre el recibo y verifica el desglose del cobro. Si el monto coincide con lo que consumió, el recibo queda conforme.

Rutas alternativas:

* Si encuentra una discrepancia, presenta un reclamo vinculado al recibo, y la respuesta de la administración le llega a la bandeja de mensajes.
* Si ya existe un reclamo activo para ese recibo, la app le muestra el reclamo existente en lugar de crear uno nuevo.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M4-revisar-consumo-recibo-y-reclamar.jpg" alt="User Flow UF-M4" width="100%">
</p>

**UF-M5 · Configurar horario y notificaciones**

**User Goal:** Como inquilino, quiero definir el horario de atención de mi local y elegir qué avisos recibo en el teléfono.

Desde su perfil, el inquilino registra el horario de atención de su local y luego ajusta sus preferencias de notificación. El flujo termina con las preferencias guardadas.

Rutas alternativas:

* Si la hora de cierre es anterior a la de apertura, la app le pide corregir el horario antes de guardarlo.
* Si intenta desactivar las alertas de intrusión o humo, la app se lo impide, ya que estas alertas críticas permanecen siempre activas.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M5-configurar-horario-y-notificaciones.jpg" alt="User Flow UF-M5" width="100%">
</p>

**UF-M6 · Consultar el historial sin conexión**

**User Goal:** Como inquilino, quiero consultar mi historial de eventos y consumo aunque pierda la conexión a Internet.

Cuando el teléfono tiene conexión, la app muestra el consumo del local con datos en tiempo real.

Rutas alternativas:

* Si pierde la conexión, la app pasa a modo solo lectura y muestra los últimos datos sincronizados junto con el historial de eventos.
* Al recuperar la conexión, la información se sincroniza automáticamente y vuelve a la vista normal; mientras no la recupere, sigue en modo solo lectura.

<p align="center">
  <img src="../../assets/applications-ux-ui-design/mobile-userflows/UF-M6-consultar-historial-sin-conexion.jpg" alt="User Flow UF-M6" width="100%">
</p>
