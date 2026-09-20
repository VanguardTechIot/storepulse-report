### 1.2.2. Lean UX Process

En esta sección se presenta el proceso de Lean UX aplicado por el equipo para definir la propuesta de StorePulse. A partir de las creencias iniciales sobre el negocio y los usuarios, se identifican los principales problemas, supuestos y resultados esperados, los cuales se transforman en hipótesis que pueden ser validadas durante el desarrollo del proyecto.

Este proceso permite relacionar las necesidades de los administradores de galerías y los inquilinos de los locales con los resultados esperados del negocio y las funcionalidades propuestas para el producto.

#### 1.2.2.1. Lean UX Problem Statements

Para representar la problemática general del proyecto se elaboró un único Problem Statement que considera los dos segmentos objetivo: administradores de galerías comerciales e inquilinos de los locales. De acuerdo con las indicaciones del Lean UX Process, se utiliza la plantilla correspondiente a una iniciativa nueva (Brand new initiative).

**Problem Statement**

El estado actual de **la gestión operativa de galerías comerciales en Lima Metropolitana** se ha enfocado principalmente en **la vigilancia presencial de áreas comunes, la inspección manual periódica y el prorrateo estimado de los servicios básicos, atendiendo a administradores e inquilinos únicamente después de que un incidente ha ocurrido**.

Lo que los productos y servicios existentes no logran atender es **la falta de información individual y verificable por local, ya que las soluciones de seguridad electrónica suelen estar diseñadas para comercios independientes y no para galerías comerciales. Además, no existe una solución integrada que permita gestionar la detección de intrusiones, la detección temprana de humo y el consumo verificable de servicios desde una misma plataforma**.

Nuestro producto atenderá esta brecha mediante **una plataforma IoT que instala dispositivos de bajo costo en cada local, procesa la telemetría en el edge para mantener la detección y el registro ante interrupciones de conectividad, y presenta la información mediante aplicaciones web y móviles con acceso diferenciado según el rol del usuario**.

Nuestro enfoque inicial será **los administradores e inquilinos de galerías comerciales de alta densidad de locales en Lima Metropolitana, específicamente en Gamarra, Mesa Redonda, Las Malvinas y el jirón Wilson**.

Sabremos que hemos tenido éxito cuando observemos que **los administradores sustituyen la inspección manual por la revisión del tablero de control, los inquilinos consultan el consumo de su local antes de cuestionar la facturación, y ambos actúan sobre una alerta durante el evento y no después de él**.

#### 1.2.2.2. Lean UX Assumptions

En esta sección se presentan las creencias que sustentan la propuesta de StorePulse. Los assumptions se organizan en las cinco categorías establecidas por Lean UX: Business Assumptions, Business Outcome Assumptions, User Assumptions, User Outcome and Benefit Assumptions y Feature Assumptions.

Estos enunciados representan las creencias resultantes de la discusión del equipo y no preguntas de exploración. Los Feature Assumptions sirven como base para la formulación de los Hypothesis Statements.

**1. Business Assumptions**

- Creemos que existe un mercado sostenible en las galerías comerciales de Lima Metropolitana, debido al volumen de locales agrupados por inmueble y a la necesidad de mejorar la seguridad y gestión operativa.
- Creemos que el administrador de la galería es quien toma la decisión de compra y asume el costo de la suscripción, mientras que el inquilino es el usuario beneficiario.
- Creemos que un modelo de suscripción mensual escalonado por número de locales monitoreados se ajusta a la capacidad de pago de una administración de galería.
- Creemos que la venta por inmueble completo, y no por local individual, reduce el costo de adquisición y hace escalable el crecimiento del negocio.
- Creemos que ningún competidor local ofrece hoy la detección de intrusión, la detección de humo y la medición de consumo integradas en una misma plataforma para el formato de galería.
- Creemos que el uso de tecnologías open-source mantiene el costo de operación por debajo del precio de las alternativas de monitoreo disponibles en el mercado.


**2. Business Outcome Assumptions**

