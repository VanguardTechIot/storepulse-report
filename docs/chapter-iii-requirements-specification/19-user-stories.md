# Capítulo III: Requirements Specification

## 3.1. User Stories

Las siguientes User Stories representan las necesidades funcionales identificadas en el análisis de User Personas (Capítulo II.3.1) y en el proceso de necesidades (Capítulo II.3). Cada historia está redactada en formato Gherkin con criterios de aceptación que permiten validar el cumplimiento de la funcionalidad desde la perspectiva del usuario.

### Segmento: Administrador de Galería Comercial (Benjamín Montenegro)

#### US-01: Recibir Alertas Inmediatas de Intrusiones

**Título:** Como administrador de galería, quiero recibir alertas inmediatas cuando se detecte una intrusión en la galería.

**User Persona:** Benjamín Montenegro (Gallery Administrator)

**Descripción:**
El administrador necesita un mecanismo automatizado que le notifique en tiempo real cuando ocurra un evento de intrusión (Security Incident de tipo Intrusion) en cualquier local o área común de la galería. Esta notificación debe llegar incluso fuera del horario de atención, permitiendo una respuesta rápida.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Intrusion Alerts for Gallery Administrator
  As a Gallery Administrator
  I want to receive immediate notifications about intrusions
  So that I can respond quickly to security threats

  Scenario: Administrator receives intrusion alert outside office hours
    Given a security sensor detects an unauthorized entry in the gallery
    When the intrusion is verified by the system
    Then an emergency alert notification is sent to the administrator's mobile device within 30 seconds
    And the alert includes the location of the intrusion, timestamp and event details
    And the alert persists in the system even if the administrator misses it initially

  Scenario: Administrator views intrusion history
    Given the administrator wants to review past intrusion attempts
    When they access the security events dashboard
    Then they can view a chronological list of all intrusions with location, date, time and status
    And they can filter intrusions by location, date range or resolution status
```

**Value Proposition:** Reduce risk of security breaches and enable proactive response to threats.

---

#### US-02: Centralizar Información de Consumo de Servicios Básicos

**Título:** Como administrador de galería, quiero consultar el consumo de agua y energía de cada local en un único sistema.

**User Persona:** Benjamín Montenegro (Gallery Administrator)

**Descripción:**
El administrador necesita acceso centralizado a los datos de Utility Consumption para todos los locales. En lugar de Excel y documentos físicos, debe poder visualizar consumos por período, comparar tendencias y detectar anomalías de manera ágil.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Centralized Utility Consumption Dashboard
  As a Gallery Administrator
  I want to view all utility consumption data in a single dashboard
  So that I can make informed decisions about billing and detect anomalies

  Scenario: Administrator views consumption for a specific commercial unit
    Given the administrator has access to the utility dashboard
    When they select a specific commercial unit (Commercial Unit)
    Then they can see the consumption history (Consumption History) for water and electricity
    And the data is organized by consumption period (Consumption Period)
    And they can compare current period against previous periods

  Scenario: Administrator detects anomalous consumption
    Given consumption data is displayed for all commercial units
    When the system detects consumption exceeding the baseline consumption (Baseline Consumption) by more than 20%
    Then the unit is highlighted in the dashboard
    And the administrator can access a detailed report of the anomaly
    And they can receive an optional alert notification

  Scenario: Administrator exports consumption data
    Given the administrator wants to share consumption data with inquilinos
    When they select a date range and commercial unit
    Then they can export the data in CSV or PDF format
    And the exported file includes detailed consumption metrics and baseline comparisons
```

**Value Proposition:** Replace manual Excel tracking with real-time data, enabling data-driven billing and anomaly detection.

---

#### US-03: Facturación Respaldada por Datos Verificables

**Título:** Como administrador de galería, quiero generar factura de servicios compartidos basada en consumo real medido.

**User Persona:** Benjamín Montenegro (Gallery Administrator)

