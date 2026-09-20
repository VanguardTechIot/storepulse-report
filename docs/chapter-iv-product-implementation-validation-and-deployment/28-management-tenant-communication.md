# 4.2.4. Bounded Context: Management-Tenant Communication

## 4.2.4.1. Domain Layer

La capa de dominio representa el núcleo del Bounded Context Management-Tenant Communication. En esta capa se encapsulan las reglas de negocio relacionadas con la comunicación directa entre el Gallery Administrator y los Tenants, el registro de notificaciones y logs de comunicación, y la asignación de Tenants a Commercial Units. Este contexto reacciona a eventos externos —en particular `UtilityBillIssued` proveniente de Consumption and Billing— para notificar al Tenant correspondiente, y administra el ciclo de vida de cada conversación desde su inicio hasta su resolución.

La capa se mantiene independiente de frameworks, mecanismos de persistencia y servicios externos. Se compone de Aggregate Roots, Entities, Value Objects, Commands, Queries y Domain Events.

### Aggregates & Entities

| Nombre de Clase | Categoría | Propósito y Reglas de Negocio |
|---|---|---|
| `Conversation` | Aggregate Root | Representa una conversación entre un Tenant y un Gallery Administrator. Es dueña de la colección de mensajes y controla el ciclo de vida del estado (`Open`, `Resolved`). Garantiza que no se puedan enviar mensajes a conversaciones resueltas y registra la fecha de resolución. |
| `Message` | Entity | Representa un mensaje individual dentro de una conversación, con contenido textual y adjuntos de soporte. Se asegura de que el contenido no supere los 2000 caracteres y que el remitente sea un participante válido. |
| `Attachment` | Entity | Representa un documento de soporte adjunto a un mensaje (facturas, comprobantes, fotos). Almacena nombre de archivo, URL, tipo MIME y tamaño. Es inmutable tras su creación. |
| `TenantNotification` | Aggregate Root | Representa una notificación emitida hacia un Tenant, generada como reacción a eventos externos (por ejemplo, `UtilityBillIssued`) o a acciones internas del contexto. Controla su ciclo de vida (`Pending`, `Sent`, `Failed`) y registra el canal de entrega (`InApp`, `Email`, `Push`). |
| `CommunicationLog` | Aggregate Root | Representa el registro histórico de una comunicación emitida hacia un Tenant, con fines de trazabilidad y auditoría. Se genera como consecuencia del evento `TenantNotified`. Almacena la referencia al recurso origen (notificación o conversación). |
| `TenantAssignment` | Aggregate Root | Representa la asignación de un Tenant a una Commercial Unit. Garantiza que una unidad no tenga más de una asignación activa simultánea y valida la disponibilidad de la unidad y el estado del Staff antes de crearse. Controla el ciclo de vida (`Active`, `Terminated`). |

### Value Objects

| Nombre de Clase | Categoría | Propósito y Reglas de Negocio |
|---|---|---|
| `ConversationId` | Value Object | Identificador fuertemente tipado de una conversación. |
| `MessageId` | Value Object | Identificador fuertemente tipado de un mensaje. |
| `NotificationId` | Value Object | Identificador fuertemente tipado de una notificación. |
| `LogId` | Value Object | Identificador fuertemente tipado de un log de comunicación. |
| `AssignmentId` | Value Object | Identificador fuertemente tipado de una asignación. |
| `TenantId` | Value Object | Referencia externa al Tenant, proveniente del contexto de gestión de inquilinos. |
| `GalleryAdministratorId` | Value Object | Referencia externa al Gallery Administrator, proveniente del contexto de gestión de usuarios. |
| `CommercialUnitId` | Value Object | Referencia externa a la Commercial Unit, proveniente del contexto de gestión de unidades comerciales. |
| `UserId` | Value Object | Referencia externa al usuario que envía un mensaje o recibe una notificación. |
| `Subject` | Value Object | Asunto de una conversación. Valida longitud entre 1 y 200 caracteres. |
| `MessageContent` | Value Object | Contenido textual de un mensaje. Valida longitud entre 1 y 2000 caracteres. |
| `ConversationStatus` | Enum | Estado de la conversación: `Open`, `Resolved`. |
| `NotificationType` | Enum | Tipo de notificación: `UtilityBillIssued`, `ConversationStarted`, `MessageReceived`, `AssignmentCreated`. |
| `NotificationStatus` | Enum | Estado de entrega: `Pending`, `Sent`, `Failed`. |
| `NotificationChannel` | Enum | Canal de entrega: `InApp`, `Email`, `Push`. |
| `SenderRole` | Enum | Rol del remitente de un mensaje: `Tenant`, `GalleryAdministrator`. |
| `ReferenceType` | Enum | Tipo de referencia de un log: `Notification`, `Conversation`. |
| `AssignmentStatus` | Enum | Estado de la asignación: `Active`, `Terminated`. |

