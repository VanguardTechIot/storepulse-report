## 4.2. Tactical-Level Domain-Driven Design

### 4.2.1. Bounded Context: Identity and Access Management

El **Bounded Context de Identity and Access Management** es transversal a StorePulse. Su responsabilidad es proporcionar una identidad confiable a los demás Bounded Contexts: administra el registro, el inicio y cierre de sesión, la recuperación de contraseña y la autorización basada en roles (Gallery Administrator y Tenant) de todos los usuarios de la plataforma.

Este contexto delimita su alcance a la identidad y el acceso. La información de perfil (nombre, foto, datos de contacto) pertenece a **Profiles and Preferences**; este Bounded Context solo conserva lo estrictamente necesario para autenticar y autorizar.

#### 4.2.1.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio del contexto. Se identifican tres agregados raíz, sus objetos de valor, enumeraciones, interfaces de repositorio y eventos de dominio.

##### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `UserAccount` | Aggregate Root | Representa la cuenta de acceso de un usuario. Mantiene su correo, contraseña protegida, rol y estado, y permite registrarse, iniciar sesión, cerrar sesión y desactivarse. |
| `PasswordRecovery` | Aggregate Root | Representa el proceso de recuperación de contraseña de un usuario: genera el código de 6 dígitos, valida su vigencia (15 minutos) y su uso único, y coordina el cambio de contraseña. |
| `UnauthorizedAccessAttempt` | Aggregate Root | Registra un intento de acceso que no cumplió con el rol requerido para una operación. |
| `UserId` | Value Object | Encapsula el identificador de una cuenta de usuario. |
| `Email` | Value Object | Encapsula y valida el correo utilizado como identificador de inicio de sesión. |
| `PasswordHash` | Value Object | Representa únicamente la contraseña ya protegida; la contraseña en texto plano no forma parte del modelo persistido. |
| `PasswordResetCode` | Value Object | Encapsula el código de 6 dígitos utilizado para confirmar una recuperación de contraseña. |

##### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `Role` | `GALLERY_ADMINISTRATOR`, `TENANT` | Determina qué puede ver y hacer un usuario autenticado (vista consolidada del inmueble o vista de su propio local). |
| `UserStatus` | `ACTIVE`, `INACTIVE` | Controla si una cuenta puede iniciar sesión. |

##### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `UserAccount` | Registrarse validando correo único y complejidad mínima de contraseña; iniciar sesión validando credenciales; cerrar sesión; desactivarse. |
| `PasswordRecovery` | Generar código de 6 dígitos vigente 15 minutos; rechazar el código si está vencido o ya fue utilizado; confirmar el cambio de contraseña y marcar el código como usado. |
| `UnauthorizedAccessAttempt` | Registrar el intento cuando una solicitud autenticada falla el chequeo de rol requerido. |

##### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `IUserAccountRepository` | Guardar, buscar por identificador y buscar por correo una cuenta de usuario. |
| `IPasswordRecoveryRepository` | Guardar una recuperación, buscar la recuperación activa de un usuario y buscar por código. |
| `IUnauthorizedAccessAttemptRepository` | Guardar y recuperar los intentos no autorizados asociados a un usuario. |

##### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `UserRegisteredEvent` | `UserAccount` | Representa el registro de una nueva cuenta de usuario. Habilita la creación automática del perfil correspondiente en Profiles and Preferences. |
| `UserSignedInEvent` | `UserAccount` | Representa el inicio de sesión exitoso de un usuario. |
| `SessionEndedEvent` | `UserAccount` | Representa el cierre de sesión de un usuario. |
| `PasswordResetRequestedEvent` | `PasswordRecovery` | Representa la solicitud de recuperación de contraseña. |
| `PasswordResetCodeGeneratedEvent` | `PasswordRecovery` | Representa la generación del código de 6 dígitos que debe enviarse al usuario. |
| `PasswordChangedEvent` | `PasswordRecovery` | Representa el cambio exitoso de contraseña. |
| `UnauthorizedAccessAttemptLoggedEvent` | `UnauthorizedAccessAttempt` | Representa el registro de un intento de acceso no autorizado. |

#### 4.2.1.2. Interface Layer

