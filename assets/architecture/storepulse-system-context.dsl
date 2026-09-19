workspace "System Context View: StorePulse Platform" {
    model {
        visitor = person "Visitor" "Anonymous user who browses the public website and learns about StorePulse." "Visitor"
        galleryAdmin = person "Gallery Administrator" "Manages the commercial gallery, monitors incidents, manages tenants and devices, and supervises water and electricity consumption."
        tenant = person "Tenant" "Monitors the security and consumption of their own commercial premises and receives relevant alerts."

        platform = softwareSystem "StorePulse Platform" "IoT-based platform for security monitoring, incident detection, and individual water and electricity consumption management in commercial galleries."
        hardware = softwareSystem "StorePulse Hardware" "IoT devices installed in commercial premises to detect security events and smoke and to measure water and electricity consumption." "External,Hardware"
        stripe = softwareSystem "Stripe" "External payment platform used to process StorePulse subscription payments." "External"

        visitor -> platform "Browses public content and learns about the platform"
        visitor -> tenant "Registers as a tenant after administrator invitation"
        visitor -> galleryAdmin "Registers as a gallery administrator"

        galleryAdmin -> platform "Manages the gallery, tenants, devices, incidents and consumption"

        tenant -> platform "Monitors their premises, receives alerts, and reviews water and electricity consumption"

        platform -> hardware "Receives sensor events, consumption readings, and device status"
        platform -> stripe "Processes and verifies subscription payments"
    }

    views {
        systemContext platform "SystemContext" {
            include *
            autolayout lr
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }

            element "Visitor" {
                background #999999
                color #ffffff
            }

            element "External" {
                background #999999
                color #ffffff
            }

            element "Hardware" {
                background #6c757d
                color #ffffff
            }
        }
    }
}