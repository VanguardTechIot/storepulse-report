### 1.2.2. Lean UX Process

En esta sección se presenta el proceso de Lean UX aplicado por el equipo para definir la propuesta de StorePulse. A partir de las creencias iniciales sobre el negocio y los usuarios, se identifican los principales problemas, supuestos y resultados esperados, los cuales se transforman en hipótesis que pueden ser validadas durante el desarrollo del proyecto.

Este proceso permite relacionar las necesidades de los administradores de galerías y los inquilinos de los locales con los resultados esperados del negocio y las funcionalidades propuestas para el producto. Para garantizar la trazabilidad, cada supuesto se identifica con un código y cada Hypothesis Statement declara explícitamente el Feature Assumption del que se deriva y el criterio de éxito del Problem Statement al que responde.

#### 1.2.2.1. Lean UX Problem Statements

Para representar la problemática general del proyecto se elaboró un único Problem Statement que considera los dos segmentos objetivo: administradores de galerías comerciales e inquilinos de los locales. De acuerdo con las indicaciones del Lean UX Process, se utiliza la plantilla correspondiente a una iniciativa nueva (Brand new initiative), que comprende cinco enunciados: dominio y estado actual, brecha no atendida, estrategia del producto, segmento inicial y criterios de éxito medibles.

El Problem Statement sintetiza los hallazgos del análisis 5W+2H de la sección 1.2.1: incorpora a los actores afectados (Who), el problema central (What), el entorno y el segmento inicial (Where), el momento en que ocurren los incidentes (When), sus causas (Why), la forma en que hoy se gestiona el problema (How) y la magnitud del daño y de la brecha de adopción (How Much). Asimismo, recoge las restricciones de alcance definidas en esa misma sección.

**Problem Statement**

El estado actual de **la gestión operativa de galerías comerciales en Lima Metropolitana, un formato que solo en el Emporio Comercial de Gamarra reúne 39 630 establecimientos, de los cuales el 99,6 % son micro y pequeñas empresas,** se ha enfocado principalmente en **administradores de galería e inquilinos de local que dependen de una vigilancia presencial y una inspección manual que no cubren la totalidad de los locales ni el horario nocturno; de un prorrateo estimado de los servicios básicos que el inquilino no puede verificar ni el administrador sustentar; y de una atención reactiva en la que los incidentes se conocen horas después de ocurridos, en un contexto donde la inseguridad genera pérdidas superiores a S/ 450 000 diarios a los pequeños comercios de Lima**.

Lo que los productos y servicios existentes no logran atender es **que, aunque las galerías comerciales figuran entre los cinco tipos de negocio más vulnerables al delito, la penetración de videovigilancia monitoreada en negocios apenas alcanza el 15 %, porque la oferta de seguridad electrónica está diseñada para comercios independientes con costos y contratos individuales, fuera del alcance del microempresario promedio, y no para inmuebles de propiedad compartida. Ninguna solución disponible integra en una misma plataforma la detección de intrusiones, la detección temprana de humo y la medición verificable del consumo por local, lo que abre la oportunidad de atender a todos los locales de una galería mediante una única contratación por inmueble**.

Nuestro producto atenderá esta brecha mediante **una plataforma IoT que instala dispositivos de bajo costo en cada local, procesa la telemetría en el edge para mantener la detección y el registro ante interrupciones de conectividad, y presenta la información mediante aplicaciones web y móviles con acceso diferenciado según el rol del usuario. La propuesta opera dentro de restricciones definidas: se limita a detectar, notificar, medir y visualizar, sin reemplazar la respuesta física de vigilancia ni los sistemas de extinción de incendios; su validación se circunscribe a galerías de Lima Metropolitana; y el tratamiento de los datos, en particular del registro visual asociado a eventos de seguridad, se sujeta a términos y condiciones que restringen el acceso a la información de cada local a su propio inquilino**.

