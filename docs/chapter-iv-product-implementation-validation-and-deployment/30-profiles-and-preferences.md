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

