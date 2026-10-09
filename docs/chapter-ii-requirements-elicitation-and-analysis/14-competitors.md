# CAPÍTULO II: REQUIREMENTS ELICITATION & ANALYSIS

En este capítulo, el equipo se enfoca en comprender las necesidades reales de los administradores e inquilinos de galerías comerciales antes de definir los requisitos de StorePulse. Para ello, se desarrolla un proceso de Obtención y Análisis de Requisitos que permite contrastar los supuestos planteados durante el Lean UX Process con evidencia obtenida de los usuarios y del entorno competitivo. De esta manera, se busca determinar si los problemas relacionados con la seguridad, el monitoreo de los locales y la gestión de los servicios básicos representan necesidades reales y relevantes para los segmentos objetivo de StorePulse.

## 2.1. Competidores

Antes de definir los requisitos de StorePulse, es necesario conocer las alternativas que actualmente existen para atender las necesidades de seguridad y monitoreo en establecimientos comerciales. El estudio de estas alternativas permite identificar las funcionalidades que ofrecen, sus principales propuestas de valor y las necesidades que aún presentan oportunidades de atención.

Este análisis permitirá identificar oportunidades de diferenciación para StorePulse, especialmente en la integración del monitoreo de intrusiones, la detección temprana de humo y la medición individual del consumo de servicios básicos dentro de galerías comerciales.

### 2.1.1. Análisis competitivo

El análisis competitivo permite identificar las características, propuestas de valor y estrategias de las principales soluciones de seguridad y monitoreo disponibles en el mercado. Para VanguardTech, este análisis resulta especialmente relevante debido a que StorePulse busca atender una necesidad que combina seguridad, prevención de incendios y medición individual de servicios en galerías comerciales, mientras que las alternativas existentes se concentran principalmente en seguridad electrónica o videovigilancia.

El análisis considera como referentes a Verisure, Prosegur y Hikvision, debido a su presencia y oferta relacionada con seguridad para negocios, monitoreo, videovigilancia y soluciones inteligentes.

El objetivo del análisis es responder:

¿Cómo puede VanguardTech diferenciar StorePulse frente a las soluciones existentes de seguridad y monitoreo para ofrecer una propuesta de mayor valor a administradores e inquilinos de galerías comerciales?

#### Competitive Analysis Landscape