### Commands

| Nombre de Clase | Categoría | Propósito | Comando |
|---|---|---|---|
| `StartConversationCommand` | Command | Encapsula la intención de iniciar una conversación entre un Tenant y un Gallery Administrator. Contiene: `tenantId`, `galleryAdministratorId`, `subject`. | — |
| `SendMessageCommand` | Command | Encapsula la intención de enviar un mensaje dentro de una conversación. Contiene: `conversationId`, `senderId`, `senderRole`, `content`, `attachments`. | — |
| `MarkConversationResolvedCommand` | Command | Encapsula la intención de marcar una conversación como resuelta. Contiene: `conversationId`. | — |
| `NotifyTenantCommand` | Command | Encapsula la intención de notificar a un Tenant sobre un evento relevante. Contiene: `tenantId`, `type`, `title`, `body`, `channel`, `referenceId`. | — |
| `RegisterCommunicationLogCommand` | Command | Encapsula la intención de registrar un log de comunicación. Contiene: `referenceId`, `referenceType`, `tenantId`, `channel`, `detail`. | — |
| `AssignTenantCommand` | Command | Encapsula la intención de asignar un Tenant a una Commercial Unit. Contiene: `tenantId`, `commercialUnitId`, `galleryAdministratorId`. | — |
| `TerminateTenantAssignmentCommand` | Command | Encapsula la intención de terminar una asignación activa. Contiene: `assignmentId`. | — |

### Queries

| Nombre de Clase | Categoría | Propósito |
|---|---|---|
| `GetConversationByIdQuery` | Query | Recupera el detalle de una conversación por su identificador. |
| `GetConversationsByTenantQuery` | Query | Lista las conversaciones de un Tenant específico. |
| `GetConversationsByAdministratorQuery` | Query | Lista las conversaciones de un Gallery Administrator específico. |
| `GetConversationMessagesQuery` | Query | Recupera los mensajes paginados de una conversación, más recientes primero. |
| `GetNotificationsByTenantQuery` | Query | Lista las notificaciones de un Tenant, con filtro por estado. |
| `GetUnreadNotificationsCountQuery` | Query | Cuenta las notificaciones no leídas de un Tenant. |
| `GetLogsByTenantQuery` | Query | Recupera los logs de comunicación de un Tenant, con filtros por tipo y rango de fechas. |
| `GetLogsByReferenceQuery` | Query | Recupera los logs asociados a una referencia específica (notificación o conversación). |
| `GetAssignmentByIdQuery` | Query | Recupera el detalle de una asignación por su identificador. |
| `GetAssignmentsByTenantQuery` | Query | Lista las asignaciones de un Tenant. |
| `GetActiveAssignmentForUnitQuery` | Query | Recupera la asignación activa de una Commercial Unit. |

### Domain Events

| Nombre de Clase | Categoría | Propósito |
|---|---|---|
| `ConversationStartedEvent` | Domain Event | Emitido al iniciarse una conversación entre un Tenant y un Gallery Administrator. |
| `MessageSentEvent` | Domain Event | Emitido al enviarse un mensaje dentro de una conversación. Contiene el indicador de si tiene adjuntos. |
| `ConversationMarkedResolvedEvent` | Domain Event | Emitido al marcarse una conversación como resuelta. |
| `TenantNotifiedEvent` | Domain Event | Emitido al confirmarse el envío de una notificación al Tenant. |
| `CommunicationLoggedEvent` | Domain Event | Emitido al registrarse un log de comunicación. |
| `TenantAssignedEvent` | Domain Event | Emitido al asignarse un Tenant a una Commercial Unit. |
| `TenantAssignmentTerminatedEvent` | Domain Event | Emitido al terminarse una asignación activa. |
| `UtilityBillIssuedEvent` | Domain Event (entrante) | Evento de integración proveniente del bounded context Consumption and Billing que notifica la emisión de una factura. Dispara la creación de una notificación al Tenant. |

