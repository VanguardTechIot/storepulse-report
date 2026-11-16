## 4.2.10. Bounded Context: Safety and Emergencies

El **Bounded Context de Safety and Emergencies** se encarga de evaluar cada medición recibida por StorePulse contra las reglas de seguridad, determinar el estado de cada dispositivo y administrar las alertas que se generan cuando una regla se cumple. Ante una intrusión fuera del horario de atención, una concentración de humo o una condición anormal de temperatura, humedad o consumo, crea la alerta correspondiente, avisa al Tenant del local afectado y permite que el Gallery Administrator confirme su atención y registre su resolución.

Este contexto recibe las mediciones desde **Service Execution and Monitoring**, consulta en **Resource and Asset Management** y **Property Management** el recurso y el local donde está instalado cada dispositivo, y entrega las notificaciones a través de **Property Communication**. Las reglas estándar también se aplican en la Edge API, de modo que los nodos reciben su respuesta aun cuando no hay conexión con la REST API.

### 4.2.10.1. Domain Layer

La **Domain Layer** contiene las reglas de seguridad, el ciclo de vida de las alertas y el estado de los dispositivos.

#### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `SafetyRule` | Aggregate Root | Define una regla de seguridad para un tipo de sensor: su umbral, el estado que asigna al dispositivo y la respuesta que se envía. Una regla de movimiento solo se cumple fuera del horario de atención. |
| `Alert` | Aggregate Root | Representa una condición detectada por una regla. Registra el dispositivo, la medición que la originó y su valor, y controla su ciclo de vida: activa, en atención y resuelta. |
| `DeviceState` | Aggregate Root | Representa el estado actual de un dispositivo y la respuesta asociada. El dispositivo permanece en alerta mientras tenga alertas sin resolver. |
| `Threshold` | Value Object | Encapsula el valor límite de una regla y el operador de comparación con el que se evalúa una medición. |
| `BusinessHours` | Value Object | Representa el horario de atención de la galería, de 10:00 a 22:00 en la hora de Lima, utilizado para evaluar las reglas de movimiento. |
| `MeasurementAssessment` | Value Object | Representa el resultado de evaluar una medición: estado del dispositivo, respuesta y si se generó una nueva alerta. |

#### Enumeraciones del dominio

| Enumeración | Valores | Propósito |
|---|---|---|
| `SensorType` | `MOTION`, `SMOKE`, `HUMIDITY`, `TEMPERATURE`, `ELECTRICITY`, `WATER` | Identifica el tipo de sensor al que se aplica una regla. |
| `ComparisonOperator` | `GREATER_THAN`, `GREATER_THAN_OR_EQUAL`, `LESS_THAN`, `LESS_THAN_OR_EQUAL`, `EQUAL` | Define cómo se compara el valor de una medición con el umbral. |
| `AlertStatus` | `ACTIVE`, `ACKNOWLEDGED`, `RESOLVED` | Controla el ciclo de vida de una alerta. |
| `DeviceStatus` | `NORMAL`, `ALERT` | Representa el estado de seguridad de un dispositivo. |
| `ResponseAction` | `NONE`, `SEND_ALERT` | Indica la respuesta que corresponde al dispositivo, por ejemplo activar su alarma. |

#### Reglas estándar de seguridad

Las mismas reglas se aplican a todos los dispositivos de la galería.

| Regla | Sensor | Condición | Estado | Respuesta |
|---|---|---|---|---|
| Motion detected | `MOTION` | Igual a 1, fuera del horario de atención | `ALERT` | `SEND_ALERT` |
| Smoke detected | `SMOKE` | Mayor a 300 ppm | `ALERT` | `SEND_ALERT` |
| High temperature | `TEMPERATURE` | Mayor a 45 °C | `ALERT` | `SEND_ALERT` |
| High humidity | `HUMIDITY` | Mayor a 70 % | `ALERT` | `SEND_ALERT` |
| High electricity consumption | `ELECTRICITY` | Mayor a 5 kWh por lectura | `ALERT` | `SEND_ALERT` |
| High water consumption | `WATER` | Mayor a 0.5 m³ por lectura | `ALERT` | `SEND_ALERT` |

#### Commands

| Command | Origen | Propósito |
|---|---|---|
| `EvaluateMeasurementCommand` | Service Execution and Monitoring | Evaluar una medición de un dispositivo contra las reglas de su tipo de sensor. |
| `AcknowledgeAlertCommand` | Gallery Administrator | Confirmar que una alerta activa está siendo atendida. |
| `ResolveAlertCommand` | Gallery Administrator | Resolver una alerta en atención con una nota sobre el resultado. |
| `SeedSafetyRulesCommand` | Sistema | Registrar las reglas estándar que aún no existen al iniciar la plataforma. |

#### Queries

| Query | Propósito |
|---|---|
| `GetAllSafetyRulesQuery` | Obtener todas las reglas de seguridad. |
| `GetSafetyRuleByIdQuery` | Obtener una regla de seguridad. |
| `GetAlertsByDeviceIdsQuery` | Obtener las alertas de los dispositivos visibles para el usuario, de la más reciente a la más antigua. |
| `GetAlertByIdQuery` | Obtener una alerta. |
| `GetDeviceStateByDeviceIdQuery` | Obtener el estado actual de un dispositivo. |

#### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `SafetyRule` | Determinar si una medición cumple la regla considerando su umbral, si está habilitada y, para el movimiento, el horario de atención. |
| `Threshold` | Comparar un valor con el límite mediante el operador configurado. |
| `Alert` | Registrar la alerta, confirmar su atención únicamente desde el estado activo y resolverla únicamente desde el estado en atención y con una nota. |
| `DeviceState` | Actualizar el estado y la respuesta del dispositivo después de cada evaluación y de cada resolución. |

Mientras un dispositivo tenga una alerta sin resolver para un tipo de sensor, las nuevas mediciones que cumplan la misma regla no generan alertas adicionales.

#### Repository Abstractions

| Repositorio | Responsabilidad |
|---|---|
| `SafetyRuleRepository` | Guardar reglas, comprobar si una regla ya existe y recuperar las reglas de un tipo de sensor. |
| `AlertRepository` | Guardar alertas, recuperar las alertas de un conjunto de dispositivos y comprobar si un dispositivo tiene alertas sin resolver. |
| `DeviceStateRepository` | Guardar y recuperar el estado de cada dispositivo. |

#### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `AlertTriggeredEvent` | `Alert` | Representa la creación de una alerta a partir de una regla de seguridad. |
| `AlertAcknowledgedEvent` | `Alert` | Representa la confirmación de que una alerta está siendo atendida. |
| `AlertResolvedEvent` | `Alert` | Representa la resolución de una alerta. |

### 4.2.10.2. Interface Layer

La **Interface Layer** proporciona los puntos de entrada del contexto. Las consultas devuelven únicamente las alertas y los estados de los dispositivos visibles para el usuario autenticado, y la atención y resolución de alertas está reservada al Gallery Administrator de la galería.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `AlertsController` | Spring Boot | Consultar las alertas, confirmar su atención y registrar su resolución. |
| `DeviceStatesController` | Spring Boot | Consultar el estado de seguridad de un dispositivo. |
| `SafetyRulesController` | Spring Boot | Consultar las reglas de seguridad vigentes. |
| `SafetyContextFacade` | Spring Boot | Evaluar mediciones para Service Execution and Monitoring y entregar a Dashboard and Analytics el conteo de alertas por estado y por tipo de sensor. |
| Dashboard UI | Angular | Mostrar las alertas abiertas de la galería y permitir al Gallery Administrator atenderlas y resolverlas. |
| Dashboard UI | Flutter / Dart | Mostrar el resumen de alertas por estado y por tipo de sensor. |

| Método | Endpoint | Propósito |
|---|---|---|
| `GET` | `/api/v1/alerts` | Consultar las alertas de los dispositivos visibles, de la más reciente a la más antigua. |
| `GET` | `/api/v1/alerts/{alertId}` | Consultar una alerta. |
| `PATCH` | `/api/v1/alerts/{alertId}/acknowledge` | Confirmar la atención de una alerta activa. Responde `409 Conflict` si la alerta no está activa. |
| `PATCH` | `/api/v1/alerts/{alertId}/resolve` | Resolver una alerta en atención con una nota. Responde `409 Conflict` si la alerta no está en atención. |
| `GET` | `/api/v1/device-states` | Consultar el estado de un dispositivo con `deviceId`. |
| `GET` | `/api/v1/safety-rules` | Consultar las reglas de seguridad. |
| `GET` | `/api/v1/safety-rules/{safetyRuleId}` | Consultar una regla de seguridad. |

### 4.2.10.3. Application Layer

La **Application Layer** coordina la evaluación de mediciones, el ciclo de vida de las alertas y la comunicación con otros Bounded Contexts.

| Componente | Responsabilidad |
|---|---|
| `AlertCommandServiceImpl` | Evaluar cada medición, crear la alerta cuando una regla se cumple, notificar al Tenant, actualizar el estado del dispositivo y gestionar la atención y resolución de las alertas. |
| `SafetyRuleCommandServiceImpl` | Registrar las reglas estándar que aún no existen. |
| `AlertQueryServiceImpl` | Consultar alertas por identificador y por dispositivos. |
| `DeviceStateQueryServiceImpl` | Consultar el estado de un dispositivo. |
| `SafetyRuleQueryServiceImpl` | Consultar las reglas de seguridad. |
| `ApplicationReadyEventHandler` | Registrar las reglas estándar cuando la plataforma inicia. |
| `SafetyContextFacadeImpl` | Atender las evaluaciones solicitadas por Service Execution and Monitoring y los conteos de alertas solicitados por Dashboard and Analytics. |
| `ExternalAssetsService` | Obtener los dispositivos visibles para el usuario a partir de Property Communication y Resource and Asset Management. |
| `ExternalAlertNotificationService` | Ubicar el local de un dispositivo en Resource and Asset Management y Property Management, y notificar al Tenant de ese local a través de Property Communication. |

