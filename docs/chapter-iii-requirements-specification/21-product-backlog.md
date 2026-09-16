# Capítulo III: Requirements Specification

## 3.3. Product Backlog

El Product Backlog consolida todas las User Stories priorizadas según su valor de negocio, urgencia e impacto en los objetivos del proyecto. Se utilizan Story Points para estimar la complejidad relativa de cada trabajo.

### Metodología de Estimación

**Story Points:** Sistema de Fibonacci (1, 2, 3, 5, 8, 13) que representa la complejidad relativa y esfuerzo de implementación.

**Criterios de Priorización:**
1. **Criticidad:** Impacto directo en la solución del pain point identificado
2. **Viabilidad Técnica:** Dependencias, complejidad de integración IoT/sensores
3. **Valor de Negocio:** Capacidad de diferenciación y generación de ROI
4. **Urgencia:** Necesidad expresada durante las entrevistas

**Escala de Prioridad:**
- **P0 (Critical):** Bloqueante para MVP; sin estas no hay propuesta de valor
- **P1 (High):** Diferenciador importante; esencial para adoption de ambos segmentos
- **P2 (Medium):** Mejora de experiencia; suma valor pero no es bloqueante

---

## Product Backlog Ordenado por Prioridad

| Rank | US # | Título | Segmento | Prioridad | Story Points | Dependencias | Estado |
|------|------|--------|----------|-----------|--------------|--------------|--------|
| 1 | US-01 | Recibir Alertas Inmediatas de Intrusiones | Administrador | P0 | 5 | Sensores IoT, Notificaciones Push | Backlog |
| 2 | US-04 | Detección Automatizada de Riesgo de Incendio | Administrador | P0 | 5 | Sensores de Humo, Notificaciones Push | Backlog |
| 3 | US-06 | Recibir Alertas Móviles de Intrusiones en mi Local | Inquilino | P0 | 3 | US-01, Notificaciones Push | Backlog |
| 4 | US-09 | Recibir Alertas de Emergencia (Humo/Incendio) | Inquilino | P0 | 3 | US-04, Notificaciones Push | Backlog |
| 5 | US-02 | Centralizar Información de Consumo de Servicios Básicos | Administrador | P0 | 8 | Sensores de Utilidades, Base de Datos | Backlog |
| 6 | US-03 | Facturación Respaldada por Datos Verificables | Administrador | P0 | 8 | US-02, Engine de Cálculos | Backlog |
| 7 | US-07 | Visualizar Desglose de Consumo de Servicios Básicos | Inquilino | P0 | 5 | US-02, Interfaz Móvil | Backlog |
| 8 | US-05 | Coordinación Integrada con Personal de Seguridad | Administrador | P1 | 5 | US-01, US-04, Sistema de Asignación | Backlog |
| 9 | US-08 | Reportar Incidentes de Seguridad Directamente desde la App | Inquilino | P1 | 5 | Backend de Incidentes, Móvil | Backlog |
| 10 | US-10 | Comunicación Eficiente Entre Administrador e Inquilino | Ambos | P1 | 8 | Mensajería Backend, Notificaciones | Backlog |
| 11 | US-11 | Histórico de Eventos y Consumo Disponible Offline | Ambos | P2 | 8 | Sincronización, Almacenamiento Local | Backlog |

---

## Detalles por Epic

### Epic 1: Real-Time Security Monitoring (US-01, US-04, US-06, US-09)

**Descripción:** Implementar un sistema integral de detección de incidentes de seguridad (intrusiones y fuego) con alertas automáticas en tiempo real a administradores e inquilinos.

**Objetivos:**
- Reducir detección tardía de incidentes de 100% (estado actual) a <5 minutos
- Proporcionar visibilidad remota 24/7 a administradores e inquilinos
- Cumplir con SLA de notificación <30 segundos

**Componentes Técnicos Requeridos:**
- Sensores de intrusión (puertas/ventanas)
- Sensores de humo/fuego
- Sistema de gestión de alertas
- Gateway IoT con soporte offline
- Notificaciones push móviles

**Estimación Total:** 16 Story Points

**Tiempo Estimado:** 4 sprints (de 2 semanas c/u)

---

### Epic 2: Utility Consumption & Billing Transparency (US-02, US-03, US-07)

**Descripción:** Centralizar la recolección, visualización y facturación de consumo de servicios básicos (agua y energía) con transparencia total de datos.

**Objetivos:**
- Eliminar dependencia de Excel/documentos físicos
- Reducir billing disputes en 80% mediante visibilidad de datos
- Generar facturas data-verified en <5 minutos

**Componentes Técnicos Requeridos:**
- Sensores inteligentes de utilidades (medidores IoT)
- Base de datos centralizada de consumo
- Engine de cálculo de prorrateo
- Dashboard de administrador
- App móvil para inquilinos
- Módulo de facturación automática

**Estimación Total:** 21 Story Points

**Tiempo Estimado:** 5 sprints (de 2 semanas c/u)

---

### Epic 3: Communication & Coordination (US-05, US-08, US-10)

**Descripción:** Implementar canales de comunicación integrados para resolver incidentes y billing disputes sin depender de WhatsApp.

**Objetivos:**
- Reemplazar 100% de comunicación WhatsApp con plataforma centralizada
- Documentar automáticamente todas las interacciones
- Reducir tiempo de resolución de reclamos en 50%