---

## 4.2.4.2. Interface Layer

La capa de interfaz del Bounded Context Management-Tenant Communication expone los endpoints RESTful necesarios para que los actores del sistema gestionen las conversaciones, consulten el historial de notificaciones y logs, y administren las asignaciones de Tenants a Commercial Units. Esta capa recibe solicitudes desde la Web Application y la Mobile Application, las transforma en Commands o Queries y delega su ejecución a la capa de aplicación.

Adicionalmente, aloja la interfaz del Anti-Corruption Layer (ACL) que permite a otros bounded contexts —en particular Consumption and Billing— notificar al Tenant sin acoplarse al modelo interno de este contexto.

### ConversationsController

| Propiedad | Valor |
|---|---|
| Nombre | `ConversationsController` |
| Categoría | Controller |
| Propósito | Exponer endpoints para iniciar, consultar y resolver conversaciones entre Tenants y Gallery Administrators. |
| Ruta | `/api/v1/conversations` |

| Nombre | Ruta | Acción | Handle (Command/Query) |
|---|---|---|---|
| Start | `/` (POST) | Inicia una nueva conversación | `StartConversationCommand` |
| GetById | `/{conversationId}` (GET) | Obtiene el detalle de una conversación | `GetConversationByIdQuery` |
| GetByTenant | `/tenants/{tenantId}` (GET) | Lista las conversaciones de un Tenant | `GetConversationsByTenantQuery` |
| GetByAdministrator | `/administrators/{adminId}` (GET) | Lista las conversaciones de un Gallery Administrator | `GetConversationsByAdministratorQuery` |
| Resolve | `/{conversationId}/resolve` (PATCH) | Marca una conversación como resuelta | `MarkConversationResolvedCommand` |

### ConversationMessagesController

| Propiedad | Valor |
|---|---|
| Nombre | `ConversationMessagesController` |
| Categoría | Controller |
| Propósito | Exponer endpoints para consultar y enviar mensajes dentro de una conversación. |
| Ruta | `/api/v1/conversations/{conversationId}/messages` |

| Nombre | Ruta | Acción | Handle (Command/Query) |
|---|---|---|---|
| GetMessages | `/` (GET) | Lista los mensajes paginados de una conversación | `GetConversationMessagesQuery` |
| SendMessage | `/` (POST) | Envía un mensaje con adjuntos | `SendMessageCommand` |

### TenantNotificationsController

| Propiedad | Valor |
|---|---|
| Nombre | `TenantNotificationsController` |
| Categoría | Controller |
| Propósito | Exponer endpoints para consultar el historial de notificaciones de un Tenant y gestionar su estado de lectura. |
| Ruta | `/api/v1/tenants/{tenantId}/notifications` |

| Nombre | Ruta | Acción | Handle (Command/Query) |
|---|---|---|---|
| GetNotifications | `/` (GET) | Lista las notificaciones de un Tenant, con filtro por estado | `GetNotificationsByTenantQuery` |
| GetUnreadCount | `/unread-count` (GET) | Cuenta las notificaciones no leídas del Tenant | `GetUnreadNotificationsCountQuery` |

### CommunicationLogsController

| Propiedad | Valor |
|---|---|
| Nombre | `CommunicationLogsController` |
| Categoría | Controller |
| Propósito | Exponer endpoints para consultar el historial de logs de comunicación registrados por el contexto. |
| Ruta | `/api/v1/communication-logs` |

| Nombre | Ruta | Acción | Handle (Command/Query) |
|---|---|---|---|
| GetLogs | `/` (GET) | Consulta los logs de comunicación con filtros | `GetLogsByTenantQuery` |

### TenantAssignmentsController

| Propiedad | Valor |
|---|---|
| Nombre | `TenantAssignmentsController` |
| Categoría | Controller |
| Propósito | Exponer endpoints para asignar un Tenant a una Commercial Unit, consultar asignaciones y terminar asignaciones activas. |
| Ruta | `/api/v1/tenant-assignments` |

