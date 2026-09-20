# 4.2.8. Bounded Context: Property Management

El **Bounded Context de Property Management** se encarga de administrar la estructura inmobiliaria, la asignación de espacios y la relación contractual entre galerías y sus inquilinos dentro de la plataforma StorePulse. Su responsabilidad principal es mantener la información estructural de las propiedades, locales e inquilinos que sirven como base contextual para la gestión operativa y de facturación.

Este contexto actúa como la fuente central de verdad sobre la organización física y de arrendamiento. Las operaciones relativas a dispositivos IoT, telemetría y cobros transaccionales pertenecen a Resource and Asset Management, Service Execution and Monitoring y Utility Billing respectivamente, manteniendo una clara separación de responsabilidades.

## 4.2.8.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio sobre la gestión inmobiliaria. En el modelo representado se identifican agregados raíz, entidades, objetos de valor, enumeraciones, interfaces de repositorio y eventos de dominio.

### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `Gallery` | Aggregate Root | Representa una galería comercial administrada por StorePulse. Mantiene su nombre, dirección, total de locales y la relación con su administrador (`OwnerId`). |
| `Unit` | Aggregate Root | Representa un local individual dentro de una galería. Mantiene número de local, piso, superficie en $m^2$ y estado de ocupación. 
| `Tenant` | Entity | Representa la persona o entidad que alquila un local específico. Mantiene datos de contacto e identificación legal. |
| `LeaseAgreement` | Aggregate Root | Administra la relación contractual de alquiler entre un `Tenant` y una `Unit`, especificando vigencia y condiciones. |
| `GalleryId` | Value Object | Encapsula el identificador único de una galería. |
| `UnitId` | Value Object | Encapsula el identificador único de un local. |
| `TenantId` | Value Object | Encapsula el identificador único de un inquilino. |
| `Address` | Value Object | Encapsula la dirección física de la galería (calle, ciudad, código postal). |

### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `UnitStatus` | `VACANT`, `OCCUPIED`, `MAINTENANCE` | Controla la disponibilidad operativa de un local. |
| `LeaseStatus` | `DRAFT`, `ACTIVE`, `TERMINATED`, `EXPIRED` | Administra el estado del contrato de alquiler. |

### Commands

| Command | Actor u origen | Propósito |
|---|---|---|
| `RegisterCommercialGalleryCommand` | Gallery Administrator | Registrar una nueva galería o centro comercial en el sistema. |
| `UpdateCommercialGalleryInfoCommand` | Gallery Administrator | Modificar los datos generales de la galería. |
| `RegisterCommercialUnitCommand` | Gallery Administrator | Crear y asignar un nuevo local comercial dentro de una galería. |
| `AssignTenantToUnitCommand` | Gallery Administrator | Cambiar el estado del local a ocupado tras la firma o asignación de un contrato. |
| `VacateCommercialUnitCommand` | Gallery Administrator | Liberar un local comercial, pasando su estado a disponible. |
| `MarkUnitUnderMaintenanceCommand` | Gallery Administrator | Inhabilitar temporalmente un local comercial por mantenimiento o remodelación. |

### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `Gallery` | Registrar galería, actualizar datos generales y registrar nuevos locales comerciales. |
| `Unit` | Registrar local, cambiar estado de ocupación, asignar inquilino y marcar el local como disponible o en mantenimiento. |
| `LeaseAgreement` | Crear contrato de alquiler, activar contrato, actualizar condiciones, renovar plazo y finalizar arrendamiento. |

### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `IGalleryRepository` | Guardar, buscar por identificador y listar galerías. |
| `IUnitRepository` | Guardar y consultar locales pertenecientes a una galería. |
| `ILeaseAgreementRepository` | Guardar y consultar contratos de arrendamiento activos. |

### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `GalleryRegisteredEvent` | `Gallery` | Representa la creación de una nueva galería en la plataforma. |
| `UnitCreatedEvent` | `Gallery` | Indica la incorporación de un nuevo local a una galería. |
| `TenantAssignedToUnitEvent` | `LeaseAgreement` | Indica que un inquilino ha ocupado formalmente un local. |
| `LeaseTerminatedEvent` | `LeaseAgreement` | Representa la finalización de un contrato de arrendamiento. |

## 4.2.8.2. Interface Layer

