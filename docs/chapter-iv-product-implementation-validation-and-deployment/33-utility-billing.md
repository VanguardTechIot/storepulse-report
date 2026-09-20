## 4.2.9. Bounded Context: Utility Billing

El **Bounded Context de Utility Billing** se encarga de gestionar la facturación de los servicios de agua y electricidad asociados a los locales comerciales. Su responsabilidad comprende la generación de la factura a partir de información de consumo verificable, el registro del desglose utilizado para sustentar el cobro y la gestión de los reclamos presentados por los inquilinos.

El contexto mantiene su propio modelo de facturación y no administra las mediciones IoT como fuente de verdad. **Dashboard and Analytics** proporciona el resumen de consumo y la línea base que Utility Billing utiliza como insumo para generar y verificar la facturación. De esta manera, el contexto conserva la responsabilidad sobre la factura y los reclamos, mientras que el consumo calculado permanece bajo la responsabilidad de Dashboard and Analytics.

Cuando una factura es emitida, Utility Billing publica el evento `UtilityBillIssued`, que es consumido por **Management-Tenant Communication** para notificar al Tenant correspondiente. Del mismo modo, los eventos `BillingDisputeRaised` y `BillingDisputeResolved` permiten comunicar el ciclo de atención de los reclamos sin trasladar la lógica de facturación al contexto de comunicación.

### 4.2.9.1. Domain Layer

La **Domain Layer** contiene las reglas de negocio relacionadas con la generación, verificación y emisión de facturas, además del ciclo de vida de los reclamos de facturación.

#### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `UtilityBill` | Aggregate Root | Representa la factura de servicios de un local para un periodo determinado. Mantiene el estado de la factura, el monto total y el desglose de consumo utilizado para sustentar el cobro. |
| `BillingItem` | Entity | Representa un concepto del desglose de una factura, asociado a un tipo de servicio y a su consumo correspondiente. |
| `BillingDispute` | Aggregate Root | Representa un reclamo presentado por un Tenant sobre una factura. Controla su registro, revisión y resolución. |
| `UtilityBillId` | Value Object | Encapsula el identificador único de una factura. |
| `BillingDisputeId` | Value Object | Encapsula el identificador único de un reclamo. |
| `BillingPeriod` | Value Object | Representa el periodo de facturación mediante una fecha de inicio y una fecha de fin. |
| `ConsumptionSummary` | Value Object | Representa la información de consumo recibida desde Dashboard and Analytics para sustentar la facturación. |
| `BaselineConsumption` | Value Object | Representa la línea base de consumo utilizada como referencia durante la revisión de la información de facturación. |

#### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `UtilityType` | `WATER`, `ELECTRICITY` | Identifica el servicio al que corresponde cada elemento del desglose. |
| `UtilityBillStatus` | `DRAFT`, `DATA_VERIFIED`, `ISSUED`, `IN_DISPUTE`, `RESOLVED` | Controla el ciclo de vida de una factura desde su generación hasta la resolución de un reclamo. |
| `BillingDisputeStatus` | `OPEN`, `UNDER_REVIEW`, `RESOLVED` | Controla el estado de atención de un reclamo de facturación. |

#### Commands

| Command | Actor u origen | Propósito |
|---|---|---|
| `GenerateUtilityBillCommand` | Gallery Administrator | Generar la información de facturación para un local y periodo utilizando el consumo disponible. |
| `VerifyBillingDataCommand` | Gallery Administrator | Confirmar que la información de consumo utilizada para la factura es suficiente y verificable. |
| `IssueUtilityBillCommand` | Gallery Administrator | Emitir la factura y publicar `UtilityBillIssued`. |
| `RaiseBillingDisputeCommand` | Tenant | Registrar un reclamo asociado a una factura existente. |
| `ReviewBillingDisputeCommand` | Gallery Administrator | Revisar un reclamo utilizando el desglose de consumo y la información disponible. |
| `ResolveBillingDisputeCommand` | Gallery Administrator | Registrar la resolución de un reclamo y cerrar su ciclo de atención. |

#### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `UtilityBill` | Generar factura, verificar datos, emitir factura, marcar información incompleta y asociar los conceptos del desglose. |
| `BillingItem` | Registrar el tipo de servicio, consumo utilizado y monto correspondiente dentro de una factura. |
| `BillingDispute` | Registrar reclamo, pasar a revisión y registrar su resolución. |

La generación de la factura requiere que exista información de consumo para el periodo. Cuando las mediciones disponibles son incompletas, el sistema debe advertir esta condición antes de confirmar la facturación, de acuerdo con los escenarios definidos para la generación de información de facturación.

#### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `IUtilityBillRepository` | Guardar facturas y consultarlas por identificador, local y periodo. |
| `IBillingDisputeRepository` | Guardar reclamos y consultarlos por factura, identificador y estado activo. |

#### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `UtilityBillGeneratedEvent` | `UtilityBill` | Representa la generación de una factura a partir de la información de consumo disponible. |
| `UtilityBillIssuedEvent` | `UtilityBill` | Representa la emisión de la factura y permite que Management-Tenant Communication notifique al Tenant correspondiente. |
| `BillingDisputeRaisedEvent` | `BillingDispute` | Representa el registro de un reclamo presentado por un Tenant. |
| `BillingDisputeResolvedEvent` | `BillingDispute` | Representa la resolución de un reclamo de facturación. |

### 4.2.9.2. Interface Layer