<table>
<tr>
<th colspan="6">Competitive Analysis Landscape</th>
</tr>
<tr>
<td>¿Por qué llevar a cabo este análisis?</td>
<td colspan="5">¿Cómo puede VanguardTech diferenciar StorePulse frente a las soluciones existentes de seguridad y monitoreo para ofrecer una propuesta de mayor valor a administradores e inquilinos de galerías comerciales?</td>
</tr>
<tr>
<th colspan="2">Aspecto</th>
<th>VanguardTech</th>
<th>Verisure</th>
<th>Prosegur</th>
<th>Hikvision</th>
</tr>
<tr>
<td rowspan="2">Perfil</td>
<td><strong>Overview</strong></td>
<td>Startup tecnológica que desarrolla StorePulse, una solución IoT orientada a la gestión de seguridad y servicios básicos en galerías comerciales.</td>
<td>Empresa especializada en soluciones de seguridad, alarmas y monitoreo profesional para establecimientos y negocios.</td>
<td>Empresa internacional dedicada a servicios de seguridad que combina soluciones tecnológicas, monitoreo y servicios especializados.</td>
<td>Empresa especializada en soluciones de videovigilancia, seguridad electrónica y tecnologías inteligentes.</td>
</tr>
<tr>
<td><strong>Ventaja competitiva<br>¿Qué valor ofrece a los clientes?</strong></td>
<td>Integra seguridad, detección temprana de humo y medición individual de servicios básicos en una misma solución, diferenciando la información según el rol del administrador y del inquilino.</td>
<td>Ofrece protección mediante sistemas de alarma, monitoreo profesional y protocolos de respuesta ante eventos de seguridad.</td>
<td>Integra tecnología y servicios de seguridad, ofreciendo monitoreo y soluciones destinadas a proteger personas, establecimientos y activos.</td>
<td>Ofrece un ecosistema de dispositivos y soluciones de videovigilancia, incluyendo cámaras y herramientas de análisis inteligente.</td>
</tr>
<tr>
<td rowspan="2">Perfil de Marketing</td>
<td><strong>Mercado objetivo</strong></td>
<td>Administradores e inquilinos de galerías comerciales de alta densidad de locales en Lima Metropolitana.</td>
<td>Negocios, comercios, oficinas, restaurantes y otros establecimientos que requieren sistemas de protección y monitoreo.</td>
<td>Hogares, pequeños negocios, empresas y organizaciones que requieren servicios y soluciones de seguridad.</td>
<td>Comercios, empresas, centros comerciales y organizaciones que requieren soluciones de videovigilancia y seguridad electrónica.</td>
</tr>
<tr>
<td><strong>Estrategias de marketing</strong></td>
<td>Especialización en las necesidades de las galerías comerciales y comunicación diferenciada para administradores e inquilinos. La propuesta se centra en seguridad, transparencia de consumos y gestión basada en información.</td>
<td>Posicionamiento asociado con protección, monitoreo profesional y respuesta frente a incidentes.</td>
<td>Posicionamiento basado en experiencia, cobertura, tecnología y prestación integral de servicios de seguridad.</td>
<td>Posicionamiento basado en innovación tecnológica, videovigilancia, analítica de video y soluciones inteligentes.</td>
</tr>
<tr>
<td rowspan="3">Perfil de Producto</td>
<td><strong>Productos &amp; Servicios</strong></td>
<td>Sensores para detección de eventos, sensores de humo, medición de energía y agua, generación de alertas, aplicaciones Web y Mobile, dashboard y procesamiento en el borde.</td>
<td>Sistemas de alarma, sensores, cámaras, monitoreo profesional y soluciones complementarias de seguridad.</td>
<td>Alarmas, cámaras monitoreadas, vigilancia, control de accesos y diferentes servicios de seguridad.</td>
<td>Cámaras, sistemas de grabación, videovigilancia inteligente, analítica de video y soluciones de control y seguridad.</td>
</tr>
<tr>
<td><strong>Precios &amp; Costos</strong></td>
<td>Modelo de suscripción mensual escalable, asociado a la cantidad de locales y servicios implementados en la galería.</td>
<td>Modelo basado en la solución requerida por el cliente y la implementación del servicio de seguridad.</td>
<td>Costos determinados según las características y alcance del servicio de seguridad contratado.</td>
<td>Costos asociados principalmente a los dispositivos, infraestructura, implementación e integración de la solución.</td>
</tr>
<tr>
<td><strong>Canales de distribución<br>(Web y/o Móvil)</strong></td>
<td>Landing Page, Web Application, Mobile Application e instalación de dispositivos IoT en los locales.</td>
<td>Sitio web, canales de contacto comercial, instalación y aplicaciones digitales.</td>
<td>Sitio web, canales comerciales, servicios profesionales y aplicaciones orientadas a la gestión de seguridad.</td>
<td>Sitio web, distribuidores, integradores y canales especializados en soluciones de seguridad electrónica.</td>
</tr>
<tr>
<td rowspan="4">Análisis SWOT</td>
<td><strong>Fortalezas</strong></td>
<td><ul><li>Integración de seguridad, detección de humo y medición de servicios.</li><li>Especialización en galerías comerciales.</li><li>Medición individual por local.</li><li>Información diferenciada para administrador e inquilino.</li><li>Aplicaciones Web y Mobile.</li><li>Procesamiento mediante Edge Computing.</li></ul></td>
<td><ul><li>Monitoreo profesional 24/7.</li><li>Sistemas de alarma y sensores para detección de intrusiones.</li><li>Verificación de señales mediante imagen y audio.</li><li>Control remoto mediante aplicación móvil.</li></ul></td>
<td><ul><li>Monitoreo de alarmas las 24 horas.</li><li>Alarmas y cámaras monitoreadas para negocios.</li><li>Aplicación móvil para gestionar el sistema de seguridad.</li><li>Respuesta ante eventos de alarma mediante protocolos establecidos.</li></ul></td>
<td><ul><li>Amplio portafolio de soluciones de videovigilancia.</li><li>Cámaras y sistemas de seguridad electrónica.</li><li>Soluciones de videovigilancia inteligente.</li><li>Analítica de video y tecnologías basadas en inteligencia artificial.</li></ul></td>
</tr>
<tr>
<td><strong>Debilidades</strong></td>
<td><ul><li>Startup sin trayectoria comercial consolidada.</li><li>Marca con bajo reconocimiento inicial.</li><li>Recursos financieros y operativos limitados frente a empresas consolidadas.</li><li>Solución en etapa de desarrollo y validación.</li></ul></td>
<td><ul><li>La propuesta se concentra principalmente en seguridad y monitoreo.</li><li>La información sobre consumo de servicios no forma parte de su propuesta principal.</li><li>Su servicio requiere contratación e instalación de una solución de seguridad.</li></ul></td>
<td><ul><li>La propuesta de alarmas se concentra principalmente en seguridad y monitoreo.</li><li>La medición individual de servicios básicos no forma parte de la propuesta de alarmas para negocios.</li><li>La solución requiere instalación de dispositivos y contratación del servicio.</li></ul></td>
<td><ul><li>Su oferta está principalmente orientada a infraestructura y soluciones de videovigilancia.</li><li>La implementación de determinadas soluciones puede requerir infraestructura e integración especializada.</li><li>No presenta como propuesta principal la medición individual de servicios básicos en galerías comerciales.</li></ul></td>
</tr>
<tr>
<td><strong>Oportunidades</strong></td>
<td><ul><li>Digitalización de la gestión de galerías.</li><li>Necesidad de transparentar el consumo de servicios.</li><li>Mayor adopción de soluciones IoT.</li><li>Posibilidad de implementar la solución en diferentes galerías y ampliar los servicios.</li></ul></td>
<td><ul><li>Mayor adopción de soluciones de seguridad conectada.</li><li>Crecimiento de la demanda de monitoreo remoto para negocios.</li><li>Incorporación de nuevas tecnologías para mejorar la protección de establecimientos.</li></ul></td>
<td><ul><li>Mayor adopción de sistemas de seguridad monitoreados.</li><li>Crecimiento de la demanda de soluciones de seguridad para negocios.</li><li>Integración de cámaras y aplicaciones para ampliar las capacidades de monitoreo.</li></ul></td>
<td><ul><li>Crecimiento de la demanda de videovigilancia inteligente.</li><li>Mayor adopción de analítica de video.</li><li>Desarrollo de soluciones de seguridad basadas en inteligencia artificial.</li></ul></td>
</tr>
<tr>
<td><strong>Amenazas</strong></td>
<td><ul><li>Competidores consolidados con mayor reconocimiento de marca.</li><li>Resistencia de algunos clientes a adoptar nuevas tecnologías.</li><li>Costos de adquisición, instalación y mantenimiento del hardware.</li><li>Dependencia de infraestructura eléctrica y conectividad.</li></ul></td>
<td><ul><li>Competencia de empresas de seguridad con servicios de monitoreo similares.</li><li>Rápida evolución de las tecnologías de seguridad.</li><li>Ingreso de nuevas soluciones de seguridad conectada al mercado.</li></ul></td>
<td><ul><li>Competencia de otras empresas de seguridad y monitoreo.</li><li>Rápida evolución de las soluciones tecnológicas de seguridad.</li><li>Cambios en las necesidades y preferencias de los clientes.</li></ul></td>
<td><ul><li>Competencia de otros fabricantes de soluciones de videovigilancia.</li><li>Rápida evolución y obsolescencia de tecnologías de seguridad.</li><li>Incremento de soluciones inteligentes de otros proveedores.</li></ul></td>
</tr>
</table>