| Nombre | Ruta | Acción | Handle (Command/Query) |
|---|---|---|---|
| Assign | `/` (POST) | Asigna un Tenant a una Commercial Unit | `AssignTenantCommand` |
| GetById | `/{assignmentId}` (GET) | Obtiene el detalle de una asignación | `GetAssignmentByIdQuery` |
| GetByTenant | `/tenants/{tenantId}` (GET) | Lista las asignaciones de un Tenant | `GetAssignmentsByTenantQuery` |
| GetActiveForUnit | `/units/{commercialUnitId}/active` (GET) | Recupera la asignación activa de una unidad | `GetActiveAssignmentForUnitQuery` |
| Terminate | `/{assignmentId}/terminate` (PATCH) | Termina una asignación activa | `TerminateTenantAssignmentCommand` |

### Anti-Corruption Layer (ACL) Interfaces

| Nombre de Interfaz | Categoría | Propósito |
|---|---|---|
| `IManagementTenantCommunicationFacade` | ACL Interface | Contrato que expone las operaciones que otros bounded contexts —en particular Consumption and Billing— pueden invocar para notificar al Tenant y validar asignaciones activas, sin conocer los detalles internos del dominio. |

---

## 4.2.4.3. Application Layer

La capa de aplicación del Bounded Context Management-Tenant Communication orquesta los casos de uso relacionados con la gestión de conversaciones, notificaciones, logs y asignaciones.

En esta capa residen los Command Handlers, Query Handlers y Event Handlers que coordinan el flujo entre la capa de interfaz, el dominio y la infraestructura.

También aloja la implementación del ACL (`ManagementTenantCommunicationFacade`), que implementa la interfaz `IManagementTenantCommunicationFacade` definida en la Interface Layer.

Esta capa no contiene reglas puras de dominio: su responsabilidad es reaccionar a eventos externos, validar referencias contra otros contextos mediante ACL, delegar la persistencia a los repositorios y publicar eventos de dominio.

### Command Handlers

| Nombre de Clase | Categoría | Propósito | Comando |
|---|---|---|---|
| `StartConversationCommandHandler` | Command Handler | Valida la existencia del Tenant y del Gallery Administrator mediante ACL, crea el agregado `Conversation` y publica `ConversationStartedEvent`. | `StartConversationCommand` |
| `SendMessageCommandHandler` | Command Handler | Carga la conversación, valida que esté en estado `Open`, registra los adjuntos antes de persistir y publica `MessageSentEvent`. | `SendMessageCommand` |
| `MarkConversationResolvedCommandHandler` | Command Handler | Carga la conversación y llama a `MarkAsResolved()`, publicando `ConversationMarkedResolvedEvent`. | `MarkConversationResolvedCommand` |
| `NotifyTenantCommandHandler` | Command Handler | Crea el agregado `TenantNotification` a partir de la información de situación y lo persiste en estado `Pending`. | `NotifyTenantCommand` |
| `RegisterCommunicationLogCommandHandler` | Command Handler | Reacciona al evento `TenantNotified` para crear el log de comunicación y publicar `CommunicationLoggedEvent`. | `RegisterCommunicationLogCommand` |
| `AssignTenantCommandHandler` | Command Handler | Valida la disponibilidad de la Commercial Unit y la ausencia de asignaciones activas previas mediante ACL, crea el agregado `TenantAssignment` y publica `TenantAssignedEvent`. | `AssignTenantCommand` |
| `TerminateTenantAssignmentCommandHandler` | Command Handler | Carga la asignación activa y llama a `Terminate()`, publicando `TenantAssignmentTerminatedEvent`. | `TerminateTenantAssignmentCommand` |

### Query Handlers