La **Interface Layer** expone las capacidades de Utility Billing hacia la Web Application y la Mobile Application mediante la **REST API**, utilizando HTTPS y JSON.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `UtilityBillsController` | ASP.NET Core | Expone las operaciones para generar, emitir y consultar facturas. |
| `BillingBreakdownController` | ASP.NET Core | Expone la consulta del desglose de consumo utilizado para calcular una factura. |
| `BillingDisputesController` | ASP.NET Core | Expone las operaciones para registrar, consultar y resolver reclamos de facturación. |
| Utility Billing UI | Angular | Permite al Gallery Administrator generar facturas, revisar información de consumo y atender reclamos. |
| Utility Billing UI | Flutter / Dart | Permite al Tenant consultar sus facturas, revisar el desglose y presentar reclamos. |

La interfaz recibe las solicitudes externas y las dirige hacia la Application Layer. Las reglas de generación y validación de facturas permanecen en el dominio.

### 4.2.9.3. Application Layer

La **Application Layer** coordina los casos de uso de facturación, resuelve las consultas y gestiona la integración con Dashboard and Analytics y Management-Tenant Communication.

| Componente | Responsabilidad |
|---|---|
| `Command Handlers` | Coordinar la generación, verificación y emisión de facturas, además del registro, revisión y resolución de reclamos. |
| `Query Handlers` | Procesar consultas de facturas, desglose de consumo e historial de reclamos. |
| `Event Handlers` | Procesar la información proveniente de otros contextos y gestionar la publicación de eventos de integración de facturación. |
| `Analytics Facade` | Adaptar el resumen de consumo y la línea base de Dashboard and Analytics al modelo requerido por Utility Billing. |
| `Utility Billing Domain` | Ejecutar las reglas y operaciones definidas en el dominio. |
| `Repository Implementations` | Persistir los cambios mediante las abstracciones de repositorio. |

El flujo general es:

```text
Aplicación Web / Aplicación Móvil
              ↓
      REST API Controllers
              ↓
   Command / Query Handlers
              ↓
       Utility Billing Domain
              ↓
  Repository Implementations
              ↓
        MySQL Database

Dashboard and Analytics
              ↓
      Analytics Facade
              ↓
       Utility Billing Domain
              ↓
     UtilityBillIssued
              ↓
Management-Tenant Communication
```

### 4.2.9.4. Infrastructure Layer

La **Infrastructure Layer** proporciona las implementaciones técnicas necesarias para persistir la información y comunicarse con otros Bounded Contexts.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `Repository Implementations` | ASP.NET Core / Entity Framework Core | Implementar las interfaces de repositorio del dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestionar el acceso de Utility Billing a la base de datos. |
| MySQL | MySQL | Persistir facturas, conceptos de facturación y reclamos. |
| `Analytics Facade` | ASP.NET Core / HTTPS-JSON | Consumir y adaptar la información de consumo y línea base proporcionada por Dashboard and Analytics. |
| `Integration Event Publisher` | Integration Events | Publicar `UtilityBillIssued`, `BillingDisputeRaised` y `BillingDisputeResolved` para los contextos consumidores. |

La integración con Dashboard and Analytics mantiene la separación de responsabilidades: Analytics conserva la autoridad sobre el consumo calculado y Utility Billing utiliza ese resultado como insumo para la facturación.

### 4.2.9.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas muestran cómo se distribuyen los componentes de Utility Billing dentro de los contenedores de StorePulse.

#### Web Application

La aplicación web, desarrollada con Angular, contiene la interfaz que permite al Gallery Administrator generar y revisar facturas, consultar información de consumo y gestionar reclamos de facturación.

![StorePulse - Utility Billing - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/utility-billing/01-utility-billing-web-component.puml&fmt=svg&v=4)

#### Mobile Application

La aplicación móvil, desarrollada con Flutter y Dart, contiene la interfaz que permite al Tenant consultar sus facturas, revisar el desglose de consumo y presentar reclamos.

![StorePulse - Utility Billing - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/utility-billing/02-utility-billing-mobile-component.puml&fmt=svg&v=4)

#### REST API

La REST API, desarrollada con ASP.NET Core, concentra los controladores, manejadores de comandos y consultas, eventos de integración, dominio, repositorios y la fachada que adapta la información de Dashboard and Analytics.

![StorePulse - Utility Billing - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/utility-billing/03-utility-billing-rest-api-component.puml&fmt=svg&v=4)

### 4.2.9.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura interna del dominio y el modelo de persistencia asociado al contexto.

#### 4.2.9.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases presenta los agregados raíz `UtilityBill` y `BillingDispute`, la entidad `BillingItem`, los objetos de valor del contexto, las enumeraciones, las abstracciones de repositorio y los eventos de dominio. `UtilityBill` mantiene el desglose de la facturación dentro de su frontera transaccional, mientras que `BillingDispute` referencia la factura mediante `UtilityBillId` sin incorporar las entidades internas del agregado de facturación.

![StorePulse - Utility Billing - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/utility-billing/04-utility-billing-domain-class.puml&fmt=svg&v=4)

#### 4.2.9.6.2. Bounded Context Database Design Diagram

El modelo de datos representa la persistencia de las facturas, sus conceptos de facturación y los reclamos asociados.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `utility_bills` | Almacenar la factura de servicios de un local, su periodo, estado y monto total. | `unit_id` es una referencia al local administrado por Property Management, sin FK física entre contextos. |
| `billing_items` | Almacenar el desglose de agua y electricidad utilizado para sustentar la factura. | Relación uno a muchos con `utility_bills` mediante FK física. |
| `billing_disputes` | Almacenar los reclamos presentados sobre una factura y su estado de atención. | Relación uno a muchos con `utility_bills` mediante FK física; `tenant_id` es una referencia externa sin FK física. |

![StorePulse - Utility Billing - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/utility-billing/05-utility-billing-database.puml&fmt=svg&v=4)