Nuestro enfoque inicial será **los administradores e inquilinos de galerías comerciales con veinte o más locales en Gamarra, Mesa Redonda, Las Malvinas y el jirón Wilson, donde la contigüidad de los locales y la densidad de mercadería almacenada concentran los riesgos de robo e incendio, y donde la acometida compartida de servicios hace inevitable el prorrateo**.

Sabremos que hemos tenido éxito cuando observemos que **el 30 % de las galerías que reciben una demostración contrata una suscripción activa durante los primeros seis meses de operación comercial; que la retención de suscripciones supera el 70 % tras el tercer mes; que las cancelaciones atribuidas a fallas de disponibilidad del servicio se mantienen por debajo del 5 %; que el 70 % de los inquilinos con local monitoreado abre la aplicación al menos una vez por semana; que los reclamos mensuales por facturación se reducen en un 30 % y su tiempo de resolución en un 50 %; que el tiempo entre la detección de humo y la primera acción de respuesta se reduce en un 50 %; y que la tasa anual de rotación de inquilinos en las galerías suscritas disminuye en un 15 %**.

**Relación con el análisis 5W+2H**

| Enunciado del Problem Statement | Elementos del 5W+2H que sintetiza |
| :--- | :--- |
| Estado actual | **Who** (administradores e inquilinos), **Where** (galerías de Lima), **When** (horario nocturno, atención horas después del incidente), **How** (vigilancia presencial, inspección manual, prorrateo) y **How Much** (39 630 establecimientos, S/ 450 000 diarios en pérdidas) |
| Brecha no atendida | **Why** (oferta diseñada para el comercio independiente y fuera del alcance del microempresario) y **How Much** (15 % de penetración de videovigilancia monitoreada) |
| Estrategia del producto | **What** (ausencia de datos medidos y compartidos) y las restricciones de alcance funcional, geográfico y ético de la sección 1.2.1 |
| Segmento inicial | **Who** y **Where** (conglomerados de alta densidad de locales con acometida compartida) |
| Criterios de éxito | **How Much**, expresado como metas cuantitativas verificables |

#### 1.2.2.2. Lean UX Assumptions

En esta sección se presentan las creencias que sustentan la propuesta de StorePulse. Los assumptions se organizan en las cinco categorías establecidas por Lean UX: Business Assumptions, Business Outcome Assumptions, User Assumptions, User Outcome and Benefit Assumptions y Feature Assumptions.

Estos enunciados representan las creencias resultantes de la discusión del equipo y no preguntas de exploración. Cada uno se identifica con un código para permitir su referencia posterior. Los Feature Assumptions sirven como base directa para la formulación de los Hypothesis Statements de la sección 1.2.2.3.

**1. Business Assumptions**

| Código | Enunciado |
| :--- | :--- |
| BA-01 | Creemos que en los cuatro conglomerados comerciales del segmento inicial existen al menos cien galerías con veinte o más locales, volumen suficiente para sostener el negocio durante sus dos primeros años de operación. |
| BA-02 | Creemos que el administrador de la galería es quien toma la decisión de compra y asume el costo de la suscripción, mientras que el inquilino es el usuario beneficiario sin participación en esa decisión. |
| BA-03 | Creemos que una suscripción mensual escalonada de entre S/ 15 y S/ 30 por local monitoreado se encuentra dentro de la capacidad de pago de una administración de galería, por representar menos del 5 % de lo que ya destina a vigilancia y mantenimiento. |
| BA-04 | Creemos que la venta por inmueble completo, y no por local individual, reduce el costo de adquisición por local en al menos un 60 % frente a una venta uno a uno. |
| BA-05 | Creemos que ningún competidor local ofrece hoy la detección de intrusión, la detección de humo y la medición de consumo integradas en una misma plataforma para el formato de galería. |
| BA-06 | Creemos que el uso de tecnologías open-source mantiene el costo mensual de operación por local por debajo del 30 % del precio de suscripción, permitiendo un margen sostenible. |


