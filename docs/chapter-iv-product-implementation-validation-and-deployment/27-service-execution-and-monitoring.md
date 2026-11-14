## 4.2.3. Bounded Context: Service Execution and Monitoring

El **Bounded Context de Service Execution and Monitoring** se encarga de recibir y registrar la información operativa que generan los dispositivos IoT de StorePulse. Su responsabilidad principal es registrar la telemetría y sus mediciones, acumular el consumo de agua y energía de cada recurso por periodo y ofrecer el estado más reciente de los sensores de cada local o área común.

Este contexto mantiene una separación clara respecto a **Resource and Asset Management** y a **Safety and Emergencies**. Resource and Asset Management administra los recursos, activos y dispositivos; Service Execution and Monitoring registra la información que esos dispositivos producen; y Safety and Emergencies evalúa cada medición contra las reglas de seguridad y administra las alertas. Cada telemetría registrada se entrega a Safety and Emergencies, y el resultado de esa evaluación se devuelve junto con la telemetría.

### 4.2.3.1. Domain Layer

La **Domain Layer** contiene las reglas de negocio relacionadas con la telemetría, las mediciones y el consumo.

#### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `Telemetry` | Aggregate Root | Representa un envío de un dispositivo IoT. Registra el dispositivo, la fecha de recepción y una o más mediciones, y publica los eventos de dominio de cada medición. |
| `Measurement` | Entity | Representa una medición individual de la telemetría, con su tipo, su valor y la fecha en que se tomó. |
| `Consumption` | Aggregate Root | Representa el consumo acumulado de un recurso para un tipo de servicio (`ELECTRICITY` o `WATER`) durante un periodo mensual. Cada lectura de consumo se suma al total del periodo. |
| `MeasurementValue` | Value Object | Encapsula el valor numérico de una medición y rechaza valores no numéricos o infinitos. |
| `SensorStatus` | Value Object | Representa la lectura más reciente de un tipo de sensor: tipo, valor y fecha. |
| `MeasurementEvaluation` | Value Object | Representa el resultado que Safety and Emergencies devuelve para una medición: estado del dispositivo, respuesta y si se generó una alerta. |
| `TelemetryRegistration` | Value Object | Agrupa la telemetría registrada con las evaluaciones de cada una de sus mediciones. |

#### Tipos de medición

| `MeasurementType` | Unidad | Descripción |
|---|---|---|
| `TEMPERATURE` | °C | Temperatura del local o del área común. |
| `HUMIDITY` | % | Humedad relativa. |
| `ELECTRICITY` | kWh | Energía consumida desde la lectura anterior. Se acumula en el consumo del periodo. |
| `WATER` | m³ | Agua consumida desde la lectura anterior. Se acumula en el consumo del periodo. |
| `MOTION` | — | Detección de movimiento: `1` cuando el sensor detecta actividad y `0` cuando no la detecta. |
| `SMOKE` | ppm | Concentración de humo registrada por el sensor. |

#### Commands

| Command | Origen | Propósito |
|---|---|---|
| `RegisterTelemetryCommand` | Edge API | Registrar la telemetría de un dispositivo con sus mediciones y, de forma opcional, el voltaje de alimentación y los eventos retenidos del nodo. |
| `RegisterMeasurementCommand` | Edge API | Representar cada medición incluida en la telemetría. |

#### Queries

| Query | Propósito |
|---|---|
| `GetTelemetryByIdQuery` | Obtener una telemetría con sus mediciones. |
| `GetTelemetryByDeviceIdsQuery` | Obtener la telemetría de los dispositivos visibles para el usuario. |
| `GetConsumptionByResourceIdQuery` | Obtener el consumo por periodo de un recurso. |
| `GetConsumptionByResourceIdsQuery` | Obtener el consumo por periodo de los recursos visibles para el usuario. |
| `GetSensorStatusByDeviceIdQuery` | Obtener la última lectura de cada sensor de un dispositivo. |
| `GetSensorStatusByDeviceIdsQuery` | Obtener la última lectura de cada sensor de todos los dispositivos de un recurso. |

#### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `Telemetry` | Agregar mediciones y publicar el evento correspondiente a cada tipo de medición. |
| `Measurement` | Registrar el tipo, el valor y la fecha de la medición. |
| `Consumption` | Identificar el periodo mensual de una lectura y sumar cada lectura al total del periodo. |
| `MeasurementType` | Indicar la unidad de cada tipo y si corresponde a un servicio de consumo. |

Solo se registra telemetría de dispositivos existentes y activos. Cuando la telemetría se registra, el dispositivo pasa a estado conectado en Resource and Asset Management junto con su último reporte, su voltaje de alimentación y sus eventos retenidos.

#### Repository Abstractions