**Descripción:**
El administrador necesita que cada Utility Bill esté fundamentado en mediciones reales de los sensores IoT, no en estimaciones. Esto permite reducir conflictos con inquilinos y sustenta cada cobro (Shared Expense) con evidencia tangible.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Data-Driven Utility Billing
  As a Gallery Administrator
  I want to generate utility bills based on actual measured consumption
  So that billing disputes are reduced and charges are defensible

  Scenario: Administrator generates consumption-based bill
    Given a consumption period (Consumption Period) has ended
    When the administrator initiates bill generation for a specific commercial unit
    Then the system calculates the shared expense (Shared Expense) based on actual utility consumption (Utility Consumption)
    And the bill displays a breakdown showing: total consumption, baseline, overage and final amount
    And the bill includes a reference to the meter readings (Utility Meter) supporting the calculation
    And the bill is timestamped and marked as "Data-Verified"

  Scenario: Administrator resolves a billing dispute with supporting data
    Given a tenant questions their billing amount (Billing Dispute)
    When the administrator accesses the bill details
    Then they can display a chart showing the tenant's consumption history vs baseline
    And they can export a detailed report with meter readings and calculations
    And the tenant can verify the data independently using their mobile app
```

**Value Proposition:** Eliminate billing disputes through transparent, data-backed charges.

---

#### US-04: Detección Automatizada de Riesgo de Incendio

**Título:** Como administrador de galería, quiero detectar automáticamente la presencia de humo en locales y áreas comunes.

**User Persona:** Benjamín Montenegro (Gallery Administrator)

**Descripción:**
El administrador necesita que el sistema detecte Fire Risk situaciones (específicamente Smoke Events) de manera automatizada y genere alertas de emergencia (Emergency Alert) inmediatas, reemplazando la falta de detectores de humo en muchos locales.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Automated Fire Risk Detection
  As a Gallery Administrator
  I want to be automatically notified of smoke events in the gallery
  So that I can initiate emergency protocols quickly

  Scenario: System detects smoke and alerts administrator
    Given smoke sensors are installed in commercial units and common areas (Common Area)
    When a smoke event (Smoke Event) is detected
    Then an emergency alert (Emergency Alert) is generated immediately
    And the administrator receives a notification with location and severity level
    And the alert is also sent to designated emergency personnel
    And the event is recorded in the security incident log (Security Incident)

  Scenario: Administrator verifies smoke alert
    Given a smoke alert has been generated
    When the administrator accesses the alert details
    Then they can view the location of the detection (Local Event or Gallery Event)
    And they can see the sensor readings and timestamp
    And they have options to: acknowledge, escalate to emergency services or cancel (if false alarm)
```

**Value Proposition:** Reduce response time to fire emergencies by replacing manual detection with automated alerts.

---

#### US-05: Coordinación Integrada con Personal de Seguridad

**Título:** Como administrador de galería, quiero coordinar con mi equipo de seguridad usando un sistema centralizado.

**User Persona:** Benjamín Montenegro (Gallery Administrator)

**Descripción:**
El administrador necesita comunicar incidentes de seguridad a su personal de seguridad de manera inmediata y coordinada, en lugar de depender de llamadas y WhatsApp informales.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Integrated Security Team Coordination
  As a Gallery Administrator
  I want to send security incident alerts to my security team members
  So that they can respond in a coordinated manner

  Scenario: Administrator assigns security team to incident
    Given a security incident (Security Incident) has been detected
    When the administrator views the incident details
    Then they can select from pre-configured security team members
    And they can assign one or more team members to investigate or respond
    And the assigned team members receive a notification with incident details
    And the administrator can monitor the response status in real-time
```

**Value Proposition:** Replace ad-hoc communication with structured incident management.

---

### Segmento: Inquilino de Local Comercial (Juana Flores)

#### US-06: Recibir Alertas Móviles de Intrusiones en mi Local

**Título:** Como inquilino, quiero recibir notificaciones en mi móvil cuando alguien intente ingresar a mi local fuera del horario.

**User Persona:** Juana Flores (Tenant)

**Descripción:**
La inquilina necesita visibilidad remota sobre la seguridad de su local (Commercial Unit) durante las horas no comerciales. Las notificaciones de intrusión deben llegar a su teléfono móvil de manera inmediata, permitiéndole tomar medidas o informar a la administración.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Real-Time Intrusion Alerts for Tenants
  As a Tenant
  I want to receive mobile notifications when an intrusion is detected at my store
  So that I can respond quickly and protect my merchandise

  Scenario: Tenant receives intrusion alert on mobile device
    Given intrusion detection is active at the tenant's commercial unit
    When an unauthorized entry is detected (Intrusion)
    Then the tenant receives a push notification on their mobile device within 30 seconds
    And the notification includes: location (Commercial Unit), time, and severity
    And the notification persists until the tenant acknowledges it
    And the tenant can take actions: view location on map, contact administrator or call emergency

  Scenario: Tenant views intrusion incident details
    Given the tenant has received an intrusion alert
    When they tap on the notification or access their security history
    Then they can view the incident status: ongoing, resolved or false alarm
    And they can see timestamps and any comments from the administrator
    And they can take actions: mark as resolved or request administrator investigation
```

