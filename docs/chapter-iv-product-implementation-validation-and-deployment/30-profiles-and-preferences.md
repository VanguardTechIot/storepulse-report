# 4.2.6. Bounded Context: Profiles and Preferences

El **Bounded Context de Profiles and Preferences** concentra la gestión del perfil de cada usuario de la plataforma y la configuración de las alertas que desea recibir. Administra los datos personales, la fotografía, el idioma preferido, los canales de entrega y los tipos de alerta habilitados, tanto para el Gallery Administrator como para el Tenant.

Este contexto no origina el perfil por decisión de un actor: reacciona al evento de registro publicado por **Identity and Access Management** para crearlo automáticamente con preferencias por defecto. A partir de ahí, los actores administran su propia información. La identidad y las credenciales pertenecen a Identity and Access Management; el enrutamiento efectivo de las alertas pertenece a **Safety and Emergencies**, que consume el evento de cambio de preferencias publicado por este contexto.

## 4.2.6.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio del contexto. Se identifican dos agregados raíz, una entidad interna, sus objetos de valor, enumeraciones, interfaces de repositorio y eventos de dominio.

### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `UserProfile` | Aggregate Root | Representa el perfil de un usuario de la plataforma. Es dueño de sus datos personales, su fotografía y su idioma preferido. Valida el formato y la unicidad del correo, y garantiza que el rol del usuario no pueda modificarse desde este contexto. |
| `NotificationPreferences` | Aggregate Root | Representa la configuración de alertas de un usuario. Es dueña de la colección de canales y del conjunto de tipos de alerta habilitados. Garantiza que siempre permanezca al menos un canal activo capaz de recibir alertas críticas. |
| `NotificationChannel` | Entity | Representa un medio de entrega configurado por el usuario. Controla su estado de habilitación e indica si transporta alertas de emergencia. No puede desactivarse si es el último canal activo. |
| `UserProfileId` | Value Object | Encapsula el identificador de un perfil de usuario. |
| `NotificationPreferencesId` | Value Object | Encapsula el identificador de una configuración de preferencias. |
| `ChannelId` | Value Object | Encapsula el identificador de un canal de notificación. |
| `UserId` | Value Object | Referencia externa al usuario, proveniente de Identity and Access Management. |
| `FullName` | Value Object | Encapsula nombre y apellidos del usuario, validando su longitud. |
| `EmailAddress` | Value Object | Encapsula el correo de contacto y valida su formato. |
| `PhoneNumber` | Value Object | Encapsula el teléfono de contacto y valida su formato. |
| `ProfilePhoto` | Value Object | Encapsula la URL de la imagen almacenada junto con su formato y tamaño. Es inmutable tras su creación. |

### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `LanguageCode` | `EN_US`, `ES_419` | Identifica el idioma de la interfaz y las notificaciones del usuario. El valor por defecto es `EN_US`, conforme a la política de internacionalización de la solución. |
| `ChannelType` | `PUSH`, `EMAIL` | Identifica el medio por el cual se entrega una notificación. |
| `AlertCategory` | `EMERGENCY`, `INFORMATIONAL` | Clasifica la alerta y determina si admite ser silenciada. |
| `AlertType` | `INTRUSION`, `SMOKE`, `CONSUMPTION_DEVIATION`, `DEVICE_FAILURE`, `BILLING` | Identifica el tipo de alerta al que el usuario puede suscribirse. |

### Commands

| Command | Actor u origen | Propósito |
|---|---|---|
| `CreateUserProfileCommand` | Policy desde Identity and Access Management | Crear el perfil de un usuario recién registrado con preferencias por defecto. |
| `UpdateProfileCommand` | Gallery Administrator / Tenant | Actualizar los datos personales del perfil. |
| `UploadProfilePhotoCommand` | Gallery Administrator / Tenant | Cargar una nueva fotografía de perfil. |
| `ChangePreferredLanguageCommand` | Gallery Administrator / Tenant | Cambiar el idioma preferido. |
| `SetNotificationPreferencesCommand` | Gallery Administrator / Tenant | Definir los tipos de alerta habilitados. |
| `DisableNotificationChannelCommand` | Gallery Administrator / Tenant | Desactivar un canal de notificación. |

### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `UserProfile` | Crearse automáticamente al registrarse el usuario, con idioma inglés por defecto; actualizar los datos personales validando formato y unicidad del correo; vincular la fotografía una vez almacenada en el servicio externo; cambiar el idioma solo si pertenece al conjunto soportado. |
| `NotificationPreferences` | Definir los tipos de alerta habilitados conservando siempre las alertas de emergencia; desactivar un canal solo si no es el último activo ni transporta alertas críticas; publicar el evento que Safety and Emergencies consume para actualizar el enrutamiento. |

### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `IUserProfileRepository` | Guardar un perfil y recuperarlo por su identificador o por el del usuario; verificar la unicidad del correo. |
| `INotificationPreferencesRepository` | Guardar la configuración de preferencias y recuperarla por el identificador del perfil. |

### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `UserProfileCreatedEvent` | `UserProfile` | Representa la creación automática del perfil tras el registro del usuario. |
| `UserProfileUpdatedEvent` | `UserProfile` | Representa la modificación de los datos personales del perfil. |
| `ProfilePhotoUploadedEvent` | `UserProfile` | Representa la vinculación de una nueva fotografía al perfil. |
| `PreferredLanguageChangedEvent` | `UserProfile` | Representa el cambio de idioma preferido del usuario. |
| `NotificationPreferencesSetEvent` | `NotificationPreferences` | Representa la modificación de los tipos de alerta habilitados; Safety and Emergencies lo consume para actualizar el enrutamiento. |
| `NotificationChannelDisabledEvent` | `NotificationPreferences` | Representa la desactivación de un canal de notificación. |
| `UserRegisteredEvent` | Identity and Access Management | Evento entrante que dispara la creación automática del perfil. |

## 4.2.6.2. Interface Layer

La **Interface Layer** expone las capacidades del contexto hacia la Web Application y la Mobile Application mediante la **REST API**, utilizando HTTPS y JSON, y recibe los eventos publicados por otros Bounded Contexts a través de un consumidor.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `UserProfilesController` | ASP.NET Core | Expone la consulta y actualización del perfil, la carga de fotografía y el cambio de idioma. |
| `NotificationPreferencesController` | ASP.NET Core | Expone la consulta y configuración de preferencias y la desactivación de canales. |
| `UserRegisteredEventConsumer` | ASP.NET Core | Recibe el evento de registro publicado por Identity and Access Management. |
| `IProfilesAndPreferencesFacade` | ASP.NET Core | Anti-Corruption Layer que expone a otros contextos el idioma preferido del usuario y los canales habilitados para un tipo de alerta. |
| Profiles UI | Angular | Permite al Gallery Administrator y al Tenant administrar su perfil y sus preferencias desde el navegador. |
| Profiles UI | Flutter / Dart | Permite al Tenant administrar su perfil y sus preferencias desde la aplicación móvil. |

## 4.2.6.3. Application Layer

La **Application Layer** coordina los comandos emitidos por los actores, resuelve las consultas de los read models y reacciona a los eventos provenientes de otros contextos.

| Componente | Responsabilidad |
|---|---|
| `Command Handlers` | Orquestar la creación y actualización del perfil, la carga de la fotografía, el cambio de idioma, la configuración de preferencias y la desactivación de canales. |
| `Query Handlers` | Resolver las consultas de Profile Settings, Language Options y Notification Settings. |
| `Event Handlers` | Reaccionar al evento `UserRegisteredEvent` para crear el perfil con preferencias por defecto, y al evento `NotificationPreferencesSetEvent` para publicar la actualización del enrutamiento hacia Safety and Emergencies. |
| `Profiles and Preferences Domain` | Ejecutar las reglas y operaciones definidas en el dominio. |
| `Repository Implementations` | Persistir los cambios mediante las abstracciones de repositorio. |

El flujo general es:

```text
Gallery Administrator / Tenant          Identity and Access Management
              ↓                                        ↓
     REST API Controllers                     Event Consumer
              ↓                                        ↓
       Command Handlers  ←──────────────────  Event Handlers
              ↓
  Profiles and Preferences Domain
              ↓
   Repository Implementations
              ↓
        MySQL Database
              ↓
        Query Handlers
              ↓
      REST API Controllers
              ↓
Aplicación Web / Aplicación Móvil
```