**Componentes Técnicos Requeridos:**
- Sistema de mensajería push
- Backend de conversaciones
- Notificaciones contextuales
- Sistema de asignación de tareas
- Formularios de reporte de incidentes

**Estimación Total:** 18 Story Points

**Tiempo Estimado:** 4 sprints (de 2 semanas c/u)

---

### Epic 4: Offline Resilience & Data Integrity (US-11)

**Descripción:** Garantizar que los datos de incidentes y consumo se registren y persistan incluso durante pérdidas de conectividad.

**Objetivos:**
- Soporte para operación offline de hasta 48 horas
- Sincronización automática sin pérdida de datos
- Mantener registros verificables incluso offline

**Componentes Técnicos Requeridos:**
- Almacenamiento local en dispositivos
- Sistema de sincronización robusta
- Caché inteligente
- Logs de auditoría local

**Estimación Total:** 8 Story Points

**Tiempo Estimado:** 2 sprints (de 2 semanas c/u)

---

## Release Planning

### MVP (Minimum Viable Product) - Release 1.0
**Fecha Objetivo:** Mes 4 del proyecto
**Story Points Total:** 45/63 (71%)

**Historias Incluidas:**
- US-01: Intrusion Alerts (5 SP)
- US-04: Fire Detection Alerts (5 SP)
- US-06: Tenant Intrusion Alerts (3 SP)
- US-09: Tenant Fire Alerts (3 SP)
- US-02: Consumption Dashboard (8 SP)
- US-03: Data-Driven Billing (8 SP)
- US-07: Tenant Consumption Visibility (5 SP)

**Justificación:** Estas historias abordan los pain points críticos identificados en las entrevistas para ambos segmentos. El MVP demuestra viabilidad técnica de los sensores IoT, notificaciones push y centralización de datos.

---

### Release 2.0 - Enhanced Communication & Coordination
**Fecha Objetivo:** Mes 7 del proyecto
**Story Points Total:** 18/63

**Historias Incluidas:**
- US-05: Security Team Coordination (5 SP)
- US-08: Tenant Incident Reporting (5 SP)
- US-10: In-Platform Messaging (8 SP)

**Justificación:** Una vez validado el MVP, agregar canales de comunicación mejora significativamente la experiencia de usuario y reduce dependencia de WhatsApp, esperando reducir reclamos en 50%.

---

### Release 3.0 - Offline Resilience & Advanced Features
**Fecha Objetivo:** Mes 10 del proyecto
**Story Points Total:** 8/63

**Historias Incluidas:**
- US-11: Offline Data Access (8 SP)

**Justificación:** Mejora la confiabilidad operacional y asegura continuidad durante interrupciones de red, crítico para la adopción en galerías con conectividad variable.

---

## Criterios de Aceptación del Backlog

Cada ítem en el backlog debe cumplir con:

1. **User Story Well-Formed:** Incluye formato "Como [rol], quiero [acción], para [beneficio]"
2. **Gherkin Scenarios:** Al menos 2 escenarios de aceptación en formato Gherkin
3. **Estimación Consensuada:** Story points asignados y validados por el equipo técnico
4. **Dependencias Identificadas:** Relaciones claramente mapeadas
5. **Value Clear:** Vinculado a pain points identificados en entrevistas

---

## Notas sobre Story Points

### Distribución de Complejidad

**Story Points 3:** Narrativas simples, lógica directa, bajo riesgo técnico
- US-06, US-09: Notificaciones push a inquilinos (reutilizan infraestructura de alertas)

**Story Points 5:** Narrativas con lógica condicional, requisitos medianos, riesgo técnico bajo-medio
- US-01, US-04, US-05, US-08: Detección, alertas, coordinación, reportes

**Story Points 8:** Narrativas complejas, lógica de negocio significativa, riesgo técnico medio-alto
- US-02, US-03, US-10, US-11: Dashboards, facturación, mensajería, offline

### Referencia de Complejidad

| Story Points | Ejemplo | Tiempo (1 Dev) |
|---|---|---|
| 1 | Cambio de interfaz simple | 2-3 horas |
| 2 | Validación de formulario | 4-6 horas |
| 3 | Notificación simple con lógica | 1 día |
| 5 | Módulo integrado (sensor + alerta) | 2-3 días |
| 8 | Dashboard con múltiples vistas + cálculos | 4-5 días |
| 13 | Módulo completo con integraciones | 1-2 semanas |

---

## Gestión del Backlog

### Refinamiento Iterativo
- Cada 2 semanas: revisión de prioridades con stakeholders
- Cada sprint: detalle de historias a implementar
- Feedback post-MVP: ajuste de estimaciones y prioridades

### Métricas de Éxito del Backlog

1. **Velocity:** Story Points completados por sprint (meta: 13-16 SP/sprint)
2. **Quality:** % de historias que cumplen todos los criterios de aceptación (meta: >95%)
3. **Adoption:** % de usuarios activos en cada release (meta: >80% en MVP)
4. **Incident Response:** Reducción en tiempo medio de detección de incidentes (meta: <5 min)
5. **Billing Accuracy:** Reducción en billing disputes (meta: 80% menos)

---

## Versionado del Product Backlog

- **Versión:** 1.0
- **Fecha de Creación:** 2026-09-15
- **Última Actualización:** 2026-09-15
- **Propietario:** Equipo de Producto (StorePulse)
- **Responsable de Refinamiento:** Product Owner + Tech Lead
