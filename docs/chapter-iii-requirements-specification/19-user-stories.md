# Capítulo III: Requirements Specification

## 3.1. User Stories
[comment]: <> (USER STORIES EN GENERAL)

## **Tabla 1**  
### **HU01: Panel Centralizado de la Galería**

| Campo | Detalle |
|---|---|
| **Épica** | Centralización y Vista General de la Galería |
| **ID-HU** | HU01 |
| **Título HU** | Panel Centralizado de la Galería |
| **Descripción HU** | Como `Gallery Administrator`, quiero visualizar un panel consolidado que muestre todas las `Commercial Units` y `Common Areas` dentro de la `Commercial Gallery` en una sola interfaz, para monitorear el estado general sin tener que hacer recorridos presenciales ni revisar múltiples archivos de Excel. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Visualizar el resumen operativo de la Galería Comercial**<br>Dado que el Gallery Administrator "Miguel Vargas" ha iniciado sesión en StorePulse,<br>Cuando navega al panel "Commercial Gallery Overview",<br>Entonces debe ver un resumen visual del estado de todas las Commercial Units registradas (ocupación, alertas activas y estado de servicios),<br>Y debe ver el estado de todas las Common Areas en una sola vista.<br><br>**Escenario 2: Filtrar locales por estado operativo**<br>Dado que el Gallery Administrator se encuentra en el panel de la Commercial Gallery,<br>Cuando filtra por "Alertas Activas",<br>Entonces el sistema muestra únicamente las Commercial Units que tienen Security Incidents activos o anomalías en el Utility Consumption. |

---
## **Tabla 2**  
### **HU02: Gestión de Locales Comerciales e Inquilinos**

| Campo | Detalle |
|---|---|
| **Épica** | Centralización y Vista General de la Galería |
| **ID-HU** | HU02 |
| **Título HU** | Gestión de Locales Comerciales e Inquilinos |
| **Descripción HU** | Como `Gallery Administrator`, quiero acceder y actualizar los detalles de cada `Commercial Unit` y su `Tenant` asignado, para mantener registros operativos y de contacto centralizados en lugar de usar WhatsApp y carpetas físicas. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Acceder a los detalles de una Commercial Unit y al registro del Tenant**<br>Dado que el Gallery Administrator está viendo la cuadrícula de la Commercial Gallery,<br>Cuando selecciona una Commercial Unit específica,<br>Entonces el sistema muestra los detalles técnicos del local, los Utility Meters activos y la información de contacto del Tenant,<br>Y muestra el historial de Security Incidents o Utility Bills asociados a ese local. |

---
## **Tabla 3**  
### **HU03: Alertas de Emergencia en Tiempo Real para Eventos de Humo y Riesgo de Incendio**

| Campo | Detalle |
|---|---|
| **Épica** | Seguridad de la Propiedad y Alertas de Emergencia |
| **ID-HU** | HU03 |
| **Título HU** | Alertas de Emergencia en Tiempo Real para Eventos de Humo y Riesgo de Incendio |
| **Descripción HU** | Como `Gallery Administrator`, quiero recibir `Emergency Alerts` inmediatas en mi smartphone cuando se detecte un `Smoke Event` o un `Fire Risk`, para tomar acciones rápidas que protejan la `Property Security`, incluso cuando esté trabajando de forma remota. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Disparo de una Emergency Alert al detectar un Smoke Event**<br>Dado que existe un sensor de humo IoT activo en una Commercial Unit o Common Area,<br>Cuando el sensor detecta humo que supera el umbral de seguridad,<br>Entonces el sistema genera una Emergency Alert y envía una notificación push al dispositivo móvil del Gallery Administrator en menos de 3 segundos,<br>Y los detalles de la alerta especifican la ubicación del local, el tipo de evento y la hora exacta. |

---
## **Tabla 4**  
### **HU04: Detección de Intrusión y Acceso No Autorizado**

| Campo | Detalle |
|---|---|
| **Épica** | Seguridad de la Propiedad y Alertas de Emergencia |
| **ID-HU** | HU04 |
| **Título HU** | Detección de Intrusión y Acceso No Autorizado |
| **Descripción HU** | Como `Gallery Administrator`, quiero recibir una notificación de `Local Event` cuando ocurra una `Intrusion` en una `Commercial Unit` fuera del horario de atención autorizado, para verificar posibles brechas de seguridad en tiempo real. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Detección de un evento de Intrusion fuera del horario de atención**<br>Dado que el estado de seguridad de la Commercial Gallery está configurado en "Armado / Cerrado",<br>Cuando se detecta un ingreso no autorizado en una Commercial Unit,<br>Entonces el sistema registra un Security Incident clasificado como Intrusion,<br>Y envía una notificación de Emergency Alert al Gallery Administrator. |

---
## **Tabla 5**  
### **HU05: Verificación de Incidentes de Seguridad y Seguimiento de Estado**

| Campo | Detalle |
|---|---|
| **Épica** | Seguridad de la Propiedad y Alertas de Emergencia |
| **ID-HU** | HU05 |
| **Título HU** | Verificación de Incidentes de Seguridad y Seguimiento de Estado |
| **Descripción HU** | Como `Gallery Administrator`, quiero actualizar el estado de un `Security Incident` durante el proceso de `Incident Verification`, para mantener un registro de auditoría claro entre emergencias confirmadas y falsas alarmas. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Verificación del estado de un Security Incident**<br>Dado que se ha generado una Emergency Alert en el sistema,<br>Cuando el Gallery Administrator revisa los detalles del incidente y actualiza el estado a "Verificado - Acción Tomada" o "Falsa Alarma",<br>Entonces el sistema actualiza el registro de Incident Verification con las notas del administrador y la hora de respuesta. |