### 2.1.2. Estrategias y tácticas frente a competidores

A partir del análisis competitivo y del análisis FODA realizado, VanguardTech plantea un conjunto de estrategias y tácticas preliminares para posicionar StorePulse frente a las soluciones existentes de seguridad, monitoreo y videovigilancia. Estas acciones buscan aprovechar las oportunidades identificadas en el mercado, utilizar las fortalezas de la propuesta, reducir las debilidades propias de una startup y responder a las amenazas y fortalezas de competidores consolidados.

Las estrategias se orientan principalmente hacia la diferenciación por especialización, la integración de servicios y la generación de valor para los administradores e inquilinos de galerías comerciales. De esta manera, StorePulse no busca competir únicamente mediante precio o cantidad de funcionalidades, sino mediante una propuesta adaptada al contexto particular de las galerías comerciales.

#### Estrategia 1: Diferenciación mediante la integración de servicios

VanguardTech buscará diferenciar a StorePulse mediante la integración de **seguridad, detección de humo y medición de servicios** en una misma solución. Mientras que los competidores analizados presentan principalmente propuestas relacionadas con seguridad, alarmas, monitoreo y videovigilancia, StorePulse incorpora también la medición individual del consumo de servicios por local.

**Tácticas:**

- Integrar en una misma solución la detección de intrusiones, eventos de humo y consumo de servicios.
- Presentar la información de seguridad y consumo de manera centralizada.
- Utilizar esta integración como elemento principal de diferenciación frente a las soluciones existentes.

