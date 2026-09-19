## 4.2.3. Bounded Context: Service Execution and Monitoring

El **Bounded Context de Service Execution and Monitoring** se encarga de procesar y monitorear la información operativa generada por la infraestructura IoT de StorePulse. Su responsabilidad principal es recibir telemetría, registrar mediciones, evaluar reglas de monitoreo, gestionar umbrales y administrar las alertas generadas a partir de las condiciones detectadas.

Este contexto mantiene una separación clara respecto a **Resource and Asset Management**. Mientras Resource and Asset Management administra los recursos, activos y dispositivos, Service Execution and Monitoring se concentra en la información que estos dispositivos producen y en las acciones derivadas de su monitoreo.

### 4.2.3.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio relacionadas con telemetría, mediciones, monitoreo, alertas y consumo.

#### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `Telemetry` | Aggregate Root | Representa la telemetría recibida desde un dispositivo IoT y agrupa una o más mediciones. |
| `Measurement` | Entity | Representa una medición individual, incluyendo tipo, valor, unidad y fecha de registro. |
| `MonitoringRule` | Aggregate Root | Define una condición de monitoreo que se evalúa sobre una medición. |
| `Alert` | Aggregate Root | Representa una condición detectada que requiere seguimiento y administra su ciclo de vida. |
| `Consumption` | Entity | Representa información acumulada de consumo asociada a un recurso y a un tipo de medición durante un periodo. |
| `TelemetryId` | Value Object | Identifica un registro de telemetría. |
| `MeasurementId` | Value Object | Identifica una medición. |
| `MeasurementValue` | Value Object | Encapsula el valor numérico de una medición. |
| `AlertId` | Value Object | Identifica una alerta. |
| `Threshold` | Value Object | Define el valor límite y el operador utilizado para evaluar una condición. |

#### Tipos de medición

| `MeasurementType` | Descripción |
|---|---|
| `TEMPERATURE` | Representa una medición de temperatura. |
| `HUMIDITY` | Representa una medición de humedad. |
| `WATER` | Representa una medición asociada al consumo o medición de agua. |
| `ELECTRICITY` | Representa una medición asociada al consumo o medición de electricidad. |

#### Reglas de monitoreo y umbrales

La entidad `MonitoringRule` utiliza un `Threshold` para evaluar una medición. El umbral está compuesto por un valor y un operador de comparación.

| Enumeración | Valores | Propósito |
|---|---|---|
| `ComparisonOperator` | `GREATER_THAN`, `GREATER_THAN_OR_EQUAL`, `LESS_THAN`, `LESS_THAN_OR_EQUAL`, `EQUAL` | Define cómo se compara el valor de una medición con el umbral. |
| `AlertStatus` | `ACTIVE`, `ACKNOWLEDGED`, `RESOLVED` | Representa el estado del ciclo de vida de una alerta. |

Las principales operaciones del dominio son:

| Elemento | Operaciones principales |
|---|---|
| `Telemetry` | Agregar mediciones y validar la telemetría. |
| `Measurement` | Validar una medición registrada. |
| `MonitoringRule` | Activar, desactivar y evaluar una medición frente a un umbral. |
| `Threshold` | Evaluar un valor utilizando el operador configurado. |
| `Alert` | Reconocer y resolver una alerta. |
| `Consumption` | Calcular el consumo correspondiente al periodo definido. |

#### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `ITelemetryRepository` | Guardar telemetría y recuperar telemetría asociada a un dispositivo. |
| `IMeasurementRepository` | Guardar mediciones y recuperarlas por dispositivo. |
| `IMonitoringRuleRepository` | Guardar reglas y recuperar las reglas activas. |
| `IAlertRepository` | Guardar alertas y recuperar las alertas activas. |

#### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `TelemetryReceivedEvent` | `Telemetry` | Representa la recepción de nueva telemetría. |
| `MeasurementRecordedEvent` | `Measurement` | Representa el registro de una nueva medición. |
| `ThresholdExceededEvent` | `MonitoringRule` | Representa la superación de una condición de umbral. |
| `AlertCreatedEvent` | `Alert` | Representa la creación de una alerta. |
| `AlertAcknowledgedEvent` | `Alert` | Representa el reconocimiento de una alerta. |
| `AlertResolvedEvent` | `Alert` | Representa la resolución de una alerta. |

El modelo completo de relaciones se representa en el siguiente diagrama:

![StorePulse - Service Execution and Monitoring - Domain Layer Class Diagram]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/05-service-monitoring-domain-class.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/05-service-monitoring-domain-class.puml\&fmt=svg\&v=4))

### 4.2.3.2. Interface Layer

La **Interface Layer** proporciona los puntos de entrada mediante los cuales las aplicaciones y la infraestructura Edge interactúan con el contexto.

La comunicación con la API REST utiliza HTTPS y JSON.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `TelemetryController` | ASP.NET Core | Recibir y consultar información de telemetría. |
| `MeasurementController` | ASP.NET Core | Gestionar el acceso a mediciones y consumo. |
| `MonitoringController` | ASP.NET Core | Gestionar reglas de monitoreo y umbrales. |
| `AlertController` | ASP.NET Core | Gestionar el ciclo de vida de las alertas. |
| Monitoring UI | Angular | Mostrar telemetría, mediciones, consumo y alertas. |
| Monitoring UI | Flutter / Dart | Mostrar información de monitoreo desde la aplicación móvil. |