| Nombre de Clase | Categoría | Propósito | Query |
|---|---|---|---|
| `GetConversationByIdQueryHandler` | Query Handler | Recupera el detalle de una conversación por su identificador. | `GetConversationByIdQuery` |
| `GetConversationsByTenantQueryHandler` | Query Handler | Lista las conversaciones asociadas a un Tenant. | `GetConversationsByTenantQuery` |
| `GetConversationsByAdministratorQueryHandler` | Query Handler | Lista las conversaciones asociadas a un Gallery Administrator. | `GetConversationsByAdministratorQuery` |
| `GetConversationMessagesQueryHandler` | Query Handler | Recupera los mensajes paginados de una conversación, más recientes primero. | `GetConversationMessagesQuery` |
| `GetNotificationsByTenantQueryHandler` | Query Handler | Lista las notificaciones de un Tenant, con filtro por estado. | `GetNotificationsByTenantQuery` |
| `GetUnreadNotificationsCountQueryHandler` | Query Handler | Cuenta las notificaciones no leídas de un Tenant. | `GetUnreadNotificationsCountQuery` |
| `GetLogsByTenantQueryHandler` | Query Handler | Recupera los logs de comunicación de un Tenant con filtros. | `GetLogsByTenantQuery` |
| `GetLogsByReferenceQueryHandler` | Query Handler | Recupera los logs asociados a una referencia específica. | `GetLogsByReferenceQuery` |
| `GetAssignmentByIdQueryHandler` | Query Handler | Recupera el detalle de una asignación por su identificador. | `GetAssignmentByIdQuery` |
| `GetAssignmentsByTenantQueryHandler` | Query Handler | Lista las asignaciones de un Tenant. | `GetAssignmentsByTenantQuery` |
| `GetActiveAssignmentForUnitQueryHandler` | Query Handler | Recupera la asignación activa de una Commercial Unit. | `GetActiveAssignmentForUnitQuery` |

### Event Handlers

| Nombre de Clase | Categoría | Propósito | Evento |
|---|---|---|---|
| `UtilityBillIssuedEventHandler` | Event Handler | Reacciona al evento emitido por Consumption and Billing invocando `NotifyTenantCommand`, implementando la política "Whenever Utility Bill Issued occurs, Tenant Notified is executed". | `UtilityBillIssuedEvent` |
| `TenantNotifiedEventHandler` | Event Handler | Reacciona a la confirmación de envío de una notificación disparando `RegisterCommunicationLogCommand`. | `TenantNotifiedEvent` |
| `TenantAssignedEventHandler` | Event Handler | Notifica al Tenant de su asignación a una Commercial Unit. | `TenantAssignedEvent` |

### Anti-Corruption Layer (ACL) Implementation

| Nombre de Clase | Categoría | Propósito | Interfaz |
|---|---|---|---|
| `ManagementTenantCommunicationFacade` | ACL Implementation | Implementa la interfaz `IManagementTenantCommunicationFacade`, traduciendo las solicitudes externas provenientes de Consumption and Billing en comandos internos (`NotifyTenantCommand`). También expone consultas de validación de asignaciones activas por unidad. | `IManagementTenantCommunicationFacade` |

---

## 4.2.4.4. Infrastructure Layer

La capa de infraestructura del Bounded Context Management-Tenant Communication resuelve los detalles técnicos necesarios para materializar las abstracciones definidas en el dominio.

En esta capa se implementan los repositorios con Entity Framework Core sobre MySQL, se configura el contexto de base de datos y se integran los adapters necesarios para el envío de notificaciones por los canales in-app, email y push.

### Repositories

| Nombre de Clase | Categoría | Propósito | Interfaz |
|---|---|---|---|
| `ConversationRepository` | Repositorio | Persiste y consulta el agregado `Conversation` y sus entidades hijas `Message` y `Attachment` en las tablas `conversations`, `messages` y `message_attachments`. | `IConversationRepository` |
| `TenantNotificationRepository` | Repositorio | Persiste y consulta las notificaciones emitidas hacia los Tenants en la tabla `tenant_notifications`. | `ITenantNotificationRepository` |
| `CommunicationLogRepository` | Repositorio | Persiste y consulta los logs de comunicación en la tabla `communication_logs`. | `ICommunicationLogRepository` |
| `TenantAssignmentRepository` | Repositorio | Persiste y consulta las asignaciones de Tenants a Commercial Units en la tabla `tenant_assignments`. | `ITenantAssignmentRepository` |

### Persistence and External Services

| Nombre de Clase | Categoría | Propósito |
|---|---|---|
| `ManagementTenantCommunicationDbContext` | DbContext | Punto central de configuración de Entity Framework Core para el mapeo de los agregados `Conversation`, `TenantNotification`, `CommunicationLog` y `TenantAssignment` sobre MySQL. |
| `ConversationEntityConfiguration` | EF Core Configuration | Configura el mapeo de la tabla `conversations` y sus relaciones con `messages` y `message_attachments`. |
| `TenantNotificationEntityConfiguration` | EF Core Configuration | Configura el mapeo de la tabla `tenant_notifications`. |
| `CommunicationLogEntityConfiguration` | EF Core Configuration | Configura el mapeo de la tabla `communication_logs`. |
| `TenantAssignmentEntityConfiguration` | EF Core Configuration | Configura el mapeo de la tabla `tenant_assignments` y su restricción de asignación activa única por unidad. |
| `EmailNotificationAdapter` | External Service Wrapper | Integra el servicio de envío de correos transaccionales para el canal `Email` de las notificaciones. |
| `PushNotificationAdapter` | External Service Wrapper | Integra el servicio de envío de notificaciones push hacia la Mobile Application para el canal `Push`. |
| `StorageAdapter` | External Service Wrapper | Almacena los adjuntos de los mensajes y expone las URLs públicas correspondientes. |