#### Estrategia 2: Especialización en galerías comerciales

VanguardTech enfocará StorePulse específicamente en las necesidades de las **galerías comerciales**, evitando competir directamente con empresas que poseen una oferta amplia para diferentes tipos de establecimientos.

**Tácticas:**

- Diseñar la solución considerando la organización y dinámica de las galerías comerciales.
- Priorizar las necesidades de administradores e inquilinos de locales comerciales.
- Orientar la propuesta comercial hacia galerías comerciales con problemas de seguridad y gestión de servicios.
- Realizar implementaciones piloto en galerías comerciales para validar la solución.

#### Estrategia 3: Transparencia en el consumo de servicios

StorePulse aprovechará la necesidad de contar con información verificable sobre el consumo de servicios básicos para diferenciarse de soluciones enfocadas principalmente en seguridad.

**Tácticas:**

- Registrar el consumo individual correspondiente a cada local.
- Permitir la consulta del historial de consumo.
- Proporcionar información diferenciada para administradores e inquilinos.
- Facilitar la verificación de los consumos utilizados como base para los cobros.

#### Estrategia 4: Continuidad operativa mediante Edge Computing

Para reducir el impacto de posibles interrupciones de conectividad, StorePulse utilizará procesamiento local mediante **Edge Computing**, permitiendo mantener determinadas capacidades de detección y registro incluso cuando la conexión con los servicios centrales se vea afectada.

**Tácticas:**

- Procesar localmente eventos relacionados con seguridad y detección.
- Mantener el registro de eventos durante interrupciones de conectividad.
- Sincronizar la información cuando se restablezca la conexión.

#### Estrategia 5: Experiencia diferenciada para administrador e inquilino

VanguardTech adaptará la información presentada según las necesidades de cada segmento. El administrador requiere una visión general de la galería, mientras que el inquilino necesita principalmente información relacionada con su propio local y consumo.

**Tácticas:**

- Proporcionar al administrador información consolidada de los locales y áreas de la galería.
- Permitir al inquilino consultar información específica de su local.
- Diferenciar los niveles de información según el tipo de usuario.
- Priorizar el uso de aplicaciones Web para la gestión administrativa y Mobile para consultas de los inquilinos.

#### Estrategia 6: Crecimiento progresivo y validación de la solución

Debido a que VanguardTech es una startup con una marca y trayectoria comercial aún en desarrollo, se plantea un crecimiento progresivo que permita validar StorePulse antes de ampliar su alcance.

**Tácticas:**

- Implementar inicialmente StorePulse en galerías comerciales seleccionadas.
- Recoger retroalimentación de administradores e inquilinos durante las primeras implementaciones.
- Mejorar progresivamente la solución a partir de los resultados obtenidos.
- Ampliar posteriormente la solución hacia otras galerías y nuevos servicios.

**Matriz CAME para el desarrollo de estrategias a partir del análisis FODA**

La siguiente matriz permite relacionar las fortalezas y debilidades de VanguardTech con las oportunidades y amenazas identificadas en el análisis FODA. A partir de estos cruces se plantean estrategias ofensivas (FO), defensivas (FA), de reorientación (DO) y de supervivencia (DA).

<table border="1" cellpadding="10" cellspacing="0" style="margin-left: auto; margin-right: auto; font-family: sans-serif;">
<tr>
<td colspan="2" style="text-align: center;"><b>Análisis FODA cruzado</b></td>
<td style="text-align: center;"><b>Oportunidades (O)</b></td>
<td style="text-align: center;"><b>Amenazas (A)</b></td>
</tr>