| Repositorio | Responsabilidad |
|---|---|
| `TelemetryRepository` | Guardar telemetría y recuperarla con sus mediciones por identificador o por dispositivo, de la más reciente a la más antigua. |
| `ConsumptionRepository` | Guardar el consumo por periodo y recuperarlo por recurso, por tipo de servicio y por inicio del periodo. |

#### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `TelemetryReceivedEvent` | `Telemetry` | Representa la recepción de nueva telemetría de un dispositivo. |
| `MeasurementRecordedEvent` | `Telemetry` | Representa el registro de una medición de cualquier tipo. |
| `MotionDetectedEvent` | `Telemetry` | Representa una medición de movimiento recibida desde un nodo. |
| `SmokeDetectedEvent` | `Telemetry` | Representa una medición de humo recibida desde un nodo, con su concentración. |
| `UtilityConsumptionRecordedEvent` | `Telemetry` | Representa una lectura de consumo de agua o energía. |

### 4.2.3.2. Interface Layer

La **Interface Layer** proporciona los puntos de entrada mediante los cuales las aplicaciones y la Edge API interactúan con el contexto. La comunicación con la REST API utiliza HTTPS y JSON, y todas las consultas devuelven únicamente la información de los recursos y dispositivos visibles para el usuario autenticado: los de su galería para el Gallery Administrator y los de su local para el Tenant.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `TelemetryController` | Spring Boot | Recibir la telemetría enviada por la Edge API y consultar la telemetría registrada. |
| `ConsumptionController` | Spring Boot | Consultar el consumo por periodo de los recursos. |
| `SensorStatusController` | Spring Boot | Consultar la última lectura de cada sensor de un dispositivo o de un recurso. |
| `MonitoredResourcesController` | Spring Boot | Consultar los recursos visibles para el usuario con los dispositivos instalados en cada uno. |
| `MonitoringContextFacade` | Spring Boot | Exponer a otros Bounded Contexts el consumo mensual de los recursos. |
| Monitoring UI | Angular | Mostrar el estado de los sensores de cada ubicación y el consumo por periodo con su línea base. |
| Monitoring UI | Flutter / Dart | Mostrar al usuario el consumo del periodo, el estado de los sensores y el historial de consumo de su local. |

| Método | Endpoint | Propósito |
|---|---|---|
| `POST` | `/api/v1/telemetry` | Registrar la telemetría de un dispositivo. Responde con la telemetría registrada y la evaluación de cada medición. |
| `GET` | `/api/v1/telemetry` | Consultar la telemetría de los dispositivos visibles, opcionalmente de un dispositivo con `deviceId`. |
| `GET` | `/api/v1/telemetry/{telemetryId}` | Consultar una telemetría con sus mediciones. |
| `GET` | `/api/v1/consumption` | Consultar el consumo por periodo de los recursos visibles, opcionalmente de un recurso con `resourceId`. |
| `GET` | `/api/v1/sensors/status` | Consultar la última lectura de cada sensor de un dispositivo (`deviceId`) o de todos los dispositivos de un recurso (`resourceId`). |
| `GET` | `/api/v1/monitored-resources` | Consultar los recursos visibles para el usuario y los dispositivos de cada uno. |

### 4.2.3.3. Application Layer

La **Application Layer** coordina los casos de uso del contexto y conecta los controladores con el dominio y con los demás Bounded Contexts.

| Componente | Responsabilidad |
|---|---|
| `TelemetryCommandServiceImpl` | Registrar la telemetría de un dispositivo activo, informar el reporte del dispositivo, acumular el consumo del periodo y solicitar la evaluación de cada medición. |
| `TelemetryQueryServiceImpl` | Consultar telemetría por identificador y por dispositivos. |
| `ConsumptionQueryServiceImpl` | Consultar el consumo por periodo de uno o varios recursos. |
| `SensorStatusQueryServiceImpl` | Obtener la lectura más reciente de cada tipo de sensor de uno o varios dispositivos. |
| `MonitoringContextFacadeImpl` | Calcular el consumo mensual de los recursos para otros Bounded Contexts. |
| `ExternalResourceAssetService` | Consultar en Resource and Asset Management si un dispositivo está activo, el recurso donde está instalado y los dispositivos de cada recurso, y registrar cada reporte del dispositivo. |
| `ExternalPropertyCommunicationService` | Consultar en Property Communication los recursos visibles para el usuario autenticado. |
| `ExternalSafetyService` | Solicitar a Safety and Emergencies la evaluación de cada medición registrada. |

El flujo de registro de telemetría es:

```text
Edge API
   ↓  POST /api/v1/telemetry
TelemetryController
   ↓
TelemetryCommandServiceImpl
   ├─ Resource and Asset Management: dispositivo activo y reporte del dispositivo
   ├─ TelemetryRepository: guardar la telemetría y sus mediciones
   ├─ ConsumptionRepository: sumar las lecturas de agua y energía al periodo
   └─ Safety and Emergencies: evaluar cada medición
   ↓
Telemetría registrada con la evaluación de cada medición
```

### 4.2.3.4. Infrastructure Layer

La **Infrastructure Layer** proporciona la persistencia del contexto y la recepción de la información en el entorno Edge.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `TelemetryRepository` | Spring Data JPA | Persistir la telemetría y sus mediciones. |
| `ConsumptionRepository` | Spring Data JPA | Persistir el consumo por recurso, tipo de servicio y periodo. |
| MySQL | MySQL | Almacenar la telemetría, las mediciones y el consumo. |
| Telemetry endpoint | Python, Flask | Recibir la telemetría de los nodos en `POST /api/v1/monitoring/telemetry`, autenticados con su identificador y su API key. |
| `TelemetryApplicationService` | Python | Validar la telemetría, guardarla localmente, solicitar su evaluación y enviarla a la REST API. |
| `TelemetryRepository` (Edge) | Python, Peewee, SQLite | Guardar la telemetría localmente como pendiente hasta confirmar su sincronización. |
| `BackendTelemetryClient` | Python, HTTP | Enviar la telemetría a la REST API con su fecha original. |
| `SynchronizationScheduler` | Python | Reintentar periódicamente el envío de la telemetría pendiente. |

En el entorno Edge, cada nodo envía su telemetría a la Edge API. La Edge API autentica al nodo, guarda la telemetría en su base local, obtiene la respuesta de seguridad de cada medición y responde al nodo de inmediato. Cuando la REST API confirma la telemetría, la Edge API la marca como sincronizada; si no hay conexión, responde `202 Accepted`, la conserva como pendiente y la reenvía al recuperar la conexión. Cuando el almacenamiento local alcanza su capacidad máxima, se descarta primero la telemetría rutinaria más antigua para conservar los eventos de intrusión y de humo.

### 4.2.3.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas representan la distribución de los componentes del contexto dentro de las aplicaciones Web, Móvil, REST API y Edge API.

#### Web Application

La aplicación web contiene las vistas de estado de sensores y de consumo, que obtienen la información de la REST API mediante un store y sus endpoints.

![StorePulse - Service Execution and Monitoring - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/01-service-monitoring-web-component.puml&fmt=svg&v=5)

#### Mobile Application

La aplicación móvil contiene la pantalla de monitoreo del local, su view model y el repositorio que consume los servicios REST de recursos, consumo y estado de sensores.

![StorePulse - Service Execution and Monitoring - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/02-service-monitoring-mobile-component.puml&fmt=svg&v=5)

#### REST API

La REST API concentra los controladores, los servicios de comandos y consultas, el dominio, los repositorios y los servicios que se comunican con otros Bounded Contexts.

![StorePulse - Service Execution and Monitoring - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/03-service-monitoring-rest-api-component.puml&fmt=svg&v=5)

#### Edge API

La Edge API recibe la telemetría de los nodos, la guarda localmente, solicita su evaluación de seguridad y la sincroniza con la REST API.

![StorePulse - Service Execution and Monitoring - Edge Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/04-service-monitoring-edge-component.puml&fmt=svg&v=5)

### 4.2.3.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura del dominio y el modelo de persistencia correspondiente al contexto.

#### 4.2.3.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases representa los agregados `Telemetry` y `Consumption`, la entidad `Measurement`, los objetos de valor, la enumeración de tipos de medición, los repositorios y los eventos de dominio.

Las relaciones permiten observar cómo la telemetría contiene mediciones, cómo cada medición publica su evento de dominio y cómo las lecturas de agua y energía se acumulan en el consumo de cada periodo.

![StorePulse - Service Execution and Monitoring - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/05-service-monitoring-domain-class.puml&fmt=svg&v=5)

#### 4.2.3.6.2. Bounded Context Database Design Diagram

El modelo de datos representa las estructuras necesarias para persistir la información registrada por el contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `telemetry` | Almacenar cada envío recibido de un dispositivo. | Una telemetría contiene una o más mediciones. |
| `measurements` | Almacenar el tipo, el valor y la fecha de cada medición. | Cada medición pertenece a una telemetría. |
| `consumption` | Almacenar el consumo acumulado por recurso, tipo de servicio y periodo. | Se identifica por recurso, tipo de servicio e inicio del periodo. |

Las principales relaciones representadas en el modelo son:

- `telemetry` → `measurements`

![StorePulse - Service Execution and Monitoring - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/service-execution-monitoring/06-service-monitoring-database.puml&fmt=svg&v=5)