**2. Business Outcome Assumptions**

| Código | Enunciado |
| :--- | :--- |
| BO-01 | Creemos que las disputas por cobros de servicios entre administradores e inquilinos se reducirán en un 30 % durante los primeros seis meses de uso de la plataforma. |
| BO-02 | Creemos que el tiempo de resolución de un reclamo por facturación se reducirá en un 50 % durante los primeros seis meses de uso, al disponer ambas partes del mismo registro de consumo. |
| BO-03 | Creemos que la tasa de rotación de inquilinos en las galerías suscritas se reducirá en un 15 % anual, al disminuir las pérdidas por robo. |
| BO-04 | Creemos que el 70 % de los inquilinos con un local monitoreado usará la aplicación móvil al menos una vez por semana al término del primer trimestre posterior a la instalación. |
| BO-05 | Creemos que el 30 % de las galerías que reciban una demostración del producto contratará una suscripción activa durante los primeros seis meses de operación comercial. |
| BO-06 | Creemos que la retención de suscripciones tras el tercer mes superará el 70 %. |
| BO-07 | Creemos que el tiempo transcurrido entre la detección de humo y la primera acción de respuesta del administrador se reducirá en un 50 % frente a la detección visual actual. |
| BO-08 | Creemos que las cancelaciones de suscripción atribuidas a fallas de disponibilidad del servicio se mantendrán por debajo del 5 % durante el primer año. |

**3. User Assumptions**

| Código | Enunciado |
| :--- | :--- |
| UA-01 | Creemos que el administrador de galería es un adulto entre 35 y 60 años, encargado de la infraestructura general del inmueble, que gestiona las operaciones desde una oficina y prefiere una vista consolidada en computadora. |
| UA-02 | Creemos que el inquilino de local es un microempresario entre 25 y 55 años cuyo capital de trabajo está invertido en la mercadería almacenada y que opera principalmente desde su teléfono móvil mientras atiende proveedores y clientes. |
| UA-03 | Creemos que ambos segmentos poseen un teléfono inteligente con acceso a internet móvil, dado que la penetración de este dispositivo en Lima Metropolitana alcanza el 99,2 % (OSIPTEL, 2025). |
| UA-04 | Creemos que ninguno de los dos segmentos posee formación técnica, por lo que la información debe presentarse sin terminología especializada ni exigir configuración. |
| UA-05 | Creemos que el inquilino desconfía de que el administrador acceda a información sobre la actividad interna de su local, por lo que el alcance de los datos debe estar delimitado por rol de forma explícita. |
| UA-06 | Creemos que el administrador es quien autoriza la instalación del hardware en el inmueble, por lo que la adopción del inquilino depende de una decisión previa que no controla. |

**4. User Outcome and Benefit Assumptions**

| Código | Enunciado |
| :--- | :--- |
| UOB-01 | Creemos que el administrador desea reducir a la mitad las horas semanales que hoy destina a recorridos de supervisión y a la elaboración manual de los recibos de servicios. |
| UOB-02 | Creemos que el administrador desea responder un reclamo mostrando el histórico de consumo del local en lugar de negociar sin evidencia, para reducir las fricciones con sus inquilinos. |
| UOB-03 | Creemos que el inquilino desea enterarse de una intrusión en su local dentro del minuto en que ocurre, y no al abrir al día siguiente. |
| UOB-04 | Creemos que el inquilino desea comprobar, antes de pagar, que el importe de servicios que se le imputa corresponde únicamente a lo que efectivamente consumió. |
| UOB-05 | Creemos que ambos desean ser advertidos de la presencia de humo con antelación suficiente para evacuar o actuar antes de que el fuego alcance los locales contiguos. |
| UOB-06 | Creemos que ambos valoran la tranquilidad de contar con vigilancia permanente sobre el inmueble por encima de la cantidad de funcionalidades que ofrezca la plataforma. |

