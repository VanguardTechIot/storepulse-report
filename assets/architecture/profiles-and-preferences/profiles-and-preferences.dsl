workspace "StorePulse - Profiles and Preferences" "Component diagrams for the Profiles and Preferences Bounded Context" {

    model {
        galleryAdministrator = person "Gallery Administrator" "Manages their profile and decides which alerts they receive."
        tenant = person "Tenant" "Manages their profile and notification preferences from the mobile application."

        imageStorage = softwareSystem "Image Storage Service" "Stores profile photos and returns the generated URL." "External System"
        identityAccess = softwareSystem "Identity and Access Management" "Publishes the user registration event that triggers profile creation." "External System"
        safetyEmergencies = softwareSystem "Safety and Emergencies" "Consumes preference changes to update alert routing." "External System"

        storePulse = softwareSystem "StorePulse" "IoT solution for security monitoring, utility consumption and billing in commercial galleries." {

            webApplication = container "Web Application" "Used by the Gallery Administrator and the Tenant to manage their profile and preferences." "Angular" {
                profilesWebUi = component "Profiles UI" "Displays the profile editor, the language selector and the notification settings." "Angular"
                profilesWebService = component "Profiles Service" "Consumes the profile and notification preference REST endpoints." "Angular Service"
            }

            mobileApplication = container "Mobile Application" "Used by the Tenant to manage their profile and preferences on the go." "Flutter, Dart" {
                profilesMobileUi = component "Profiles UI" "Displays the profile editor and the notification settings." "Flutter, Dart"
                profilesMobileService = component "Profiles Service" "Consumes the profile and notification preference REST endpoints." "Dart"
                photoPickerAdapter = component "Photo Picker Adapter" "Accesses the device gallery to select the profile photo." "Flutter Plugin"
            }

            restApi = container "REST API" "Monolithic API that centralizes StorePulse business logic." "ASP.NET Core, .NET" {
                userProfilesController = component "UserProfilesController" "Exposes the profile query, update, photo upload and language change endpoints." "ASP.NET Core Controller"
                notificationPreferencesController = component "NotificationPreferencesController" "Exposes the notification preference query, update and channel disable endpoints." "ASP.NET Core Controller"
                userRegisteredEventConsumer = component "UserRegisteredEventConsumer" "Receives the user registration event published by Identity and Access Management." "ASP.NET Core"
                commandHandlers = component "Command Handlers" "Orchestrates profile creation and update, photo upload, language change and preference configuration." "Application Layer"
                queryHandlers = component "Query Handlers" "Resolves the Profile Settings, Language Options and Notification Settings read models." "Application Layer"
                eventHandlers = component "Event Handlers" "Creates the profile on user registration and publishes preference changes to Safety and Emergencies." "Application Layer"
                profilesDomain = component "Profiles and Preferences Domain" "Contains the UserProfile and NotificationPreferences aggregates and domain rules." "Domain Layer"
                profilesFacade = component "ProfilesAndPreferencesFacade" "Anti-Corruption Layer that exposes the preferred language and enabled channels to other Bounded Contexts." "Application Layer"
                repositoryImplementations = component "Repository Implementations" "Implements domain repository abstractions using Entity Framework Core." "Infrastructure Layer"
                imageStorageAdapter = component "ImageStorageServiceAdapter" "Sends the profile photo to the external storage service and retrieves its URL." "Infrastructure Layer"
            }

            database = container "Database" "Stores user profiles, notification preferences and channels." "MySQL"
        }

        // Web Application relationships
        galleryAdministrator -> webApplication "Uses"
        tenant -> webApplication "Uses"
        profilesWebUi -> profilesWebService "Uses"
        profilesWebService -> restApi "Consumes profile and preference services" "HTTPS/JSON"

        // Mobile Application relationships
        tenant -> mobileApplication "Uses"
        profilesMobileUi -> profilesMobileService "Uses"
        profilesMobileUi -> photoPickerAdapter "Selects photo through"
        profilesMobileService -> restApi "Consumes profile and preference services" "HTTPS/JSON"

        // REST API internal relationships
        userProfilesController -> commandHandlers "Invokes"
        userProfilesController -> queryHandlers "Invokes"
        notificationPreferencesController -> commandHandlers "Invokes"
        notificationPreferencesController -> queryHandlers "Invokes"
        userRegisteredEventConsumer -> eventHandlers "Delegates"
        commandHandlers -> profilesDomain "Executes domain operations"
        queryHandlers -> profilesDomain "Queries domain data"
        eventHandlers -> profilesDomain "Creates and updates aggregates"
        commandHandlers -> imageStorageAdapter "Uploads photo through"
        profilesFacade -> profilesDomain "Queries language and channels"
        profilesDomain -> repositoryImplementations "Uses repository abstractions"
        repositoryImplementations -> database "Reads and writes" "Entity Framework Core"

        // External System relationships
        identityAccess -> userRegisteredEventConsumer "Publishes UserRegisteredEvent" "Integration Event"
        imageStorageAdapter -> imageStorage "Sends the profile photo" "HTTPS/JSON"
        eventHandlers -> safetyEmergencies "Publishes NotificationPreferencesSetEvent" "Integration Event"
    }

    views {
        component restApi "ProfilesRestApiComponents" "Component diagram for the REST API container - Profiles and Preferences" {
            include *
            autoLayout lr
        }

        component webApplication "ProfilesWebComponents" "Component diagram for the Web Application container - Profiles and Preferences" {
            include *
            autoLayout lr
        }

        component mobileApplication "ProfilesMobileComponents" "Component diagram for the Mobile Application container - Profiles and Preferences" {
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