El flujo de evaluación de una medición es:

```text
Service Execution and Monitoring
   ↓  SafetyContextFacade.evaluate(...)
AlertCommandServiceImpl
   ├─ SafetyRuleRepository: reglas del tipo de sensor
   ├─ ¿Se cumple la regla y no hay una alerta abierta del mismo sensor?
   │     ├─ Sí: crear la alerta y notificar al Tenant del local
   │     └─ No: no se crea una alerta nueva
   └─ DeviceStateRepository: actualizar el estado del dispositivo
   ↓
Estado del dispositivo, respuesta y si se generó la alerta
```

Las notificaciones de intrusión, humo y temperatura se envían como alertas de emergencia, y las de humedad y consumo como incidentes. Cada una indica el local o el área común, la fecha y la hora en que se detectó la condición.

### 4.2.10.4. Infrastructure Layer

La **Infrastructure Layer** proporciona la persistencia del contexto y la evaluación de seguridad en el entorno Edge.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `SafetyRuleRepository` | Spring Data JPA | Persistir las reglas de seguridad. |
| `AlertRepository` | Spring Data JPA | Persistir las alertas y su ciclo de vida. |
| `DeviceStateRepository` | Spring Data JPA | Persistir el estado de cada dispositivo. |
| MySQL | MySQL | Almacenar reglas, alertas y estados de dispositivos. |
| Safety rules endpoint | Python, Flask | Consultar en `GET /api/v1/safety/rules` las reglas que la Edge API aplica localmente. |
| `SafetyEvaluationApplicationService` | Python | Evaluar cada medición recibida por la Edge API con las reglas locales y el horario de atención. |
| `SafetyRuleApplicationService` | Python | Actualizar las reglas locales desde la REST API y utilizar las reglas estándar cuando no hay conexión. |
| `SafetyRuleRepository` (Edge) | Python, Peewee, SQLite | Guardar la copia local de las reglas de seguridad. |
| `BackendSafetyRuleClient` | Python, HTTP | Obtener las reglas de seguridad desde la REST API. |

La Edge API evalúa cada medición en cuanto la recibe y devuelve al nodo el estado y la respuesta correspondientes, de modo que el nodo puede activar su alarma de inmediato. La REST API vuelve a evaluar la medición al sincronizarse y registra la alerta oficial, que es la que se notifica y se atiende desde la plataforma.

### 4.2.10.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas representan la distribución de los componentes del contexto dentro de las aplicaciones Web, Móvil, REST API y Edge API.

#### Web Application

La aplicación web muestra en el dashboard las alertas abiertas de la galería y, en el centro de alertas, permite al Gallery Administrator confirmar su atención y registrar su resolución.

![StorePulse - Safety and Emergencies - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/01-safety-web-component.puml&fmt=svg&v=1)

#### Mobile Application

La aplicación móvil muestra el resumen de alertas por estado y por tipo de sensor que entrega Dashboard and Analytics a partir de este contexto.

![StorePulse - Safety and Emergencies - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/02-safety-mobile-component.puml&fmt=svg&v=1)

#### REST API

La REST API concentra los controladores, los servicios de comandos y consultas, el dominio, los repositorios y los servicios que se comunican con otros Bounded Contexts.

![StorePulse - Safety and Emergencies - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/03-safety-rest-api-component.puml&fmt=svg&v=1)

#### Edge API

La Edge API mantiene una copia local de las reglas de seguridad y evalúa cada medición para responder al nodo sin depender de la conexión.

![StorePulse - Safety and Emergencies - Edge Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/04-safety-edge-component.puml&fmt=svg&v=1)

### 4.2.10.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura del dominio y el modelo de persistencia correspondiente al contexto.

#### 4.2.10.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases representa los agregados `SafetyRule`, `Alert` y `DeviceState`, los objetos de valor, las enumeraciones, los repositorios y los eventos de dominio.

Las relaciones permiten observar cómo una regla evalúa las mediciones mediante su umbral y el horario de atención, cómo una regla puede originar alertas y cómo las alertas determinan el estado de cada dispositivo.

![StorePulse - Safety and Emergencies - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/05-safety-domain-class.puml&fmt=svg&v=1)

#### 4.2.10.6.2. Bounded Context Database Design Diagram

El modelo de datos representa las estructuras necesarias para persistir la información del contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `safety_rules` | Almacenar las reglas de seguridad con su umbral, estado y respuesta. | Una regla puede originar múltiples alertas. |
| `alerts` | Almacenar las alertas, la medición que las originó y las fechas de su ciclo de vida. | Cada alerta pertenece a una regla y a un dispositivo. |
| `device_states` | Almacenar el estado actual y la respuesta de cada dispositivo. | Existe un estado por dispositivo. |

Las principales relaciones representadas en el modelo son:

- `safety_rules` → `alerts`

![StorePulse - Safety and Emergencies - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/safety-and-emergencies/06-safety-database.puml&fmt=svg&v=1)
