## 4.2.2. Bounded Context: Resource and Asset Management

El **Bounded Context de Resource and Asset Management** se encarga de administrar los recursos, activos y dispositivos IoT que forman parte de la solución StorePulse. Su responsabilidad principal es mantener la información necesaria para identificar, organizar, asignar y controlar el estado de los elementos físicos y lógicos gestionados por la plataforma.

Este contexto delimita las responsabilidades relacionadas con la administración de recursos y activos. Las operaciones de recepción de telemetría, registro de mediciones, evaluación de umbrales y generación de alertas pertenecen al **Bounded Context de Service Execution and Monitoring**, evitando mezclar responsabilidades entre ambos contextos.

### 4.2.2.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio del contexto. En el modelo representado se identifican agregados raíz, entidades, objetos de valor, enumeraciones, interfaces de repositorio y eventos de dominio.

#### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `Resource` | Aggregate Root | Representa un recurso administrado por StorePulse. Mantiene su nombre, descripción, ubicación y estado, y permite activarlo, desactivarlo, actualizar su información y asociarle activos. |
| `Asset` | Aggregate Root | Representa un activo administrado dentro de un recurso. Mantiene su tipo, estado y referencia al recurso al que pertenece. |
| `IoTDevice` | Entity | Representa un dispositivo IoT asociado a un activo. Mantiene número de serie, fabricante, versión de firmware y estado. |
| `Sensor` | Entity | Representa un sensor asociado a un dispositivo IoT. Su tipo y unidad permiten identificar la variable que participa en la infraestructura IoT. |
| `Meter` | Entity | Representa un medidor asociado a un dispositivo IoT, incluyendo su tipo y unidad de medición. |
| `ResourceId` | Value Object | Encapsula el identificador de un recurso. |
| `AssetId` | Value Object | Encapsula el identificador de un activo. |
| `DeviceId` | Value Object | Encapsula el identificador de un dispositivo IoT. |
| `Location` | Value Object | Representa la ubicación de un recurso mediante dirección, piso y referencia. |

#### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `ResourceStatus` | `ACTIVE`, `INACTIVE`, `MAINTENANCE` | Controla el estado operativo de un recurso. |
| `AssetType` | `IOT_DEVICE` | Clasifica el tipo de activo administrado. |
| `AssetStatus` | `ACTIVE`, `INACTIVE`, `MAINTENANCE` | Controla el estado del activo. |
| `SensorType` | `HUMIDITY`, `TEMPERATURE`, `WATER`, `ELECTRICITY` | Identifica el tipo de variable asociada a un sensor. |
| `MeterType` | `WATER`, `ELECTRICITY` | Identifica el tipo de medición asociada a un medidor. |

#### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `Resource` | Activar, desactivar, actualizar información y asignar activos. |
| `Asset` | Activar, desactivar, cambiar estado y asignarse a un recurso. |
| `IoTDevice` | Activar, desactivar y actualizar la versión de firmware. |
| `Sensor` | Activar y desactivar el sensor. |
| `Meter` | Activar y desactivar el medidor. |

#### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `IResourceRepository` | Guardar, buscar por identificador y recuperar recursos. |
| `IAssetRepository` | Guardar, buscar por identificador y recuperar activos asociados a un recurso. |
| `IIoTDeviceRepository` | Guardar y recuperar dispositivos IoT. |

#### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `ResourceRegisteredEvent` | `Resource` | Representa el registro de un nuevo recurso. |
| `AssetRegisteredEvent` | `Asset` | Representa el registro de un nuevo activo. |
| `AssetAssignedToResourceEvent` | `Asset` | Representa la asignación de un activo a un recurso. |
| `IoTDeviceRegisteredEvent` | `IoTDevice` | Representa el registro de un dispositivo IoT. |

El modelo de relaciones se encuentra representado en el siguiente diagrama:

![StorePulse - Resource and Asset Management - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/05-resource-asset-domain-class.puml&fmt=svg&v=4)


### 4.2.2.2. Interface Layer

La **Interface Layer** expone los puntos de entrada mediante los cuales las aplicaciones interactúan con este Bounded Context. En StorePulse, la comunicación se realiza mediante la **REST API**, utilizando HTTPS y JSON.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `ResourceController` | ASP.NET Core | Expone las operaciones relacionadas con recursos. |
| `AssetController` | ASP.NET Core | Expone las operaciones relacionadas con activos. |
| `IoTDeviceController` | ASP.NET Core | Expone las operaciones relacionadas con dispositivos IoT. |
| Resource & Asset Management UI | Angular | Permite al administrador interactuar con la gestión de recursos, activos y dispositivos. |
| Resource & Asset UI | Flutter / Dart | Permite consultar información de recursos y activos desde la aplicación móvil. |