### 4.2.3.3. Application Layer

La **Application Layer** coordina los casos de uso del contexto y conecta los controladores con el dominio.

| Componente | Responsabilidad |
|---|---|
| `TelemetryController` | Recibir y consultar telemetría. |
| `MeasurementController` | Gestionar consultas de mediciones y consumo. |
| `MonitoringController` | Gestionar reglas y umbrales de monitoreo. |
| `AlertController` | Gestionar las operaciones del ciclo de vida de las alertas. |
| `Command Handlers` | Coordinar operaciones que modifican el estado del dominio. |
| `Query Handlers` | Procesar consultas de monitoreo y datos operativos. |
| `Service Execution & Monitoring Domain` | Ejecutar las reglas y operaciones definidas en el dominio. |
| `Repository Implementations` | Persistir la información utilizando las abstracciones del dominio. |

El flujo general es:

```text
Aplicación Web / Aplicación Móvil
              ↓
      REST API Controllers
              ↓
   Command / Query Handlers
              ↓
Service Execution & Monitoring Domain
              ↓
  Repository Implementations
              ↓
        MySQL Database
```

### 4.2.3.4. Infrastructure Layer

La **Infrastructure Layer** proporciona la persistencia y la comunicación con la infraestructura IoT.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `Repository Implementations` | ASP.NET Core / Entity Framework Core | Implementar las interfaces de repositorio del dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestionar el acceso a la base de datos. |
| MySQL | MySQL | Persistir telemetría, mediciones, reglas, alertas y consumo. |
| `Telemetry Collector` | Python / Flask | Recibir telemetría proveniente de los dispositivos IoT. |
| `Local Monitoring Processor` | Python | Procesar y preparar las mediciones localmente. |
| `Cloud Synchronization` | Python | Enviar telemetría y mediciones a la REST API central. |

El flujo de infraestructura IoT se inicia en la **Embedded Application**, continúa hacia la **Telemetry Collector**, pasa por el **Local Monitoring Processor** y finalmente es sincronizado con la REST API mediante **Cloud Synchronization**.

### 4.2.3.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas representan la distribución de los componentes del contexto dentro de las aplicaciones Web, Móvil, REST API y Edge API.

#### Web Application

La aplicación web contiene una interfaz de monitoreo y un servicio que consume los endpoints correspondientes de la REST API.

![StorePulse - Service Execution and Monitoring - Web Components]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/01-service-monitoring-web-component.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/01-service-monitoring-web-component.puml\&fmt=svg\&v=4))

#### Mobile Application

La aplicación móvil contiene la interfaz de monitoreo y un servicio encargado de consumir los servicios REST relacionados con telemetría, mediciones y alertas.

![StorePulse - Service Execution and Monitoring - Mobile Components]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/02-service-monitoring-mobile-component.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/02-service-monitoring-mobile-component.puml\&fmt=svg\&v=4))

#### REST API

La REST API concentra los controladores, manejadores de comandos y consultas, dominio y repositorios del contexto de monitoreo.

![StorePulse - Service Execution and Monitoring - REST API Components]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/03-service-monitoring-rest-api-component.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/03-service-monitoring-rest-api-component.puml\&fmt=svg\&v=4))

#### Edge API

La Edge API recibe los datos provenientes de la aplicación embebida, realiza un procesamiento local y sincroniza la información con la REST API central.

![StorePulse - Service Execution and Monitoring - Edge Components]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/04-service-monitoring-edge-component.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/04-service-monitoring-edge-component.puml\&fmt=svg\&v=4))

### 4.2.3.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura del dominio y el modelo de persistencia correspondiente al contexto.

#### 4.2.3.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases representa los agregados `Telemetry`, `MonitoringRule` y `Alert`, junto con las entidades `Measurement` y `Consumption`, los objetos de valor, enumeraciones, repositorios y eventos de dominio.

Las relaciones permiten observar cómo la telemetría contiene mediciones, cómo las reglas evalúan las mediciones y cómo las condiciones detectadas pueden generar alertas.

![StorePulse - Service Execution and Monitoring - Domain Layer Class Diagram]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/05-service-monitoring-domain-class.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/05-service-monitoring-domain-class.puml\&fmt=svg\&v=4))

#### 4.2.3.6.2. Bounded Context Database Design Diagram

El modelo de datos representa las estructuras necesarias para persistir la información generada y procesada por el contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `telemetry` | Almacenar los registros de telemetría recibidos. | Una telemetría puede contener múltiples mediciones. |
| `measurements` | Almacenar valores medidos, tipo, unidad y momento de registro. | Cada medición pertenece a un registro de telemetría. |
| `monitoring_rules` | Almacenar las reglas y umbrales utilizados para evaluar mediciones. | Una regla puede generar múltiples alertas. |
| `alerts` | Almacenar las alertas generadas, su estado y fechas del ciclo de vida. | Una alerta se relaciona con una regla y una medición. |
| `consumption` | Almacenar información de consumo por recurso y periodo. | Representa el consumo calculado para un periodo determinado. |

Las principales relaciones representadas en el modelo son:

- `telemetry` → `measurements`
- `monitoring_rules` → `alerts`
- `measurements` → `alerts`

![StorePulse - Service Execution and Monitoring - Database Design]\([https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/06-service-monitoring-database.puml&fmt=svg&v=4](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/bounded-context/service-execution-monitoring/06-service-monitoring-database.puml\&fmt=svg\&v=4))
