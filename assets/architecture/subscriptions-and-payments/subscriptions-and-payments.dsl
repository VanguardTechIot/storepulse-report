workspace "StorePulse - Subscriptions and Payments" "Component diagrams for the Subscriptions and Payments Bounded Context" {

    model {
        platformOperator = person "Platform Operator" "Publishes and maintains the subscription plan catalog."
        galleryAdministrator = person "Gallery Administrator" "Contracts, pays, renews and cancels the subscription of their gallery."

        paymentGateway = softwareSystem "Payment Gateway" "Processes subscription payments and confirms or rejects the transaction." "External System"
        resourceAssetManagement = softwareSystem "Resource and Asset Management" "Consumes the activation event to enable device registration up to the plan limit." "External System"
        operationalContexts = softwareSystem "Operational Bounded Contexts" "Consume the expiration event to restrict access to read-only mode." "External System"

        storePulse = softwareSystem "StorePulse" "IoT solution for security monitoring, utility consumption and billing in commercial galleries." {

            webApplication = container "Web Application" "Used by the Platform Operator and the Gallery Administrator to manage plans and subscriptions." "Angular" {
                subscriptionsWebUi = component "Subscriptions UI" "Displays the plan catalog, the subscription form, the payment form and the subscription status." "Angular"
                subscriptionsWebService = component "Subscriptions Service" "Consumes the plan, subscription and payment REST endpoints." "Angular Service"
            }

            mobileApplication = container "Mobile Application" "Used by the Gallery Administrator to review the status and validity of their subscription." "Flutter, Dart" {
                subscriptionsMobileUi = component "Subscriptions UI" "Displays the subscription status, its validity and the payment history." "Flutter, Dart"
                subscriptionsMobileService = component "Subscriptions Service" "Consumes the subscription and payment REST endpoints." "Dart"
            }

            restApi = container "REST API" "Monolithic API that centralizes StorePulse business logic." "ASP.NET Core, .NET" {
                subscriptionPlansController = component "SubscriptionPlansController" "Exposes the publication and query of the subscription plan catalog." "ASP.NET Core Controller"
                subscriptionsController = component "SubscriptionsController" "Exposes the request, query, renewal and cancellation of a subscription." "ASP.NET Core Controller"
                paymentsController = component "PaymentsController" "Exposes the payment registration and the payment history query." "ASP.NET Core Controller"
                paymentWebhookController = component "PaymentGatewayWebhookController" "Receives the payment confirmation or rejection sent by the gateway." "ASP.NET Core Controller"
                commandHandlers = component "Command Handlers" "Orchestrates plan publication, subscription request, payment registration, renewal and cancellation." "Application Layer"
                queryHandlers = component "Query Handlers" "Resolves the Plan Catalog, Available Plans, Payment Summary, Subscription Status and Payment History read models." "Application Layer"
                eventHandlers = component "Event Handlers" "Activates the subscription on payment confirmation, flags it at risk on rejection and publishes integration events." "Application Layer"
                expirationScheduler = component "Subscription Expiration Scheduler" "Detects subscriptions whose end date has been reached and emits the expiration event." "Hosted Service"
                subscriptionsDomain = component "Subscriptions and Payments Domain" "Contains the SubscriptionPlan, Subscription and Payment aggregates and domain rules." "Domain Layer"
                subscriptionsFacade = component "SubscriptionsFacade" "Anti-Corruption Layer that exposes the subscription status and the monitored unit limit to other Bounded Contexts." "Application Layer"
                repositoryImplementations = component "Repository Implementations" "Implements domain repository abstractions using Entity Framework Core." "Infrastructure Layer"
                paymentGatewayAdapter = component "PaymentGatewayAdapter" "Sends the payment order to the external gateway and retrieves the transaction reference." "Infrastructure Layer"
            }

            database = container "Database" "Stores subscription plans, subscriptions and payments." "MySQL"
        }

        // Web Application relationships
        platformOperator -> webApplication "Uses"
        galleryAdministrator -> webApplication "Uses"
        subscriptionsWebUi -> subscriptionsWebService "Uses"
        subscriptionsWebService -> restApi "Consumes plan, subscription and payment services" "HTTPS/JSON"

        // Mobile Application relationships
        galleryAdministrator -> mobileApplication "Uses"
        subscriptionsMobileUi -> subscriptionsMobileService "Uses"
        subscriptionsMobileService -> restApi "Consumes subscription and payment services" "HTTPS/JSON"

        // REST API internal relationships
        subscriptionPlansController -> commandHandlers "Invokes"
        subscriptionPlansController -> queryHandlers "Invokes"
        subscriptionsController -> commandHandlers "Invokes"
        subscriptionsController -> queryHandlers "Invokes"
        paymentsController -> commandHandlers "Invokes"
        paymentsController -> queryHandlers "Invokes"
        paymentWebhookController -> eventHandlers "Delegates"
        commandHandlers -> subscriptionsDomain "Executes domain operations"
        queryHandlers -> subscriptionsDomain "Queries domain data"
        eventHandlers -> subscriptionsDomain "Activates and updates aggregates"
        expirationScheduler -> subscriptionsDomain "Expires due subscriptions"
        commandHandlers -> paymentGatewayAdapter "Sends payment order through"
        subscriptionsFacade -> subscriptionsDomain "Queries status and unit limit"
        subscriptionsDomain -> repositoryImplementations "Uses repository abstractions"
        repositoryImplementations -> database "Reads and writes" "Entity Framework Core"

        // External System relationships
        paymentGatewayAdapter -> paymentGateway "Sends the payment order" "HTTPS/JSON"
        paymentGateway -> paymentWebhookController "Confirms or rejects the payment" "HTTPS/JSON"
        eventHandlers -> resourceAssetManagement "Publishes SubscriptionActivatedEvent" "Integration Event"
        expirationScheduler -> operationalContexts "Publishes SubscriptionExpiredEvent" "Integration Event"
    }

    views {
        component restApi "SubscriptionsRestApiComponents" "Component diagram for the REST API container - Subscriptions and Payments" {
            include *
            autoLayout lr
        }

        component webApplication "SubscriptionsWebComponents" "Component diagram for the Web Application container - Subscriptions and Payments" {
            include *
            autoLayout lr
        }

        component mobileApplication "SubscriptionsMobileComponents" "Component diagram for the Mobile Application container - Subscriptions and Payments" {
            include *
            autoLayout lr
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
        }
    }
}