### Database Tables

| Tabla | Propósito |
|---|---|
| `conversations` | Almacena las conversaciones entre Tenants y Gallery Administrators, incluyendo estado, asunto y fechas. |
| `messages` | Almacena los mensajes individuales de cada conversación, con FK a `conversations`. |
| `message_attachments` | Almacena los adjuntos de cada mensaje, con FK a `messages`. |
| `tenant_notifications` | Almacena las notificaciones emitidas hacia los Tenants, con tipo, canal, estado y fecha de envío. |
| `communication_logs` | Almacena el histórico de logs de comunicación con referencia al recurso origen. |
| `tenant_assignments` | Almacena las asignaciones de Tenants a Commercial Units, con estado y fechas. |

---

# 4.2.4.5. Bounded Context Software Architecture Component Level Diagrams

Los diagramas de componentes muestran la estructura interna de la Web Application, Mobile Application y REST API del Bounded Context Management-Tenant Communication, identificando sus principales componentes, responsabilidades y relaciones.

## 4.2.4.5.1. Component Diagram — Web Application Container

Este diagrama muestra la estructura interna de la Web Application, desarrollada con Angular, y los componentes que permiten al Gallery Administrator gestionar conversaciones, notificaciones y asignaciones. También se muestran las relaciones con los controladores de la REST API.

![Web Component Management-Tenant Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/management-tenant-communication/02_Component_Web_Application.puml&fmt=svg&v=4)

### Componentes

| Componente | Responsabilidad | Tecnología |
|---|---|---|
| `ManagementTenantCommunicationUi` | Provee la interfaz de usuario para gestionar conversaciones entre Tenants y Gallery Administrators, consultar el historial de notificaciones y visualizar asignaciones de Tenants a Commercial Units. | Angular, TypeScript |

### Interacciones

| Interactúa con | Tipo de Relación | Descripción de la Interacción |
|---|---|---|
| Gallery Administrator | Interfaz de Usuario | Provee las pantallas para que el Gallery Administrator gestione conversaciones, notificaciones y asignaciones. |
| ConversationsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para iniciar, consultar y resolver conversaciones. |
| ConversationMessagesController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar y enviar mensajes dentro de una conversación. |
| TenantNotificationsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar el historial de notificaciones. |
| CommunicationLogsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar los logs de comunicación. |
| TenantAssignmentsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para asignar y terminar asignaciones de Tenants a Commercial Units. |

---

## 4.2.4.5.2. Component Diagram — Mobile Application Container

Este diagrama muestra la estructura interna de la Mobile Application, desarrollada con Flutter y Dart, y los componentes que permiten al Tenant consultar sus conversaciones, recibir notificaciones y visualizar el estado de su asignación.

![Mobile Component Management-Tenant Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/management-tenant-communication/01_Component_Mobile_Application.puml&fmt=svg&v=4)

### Componentes

| Componente | Responsabilidad | Tecnología |
|---|---|---|
| `ManagementTenantCommunicationMobileUi` | Provee las pantallas y lógica local móvil para que los Tenants consulten conversaciones, reciban notificaciones y visualicen el estado de su asignación. | Flutter, Dart |

### Interacciones

| Interactúa con | Tipo de Relación | Descripción de la Interacción |
|---|---|---|
| Tenant | Interfaz de Usuario | Provee las pantallas para que el Tenant consulte conversaciones, notificaciones y el estado de su asignación. |
| ConversationsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar conversaciones. |
| ConversationMessagesController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar y enviar mensajes dentro de una conversación. |
| TenantNotificationsController | Petición HTTP / REST | Envía solicitudes HTTPS/JSON para consultar el historial de notificaciones. |

---

## 4.2.4.5.3. Component Diagram — REST API Container

