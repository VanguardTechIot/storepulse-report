workspace "StorePulse - Analytics" "Component diagrams for the Analytics Bounded Context" {

    model {
        galleryAdministrator = person "Gallery Administrator" "Supervises the premises and reviews the consolidated dashboard."
        tenant = person "Tenant" "Monitors their own premises through the local dashboard and notifications."

        utilityMeter = softwareSystem "Utility Meter (IoT)" "Captures water and electricity readings." "External System"
        sedapal = softwareSystem "Sedapal" "Confirms water consumption for the billing period." "External System"
        luzDelSur = softwareSystem "Luz del Sur" "Confirms electricity consumption for the billing period." "External System"
        fcm = softwareSystem "Firebase Cloud Messaging" "Delivers push notifications to the Web and Mobile Applications." "External System"

        storePulse = softwareSystem "StorePulse" "IoT solution for security monitoring, utility consumption and billing in commercial galleries." {

            webApplication = container "Web Application" "Used by the Gallery Administrator to review the consolidated dashboard and notifications." "Angular" {
                analyticsWebUi = component "Analytics UI" "Displays the Consolidated Dashboard and the Notification Center." "Angular"
                analyticsWebService = component "Analytics Service" "Consumes the dashboard and notification REST endpoints." "Angular Service"
            }

            mobileApplication = container "Mobile Application" "Used by the Tenant to review their local dashboard and notifications." "Flutter, Dart" {
                analyticsMobileUi = component "Analytics UI" "Displays the Local Dashboard and the Notification Center." "Flutter, Dart"
                analyticsMobileService = component "Analytics Service" "Consumes the dashboard and notification REST endpoints." "Dart"
            }

            restApi = container "REST API" "Monolithic API that centralizes StorePulse business logic." "ASP.NET Core, .NET" {
                notificationsController = component "NotificationsController" "Exposes the Notification Center endpoint." "ASP.NET Core Controller"
                dashboardController = component "DashboardController" "Exposes the Consolidated Dashboard and the Local Dashboard endpoints." "ASP.NET Core Controller"
                queryHandlers = component "Query Handlers" "Resolves notification and dashboard queries." "Application Layer"
                eventHandlers = component "Event Handlers" "Reacts to critical events from other Bounded Contexts and to utility readings to build Notification and ConsumptionRegistration." "Application Layer"
                analyticsDomain = component "Analytics Domain" "Contains the Notification and ConsumptionRegistration aggregates and domain rules." "Domain Layer"
                repositoryImplementations = component "Repository Implementations" "Implements domain repository abstractions using Entity Framework Core." "Infrastructure Layer"
            }

            database = container "Database" "Stores notifications and consumption registrations." "MySQL"
        }

        // Web Application relationships
        galleryAdministrator -> webApplication "Uses"
        analyticsWebUi -> analyticsWebService "Uses"
        analyticsWebService -> restApi "Consumes notification and dashboard services" "HTTPS/JSON"

        // Mobile Application relationships
        tenant -> mobileApplication "Uses"
        analyticsMobileUi -> analyticsMobileService "Uses"
        analyticsMobileService -> restApi "Consumes notification and dashboard services" "HTTPS/JSON"

        // REST API internal relationships
        notificationsController -> queryHandlers "Invokes"
        dashboardController -> queryHandlers "Invokes"
        queryHandlers -> analyticsDomain "Queries domain data"
        eventHandlers -> analyticsDomain "Executes domain operations"
        analyticsDomain -> repositoryImplementations "Uses repository abstractions"
        repositoryImplementations -> database "Reads and writes" "Entity Framework Core"

        // External System relationships
        utilityMeter -> eventHandlers "Sends utility meter reading" "HTTPS/JSON"
        sedapal -> eventHandlers "Confirms water consumption for the period" "HTTPS/JSON"
        luzDelSur -> eventHandlers "Confirms electricity consumption for the period" "HTTPS/JSON"
        eventHandlers -> fcm "Sends push notification" "HTTPS"
    }

    views {
        component restApi "AnalyticsRestApiComponents" "Component diagram for the REST API container - Analytics" {
            include *
            autoLayout lr
        }

        component webApplication "AnalyticsWebComponents" "Component diagram for the Web Application container - Analytics" {
            include *
            autoLayout lr
        }

        component mobileApplication "AnalyticsMobileComponents" "Component diagram for the Mobile Application container - Analytics" {
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
