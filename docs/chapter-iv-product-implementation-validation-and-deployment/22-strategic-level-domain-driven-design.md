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
ejecutarlos. Luego se agregaron los Read Models (verde) simples bocetos de la información que un actor necesita
antes de decidir, no un diseño de interfaz y los External Systems (rosado) ajenos al control del equipo. Finalmente,
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

![eventstorming-commads.png](../../assets/research/eventstorming/eventstorming-commads.png)

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