Este diagrama muestra la estructura interna de la REST API, desarrollada con ASP.NET Core y .NET, y los componentes que gestionan las operaciones del Bounded Context Management-Tenant Communication, incluyendo controladores, handlers, repositorios, adaptadores y la fachada de integración con otros Bounded Contexts.

![Backend Component Management-Tenant Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/management-tenant-communication/05_Component_REST_API_Backend.puml&fmt=svg&v=4)
### Componentes

| Componente | Responsabilidad | Tecnología |
|---|---|---|
| `ConversationsController` | Expone endpoints para iniciar, consultar y resolver conversaciones. | ASP.NET Core MVC |
| `ConversationMessagesController` | Expone endpoints para consultar y enviar mensajes dentro de una conversación. | ASP.NET Core MVC |
| `TenantNotificationsController` | Expone endpoints para consultar notificaciones y su estado de lectura. | ASP.NET Core MVC |
| `CommunicationLogsController` | Expone endpoints para consultar los logs de comunicación. | ASP.NET Core MVC |
| `TenantAssignmentsController` | Expone endpoints para asignar y terminar asignaciones de Tenants a Commercial Units. | ASP.NET Core Core MVC |
| `ConversationCommandHandlers` | Orquestan los casos de uso de creación, envío de mensajes y resolución de conversaciones. | C# Application Services |
| `NotificationCommandHandlers` | Orquestan la creación y despacho de notificaciones al Tenant. | C# Application Services |
| `CommunicationLogCommandHandlers` | Registran los logs de comunicación asociados a notificaciones y conversaciones. | C# Application Services |
| `AssignmentCommandHandlers` | Orquestan la asignación y terminación de asignaciones de Tenants a Commercial Units. | C# Application Services |
| `QueryHandlers` | Atienden las consultas de conversaciones, notificaciones, logs y asignaciones. | C# Application Services |
| `UtilityBillIssuedEventHandler` | Reacciona al evento emitido por Consumption and Billing e invoca la notificación al Tenant. | C# Event Handler |
| `TenantNotifiedEventHandler` | Registra el log de comunicación al confirmarse el envío de una notificación. | C# Event Handler |
| `Conversation` | Agregado que representa una conversación con sus mensajes y adjuntos. | C# Domain Model |
| `TenantNotification` | Agregado que representa una notificación emitida al Tenant. | C# Domain Model |
| `CommunicationLog` | Agregado que representa el registro histórico de una comunicación. | C# Domain Model |
| `TenantAssignment` | Agregado que representa la asignación de un Tenant a una Commercial Unit. | C# Domain Model |
| `ConversationRepository` | Persiste y recupera conversaciones y sus mensajes. | Entity Framework Core |
| `TenantNotificationRepository` | Persiste y recupera notificaciones. | Entity Framework Core |
| `CommunicationLogRepository` | Persiste y recupera logs de comunicación. | Entity Framework Core |
| `TenantAssignmentRepository` | Persiste y recupera asignaciones. | Entity Framework Core |
| `ManagementTenantCommunicationFacade` | Anti-Corruption Layer que expone operaciones de notificación y validación a otros bounded contexts. | C# Application Service |
| `EmailNotificationAdapter` | Envía notificaciones por correo electrónico. | C# Adapter |
| `PushNotificationAdapter` | Envía notificaciones push a la aplicación móvil. | C# Adapter |

### Interacciones

| Interactúa con | Tipo de Relación | Descripción de la Interacción |
|---|---|---|
| Web Application | Solicitud Entrante (HTTPS/JSON) | Recibe solicitudes para gestionar conversaciones, notificaciones y asignaciones desde la aplicación web. |
| Mobile Application | Solicitud Entrante (HTTPS/JSON) | Recibe solicitudes móviles para consultar conversaciones y notificaciones. |
| Identity and Access Management | Dependencia Interna | Valida tokens JWT y permisos de usuario antes de permitir operaciones sobre conversaciones, notificaciones y asignaciones. |
| Consumption and Billing | Evento Entrante | Consume el evento `UtilityBillIssuedEvent` que dispara la notificación al Tenant correspondiente. |
| Commercial Units | Dependencia Interna | Valida la existencia y disponibilidad de la Commercial Unit antes de crear una asignación. |
| Tenant Management | Dependencia Interna | Valida la existencia del Tenant antes de iniciar conversaciones, notificar o asignar. |
| Email Provider | Integración Externa | Envía notificaciones por correo electrónico a través del `EmailNotificationAdapter`. |
| Push Notification Service | Integración Externa | Envía notificaciones push a la Mobile Application a través del `PushNotificationAdapter`. |
| MySQL Database | Persistencia | Almacena y recupera conversaciones, mensajes, adjuntos, notificaciones, logs de comunicación y asignaciones mediante Entity Framework Core. |