**Value Proposition:** Provide peace of mind by enabling remote monitoring of store security.

---

#### US-07: Visualizar Desglose de Consumo de Servicios Básicos

**Título:** Como inquilino, quiero ver exactamente cuánta agua y energía consumí este período.

**User Persona:** Juana Flores (Tenant)

**Descripción:**
La inquilina necesita transparencia sobre su Utility Consumption real. En lugar de recibir un monto facturado sin justificación, debe poder visualizar en su móvil cuánto consumió (en kWh, m³, etc.) y cómo se calculó su cuota correspondiente.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Transparent Utility Consumption Visibility for Tenants
  As a Tenant
  I want to view my actual consumption for each utility in real-time
  So that I can understand and verify my charges

  Scenario: Tenant views current consumption
    Given the tenant opens the mobile app
    When they navigate to the consumption section
    Then they can see their current period consumption for water and electricity
    And the data displays: total consumption, consumption period (dates), and comparison to previous period
    And they can visualize consumption trends in a simple chart or graph

  Scenario: Tenant reviews monthly billing breakdown
    Given a new billing period (Consumption Period) has been generated
    When the tenant accesses their bill (Utility Bill)
    Then they can see: individual utility meters (Utility Meter) readings
    And they can see their proportional share of shared expenses (Shared Expense)
    And they can see the calculation: (My consumption / Total consumption) × Total cost
    And all numbers are linked to actual meter readings as proof

  Scenario: Tenant challenges a billing amount
    Given the tenant believes their bill is incorrect (Billing Dispute)
    When they initiate a dispute claim in the app
    Then they can include evidence: compare their consumption to baseline consumption (Baseline Consumption)
    And they can request administrator review with consumption details
    And they receive acknowledgment and estimated resolution time
```

**Value Proposition:** Replace distrust with transparency, reducing billing disputes.

---

#### US-08: Reportar Incidentes de Seguridad Directamente desde la App

**Título:** Como inquilino, quiero reportar un incidente de seguridad o daño a mi local directamente por la aplicación.

**User Persona:** Juana Flores (Tenant)

**Descripción:**
La inquilina necesita un canal de comunicación directo para reportar Security Incidents, roturas, daños o situaciones anormales sin depender de WhatsApp o llamadas. El reporte debe documentarse automáticamente en el sistema.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: In-App Security Incident Reporting
  As a Tenant
  I want to report security incidents or property damage through the mobile app
  So that my report is documented and tracked

  Scenario: Tenant reports an unauthorized entry attempt
    Given the tenant has observed or been notified of an intrusion attempt
    When they access the app and select "Report Incident"
    Then they can choose the incident type: Intrusion, Smoke/Fire, Property Damage or Other
    And they can provide details: description, location within their unit, photos/evidence
    And they can attach up to 5 photos as evidence
    And the report is immediately sent to the gallery administrator
    And they receive a confirmation number and estimated response time

  Scenario: Tenant tracks incident resolution
    Given the tenant has filed an incident report (Security Incident)
    When they return to the app
    Then they can view the status: Pending, In Investigation, Resolved or Closed
    And they can see any comments or updates from the administrator
    And they receive notifications when the status changes
```

**Value Proposition:** Ensure incident documentation and improve response tracking.

---

#### US-09: Recibir Alertas de Emergencia (Humo/Incendio)

**Título:** Como inquilino, quiero ser notificado inmediatamente si hay detección de humo o riesgo de incendio en mi local.

**User Persona:** Juana Flores (Tenant)

**Descripción:**
La inquilina necesita protección contra Fire Risks. Aunque ella no instalará sensores en su local, StorePulse debe integrar detectores de humo a nivel de galería y notificarla de cualquier Smoke Event que afecte o se localice cerca de su área.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Fire Emergency Alerts for Tenants
  As a Tenant
  I want to receive immediate alerts if smoke or fire is detected near my store
  So that I can evacuate or take protective measures

  Scenario: System detects smoke and alerts affected tenants
    Given smoke sensors are monitoring the gallery (Common Area and Commercial Unit areas)
    When a smoke event (Smoke Event) is detected near the tenant's unit
    Then the tenant receives an urgent push notification
    And the notification includes: severity level, location and recommended action (evacuate or monitor)
    And the alert is delivered within 10 seconds of detection
    And the alert cannot be dismissed until acknowledged by the tenant

  Scenario: Tenant receives all-clear notification after fire event
    Given a fire alert was triggered at the tenant's location
    When the administrator or emergency services determines the threat is over
    Then the tenant receives a follow-up notification: "All Clear - Fire Risk Resolved"
    And they can access a summary of what triggered the alert and response taken
