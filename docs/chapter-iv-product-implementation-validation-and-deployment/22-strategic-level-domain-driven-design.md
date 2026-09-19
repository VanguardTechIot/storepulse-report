# Capítulo IV: Solution Software Design

## 4.1. Strategic-Level Domain-Driven Design

En esta sección se describirá y explicará el proceso realizado para la toma de decisiones
a nivel estratégico para StorePulse, con la aplicación de Domain Driven Design 
sobre el dominio de los anteriores capítulos. El principal objetivo de esta sección 
es el descomponer el sistema en subconjuntos limitados o *Bounded Contexts*, en el que se 
evidenciará el proceso del *Event Storming* y el *Bounded Context Canvas* con el fin de 
definir las relaciones estructurales que hay entre los diferentes contextos y la arquitectura 
de software que lo soportará. 

### 4.1.1. Design-Level EventStorming

En esta sección el equipo explica y pone en evidencia el proceso de **Design-Level EventStorming**, con
el fin de plantear una primera aproximación revisada y mejorada al modelado de nivel general para el
dominio de StorePulse, buscando a partir de ahí identificar el mayor nivel de detalle posible sobre los
eventos de dominio significativos ya capturados en el *Big Picture EventStorming* y el
*Ubiquitous Language*.

Para la construcción del Design-Level EventStorming, el equipo siguió la guía de facilitación de referencia
[Guía de Design-Level Event Storming](https://www.eventstormingjournal.com/software%20design/design-level-event-storming-in-3-minutes/),
trabajando enteramente con notas adhesivas sobre el tablero
colaborativo de Lucid, sin recurrir a herramientas de diseño visual. El proceso inició generando los Domain Events
(naranja) que detallan, a nivel de diseño, los eventos ya validados en el Big Picture EventStorming; a partir de ahí
se incorporaron los Commands (azul) que los originan y los Actores y Policies (amarillo/morado) responsables de
ejecutarlos. Luego se agregaron los Read Models (verde), simples bocetos de la información que un actor necesita
antes de decidir y no un diseño de interfaz, junto con los External Systems (rosado) ajenos al control del equipo. Finalmente,
se redactaron las Business Rules asociadas a cada Policy y se agruparon los Commands y Events relacionados bajo
Aggregates con nombre propio, completando así el nivel de detalle exigido por la sesión.

**Paso 1: Presentar el diseño objetivo**

Antes de abordar el dominio de negocio, se presenta el patrón visual y
la gramática de notación que se utilizará durante toda la sesión, de forma que todos los miembros compartan
el mismo lenguaje visual desde el inicio, siguiendo la guía de facilitación de referencia.

> **Actor → Command → Aggregate/Event → Policy → Command → Event**

| Elemento | Color / forma en Lucid | Descripción |
|---|---|---|
| Domain Event | Nota naranja | Hecho relevante del dominio, redactado en pasado (ej. *Security Incident Noticed*). |
| Actor / Rol | Nota amarilla pequeña | Persona o rol que ejecuta un Command (ej. *Gallery Administrator*, *Tenant*). |
| Command | Nota azul | Intención de acción de un actor o sistema, redactada en imperativo. |
| Policy | Nota morada/violeta | Reacción automática del negocio ante un evento, con la forma "Cada vez que X, entonces Y". |
| Read Model | Nota verde | Información que un actor necesita consultar antes de emitir un Command. |
| External System | Nota rosada (grande) | Sistema externo fuera del control del equipo. |
| Aggregate | Nota amarilla grande | Agrupación de Commands y Events que comparten ciclo de vida y consistencia transaccional. |
| Bounded Context | Contorno punteado | Límite candidato que agrupa Aggregates, Commands, Events y Policies con lenguaje y responsabilidad cohesivos. |

**Paso 2: Generar Domain Events**

![eventstorming-events.png](../../assets/research/eventstorming/eventstorming-events.png)

Como se muestra en la imagen, se construyeron los 39 Domain Events (naranja) a mayor nivel de profundidad de
los eventos ya validados en el Big Picture EventStorming.

**Paso 3: Agregar Commands**

![eventstorming-commands.png](../../assets/research/eventstorming/eventstorming-commands.png)

La imagen muestra los Commands (azul) agregados junto a cada Domain Event, representando la intención de acción,
en imperativo, que lo origina. Los eventos que provienen de un External System (sensores IoT en este caso) o que se derivan
automáticamente de una Policy no llevan Command propio, ya que no nacen de la decisión de un actor.

**Paso 4: Agregar Actors y Policies**

![eventstorming-actors.png](../../assets/research/eventstorming/eventstorming-actors.png)

La imagen agrupa los eventos que nacen directamente de la decisión de un Actor (Gallery Administrator, Tenant o Security
Team Member) mediante su Command respectivo, por lo que no requieren una Policy: el propio actor decide y ejecuta la acción.


![eventstorming-policy-1.png](../../assets/research/eventstorming/eventstorming-policy-1.png)

Policy que consolida las dos vías de detección de un incidente de seguridad (intrusión detectada por VanguardTech o
reporte directo del Tenant vía app) en el evento pivote Security Incident Noticed.

![eventstorming-policy-2.png](../../assets/research/eventstorming/eventstorming-policy-2.png)

Policy que, ante la detección de humo, dispara automáticamente la evaluación del riesgo de incendio.

![eventstorming-policy-3.png](../../assets/research/eventstorming/eventstorming-policy-3.png)

Una vez verificado el incidente por el Security Team Member, la Policy notifica en paralelo al Gallery Administrator y
al Tenant mediante la emisión de la alerta de emergencia.

![eventstorming-policy-4.png](../../assets/research/eventstorming/eventstorming-policy-4.png)

Policy de cierre: cuando el incidente de seguridad y el riesgo de incendio quedan resueltos, se envía de forma
automática la notificación de "todo despejado" (All-Clear).

![eventstorming-policy-5.png](../../assets/research/eventstorming/eventstorming-policy-5.png)

Policy que compara el consumo registrado contra la Baseline Consumption establecida y, si la excede, marca
automáticamente una desviación de consumo.

![eventstorming-policy-6.png](../../assets/research/eventstorming/eventstorming-policy-6.png)

Policy que, al emitirse la factura (evento pivote Utility Bill Issued), notifica automáticamente al Tenant sin
intervención adicional del Gallery Administrator.

![eventstorming-policy-7.png](../../assets/research/eventstorming/eventstorming-policy-7.png)

Ante la pérdida de conectividad (evento pivote), la Policy activa en paralelo el almacenamiento en búfer de eventos
locales y el modo de solo lectura sin conexión para el usuario.

![eventstorming-policy-8.png](../../assets/research/eventstorming/eventstorming-policy-8.png)

Al restablecerse la conectividad, la Policy sincroniza los eventos acumulados en el búfer y confirma al usuario que la
sincronización se completó.

**Paso 5: Read-models**

![eventstorming-read-models.png](../../assets/research/eventstorming/eventstorming-read-models.png)

La imagen incorpora los Read Models (verde) en cada punto donde un actor necesita consultar información antes de ejecutar
su Command: Security Monitoring para el Security Team Member, Consumption History y Baseline Consumption para las
decisiones de facturación, y Commercial Unit Availability / Conversation History para Management-Tenant Communication.
Business Continuity no requiere ninguno, ya que todos sus eventos son automáticos.

**Paso 6: Read-models detallados**

![eventstorming-read-model-security-monitoring.png](../../assets/research/eventstorming/eventstorming-read-model-security-monitoring.png)

El Read Model Security Monitoring detalla el estado de los sensores del local, la hora del último evento y el historial
de incidentes recientes, información que el Security Team Member consulta antes de verificar un incidente.

![eventstorming-read-model-utility-bill-detail.png](../../assets/research/eventstorming/eventstorming-read-model-utility-bill-detail.png)

El Read Model Utility Bill Detail muestra el monto facturado, el período, el desglose por servicio y el consumo frente
a la Baseline, datos que el Tenant revisa antes de reportar una disputa de facturación.

![eventstorming-read-model-consumption-history.png](../../assets/research/eventstorming/eventstorming-read-model-consumption-history.png)

El Read Model Consumption History resume el consumo de periodos anteriores y el promedio histórico, insumo que el
Gallery Administrator utiliza para establecer la Baseline Consumption.

![eventstorming-read-model-baseline-consumption.png](../../assets/research/eventstorming/eventstorming-read-model-baseline-consumption.png)

El Read Model Baseline Consumption expone el nivel de referencia vigente y la fecha de su última actualización,
dato verificable que el Gallery Administrator usa para resolver una disputa de facturación.

![eventstorming-read-model-commercial-unit-availability.png](../../assets/research/eventstorming/eventstorming-read-model-commercial-unit-availability.png)

El Read Model Commercial Unit Availability lista los locales sin Tenant asignado y su estado,
información que el Gallery Administrator consulta antes de asignar un Tenant a una unidad.

![eventstorming-read-conversation-history.png](../../assets/research/eventstorming/eventstorming-read-conversation-history.png)

El Read Model Conversation History reúne los mensajes previos, adjuntos y el estado de la conversación, que el Gallery
Administrator revisa antes de marcarla como resuelta.

**Paso 7: Agregar External Systems**

![eventstorming-external-system.png](../../assets/research/eventstorming/eventstorming-external-system.png)

La imagen conecta cada evento originado fuera del control del equipo con su External System (rosado): Internet Service
Provider en la pérdida y restauración de conectividad, Fire Brigade en la detección de humo, y Sedapal / Luz del Sur en
el registro del consumo de servicios.

**Paso 8: Business Rules en Blanco**

![eventstorming-business-rules.png](../../assets/research/eventstorming/eventstorming-business-rules.png)

La imagen marca con una estrella los Commands que requieren una Business Rule explícita antes de ejecutarse: Establish Baseline Consumption,
Verify Security Incident, Issue Utility Bill y Assign Tenant. La redacción de cada regla se completa en el paso 9.

**Paso 9: Escribir los Business Rules**

![eventstorming-business-assign-tenant.png](../../assets/research/eventstorming/eventstorming-business-assign-tenant.png)

Business Rule de Assign Tenant: un Tenant solo puede asignarse a una Commercial Unit que figure como disponible
(sin otro Tenant activo asignado).

![eventstorming-business-issue-utility.png](../../assets/research/eventstorming/eventstorming-business-issue-utility.png)

Business Rule de Issue Utility Bill: la factura solo se emite una vez cerrado el Consumption Period y siempre que no
exista ya una factura emitida para ese mismo período.

![eventstorming-business-establish-baseline.png](../../assets/research/eventstorming/eventstorming-business-establish-baseline.png)

Business Rule de Establish Baseline Consumption: se requiere un mínimo de tres periodos históricos de consumo para
calcular la Baseline; si no están disponibles, se usa un valor de referencia por defecto.

![eventstorming-business-verify-security.png](../../assets/research/eventstorming/eventstorming-business-verify-security.png)

Business Rule de Verify Security Incident: la verificación debe completarse dentro de un SLA máximo (ej. 15 minutos)
desde que el incidente fue asignado al Security Team Member.

**Paso 10: Agrupación de los Business Rules**

![eventstorming-group-business-rule-safety-and-emergencies.png](../../assets/research/eventstorming/eventstorming-group-business-rule-safety-and-emergencies.png)

Agrupación completa del Bounded Context Safety and Emergencies: las dos vías de detección (intrusión y humo), la
verificación del incidente con su Business Rule de SLA, y el cierre con la notificación All-Clear.

![eventstorming-group-business-rule-consumption-billing.png](../../assets/research/eventstorming/eventstorming-group-business-rule-consumption-billing.png)

Agrupación completa del Bounded Context Consumption and Billing: desde el registro del consumo y el establecimiento de
la Baseline (con su Business Rule) hasta la emisión de la factura y la disputa de facturación.

![eventstorming-group-business-rule-management.png](../../assets/research/eventstorming/eventstorming-group-business-rule-management.png)

Agrupación completa del Bounded Context Management-Tenant Communication: la asignación del Tenant a su unidad, el
intercambio de mensajes y el registro de la comunicación derivada de la factura emitida.

![eventstorming-group-business-rule-business-continuity.png](../../assets/research/eventstorming/eventstorming-group-business-rule-business-continuity.png)

Agrupación completa del Bounded Context Business Continuity: la pérdida de conectividad con su respuesta de buffering y
modo offline, y la restauración con la sincronización de los eventos acumulados.

**Paso 11: Aggregates**

![eventstorming-aggregates-safety-emergencies.png](../../assets/research/eventstorming/eventstorming-aggregates-safety-emergencies.png)

La imagen consolida el Bounded Context Safety and Emergencies en 3 Aggregates: Security Incident (desde la instalación de
sensores hasta la verificación del incidente), Fire Risk (la detección de humo y su resolución) y Emergency Notification
(el envío de alertas y la notificación All-Clear). Las dos Policies que cruzan de un Aggregate a otro permanecen en la
frontera entre los óvalos, ya que representan la comunicación entre Aggregates y no pertenecen a uno solo.

![eventstorming-aggregates-consumption-and-billing.png](../../assets/research/eventstorming/eventstorming-aggregates-consumption-and-billing.png)

La imagen agrupa Consumption and Billing en 3 Aggregates: Utility Meter (la vinculación y captura del consumo del
medidor), Consumption Baseline (el establecimiento de la referencia y la detección de desviaciones) y Utility Bill
(desde el cierre del periodo hasta la emisión de la factura y la resolución de disputas). La única Policy que cruza de
un Aggregate a otro, de Utility Meter hacia Consumption Baseline, queda en el límite entre ambos óvalos.

![eventstorming-aggregates-management-tenant-communication.png](../../assets/research/eventstorming/eventstorming-aggregates-management-tenant-communication.png)

La imagen agrupa Management-Tenant Communication en 3 Aggregates: Tenant Assignment (la asignación del Tenant a su
unidad), Conversation (el intercambio de mensajes hasta su resolución) y Tenant Notification, que converge dos orígenes
distintos —la resolución de una conversación y la Policy cruzada desde Utility Bill Issued en Consumption and
Billing— en un único registro de comunicación.

![eventstorming-aggregates-connectivity-buffer.png](../../assets/research/eventstorming/eventstorming-aggregates-connectivity-buffer.png)

La imagen muestra Business Continuity como un único Aggregate, Connectivity Buffer, ya que la pérdida y la restauración
de conectividad son dos fases del mismo ciclo de vida y no requieren una frontera transaccional separada. Ambas
Policies quedan completamente dentro del óvalo, pues no cruzan hacia ningún otro Aggregate.

![eventstorming-complete.png](../../assets/research/eventstorming/eventstorming-complete.png)

La imagen final consolida los 4 Bounded Contexts con los 10 Aggregates resultantes. Los eventos Commercial Unit
Registered y Commercial Gallery Registered permanecen fuera de los cuatro recuadros, ya que son precondiciones
compartidas —el alta de la unidad y de la galería comercial— que no pertenecen a ningún Bounded Context en particular,
siguiendo el mismo patrón con el que ya se habían presentado en el Big Picture EventStorming.

Con este paso concluye el **Design-Level EventStorming**. Partiendo de los 39 Domain Events identificados en el
Paso 2, se incorporaron sucesivamente los Commands, Actors, Policies, Read Models, External Systems y Business Rules
que dan soporte a los 4 Bounded Contexts candidatos —Safety and Emergencies, Consumption and Billing,
Management-Tenant Communication y Business Continuity— y se consolidaron en 10 Aggregates que constituyen la unidad
de consistencia transaccional del diseño. Este resultado sirve de base para el Candidate Context Discovery, el Domain
Message Flows Modeling y las Bounded Context Canvases desarrollados en las siguientes secciones.

#### 4.1.1.1. Candidate Context Discovery

Con el Design-Level EventStorming completo, el equipo realizó una sesión de **Candidate Context Discovery** de no más
de 2 horas, con el objetivo de transformar los Aggregates ya agrupados en Bounded Contexts candidatos formales. De las
tres técnicas propuestas por la guía de referencia, se aplicaron **look-for-pivotal-events** y **start-with-value**: la
primera porque los eventos pivote del dominio ya habían sido validados desde el Big Picture EventStorming, y la segunda
para argumentar cuál Bounded Context concentra el mayor valor de negocio para StorePulse.

**Look for Pivotal Events**

![eventstorming-pivotal-events.png](../../assets/research/eventstorming/eventstorming-pivotal-events.png)

Sobre el board de detalle se volvieron a marcar los 4 eventos pivote ya identificados en el Big Picture
EventStorming —Security Incident Noticed, Billing Dispute Raised, Utility Bill Issued y Connectivity Lost Detected—,
confirmando que cada uno sigue señalando, a este nivel de detalle, el mismo cambio de responsabilidad o de fase que
justificó su elección: de una detección externa a una responsabilidad interna (Security Incident Noticed), de la
iniciativa del Tenant a la de la administración (Billing Dispute Raised), del sistema externo a la interacción directa
con el Tenant (Utility Bill Issued), y de la conectividad normal a la operación en modo offline
(Connectivity Lost Detected).

**Delimitación de los Bounded Contexts candidatos**

![eventstorming-candidate-contexts.png](../../assets/research/eventstorming/eventstorming-candidate-contexts.png)

Usando los 4 eventos pivote como frontera, se trazó un contorno punteado alrededor de cada cluster de Aggregates,
confirmando los 4 Bounded Contexts candidatos: Safety and Emergencies, Consumption and Billing, Management-Tenant
Communication y Business Continuity. Los eventos Commercial Unit Registered y Commercial Gallery Registered permanecen
fuera de los cuatro contornos, ya que son precondiciones compartidas que no pertenecen a ningún contexto en particular.
Las Policies que cruzan de un contexto a otro de Utility Meter hacia Consumption Baseline dentro de Consumption and
Billing, y de Utility Bill Issued hacia Tenant Notification entre Consumption and Billing y Management Tenant
Communication quedan visiblemente en la frontera entre los contornos, evidenciando la comunicación entre Bounded
Contexts.