## 4.2.6.4. Infrastructure Layer

La **Infrastructure Layer** proporciona las implementaciones técnicas necesarias para persistir la información y comunicarse con los servicios externos y con los demás Bounded Contexts.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `Repository Implementations` | ASP.NET Core / Entity Framework Core | Implementan las interfaces de repositorio del dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestiona el acceso de la aplicación a la base de datos. |
| MySQL | MySQL | Persiste perfiles, preferencias y canales de notificación. |
| `ImageStorageServiceAdapter` | HTTPS/JSON | Envía la fotografía al servicio externo de almacenamiento y recupera la URL generada. |
| Evento entrante desde Identity and Access Management | Integration Event | Recibe `UserRegisteredEvent` para disparar la creación automática del perfil. |
| Evento saliente hacia Safety and Emergencies | Integration Event | Publica `NotificationPreferencesSetEvent` para actualizar el enrutamiento de alertas. |

## 4.2.6.5. Bounded Context Software Architecture Component Level Diagrams

Los diagramas [research](../../assets/research)de componentes de este Bounded Context se elaboran con **Structurizr DSL** (`assets/architecture/profiles-and-preferences/profiles-and-preferences.dsl`), siguiendo la misma herramienta utilizada en los demás contextos. El archivo `.dsl` es el código fuente; las imágenes siguientes son la exportación de cada vista.

### Web Application

La aplicación web, desarrollada con Angular, contiene la interfaz de gestión de perfil y preferencias, junto con el servicio encargado de consumir los servicios REST correspondientes.

![StorePulse - Profiles and Preferences - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/profiles-and-preferences/01_Profiles_Web_Component.puml&fmt=svg&v=4)

### Mobile Application

La aplicación móvil, desarrollada con Flutter y Dart, contiene la interfaz de perfil y preferencias, junto con el servicio encargado de consumir la API REST y de acceder a la galería del dispositivo para la carga de la fotografía.

![StorePulse - Profiles and Preferences - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/profiles-and-preferences/02_Profiles_Mobile_Component.puml&fmt=svg&v=4)

### REST API

La REST API, desarrollada con ASP.NET Core, concentra los controladores, manejadores de comandos, consultas y eventos, dominio, repositorios, la fachada ACL y el adaptador hacia el servicio de almacenamiento de imágenes.

![StorePulse - Profiles and Preferences - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/profiles-and-preferences/03_Profiles_REST_API_Component.puml&fmt=svg&v=4)

## 4.2.6.6. Bounded Context Software Architecture Code Level Diagrams

Los diagramas de nivel de código se elaboran con **PlantUML**.

### 4.2.6.6.1. Bounded Context Domain Layer Class Diagrams

El diagrama de clases presenta los agregados raíz `UserProfile` y `NotificationPreferences`, la entidad `NotificationChannel`, sus objetos de valor, las enumeraciones del contexto, los repositorios, los eventos de dominio y la interfaz de Anti-Corruption Layer. Ambos agregados se relacionan a través del identificador del perfil, sin compartir referencias directas entre sus entidades internas.

![StorePulse - Profiles and Preferences - Domain Layer Class Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/profiles-and-preferences/04-profiles-domain-class.puml&fmt=svg&v=4)

### 4.2.6.6.2. Bounded Context Database Design Diagram

El modelo de datos representa la persistencia de los principales elementos del contexto.

| Tabla | Propósito | Relación principal |
|---|---|---|
| `user_profiles` | Almacenar los datos personales, la fotografía y el idioma preferido de cada usuario. | `user_id` es una referencia externa a Identity and Access Management, sin FK física entre contextos. |
| `notification_preferences` | Almacenar la configuración de alertas de cada perfil. | Relación uno a uno con `user_profiles` mediante FK física. |
| `notification_channels` | Almacenar los canales de entrega configurados por el usuario. | Relación uno a muchos con `notification_preferences` mediante FK física. |
| `preference_alert_types` | Almacenar los tipos de alerta habilitados por cada configuración. | Relación uno a muchos con `notification_preferences` mediante FK física. |

![StorePulse - Profiles and Preferences - Database Design](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/profiles-and-preferences/05-profiles-database.puml&fmt=svg&v=4)