La **Interface Layer** expone las capacidades del contexto hacia la Web Application y la Mobile Application mediante la **REST API**, utilizando HTTPS y JSON, y recibe los eventos publicados por otros Bounded Contexts a través de un consumidor.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `GalleryController` | ASP.NET Core | Expone las operaciones CRUD y de gestión de galerías. |
| `UnitController` | ASP.NET Core | Expone endpoints para consulta y mantenimiento de locales. |
| `LeaseController` | ASP.NET Core | Gestiona la asignación de inquilinos y contratos de arrendamiento. |
| Property Management UI | Angular | Permite al administrador gestionar galerías, locales e inquilinos. |
| Property Mobile UI | Flutter / Dart | Permite consultar información sobre locales y contratos desde la aplicación móvil. |

## 4.2.8.3. Application Layer

La **Application Layer** coordina los comandos emitidos por los actores, resuelve las consultas de los read models y reacciona a los eventos provenientes de otros contextos.

| Componente | Responsabilidad |
|---|---|
| `Command Handlers` | Coordinar la creación y actualización de galerías, locales y contratos de arrendamiento. |
| `Query Handlers` | Procesar consultas estructuradas sobre galerías, locales y estado de ocupación. |
| `Property Domain` | Ejecutar las reglas y validaciones de negocio relacionadas con la gestión inmobiliaria. |
| `Repository Implementations` | Persistir y recuperar las entidades del dominio mediante las interfaces de repositorio. |

El flujo general es:

```text
Aplicación Web / Aplicación Móvil
              ↓
      REST API Controllers
              ↓
   Command / Query Handlers
              ↓
        Property Domain
              ↓
  Repository Implementations
              ↓
        MySQL Database
```

## 4.2.8.4. Infrastructure Layer

La **Infrastructure Layer** proporciona las implementaciones técnicas necesarias para persistir la información y comunicarse con los servicios externos y con los demás Bounded Contexts.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `Repository Implementations` | ASP.NET Core / EF Core | Implementar las abstracciones de repositorio definidas por el dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestionar el acceso y la interacción con la base de datos central. |
| MySQL | MySQL | Persistir galerías, locales, inquilinos y contratos de arrendamiento. |

## 4.2.8.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas muestran cómo se distribuyen los componentes del Bounded Context dentro de los contenedores de StorePulse.

### Web Application

La aplicación web, desarrollada con Angular, contiene la interfaz de gestión de galerías y unidades comerciales, junto con el servicio encargado de consumir los servicios REST correspondientes para la administración del espacio físico.

![StorePulse - Property Management - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/property-management/property-management-web-component.puml&fmt=svg&v=4)

### Mobile Application

La aplicación móvil, desarrollada con Flutter y Dart, contiene la interfaz de inspección y consulta de disponibilidad de locales comerciales, junto con el servicio encargado de consumir la API REST para administradores de campo.

![StorePulse - Property Managements - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/property-management/property-management-mobile-component.puml&fmt=svg&v=4)

### REST API

La REST API, desarrollada con ASP.NET Core, concentra los controladores de galerías y locales comerciales, manejadores de comandos y consultas, el modelo de dominio y la implementación de repositorios para la gestión inmobiliaria.

![StorePulse - Property Management - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/property-management/property-management-rest-api-component.puml&fmt=svg&v=4)

## 4.2.8.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código detallan la estructura interna del dominio y el modelo de persistencia asociado al contexto.

### 4.2.8.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases presenta los agregados raíz `CommercialGallery` y `CommercialUnit`, sus objetos de valor (`CommercialGalleryId`, `CommercialUnitId`, `AdministratorId`, `UnitDimensions`), las enumeraciones del contexto, los repositorios y los eventos de dominio. Ambos agregados se relacionan mediante el identificador de la galería, manteniendo la independencia de sus fronteras transaccionales.

![StorePulse - Profiles and Preferences - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/property-management/property-management-domain-class.puml&fmt=svg&v=4)

### 4.2.8.6.2. Bounded Context Database Design Diagram

El modelo de datos representa la persistencia de los principales elementos del contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `commercial_galleries` | Almacenar los datos generales de la galería comercial, su dirección y total de unidades. | `administrator_id` es una referencia externa a Identity and Access Management, sin FK física entre contextos. |
| `commercial_units` | Almacenar la información física, superficie en metros cuadrados, piso y estado operativo de cada local. | Relación uno a muchos con `commercial_galleries` mediante FK física (`gallery_id`). |

![StorePulse - Profiles and Preferences - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/property-management/property-management-database.puml&fmt=svg&v=4)