<tr>
<td rowspan="1"><b>Fortalezas (F)</b></td>
<td>
1. Integración de seguridad, detección temprana de humo y medición individual de servicios.<br>
2. Especialización en galerías comerciales.<br>
3. Información diferenciada para administradores e inquilinos.<br>
4. Aplicaciones Web y Mobile.<br>
5. Procesamiento local mediante Edge Computing.
</td>

<td>
<b>FO — Estrategias ofensivas</b><br><br>
1. Aprovechar la especialización en galerías comerciales y la integración de servicios para posicionar StorePulse como una solución integral ante la creciente digitalización de este tipo de establecimientos.<br><br>
2. Utilizar la medición individual de servicios para atender la necesidad de mayor transparencia en el consumo y diferenciar la propuesta frente a soluciones centradas principalmente en seguridad.<br><br>
3. Aprovechar las capacidades Web, Mobile y Edge Computing para ofrecer una solución IoT integral y ampliar progresivamente su implementación en nuevas galerías.
</td>

<td>
<b>FA — Estrategias defensivas</b><br><br>
1. Utilizar la especialización en galerías comerciales para diferenciar StorePulse frente a competidores consolidados con una oferta más generalizada.<br><br>
2. Destacar la integración de seguridad, detección de humo y medición de servicios para evitar competir únicamente mediante precio frente a empresas con mayor trayectoria y reconocimiento.<br><br>
3. Aprovechar Edge Computing para reducir el impacto de posibles interrupciones de conectividad y fortalecer la continuidad operativa de la solución.<br><br>
4. Utilizar la experiencia diferenciada por roles para facilitar la adopción y atender las necesidades específicas de administradores e inquilinos.
</td>
</tr>

<tr>
<td><b>Debilidades (D)</b></td>
<td>
1. Startup con bajo reconocimiento de marca.<br>
2. Recursos financieros y operativos limitados frente a competidores consolidados.<br>
3. Solución en etapa de desarrollo y validación.<br>
4. Trayectoria comercial aún limitada.
</td>

<td>
<b>DO — Estrategias de reorientación</b><br><br>
1. Aprovechar la creciente adopción de soluciones IoT para realizar proyectos piloto que permitan validar StorePulse y obtener evidencia de su valor.<br><br>
2. Utilizar los resultados de los primeros pilotos y la retroalimentación de los usuarios para fortalecer el reconocimiento de la marca.<br><br>
3. Priorizar las funcionalidades con mayor valor para los usuarios antes de ampliar el alcance de la solución, optimizando los recursos disponibles.<br><br>
4. Establecer alianzas con administradores de galerías y proveedores tecnológicos para facilitar las primeras implementaciones.
</td>

<td>
<b>DA — Estrategias de supervivencia</b><br><br>
1. Mantener un alcance inicial controlado para reducir el impacto de los recursos financieros y operativos limitados.<br><br>
2. Priorizar las funcionalidades principales de seguridad, detección de humo y medición de servicios antes de incorporar nuevas capacidades.<br><br>
3. Aplicar pruebas de funcionamiento y mecanismos de respaldo para reducir los riesgos asociados a los dispositivos IoT, la energía y la conectividad.<br><br>
4. Implementar un proceso de soporte y atención de incidentes para reducir el impacto de posibles fallos durante las primeras implementaciones.<br><br>
5. Mantener un crecimiento progresivo que permita reducir la exposición financiera y operativa durante la entrada al mercado.
</td>
</tr>
</table>

En conjunto, la matriz FODA cruzada permite traducir el análisis realizado en líneas de acción para StorePulse. Las estrategias resultantes buscan aprovechar las oportunidades del mercado, utilizar las fortalezas de la solución, reducir las debilidades propias de una startup y afrontar las amenazas del entorno competitivo.

A partir de este análisis, VanguardTech plantea competir principalmente mediante la **especialización en galerías comerciales, la integración de servicios, la transparencia de la información y la continuidad operativa**, evitando basar su posicionamiento únicamente en el precio o en la cantidad de funcionalidades ofrecidas. Estas estrategias y tácticas servirán como base para orientar las siguientes actividades de **obtención y análisis de requisitos** de StorePulse.