La **Interface Layer** expone las capacidades de Identity and Access Management hacia la Web Application y la Mobile Application. La comunicación se realiza mediante la **REST API**, utilizando HTTPS y JSON.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `AuthenticationController` | ASP.NET Core | Expone el registro, inicio de sesión y cierre de sesión. |
| `PasswordRecoveryController` | ASP.NET Core | Expone la solicitud y confirmación de recuperación de contraseña. |
| Identity & Access UI | Angular | Permite al Gallery Administrator registrarse, iniciar sesión y recuperar su contraseña. |
| Identity & Access UI | Flutter / Dart | Permite al Tenant registrarse, iniciar sesión y recuperar su contraseña desde la aplicación móvil. |

La interfaz no concentra reglas de negocio: recibe las solicitudes externas y las dirige hacia los componentes de aplicación correspondientes.

#### 4.2.1.3. Application Layer

La **Application Layer** coordina los casos de uso de Identity and Access Management y actúa como intermediaria entre los controladores y el modelo de dominio.

| Componente | Responsabilidad |
|---|---|
| `Command Handlers` | Coordinar el registro, inicio de sesión, cierre de sesión y recuperación de contraseña. |
| `Query Handlers` | Resolver consultas de sesión y de información básica del usuario requerida por otros componentes. |
| `Identity & Access Domain` | Ejecutar las reglas y operaciones definidas en el dominio. |
| `Repository Implementations` | Persistir los cambios mediante las abstracciones de repositorio. |
| `IPasswordHasher` / `ITokenService` | Contratos de salida (Outbound Service Contracts) que desacoplan el dominio de la tecnología concreta de hashing y de generación de tokens; sus implementaciones concretas se ubican en Infrastructure Layer. |

El flujo general es:

```text
Aplicación Web / Aplicación Móvil
              ↓
      REST API Controllers
              ↓
   Command / Query Handlers
              ↓
   Identity & Access Domain
              ↓
  Repository Implementations
              ↓
        MySQL Database
```

#### 4.2.1.4. Infrastructure Layer

La **Infrastructure Layer** proporciona las implementaciones técnicas necesarias para proteger, persistir y validar la identidad de los usuarios.

| Componente | Tecnología | Responsabilidad |
|---|---|---|
| `TokenService` | JWT (JSON Web Token) | Genera y valida los tokens de acceso que el resto de los Bounded Contexts consumen para autorizar sus solicitudes. |
| `PasswordHasher` | Hashing seguro (ASP.NET Core) | Protege la contraseña antes de persistirla; implementa el contrato `IPasswordHasher`. |
| `Authorization Middleware` | ASP.NET Core Middleware | Valida el token de acceso en cada solicitud protegida y aplica el control de acceso por rol. |
| `Repository Implementations` | ASP.NET Core / Entity Framework Core | Implementan las interfaces de repositorio del dominio. |
| `StorePulseDbContext` | Entity Framework Core | Gestiona el acceso de la aplicación a la base de datos. |
| MySQL | MySQL | Persiste cuentas de usuario, códigos de recuperación e intentos no autorizados. |
| Servicio de envío de código | Firebase Authentication | Envía por correo el código de 6 dígitos de recuperación de contraseña generado internamente por el backend. |

#### 4.2.1.5. Bounded Context Software Architecture Component Level Diagrams

Los siguientes diagramas muestran cómo se distribuyen los componentes del Bounded Context dentro de los contenedores de StorePulse.

##### Web Application

La aplicación web, desarrollada con Angular, contiene la interfaz de identidad y acceso y el servicio encargado de consumir los servicios REST correspondientes.

![StorePulse - Identity and Access Management - Web Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/identity-and-access-management/01-iam-web-component.puml&fmt=svg&v=4)

##### Mobile Application

La aplicación móvil, desarrollada con Flutter y Dart, contiene la interfaz de identidad y acceso y el servicio encargado de consumir la API REST.

![StorePulse - Identity and Access Management - Mobile Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/identity-and-access-management/02-iam-mobile-component.puml&fmt=svg&v=4)

##### REST API

La REST API, desarrollada con ASP.NET Core, concentra los controladores, manejadores de comandos y consultas, dominio, repositorios y los servicios de seguridad (`TokenService`, `PasswordHasher`) del contexto.

![StorePulse - Identity and Access Management - REST API Components](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/identity-and-access-management/03-iam-rest-api-component.puml&fmt=svg&v=4)