La interfaz no concentra las reglas de negocio. Su función es recibir las solicitudes externas y dirigirlas hacia los componentes de aplicación correspondientes.

### 4.2.2.3. Application Layer

La **Application Layer** coordina los casos de uso del contexto y actúa como intermediaria entre los controladores y el modelo de dominio.

| Componente | Responsabilidad |
|---|---|
| `Command Handlers` | Coordinar operaciones que modifican el estado de recursos, activos y dispositivos IoT. |
| `Query Handlers` | Procesar consultas relacionadas con recursos, activos y dispositivos IoT. |
| `Resource & Asset Domain` | Ejecutar las reglas y operaciones definidas en el dominio. |
| `Repository Implementations` | Persistir los cambios mediante las abstracciones de repositorio. |

El flujo general es:

```text
Aplicación Web / Aplicación Móvil
              ↓
      REST API Controllers
              ↓
   Command / Query Handlers
              ↓
    Resource & Asset Domain
              ↓
  Repository Implementations
              ↓
        MySQL Database
```

### 4.2.2.4. Infrastructure Layer

La **Infrastructure Layer** proporciona las implementaciones técnicas necesarias para persistir la información y comunicarse con la infraestructura IoT.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `Repository Implementations` | ASP.NET Core / Entity Framework Core | Implementar las interfaces de repositorio del dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestionar el acceso de la aplicación a la base de datos. |
| MySQL | MySQL | Persistir recursos, activos y dispositivos IoT. |
| `Device Gateway` | Python / Flask | Recibir comunicación proveniente de los dispositivos IoT. |
| `Device Configuration` | Python | Procesar información de configuración de dispositivos. |
| `Cloud Synchronization` | Python | Sincronizar información relacionada con dispositivos con la REST API central. |

La relación con la infraestructura IoT se organiza mediante la comunicación entre la **Embedded Application**, la **Edge API** y la **REST API** central.

### 4.2.2.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas muestran cómo se distribuyen los componentes del Bounded Context dentro de los contenedores de StorePulse.

#### Web Application

La aplicación web, desarrollada con Angular, contiene una interfaz de gestión y un servicio encargado de consumir los servicios REST correspondientes.

![StorePulse - Resource and Asset Management - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/01-resource-asset-web-component.puml&fmt=svg&v=4)
#### Mobile Application

La aplicación móvil, desarrollada con Flutter y Dart, contiene la interfaz de recursos y activos y el servicio encargado de consumir la API REST.

![StorePulse - Resource and Asset Management - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/02-resource-asset-mobile-component.puml&fmt=svg&v=4)

#### REST API

La REST API, desarrollada con ASP.NET Core, concentra los controladores, manejadores de comandos y consultas, dominio y repositorios del contexto.

![StorePulse - Resource and Asset Management - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/03-resource-asset-rest-api-component.puml&fmt=svg&v=4)
#### Edge API

La Edge API, desarrollada con Python y Flask, actúa como intermediaria entre la aplicación embebida y la plataforma central para las operaciones relacionadas con los dispositivos.

![StorePulse - Resource and Asset Management - Edge Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/04-resource-asset-edge-component.puml&fmt=svg&v=4)
### 4.2.2.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura interna del dominio y el modelo de persistencia asociado al contexto.

#### 4.2.2.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases presenta los agregados raíz `Resource` y `Asset`, las entidades `IoTDevice`, `Sensor` y `Meter`, los objetos de valor, las enumeraciones, los repositorios y los eventos de dominio. Las relaciones muestran cómo un recurso administra activos y cómo los activos y dispositivos se organizan dentro del modelo.

![StorePulse - Resource and Asset Management - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/05-resource-asset-domain-class.puml&fmt=svg&v=4)
#### 4.2.2.6.2. Bounded Context Database Design Diagram

El modelo de datos representa la persistencia de los principales elementos del contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `resources` | Almacenar información de los recursos. | Un recurso puede contener múltiples activos. |
| `assets` | Almacenar información de los activos. | Cada activo pertenece a un recurso y puede representar un dispositivo IoT. |
| `iot_devices` | Almacenar información de los dispositivos IoT. | Un dispositivo está asociado a un activo y puede contener sensores y medidores. |
| `sensors` | Almacenar sensores asociados a dispositivos. | Cada sensor pertenece a un dispositivo IoT. |
| `meters` | Almacenar medidores asociados a dispositivos. | Cada medidor pertenece a un dispositivo IoT. |

Las relaciones del modelo de datos son:

- `resources` → `assets`
- `assets` → `iot_devices`
- `iot_devices` → `sensors`
- `iot_devices` → `meters`

![StorePulse - Resource and Asset Management - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/resource-asset-management/06-resource-asset-database.puml&fmt=svg&v=4)