---
## **Tabla 6**  
### **HU06: Monitoreo en Tiempo Real del Consumo de Servicios**

| Campo | Detalle |
|---|---|
| **Épica** | Consumo de Servicios Públicos y Gastos Compartidos |
| **ID-HU** | HU06 |
| **Título HU** | Monitoreo en Tiempo Real del Consumo de Servicios |
| **Descripción HU** | Como `Gallery Administrator`, quiero monitorear las lecturas en vivo de cada `Utility Meter` de agua y electricidad en las `Commercial Units`, para detectar picos anormales o fugas antes de que generen costos elevados. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Detección de Utility Consumption anormal en tiempo real**<br>Dado que los IoT Utility Meters reportan continuamente el consumo de agua de una Commercial Unit,<br>Cuando el flujo de agua excede el umbral máximo esperado durante 30 minutos consecutivos,<br>Entonces el sistema genera una alerta de anomalía de Utility Consumption en el panel del Gallery Administrator. |

---
## **Tabla 7**  
### **HU07: Comparación de Consumo Histórico y Consumo Base**

| Campo | Detalle |
|---|---|
| **Épica** | Consumo de Servicios Públicos y Gastos Compartidos |
| **ID-HU** | HU07 |
| **Título HU** | Comparación de Consumo Histórico y Consumo Base |
| **Descripción HU** | Como `Gallery Administrator`, quiero ver gráficos de `Consumption History` que comparen el consumo actual contra el `Baseline Consumption` a lo largo de los `Consumption Periods`, para analizar visualmente los patrones de uso y justificar los cobros a los `Tenants`. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Visualización de la comparación de consumo histórico**<br>Dado que existen datos acumulados de Utility Consumption de Consumption Periods anteriores,<br>Cuando el Gallery Administrator selecciona una Commercial Unit y elige un rango de fechas,<br>Entonces el sistema muestra un gráfico de líneas superponiendo el Utility Consumption real frente al Baseline Consumption y los promedios de meses anteriores. |

---
## **Tabla 8**  
### **HU08: Desglose de Servicios Compartidos y Gastos Comunes**

| Campo | Detalle |
|---|---|
| **Épica** | Consumo de Servicios Públicos y Gastos Compartidos |
| **ID-HU** | HU08 |
| **Título HU** | Desglose de Servicios Compartidos y Gastos Comunes |
| **Descripción HU** | Como `Gallery Administrator`, quiero que el sistema calcule automáticamente la porción correspondiente a cada `Commercial Unit` por concepto de `Shared Utility` y `Shared Expense`, para eliminar los cálculos manuales en Excel para los costos de áreas comunes. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Cálculo del Shared Expense mensual por local**<br>Dado que el Shared Expense total de electricidad de las Common Areas para un Consumption Period ha sido registrado por el medidor,<br>Cuando el Gallery Administrator activa el cálculo de facturación de servicios,<br>Entonces el sistema calcula el cobro proporcional de cada Commercial Unit según las reglas de distribución,<br>Y prepara el desglose detallado para cada Utility Bill. |

---
## **Tabla 9**  
### **HU09: Resolución de Disputas de Facturación con Datos Verificables**

| Campo | Detalle |
|---|---|
| **Épica** | Consumo de Servicios Públicos y Gastos Compartidos |
| **ID-HU** | HU09 |
| **Título HU** | Resolución de Disputas de Facturación con Datos Verificables |
| **Descripción HU** | Como `Gallery Administrator`, quiero generar un reporte de `Utility Bill` verificable con marcas de tiempo exactas del medidor durante una `Billing Dispute`, para demostrar la exactitud del cobro con datos concretos ante el `Tenant`. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Exportar reporte de verificación para una Billing Dispute**<br>Dado que un Tenant inicia una Billing Dispute respecto a su Utility Bill,<br>Cuando el Gallery Administrator selecciona "Generar Documento de Verificación de Disputa" para ese Consumption Period,<br>Entonces el sistema descarga un reporte en PDF que muestra las lecturas diarias del Utility Meter, las marcas de tiempo y los valores de referencia (baseline). |

---
## **Tabla 10**  
### **HU10: Almacenamiento Temporal de Eventos Offline y Sincronización Automática**

| Campo | Detalle |
|---|---|
| **Épica** | Resiliencia del Sistema y Operaciones |
| **ID-HU** | HU10 |
| **Título HU** | Almacenamiento Temporal de Eventos Offline y Sincronización Automática |
| **Descripción HU** | Como `Gallery Administrator`, quiero que el gateway local del sistema almacene las lecturas del `Utility Meter` y los `Local Events` durante caídas de conexión a Internet, para que no se pierda ningún registro crítico ni datos de seguridad durante interrupciones de red. |
| **Criterios de Aceptación (Gherkin)** | **Escenario 1: Sincronización automática tras restablecer Internet**<br>Dado que ocurre un corte de Internet en la Commercial Gallery mientras los Utility Meters continúan registrando datos,<br>Cuando se restablece la conexión a la red,<br>Entonces el gateway local sincroniza automáticamente todos los Local Events y registros de medidores almacenados hacia la base de datos central,<br>Y actualiza el Consumption History del Gallery Administrator sin pérdida de datos. |