**5. Feature Assumptions**

| Código | Enunciado |
| :--- | :--- |
| FA-01 | Creemos que la detección de intrusión mediante sensores de movimiento y activación por proximidad, con notificación inmediata y captura de imagen asociada al evento, permitirá al inquilino reaccionar durante el evento y distinguir una alerta real de una falsa sin trasladarse al local. |
| FA-02 | Creemos que la detección de humo y el envío simultáneo de la alerta al inquilino y al administrador permitirá reducir el tiempo entre la detección del evento y la respuesta. |
| FA-03 | Creemos que los medidores inteligentes de energía y agua instalados en cada local permitirán sustituir el prorrateo estimado por una facturación basada en el consumo real verificable por ambas partes. |
| FA-04 | Creemos que un tablero de control web con visualización de consumo acumulado, promedio histórico y desviación respecto de la línea base permitirá a ambos segmentos interpretar la información sin formación técnica. |
| FA-05 | Creemos que el control de acceso por rol, que limita al inquilino a su propio local y otorga al administrador la vista consolidada del inmueble, es condición para que el inquilino acepte el uso de la plataforma. |
| FA-06 | Creemos que una aplicación móvil nativa con push notifications de emergencias permitirá al inquilino supervisar su local mientras se encuentra fuera de la galería. |
| FA-07 | Creemos que el procesamiento y almacenamiento local en el Edge API mantendrá la detección y el registro operativos aun cuando se interrumpa la conectividad con la nube. |
| FA-08 | Creemos que una Landing Page estática con contenido y calls to action diferenciados por segmento permitirá comunicar la propuesta de valor y dirigir a cada usuario hacia el punto de acceso correspondiente. |

#### 1.2.2.3. Lean UX Hypothesis Statements

Conforme a lo establecido por el Lean UX Process, se formula **un Hypothesis Statement por cada Feature Assumption**, en una relación uno a uno. Cada hipótesis declara explícitamente el Feature Assumption del que deriva, el Business Outcome Assumption cuyo cumplimiento busca verificar y el criterio de éxito del Problem Statement al que responde. De este modo, las ocho hipótesis cubren la totalidad de los criterios de éxito declarados en el Problem Statement, y cada uno de sus pain points —intrusión, humo, opacidad en el cobro de servicios y atención reactiva— queda respaldado por al menos una hipótesis.

La siguiente tabla resume dicha correspondencia.

| Hypothesis | Deriva de | Verifica | Criterio de éxito del Problem Statement | Pain point que atiende |
| :--- | :--- | :--- | :--- | :--- |
| HS-01 | FA-01 | BO-03 | Rotación anual de inquilinos −15 % | Intrusión |
| HS-02 | FA-02 | BO-07 | Tiempo de respuesta ante humo −50 % | Humo |
| HS-03 | FA-03 | BO-01 | Reclamos mensuales por facturación −30 % | Cobro de servicios |
| HS-04 | FA-04 | BO-02 | Tiempo de resolución de reclamos −50 % | Cobro de servicios |
| HS-05 | FA-05 | BO-06 | Retención de suscripciones > 70 % | Adopción del inquilino |
| HS-06 | FA-06 | BO-04 | 70 % de inquilinos activos semanalmente | Atención reactiva |
| HS-07 | FA-07 | BO-08 | Cancelaciones por indisponibilidad < 5 % | Atención reactiva |
| HS-08 | FA-08 | BO-05 | Conversión de demostraciones del 30 % | Brecha de la oferta actual |

**HS-01 — Detección de intrusión con registro visual** *(deriva de FA-01, verifica BO-03)*

Creemos que lograremos **reducir en un 15 % la tasa anual de rotación de inquilinos** si **los inquilinos de local** alcanzan **la capacidad de reaccionar ante una intrusión mientras ocurre y de distinguir una alerta real de una falsa sin trasladarse al inmueble** con **la detección por sensores de movimiento y proximidad, con notificación inmediata y captura de imagen asociada al evento**.