- Creemos que las disputas por cobros de servicios entre administradores e inquilinos se reducirán en un 30 % durante los primeros seis meses de uso de la plataforma.
- Creemos que el tiempo de resolución de un reclamo por facturación se reducirá en un 50 %, al disponer ambas partes del mismo registro de consumo.
- Creemos que la tasa de rotación de inquilinos en las galerías suscritas se reducirá en un 15 % anual, al disminuir las pérdidas por robo y los conflictos por cobros.
- Creemos que el 70 % de los inquilinos con un local monitoreado usará la aplicación móvil al menos una vez por semana.
- Creemos que el 30 % de las galerías que reciban una demostración del producto contratará una suscripción activa.
- Creemos que la retención de suscripciones tras el tercer mes superará el 70 %.

**3. User Assumptions**

- Creemos que el administrador de galería es un adulto entre 35 y 60 años, encargado de la infraestructura general del inmueble, que gestiona las operaciones desde una oficina y prefiere una vista consolidada en computadora.
- Creemos que el inquilino de local es un microempresario entre 25 y 55 años cuyo capital de trabajo está invertido en la mercadería almacenada y que opera principalmente desde su teléfono móvil mientras atiende proveedores y clientes.
- Creemos que ambos segmentos poseen un teléfono inteligente con acceso a internet móvil, dado que la penetración de este dispositivo en Lima Metropolitana alcanza el 99,2 % (OSIPTEL, 2025).
- Creemos que ninguno de los dos segmentos posee formación técnica, por lo que la información debe presentarse sin terminología especializada ni exigir configuración.
- Creemos que el inquilino desconfía de que el administrador acceda a información sobre la actividad interna de su local, por lo que el alcance de los datos debe estar delimitado por rol de forma explícita.
- Creemos que el administrador es quien autoriza la instalación del hardware en el inmueble, por lo que la adopción del inquilino depende de una decisión previa que no controla.

**4. User Outcome and Benefit Assumptions**

- Creemos que el administrador desea reducir las horas de trabajo manual que dedica a recorrer el inmueble y a elaborar los recibos de servicios.
- Creemos que el administrador desea sustentar el cobro de servicios con evidencia verificable, para reducir el estrés de la gestión operativa y las fricciones con sus inquilinos.
- Creemos que el inquilino desea enterarse de una intrusión en su local mientras ocurre y  no al abrir al día siguiente.
- Creemos que el inquilino desea comprobar que el importe de servicios que se le imputa corresponde únicamente a lo que efectivamente consumió.
- Creemos que ambos desean ser advertidos de la presencia de humo con antelación suficiente para actuar antes de que el fuego alcance los locales contiguos.
- Creemos que ambos valoran la tranquilidad de contar con vigilancia permanente sobre el inmueble por encima de la sofisticación de las funcionalidades ofrecidas.

**5. Feature Assumptions**

- Creemos que la detección de intrusión mediante sensores de movimiento y activación por proximidad, con notificación inmediata y captura de imagen asociada al evento, permitirá al inquilino reaccionar durante el evento y distinguir una alerta real de una falsa sin trasladarse al local.
- Creemos que la detección de humo y el envío simultáneo de la alerta al inquilino y al administrador permitirá reducir el tiempo entre la detección del evento y la respuesta.
- Creemos que los medidores inteligentes de energía y agua instalados en cada local permitirán sustituir el prorrateo estimado por una facturación basada en el consumo real verificable por ambas partes.
- Creemos que un tablero de control web con visualización de consumo acumulado, promedio histórico y desviación respecto de la línea base permitirá a ambos segmentos interpretar la información sin formación técnica.
- Creemos que el control de acceso por rol, que limita al inquilino a su propio local y otorga al administrador la vista consolidada del inmueble, es condición para que el inquilino acepte el uso de la plataforma.
- Creemos que una aplicación móvil nativa con push notifications de emergencias permitirá al inquilino supervisar su local mientras se encuentra fuera de la galería.
- Creemos que el procesamiento y almacenamiento local en el Edge API mantendrá la detección y el registro operativos aun cuando se interrumpa la conectividad con la nube.
- Creemos que una Landing Page estática con contenido y calls to action diferenciados por segmento permitirá comunicar la propuesta de valor y dirigir a cada usuario hacia el punto de acceso correspondiente..