---

# 4.2.4.6. Bounded Context Software Architecture Code Level Diagrams

En esta sección, el equipo presenta y explica los diagramas que presentan un mayor detalle sobre la implementación de componentes en el bounded context Management-Tenant Communication.

Se incluyen como secciones internas el Domain Layer Class Diagram y el Database Design Diagram. Los diagramas se elaboran con PlantUML en modo Diagram-as-Code.

## 4.2.4.6.1. Bounded Context Domain Layer Class Diagrams

En esta sección se presenta el Diagrama de Clases detallado para la Domain Layer del Bounded Context Management-Tenant Communication. El diagrama evidencia cómo el contexto organiza la lógica de comunicación entre Tenants y Gallery Administrators, así como la gestión de notificaciones, logs y asignaciones.

Para mantener la claridad del modelo, el diagrama se organiza visualmente en los siguientes sub-paquetes lógicos:

- **Model.Aggregates:** Agrupa los agregados `Conversation`, `TenantNotification`, `CommunicationLog` y `TenantAssignment`.
- **Model.Entities:** Define las entidades `Message` y `Attachment` que componen el agregado `Conversation`.
- **Model.ValueObjects:** Agrupa los identificadores fuertemente tipados, objetos de valor y enumeraciones que definen el lenguaje ubicuo del contexto.
- **Model.Events:** Mapea los eventos de dominio emitidos por el contexto y el evento entrante `UtilityBillIssuedEvent` consumido desde Consumption and Billing.
- **Services.Acl:** Define la interfaz `IManagementTenantCommunicationFacade` que expone las capacidades del contexto hacia otros bounded contexts.

El modelo es un Modelo de Dominio Rico: los agregados exponen métodos con lógica de negocio explícita (`Start`, `SendMessage`, `MarkAsResolved`, `NotifyTenant`, `Register`, `AssignTenant`, `Terminate`) que validan las invariantes del dominio antes de permitir cualquier cambio de estado.

Los Value Objects garantizan el tipado estricto de identificadores y contenidos, evitando el uso de tipos primitivos en las operaciones del dominio.

![Class Diagram Management-Tenant Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/management-tenant-communication/04_Domain_Layer.puml&fmt=svg&v=4)

---

## 4.2.4.6.2. Bounded Context Database Design Diagram

En esta sección se presenta el diagrama de Base de Datos del Bounded Context Management-Tenant Communication, diseñado sobre un modelo relacional en MySQL.

El esquema agrupa las entidades del contexto en seis tablas:

- `conversations`
- `messages`
- `message_attachments`
- `tenant_notifications`
- `communication_logs`
- `tenant_assignments`

El diseño mantiene integridad referencial interna entre `conversations` y `messages`, y entre `messages` y `message_attachments`, mediante claves foráneas físicas.

Los campos `tenant_id`, `gallery_administrator_id` y `commercial_unit_id` son referencias externas hacia otros bounded contexts y se validan mediante ACL, sin claves foráneas físicas por tratarse de relaciones entre contextos.

Los identificadores se modelan como `CHAR(36)` para almacenar valores `Guid` generados por la aplicación.

![Database Diagram Management-Tenant Communication](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/management-tenant-communication/03_Database_Diagram.puml&fmt=svg&v=4)

### Database Tables

| Tabla | Propósito |
|---|---|
| `conversations` | Almacena la cabecera de cada conversación entre un Tenant y un Gallery Administrator. |
| `messages` | Almacena los mensajes individuales de cada conversación, con FK a `conversations`. |
| `message_attachments` | Almacena los adjuntos de cada mensaje, con FK a `messages`. |
| `tenant_notifications` | Almacena las notificaciones emitidas hacia los Tenants. |
| `communication_logs` | Almacena el histórico de logs de comunicación del contexto. |
| `tenant_assignments` | Almacena las asignaciones de Tenants a Commercial Units. |