**HS-02 — Detección temprana de humo** *(deriva de FA-02, verifica BO-07)*

Creemos que lograremos **reducir en un 50 % el tiempo transcurrido entre la detección de humo y la primera acción de respuesta** si **los administradores de galería y los inquilinos de local** alcanzan **la advertencia de humo con antelación suficiente para evacuar o actuar antes de que el fuego alcance los locales contiguos** con **el sensor de humo y el escalamiento simultáneo de la alerta a ambos roles**.

**HS-03 — Medición individual de consumo** *(deriva de FA-03, verifica BO-01)*

Creemos que lograremos **reducir en un 30 % las disputas por cobros de servicios** si **los administradores de galería y los inquilinos de local** alcanzan **una facturación sustentada en consumo real y no en estimaciones** con **los medidores inteligentes de energía y agua instalados por local**.

**HS-04 — Tablero de control y visualización cuantitativa** *(deriva de FA-04, verifica BO-02)*

Creemos que lograremos **reducir en un 50 % el tiempo de resolución de reclamos por facturación** si **los administradores de galería y los inquilinos de local** alcanzan **la comprensión de su consumo y de sus desviaciones sin formación técnica** con **la visualización de consumo acumulado, promedio histórico y desviación respecto de la línea base en el tablero de control**.

**HS-05 — Control de acceso por rol** *(deriva de FA-05, verifica BO-06)*

Creemos que lograremos **una retención de suscripciones superior al 70 % tras el tercer mes** si **los inquilinos de local** alcanzan **la certeza de que el administrador no accede a la actividad interna de su local** con **el control de acceso por rol que delimita el alcance de la información para cada perfil**.

**HS-06 — Aplicación móvil con notificaciones push** *(deriva de FA-06, verifica BO-04)*

Creemos que lograremos **que el 70 % de los inquilinos use la aplicación al menos una vez por semana** si **los inquilinos de local** alcanzan **la posibilidad de supervisar su local mientras se desplazan atendiendo proveedores y clientes** con **la aplicación móvil nativa y las notificaciones push de emergencias en tiempo real**.

**HS-07 — Procesamiento en el borde** *(deriva de FA-07, verifica BO-08)*

Creemos que lograremos **mantener por debajo del 5 % las cancelaciones atribuidas a fallas de disponibilidad del servicio** si **los administradores de galería y los inquilinos de local** alcanzan **la certeza de que la detección y el registro continúan operando ante una caída de conexión** con **el procesamiento y almacenamiento local en el Edge API**.

**HS-08 — Landing Page diferenciado por segmento** *(deriva de FA-08, verifica BO-05)*

Creemos que lograremos **una conversión del 30 % de las galerías que reciben una demostración hacia una suscripción activa** si **los administradores de galería** alcanzan **la comprensión de la propuesta de valor aplicada a su formato de negocio** con **el Landing Page de contenido y llamadas a la acción diferenciados por segmento**.

#### 1.2.2.4. Lean UX Canvas

A continuación, se presenta el Lean UX Canvas elaborado por el equipo VanguardTech. Este canvas resume los principales elementos analizados durante el proceso de Lean UX y permite visualizar la relación entre el problema identificado, los usuarios, las necesidades, las soluciones propuestas y los resultados esperados.

![Lean-UX-Canvas - VanguardTech](../../assets/lean-ux/lean-ux-canvas-v3.png)

El canvas fue elaborado en Figma y puede consultarse en el siguiente enlace:

**Lean UX Canvas:** [Ver en Figma](https://www.figma.com/board/Ve7fG9wg5OyzZneKkhMLxP/Lean-UX-Canvas--v2---Community-?node-id=0-1&t=rXoIKtDzO5D6iOE2-1)

<div class="page"></div>