#### 1.2.2.3. Lean UX Hypothesis Statements

A partir de los Feature Assumptions definidos anteriormente, se formula un Hypothesis Statement por cada funcionalidad propuesta. Cada hipótesis relaciona un resultado de negocio esperado con los usuarios, el beneficio que buscan obtener y la solución propuesta.

*Hypothesis 1 — Detección de intrusión con registro visual*

* Creemos que lograremos **reducir en un 15 % la tasa de rotación de inquilinos** si **los inquilinos de local** alcanzan **la capacidad de reaccionar ante una intrusión mientras ocurre y de distinguir una alerta real de una falsa sin trasladarse al inmueble** con **la detección por sensores de movimiento y proximidad, con notificación inmediata y captura de imagen asociada al evento**.

*Hypothesis 2 — Detección temprana de humo*

* Creemos que lograremos **una conversión del 30 % de las galerías que reciben una demostración hacia una suscripción activa** si **los administradores de galería** alcanzan **la advertencia de humo con antelación suficiente para actuar antes de que el fuego alcance los locales contiguos** con **el sensor de humo y el escalamiento simultáneo de la alerta al inquilino y al administrador**.

*Hypothesis 3 — Medición individual de consumo*

* Creemos que lograremos **reducir en un 30 % las disputas por cobros de servicios** si **los administradores de galería y los inquilinos de local** alcanzan **una facturación sustentada en consumo real y no en estimaciones** con **los medidores inteligentes de energía y agua instalados por local**.

*Hypothesis 4 — Tablero de control y visualización cuantitativa*

* Creemos que lograremos **reducir en un 50 % el tiempo de resolución de reclamos por facturación** si **los administradores de galería y los inquilinos de local** alcanzan **la comprensión de su consumo y de sus desviaciones sin formación técnica** con **la visualización de consumo acumulado, promedio histórico y desviación respecto de la línea base en el tablero de control**.

*Hypothesis 5 — Control de acceso por rol*

* Creemos que lograremos **una retención de suscripciones superior al 70 % tras el tercer mes** si **los inquilinos de local** alcanzan **la certeza de que el administrador no accede a la actividad interna de su local** con **el control de acceso por rol que delimita el alcance de la información para cada perfil**.

*Hypothesis 6 — Aplicación móvil con notificaciones push*

* Creemos que lograremos **que el 70 % de los inquilinos use la aplicación al menos una vez por semana** si **los inquilinos de local** alcanzan **la posibilidad de supervisar su local mientras se desplazan atendiendo proveedores y clientes** con **la aplicación móvil nativa y las notificaciones push de emergencias en tiempo real**.

*Hypothesis 7 — Procesamiento en el borde*

* Creemos que lograremos **una retención de suscripciones superior al 70 % tras el tercer mes** si **los administradores de galería y los inquilinos de local** alcanzan **la certeza de que la detección y el registro continúan operando ante una caída de conexión** con **el procesamiento y almacenamiento local en el Edge API**.

*Hypothesis 8 — Landing Page diferenciado por segmento*

* Creemos que lograremos **una conversión del 30 % de las galerías que reciben una demostración hacia una suscripción activa** si **los administradores de galería** alcanzan **la comprensión de la propuesta de valor aplicada a su formato de negocio** con **el Landing Page de contenido y llamadas a la acción diferenciados por segmento**.

#### 1.2.2.4. Lean UX Canvas

A continuación, se presenta el Lean UX Canvas elaborado por el equipo VanguardTech. Este canvas resume los principales elementos analizados durante el proceso de Lean UX y permite visualizar la relación entre el problema identificado, los usuarios, las necesidades, las soluciones propuestas y los resultados esperados.

![Lean-UX-Canvas - VanguardTech](../../assets/lean-ux/lean-ux-canvas-v2.png)

El canvas fue elaborado en Figma y puede consultarse en el siguiente enlace:

**Lean UX Canvas:** [https://shorturl.fm/UI0pZ](https://shorturl.fm/UI0pZ)

<div class="page"></div>