```

**Value Proposition:** Provide safety assurance and reduce fear of undetected fires.

---

### Segmento: Ambos (Administrador e Inquilino)

#### US-10: Comunicación Eficiente Entre Administrador e Inquilino

**Título:** Como administrador/inquilino, quiero comunicarme directamente dentro de la plataforma para resolver dudas y reclamos.

**User Persona:** Benjamín Montenegro & Juana Flores

**Descripción:**
Ambos segmentos necesitan reemplazar WhatsApp (calificado por 100% de inquilinos como "ineficiente") con un canal de comunicación integrado que centralice conversaciones sobre billing, incidents y maintenance.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Integrated Messaging Between Administrator and Tenants
  As a Gallery Administrator or Tenant
  I want to communicate through the platform about billing and incidents
  So that all conversations are documented and accessible

  Scenario: Tenant initiates conversation about billing
    Given the tenant has a question about their billing (Billing Dispute or Utility Bill)
    When they access the messaging section and create a new message to the administrator
    Then they can attach relevant documents (previous bill, consumption comparison)
    And they can assign priority: Low, Medium or High
    And the administrator receives a notification with the message details
    And the conversation history is maintained and searchable

  Scenario: Administrator responds to tenant inquiry
    Given the administrator has received a message from a tenant
    When they access the messaging inbox
    Then they can view all open conversations grouped by tenant or category
    And they can respond with explanations, supporting data or proposed solutions
    And the tenant is notified of the response
    And both parties can continue the conversation until resolution
```

**Value Proposition:** Replace fragmented WhatsApp conversations with organized, documented communication.

---

#### US-11: Histórico de Eventos y Consumo Disponible Offline

**Título:** Como usuario, quiero poder consultar mi histórico de eventos y consumo incluso si pierdo conexión temporal a Internet.

**User Persona:** Benjamín Montenegro & Juana Flores

**Descripción:**
Ambos segmentos requieren que el sistema continúe registrando y almacenando datos localmente cuando hay pérdida de conectividad, asegurando que no se pierda información crítica de incidentes o consumo.

**Criterios de Aceptación (Gherkin):**

```gherkin
Feature: Offline Availability of History and Consumption Data
  As a Gallery Administrator or Tenant
  I want to access my event history and consumption data even with temporary Internet loss
  So that I don't lose critical information

  Scenario: User accesses history during offline mode
    Given the user has previously synced data to their device
    When they lose Internet connection
    Then they can still view consumption history (Consumption History), event logs and past incidents
    And the data displayed is marked as "Last updated: [timestamp]"
    And the user cannot make changes while offline (read-only mode)

  Scenario: Data syncs automatically when connection is restored
    Given the user regains Internet connection
    When the app reconnects to the server
    Then all local data is automatically synced
    And any new events from the server are merged with local records
    And a notification confirms: "Sync successful - all data is current"
    And the user can resume normal operations (creation/modification of records)
```

**Value Proposition:** Ensure business continuity and prevent loss of critical security or consumption records.

---

## Summary of User Stories

| # | User Persona | Feature | Priority | Complexity |
|---|---|---|---|---|
| US-01 | Administrador | Intrusion Alerts | Critical | Medium |
| US-02 | Administrador | Consumption Dashboard | Critical | High |
| US-03 | Administrador | Data-Driven Billing | Critical | High |
| US-04 | Administrador | Smoke Detection Alerts | Critical | Medium |
| US-05 | Administrador | Security Team Coordination | High | Medium |
| US-06 | Inquilino | Intrusion Alerts (Mobile) | Critical | Low |
| US-07 | Inquilino | Consumption Visibility | Critical | Medium |
| US-08 | Inquilino | Incident Reporting | High | Medium |
| US-09 | Inquilino | Fire Alerts | Critical | Low |
| US-10 | Ambos | In-Platform Messaging | High | High |
| US-11 | Ambos | Offline Data Access | Medium | High |
