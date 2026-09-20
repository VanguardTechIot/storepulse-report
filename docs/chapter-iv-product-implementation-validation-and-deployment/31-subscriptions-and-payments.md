# 4.2.7. Bounded Context: Subscriptions and Payments

El **Bounded Context de Subscriptions and Payments** concentra la contratación y el ciclo de vida de las suscripciones de las galerías comerciales, junto con el procesamiento de los pagos que las sustentan. Administra el catálogo de planes escalonados por cantidad de locales monitoreados, la activación y renovación de la suscripción, su cancelación y su expiración.

Este contexto es la puerta de entrada comercial de la solución: el Gallery Administrator es el único actor que contrata y asume el costo del servicio, mientras que el Tenant es el beneficiario sin participación en la decisión de compra. El procesamiento del cobro se delega a una **pasarela de pagos** externa, que confirma o rechaza la transacción. La gestión de los dispositivos como activo físico pertenece a **Resource and Asset Management**, que consume el evento de activación para habilitar el registro de dispositivos hasta el límite del plan contratado.

## 4.2.7.1. Domain Layer

La **Domain Layer** contiene el núcleo de las reglas de negocio del contexto. Se identifican tres agregados raíz, sus objetos de valor, enumeraciones, interfaces de repositorio y eventos de dominio.

### Aggregates, Entities and Value Objects

| Nombre | Categoría | Propósito y reglas de negocio |
|---|---|---|
| `SubscriptionPlan` | Aggregate Root | Representa un plan de suscripción publicado en el catálogo. Define el límite de locales monitoreados y el precio del periodo. Garantiza que el nombre sea único entre los planes activos y que un plan con suscripciones vigentes no pueda eliminarse. |
| `Subscription` | Aggregate Root | Representa la suscripción de una galería comercial. Controla su ciclo de vida completo (`PendingPayment`, `Active`, `Cancelled`, `Expired`) y el conteo de locales monitoreados frente al límite del plan. Garantiza que una galería no tenga dos suscripciones activas de forma simultánea y que la contratación se realice por inmueble completo. |
| `Payment` | Aggregate Root | Representa un cobro asociado a una suscripción. Registra el monto, el medio de pago y el resultado devuelto por la pasarela externa. Es inmutable tras su resolución. |
| `SubscriptionPlanId` | Value Object | Encapsula el identificador de un plan de suscripción. |
| `SubscriptionId` | Value Object | Encapsula el identificador de una suscripción. |
| `PaymentId` | Value Object | Encapsula el identificador de un pago. |
| `GalleryId` | Value Object | Referencia externa a la galería comercial, proveniente de Resource and Asset Management. |
| `GalleryAdministratorId` | Value Object | Referencia externa al administrador que contrata, proveniente de Identity and Access Management. |
| `PlanName` | Value Object | Nombre comercial del plan. Valida longitud y unicidad entre los planes activos. |
| `MonitoredUnitLimit` | Value Object | Cantidad máxima de locales que el plan permite monitorear. Valida que sea mayor que cero. |
| `Money` | Value Object | Encapsula el monto y la moneda de un precio o de un cobro. Valida que el monto no sea negativo. |
| `BillingPeriod` | Value Object | Encapsula la fecha de inicio y la fecha de vencimiento de un periodo de suscripción. |
| `GatewayReference` | Value Object | Encapsula el identificador de la transacción devuelto por la pasarela de pagos. |

### Enumeraciones del dominio

| Enumeración | Valores representados | Propósito |
|---|---|---|
| `SubscriptionStatus` | `PENDING_PAYMENT`, `ACTIVE`, `CANCELLED`, `EXPIRED` | Identifica el estado del ciclo de vida de una suscripción. |
| `PaymentStatus` | `PENDING`, `ACCEPTED`, `REJECTED` | Identifica el resultado del cobro devuelto por la pasarela externa. |
| `PaymentMethod` | `CREDIT_CARD`, `DEBIT_CARD`, `BANK_TRANSFER` | Identifica el medio de pago utilizado en la transacción. |
| `BillingCycle` | `MONTHLY`, `ANNUAL` | Identifica la periodicidad de cobro del plan contratado. |

### Commands

| Command | Actor u origen | Propósito |
|---|---|---|
| `PublishSubscriptionPlanCommand` | Platform Operator | Publicar un plan en el catálogo con su límite de locales y su precio. |
| `RequestSubscriptionCommand` | Gallery Administrator | Solicitar la contratación de un plan para su galería. |
| `RegisterPaymentCommand` | Gallery Administrator | Registrar el pago que sustenta la suscripción solicitada. |
| `RenewSubscriptionCommand` | Gallery Administrator | Extender la vigencia de la suscripción por un periodo adicional. |
| `CancelSubscriptionCommand` | Gallery Administrator | Cancelar la suscripción vigente de su galería. |

### Reglas y operaciones principales

| Elemento | Operaciones principales |
|---|---|
| `SubscriptionPlan` | Publicarse en el catálogo validando la unicidad del nombre y que el límite de locales y el precio sean mayores que cero; impedir su eliminación mientras existan suscripciones activas asociadas. |
| `Subscription` | Crearse en estado de pago pendiente al solicitarse; activarse únicamente cuando la pasarela confirma el cobro; renovarse solo si el número de locales en uso no excede el límite del nuevo plan; cancelarse conservando la vigencia hasta el fin del periodo pagado; expirar automáticamente al alcanzarse la fecha de vencimiento, conservando acceso de solo lectura al histórico durante treinta días. |
| `Payment` | Registrarse en estado pendiente y resolverse con el resultado devuelto por la pasarela externa; disparar la activación de la suscripción cuando el cobro es aceptado; notificar al administrador y marcar la suscripción en riesgo cuando es rechazado. |

### Repository Abstractions

| Interfaz | Responsabilidad |
|---|---|
| `ISubscriptionPlanRepository` | Guardar un plan y recuperar el catálogo de planes publicados; verificar la unicidad del nombre. |
| `ISubscriptionRepository` | Guardar una suscripción y recuperarla por su identificador o por el de la galería; verificar la existencia de una suscripción activa. |
| `IPaymentRepository` | Guardar un pago y recuperar el histórico de cobros de una suscripción. |

### Domain Events

| Evento | Origen | Propósito |
|---|---|---|
| `SubscriptionPlanPublishedEvent` | `SubscriptionPlan` | Representa la publicación de un nuevo plan en el catálogo. |
| `SubscriptionRequestedEvent` | `Subscription` | Representa la solicitud de contratación de un plan por parte de una galería. |
| `PaymentRegisteredEvent` | `Payment` | Representa el cobro aceptado por la pasarela de pagos; dispara la activación de la suscripción. |
| `PaymentFailedEvent` | `Payment` | Representa el cobro rechazado por la pasarela; dispara la notificación al administrador. |
| `SubscriptionActivatedEvent` | `Subscription` | Representa la activación de la suscripción; Resource and Asset Management lo consume para habilitar el registro de dispositivos. |
| `MonitoredUnitLimitReachedEvent` | `Subscription` | Representa que la galería alcanzó el límite de locales monitoreados de su plan. |
| `SubscriptionRenewedEvent` | `Subscription` | Representa la extensión de la vigencia por un periodo adicional. |
| `SubscriptionCancelledEvent` | `Subscription` | Representa la cancelación solicitada por el administrador. |
| `SubscriptionExpiredEvent` | `Subscription` | Representa el vencimiento de la suscripción; los contextos operativos lo consumen para restringir el acceso a modo de solo lectura. |

