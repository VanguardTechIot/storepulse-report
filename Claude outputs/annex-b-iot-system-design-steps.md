# Anexo B. IoT System Design Steps

Este anexo desarrolla los **12 pasos de diseño de sistemas IoT** propuestos por Balestrieri, De Vito, Lamonaca, Picariello, Rapuano y Tudosa (Università del Sannio) en *Research challenges in measurements for Internet of Things systems*, aplicados a la solución StorePulse.

La arquitectura general de referencia del sistema IoT se organiza en cuatro capas: **Physical Layer**, **Data Exchange Layer**, **Information Integration Layer** y **Application Service Layer**. Los doce pasos recorren esas capas desde la definición de requisitos hasta la interfaz de usuario final.

Los requisitos clave que atraviesan todo el diseño son: *resource control*, *energy awareness*, *quality of service*, *interoperability*, *interference management* y *security*.

---

## Paso 1. Definition of the system requirements

Definición de los requisitos del sistema en términos de capacidades de suministro de energía y restricciones de *time-delay*.

### 1.1. Capacidades de suministro de energía

A diferencia de un dispositivo móvil autónomo, el nodo de StorePulse se instala en un local comercial que ya cuenta con acometida eléctrica. Sin embargo, la función de seguridad debe sobrevivir a un corte de energía, porque **la interrupción del suministro coincide con el escenario de intrusión** que la solución busca detectar. De ahí que el respaldo por batería no sea un accesorio sino un requisito funcional.

**Presupuesto de potencia del nodo de local**

| Carga | Tensión | Corriente | Potencia |
|---|---:|---:|---:|
| ESP32 DevKit V1 (WiFi activo) | 5 V | 160 mA | 0.80 W |
| ESP32-CAM durante la captura | 5 V | 240 mA | 1.20 W |
| Sensor MQ-2 (calefactor permanente) | 5 V | 150 mA | 0.75 W |
| Sensor PIR HC-SR501 | 5 V | 60 mA | 0.30 W |
| PZEM-004T v3 | 5 V | 60 mA | 0.30 W |
| Caudalímetro YF-S201 | 5 V | 15 mA | 0.08 W |
| DHT22 | 3.3 V | 2 mA | 0.01 W |
| Buzzer activo en alarma | 5 V | 100 mA | 0.50 W |
| LED RGB de estado | 3.3 V | 30 mA | 0.10 W |
| **Total nominal (sin captura ni alarma)** | | | **≈ 2.4 W** |
| **Total pico (captura + alarma simultáneas)** | | | **≈ 4.1 W** |

| ID | Requisito de suministro de energía |
|---|---|
| **PS-01** | Alimentación principal desde la red eléctrica peruana de **220 V AC / 60 Hz**, mediante fuente conmutada de 5 V / 2 A con aislamiento galvánico. |
| **PS-02** | Riel de 5 V para sensores y actuadores, y riel de 3.3 V derivado del regulador del ESP32 para la lógica y el DHT22. |
| **PS-03** | **Respaldo por batería Li-ion 18650 de 3.7 V / 2600 mAh (9.6 Wh)** con módulo de carga TP4056 y elevador MT3608 a 5 V. |
| **PS-04** | **Autonomía mínima de 4 horas** en modo de respaldo. Con el calefactor del MQ-2 apagado durante el corte, el consumo baja a ≈ 1.4 W, lo que rinde 9.6 Wh × 0.8 ÷ 1.4 W ≈ **5.5 h**, por encima del objetivo. |
| **PS-05** | Durante el respaldo, el nodo **conserva la detección de intrusión y suspende la medición de consumo**: sin energía en el local no hay consumo que medir, y el calefactor del MQ-2 es la carga dominante. |
| **PS-06** | El nodo gateway (Edge) se alimenta con fuente de 5 V / 3 A y cuenta con UPS propio de al menos **30 minutos**, suficientes para cerrar la base de datos local sin corrupción y notificar el corte. |
| **PS-07** | Protecciones: fusible de 1 A en la entrada AC, protección contra polaridad inversa y supresor de transitorios. El PZEM-004T se instala en el tablero del local con bornera aislada. |

### 1.2. Restricciones de time-delay

| ID | Restricción | Límite | Tipo |
|---|---|---|---|
| **TD-01** | Detección de humo → activación del buzzer local | **≤ 1.5 s** | Duro |
| **TD-02** | Detección de humo → notificación push al inquilino y al administrador | ≤ 5 s | Blando |
| **TD-03** | Detección de intrusión → generación del evento con imagen asociada | ≤ 1 s | Duro |
| **TD-04** | Detección de intrusión → notificación push al inquilino | ≤ 5 s | Blando |
| **TD-05** | Muestreo del sensor de humo | cada 500 ms | Duro |
| **TD-06** | Muestreo del sensor PIR | cada 100 ms | Duro |
| **TD-07** | Transmisión de la lectura de consumo eléctrico y de agua | cada 60 s | Best-effort |
| **TD-08** | Sincronización Edge → Cloud de la telemetría acumulada | ≤ 30 s | Best-effort |
| **TD-09** | Evaluación de una `MonitoringRule` contra su `Threshold` en el Edge | ≤ 50 ms | Duro |
| **TD-10** | Reintento de envío tras fallo de comunicación (MS-08) | backoff exponencial desde 5 s, máximo 5 reintentos | Best-effort |

> **Principio de diseño que amarra el paso 1:** las restricciones duras se resuelven **en el nodo y en el Edge**, nunca en la nube. Ante una caída de internet, el buzzer sigue sonando y el evento sigue registrándose, conforme al epic EP-09 (Continuidad operativa).

---

## Paso 2. Selection of the IoT system typology

Elección de la tipología del sistema IoT.

Se selecciona una **tipología de tres niveles con gateway concentrador local**:

```
Nodos sensores/actuadores  →  Gateway concentrador  →  Cloud  →  Dispositivos de usuario final
   (1 por local comercial)      (1 por galería)        (REST API)    (Web / Mobile)
```

**Sustento de la elección**

| Alternativa | Por qué se descarta o se acepta |
|---|---|
| Nodo conectado directamente a la nube por red celular | **Descartada.** Requeriría una SIM y un plan de datos por cada local. En una galería de 120 locales el costo recurrente hace inviable el modelo de suscripción descrito en el Capítulo I. |
| Nodo conectado directamente a la nube por WiFi del local | **Descartada.** Depende de que cada inquilino tenga y mantenga su propio router, y no permite mantener la operación cuando cae el enlace a internet. Contradice EP-09. |
| **Nodos → gateway concentrador → nube** | **Aceptada.** Un único punto de salida a internet por inmueble, costo de conectividad compartido, y el gateway conserva la capacidad de evaluar reglas y almacenar telemetría durante los cortes de red. |

Esta tipología además refleja la naturaleza del negocio: la galería es una unidad de propiedad común, y el administrador —que es el decisor de compra— contrata el servicio para todo el inmueble, no local por local.

---

## Paso 3. Definition of physical layer requirements

### 3.1. Número y tipos de nodos sensores y actuadores

| # | Nodo | Tipo | Cantidad | Ubicación |
|---|---|---|---:|---|
| N1 | Detección de movimiento (PIR) | Sensor | 1 por local | Interior, esquina superior |
| N2 | Apertura de puerta o cortina (reed) | Sensor | 1 por local | Marco de la cortina metálica |
| N3 | Detección de humo | Sensor | 1 por local | Techo del local |
| N4 | Captura de imagen del evento | Sensor | 1 por local | Junto al PIR |
| N5 | Medición de energía eléctrica | Sensor | 1 por local | Tablero eléctrico |
| N6 | Medición de caudal de agua | Sensor | 1 por local con punto de agua | Tubería de entrada |
| N7 | Temperatura y humedad ambiente | Sensor | 1 por local | Interior |
| N8 | Alarma acústica local | Actuador | 1 por local | Interior |
| N9 | Indicador de estado | Actuador | 1 por local | Carcasa del nodo |

**Total: 7 tipos de nodo sensor y 2 tipos de nodo actuador por local comercial.**

### 3.2. Consumo máximo de energía para cada nodo

Ver la tabla de presupuesto de potencia del paso 1.1. El consumo máximo por nodo sensor es el del **MQ-2 con 0.75 W**, debido a su calefactor permanente, y el del **ESP32-CAM con 1.20 W** durante la captura.

### 3.3. Target uncertainty de cada sensor

La incertidumbre objetivo se deriva del **uso que se le da a la medición**, no del catálogo del componente.

| Nodo | Magnitud física | Rango | Target uncertainty | Razón |
|---|---|---|---|---|
| N1 | Presencia / movimiento | 3–7 m, 110° | Detección binaria; **tasa de falsos positivos < 5 %** en 24 h | El PIR no mide distancia: confirma presencia. Lo que degrada el servicio no es el error métrico sino la falsa alarma que erosiona la confianza del inquilino |
| N2 | Estado de apertura | 0 / 1 | Distancia de conmutación **15 ± 5 mm** | Solo debe distinguir cortina cerrada de abierta |
| N3 | Concentración de humo | 300–10 000 ppm | **± 10 % del valor leído** tras calibración | El umbral se fija por comparación relativa contra la línea base del local, no por un valor absoluto certificado |
| N5 | Tensión (V) | 80–260 V AC | **± 0.5 %** | Es la base de un cobro facturable: el error debe ser menor que el margen de disputa entre administrador e inquilino |
| N5 | Corriente (A) | 0–100 A | **± 0.5 %** | Ídem |
| N5 | Energía activa (kWh) | 0–9999 kWh | **± 0.5 %**, resolución 1 Wh | Es la cifra que sustituye al prorrateo estimado |
| N6 | Caudal de agua (L/min) | 1–30 L/min | **± 10 %** | Aceptable para detectar consumo anómalo y fugas; insuficiente para facturación legal, lo que se declara como limitación |
| N7 | Temperatura (°C) | −40 a 80 °C | **± 0.5 °C** | Contexto para la alerta de humo: descarta falsos positivos por calor ambiental |
| N7 | Humedad relativa (%) | 0–100 % HR | **± 3 % HR** | Ídem |

### 3.4. Target accuracy and precision de los actuadores

| Nodo | Actuador | Target accuracy & precision |
|---|---|---|
| N8 | Buzzer activo | Nivel sonoro ≥ **85 dB a 10 cm**; latencia de activación **≤ 50 ms** desde la orden del ESP32; no aplica precisión analógica |
| N9 | LED RGB de estado | Resolución PWM de **8 bits por canal** (256 niveles), suficiente para distinguir los cinco estados operativos definidos (normal, sin red, alarma, respaldo por batería, error) |

### 3.5. Tipología de las interfaces digitales

| Nodo | Interfaz | Detalle |
|---|---|---|
| N1 PIR | **GPIO digital** | Salida 3.3 V compatible directamente con el ESP32 |
| N2 Reed | **GPIO digital con pull-up interno** | Contacto seco |
| N3 MQ-2 | **ADC de 12 bits + GPIO digital** | Salida analógica 0–5 V que requiere **divisor resistivo a 0–3.3 V**. Debe usarse **ADC1**: el ADC2 del ESP32 queda inutilizable mientras el WiFi está activo |
| N4 ESP32-CAM | **UART** hacia el ESP32 principal, o nodo WiFi independiente | Interfaz DVP interna hacia el sensor OV2640 |
| N5 PZEM-004T | **UART / Modbus-RTU a 9600 bps** | Aislamiento óptico entre el lado de 220 V y la lógica |
| N6 YF-S201 | **GPIO con interrupción externa** | Tren de pulsos; frecuencia F = 7.5 × Q (L/min) |
| N7 DHT22 | **Bus único (1-Wire propietario)** | Una lectura cada 2 s como mínimo |
| N8 Buzzer | **GPIO digital** | Vía transistor de conmutación |
| N9 LED RGB | **PWM (periférico LEDC del ESP32)** | 3 canales |

### 3.6. Esfuerzo computacional de los algoritmos del nodo

| Algoritmo en el nodo | Frecuencia | Costo estimado |
|---|---|---|
| Lectura y antirrebote del PIR con ventana de confirmación | 10 Hz | < 0.01 MIPS |
| Lectura del MQ-2 con promedio móvil de 10 muestras y comparación contra umbral | 2 Hz | ≈ 0.02 MIPS |
| Conteo de pulsos del caudalímetro por interrupción y cálculo del caudal | 1 Hz | despreciable |
| Consulta Modbus al PZEM-004T y decodificación de la trama | 1/60 Hz | despreciable |
| Captura y compresión JPEG en el ESP32-CAM | por evento | **dominante**: usa el codificador por hardware del ESP32 |
| Serialización JSON de la telemetría | 1/60 Hz | < 0.01 MIPS |
| Cifrado TLS del canal MQTT | continuo | **la carga real**; exige el acelerador AES/SHA por hardware |

### 3.7. Time-delay requerido para el procesamiento de datos

| Operación en el nodo | Tiempo objetivo |
|---|---|
| Lectura de GPIO (PIR, reed) | < 1 µs |
| Lectura del ADC con promedio de 10 muestras (MQ-2) | ≤ 2 ms |
| Transacción Modbus completa con el PZEM-004T | ≤ 40 ms |
| Lectura del DHT22 | ≤ 5 ms |
| Captura y compresión JPEG a 800×600 | ≤ 400 ms |
| Evaluación local de umbral y activación del buzzer | ≤ 50 ms |

---

## Paso 4. Definition of exchange layer requirements

| Requisito | Definición |
|---|---|
| **Máximo time-delay por paquete** | Nodo → gateway: **≤ 200 ms**. Gateway → nube: **≤ 2 s**. Nube → dispositivo de usuario final (push): ≤ 3 s. |
| **Tipología de comunicaciones** | **Inalámbrica** entre nodos y gateway (WiFi 2.4 GHz, 802.11 b/g/n). **Alámbrica** entre el gateway y el router de la galería (Ethernet), por estabilidad. |
| **Topología de red** | **Estrella**: cada nodo se asocia directamente al punto de acceso más cercano, y todos convergen en el gateway. Se descarta malla por la complejidad de gestión frente a un inmueble que ya dispone de infraestructura eléctrica para alimentar repetidores. |
| **Distancia máxima nodo ↔ punto de acceso** | **25 m** con obstrucción de muros y cortinas metálicas. Se asume **un punto de acceso por piso** de la galería. |
| **Distancia máxima punto de acceso ↔ gateway** | **80 m** por cableado Ethernet Cat 5e, dentro del límite de 100 m del estándar. |
| **Distancia máxima nodo ↔ nodo** | No aplica: los nodos no se comunican entre sí en topología estrella. |
| **Consumo de potencia máximo para la comunicación** | **≤ 0.6 W** por nodo en transmisión sostenida (ESP32 con WiFi activo, 160 mA a 3.3 V con picos de 240 mA). |
| **Tipo de criptografía de datos** | **WPA2-PSK** en el enlace inalámbrico; **TLS 1.2 con AES-128-GCM** sobre MQTT entre nodo y gateway; **HTTPS con TLS 1.3** entre el gateway y la REST API. Autenticación del dispositivo mediante **API Key rotativa**, conforme a MS-02 y SP-06. |

**Protocolo seleccionado: MQTT sobre TLS.** Comparación exigida por SP-04:

| Criterio | MQTT | HTTP |
|---|---|---|
| Overhead por mensaje | 2 bytes de cabecera fija | ~200 bytes de cabeceras |
| Modelo | Publicación/suscripción con sesión persistente | Petición/respuesta, requiere *polling* |
| Entrega garantizada | QoS 0, 1 y 2 | Solo con reintentos en la aplicación |
| Consumo de energía | Menor: conexión persistente, sin renegociar TLS | Mayor: cada petición reabre la conexión |
| **Decisión** | **Seleccionado** para el enlace nodo → gateway | Se conserva HTTPS para gateway → nube, por compatibilidad con la REST API monolítica |

---

## Paso 5. Definition of information layer requirements

### 5.1. Definición de los usuarios finales

| Usuario | Contexto | Perfil |
|---|---|---|
| **Gallery Administrator** | Responsable del inmueble. Decisor de compra. Opera desde una oficina con computadora. | Sin formación técnica |
| **Tenant** | Comerciante del local. Usuario beneficiario. Opera exclusivamente desde el móvil. | Sin formación técnica |
| **Maintenance Technician** | Instala y da mantenimiento a los dispositivos. | Técnico |
| **Support / Customer Service** | Atiende incidencias de la plataforma. | Medio |

### 5.2. Número y tipos de servicios por usuario final

| ID | Servicio | Admin | Tenant | Técnico | Soporte |
|---|---|:-:|:-:|:-:|:-:|
| SV-01 | Alerta de intrusión con evidencia visual | ● | ● | | |
| SV-02 | Alerta de humo y riesgo de incendio | ● | ● | | |
| SV-03 | Consulta de consumo del periodo | ● | ● | | |
| SV-04 | Histórico de consumo y comparación contra línea base | ● | ● | | |
| SV-05 | Tablero consolidado del inmueble | ● | | | |
| SV-06 | Tablero del propio local | | ● | | |
| SV-07 | Centro de notificaciones | ● | ● | | |
| SV-08 | Reporte y seguimiento de incidentes | ● | ● | | |
| SV-09 | Gestión de locales, inquilinos y dispositivos | ● | | ● | |
| SV-10 | Diagnóstico remoto del dispositivo | | | ● | ● |

**Total: 10 servicios.** El administrador accede a 7, el inquilino a 6, el técnico a 2 y soporte a 1.

### 5.3. Necesidades de información integrada por servicio

| Servicio | Información que debe integrarse | Fuentes combinadas |
|---|---|---|
| SV-01 | Evento del PIR confirmado + estado del reed + imagen capturada + horario de atención configurado del local + identidad del inquilino responsable | N1, N2, N4, configuración, IAM |
| SV-02 | Concentración de humo + temperatura ambiente (para descartar falso positivo) + ubicación del local + lista de locales colindantes a notificar | N3, N7, Property Management |
| SV-03 | Lectura acumulada del PZEM + caudal acumulado + periodo de facturación vigente + tarifa aplicable | N5, N6, catálogo |
| SV-04 | Serie histórica de consumo + **línea base** calculada sobre los periodos anteriores + desviación porcentual del periodo actual | Telemetry Store, algoritmo de baseline |
| SV-05 | Estado consolidado de N locales: incidentes activos, consumo del periodo, dispositivos desconectados, último reporte por dispositivo | Agregación multi-dispositivo + Device Twin |
| SV-06 | Estado de seguridad del local + consumo propio + desglose que sustenta su cobro | Filtrado por rol sobre las mismas fuentes |
| SV-07 | Listado cronológico de alertas por tipo y local, agrupadas por ventana temporal para evitar avalanchas | Motor de reglas + preferencias del usuario |
| SV-08 | Incidente reportado + evidencia asociada + estado del ciclo de vida + responsable asignado | Alert + Management-Tenant Communication |
| SV-09 | Inventario de `Resource`, `Asset`, `IoTDevice`, `Sensor` y `Meter` + estado y versión de firmware | Resource and Asset Management |
| SV-10 | Logs estructurados del dispositivo (MS-03) + métricas de conectividad + histórico de reintentos | Nodo + gateway |

### 5.4. Arquitectura de la capa de integración: algoritmos en el nodo y en la nube

| Algoritmo | Dónde se ejecuta | Por qué |
|---|---|---|
| Antirrebote y confirmación del PIR | **Nodo** | Debe responder en menos de 1 s y no puede depender de la red |
| Comparación del MQ-2 contra umbral y disparo del buzzer | **Nodo** | Restricción dura TD-01 |
| Conteo de pulsos y cálculo de caudal instantáneo | **Nodo** | Requiere atención a interrupciones en tiempo real |
| Filtrado de la ventana horaria de atención | **Nodo** | Evita transmitir eventos irrelevantes y ahorra ancho de banda |
| Evaluación de `MonitoringRule` frente a `Threshold` | **Edge (gateway)** | Debe seguir operando sin internet (EP-09) |
| Agrupación de notificaciones repetidas | **Edge** | Reduce el tráfico hacia la nube |
| Cálculo del consumo del periodo | **Nube** | Necesita el histórico completo y las reglas de facturación |
| Cálculo de la línea base y detección de desviación | **Nube** | Requiere series largas y comparación entre periodos |
| Agregación consolidada del inmueble | **Nube** | Cruza datos de todos los locales |

### 5.5. Complejidad computacional

| Algoritmo | Complejidad | Observación |
|---|---|---|
| Promedio móvil de las lecturas del MQ-2 | **O(1)** con ventana circular de tamaño fijo | Se evita O(n) manteniendo la suma acumulada |
| Evaluación de reglas de monitoreo | **O(r)** con r = reglas activas del dispositivo | r ≤ 10 por dispositivo |
| Cálculo del consumo del periodo | **O(m)** con m = mediciones del periodo | m ≈ 43 200 con muestreo de 1/min durante 30 días |
| Línea base por promedio de periodos previos | **O(p)** con p = periodos históricos | p ≤ 12 |
| Dashboard consolidado de la galería | **O(L)** con L = locales del inmueble | Resuelto con agregados precalculados para evitar recorrer la telemetría cruda |

### 5.6. Tiempo de procesamiento por información integrada

| Información integrada | Tiempo objetivo |
|---|---|
| Estado de seguridad del local en tiempo real | ≤ 1 s |
| Consumo acumulado del periodo | ≤ 2 s |
| Comparación contra la línea base | ≤ 3 s |
| Tablero consolidado del inmueble (120 locales) | ≤ 5 s |
| Reporte histórico de 12 periodos | ≤ 10 s |

---

## Paso 6. Definition of application service layer requirements

| Requisito | Definición |
|---|---|
| **Interfaz de usuario por servicio** | SV-01 y SV-02 se entregan como **notificación push con acción directa**, no como pantalla que el usuario deba buscar. SV-03 a SV-06 se resuelven en **tableros con visualización cuantitativa**. SV-07 es un **listado cronológico**. SV-08 un **formulario con seguimiento de estado**. SV-09 y SV-10 son **vistas tabulares de administración**. |
| **Complejidad computacional en el dispositivo de usuario final** | La aplicación cliente **no ejecuta cálculo analítico**: recibe agregados ya resueltos por la nube. Su costo se limita a renderizar series de a lo sumo 500 puntos y a mantener la suscripción push. Esto responde al perfil de usuario definido en el Capítulo I —incluidas personas mayores— y a la gama de teléfonos del segmento C y D. |
| **Tipologías de plataformas de usuario final** | **Web responsiva en Angular** para el Gallery Administrator, que opera desde computadora. **Aplicación móvil nativa en Flutter/Dart** para el Tenant, que opera en movimiento. **Landing Page estática** para el visitante. |

---

## Paso 7. Selection of the architectures of data exchange and information integration layers

**Capa de intercambio de datos**

```
Nodo ESP32 ──MQTT/TLS──► Broker Mosquitto (gateway)
                              │
                         Edge API (Flask)
                              │
                         ──HTTPS/JSON──► REST API (nube)
```

**Capa de integración de información**

La REST API monolítica en ASP.NET Core concentra la lógica de negocio; MySQL almacena tanto los datos operativos como la telemetría histórica particionada por tiempo.

| Decisión | Sustento |
|---|---|
| Broker MQTT local en el gateway, no en la nube | Los nodos siguen publicando y las reglas siguen evaluándose durante una caída de internet. Sin esto, EP-09 no se cumple. |
| Edge API en Python/Flask sobre el mismo gateway | Coherente con la arquitectura ya definida en la sección 4.1.3 del informe. Permite almacenar y reintentar (MS-07, MS-08). |
| REST API monolítica | Un único despliegue y un único modelo transaccional; las operaciones que cruzan dominios se resuelven en una sola transacción ACID. |
| Base de datos única MySQL | Coherente con el monolito. Si el volumen de telemetría crece, el primer componente a separar sería un almacén de series temporales. |

---

## Paso 8. Selection of the sensors and the actuators

Selección según características **metrológicas** y **eléctricas**, con disponibilidad verificada en el mercado peruano.

### 8.1. Nodo de local comercial

| Componente | Modelo | Características metrológicas | Características eléctricas | Interfaz | Precio ref. |
|---|---|---|---|---|---:|
| Sensor de movimiento | **HC-SR501 (PIR)** | Alcance 3–7 m ajustable, ángulo 110°, tiempo de bloqueo 2.5 s | 4.5–20 V, 60 mA | GPIO | S/ 10 |
| Sensor de apertura | **MC-38 (reed magnético)** | Conmutación a 15 ± 5 mm | Contacto seco, 100 mA máx. | GPIO | S/ 6 |
| Sensor de humo | **MQ-2** | 300–10 000 ppm, ±10 % tras calibración | 5 V, 150 mA (calefactor) | ADC1 + GPIO | S/ 10 |
| Cámara | **ESP32-CAM (OV2640)** | 2 MP, hasta 1600×1200 | 5 V, 240 mA en captura | UART / WiFi | S/ 40 |
| Medidor eléctrico | **PZEM-004T v3 (100 A)** | 80–260 V ±0.5 %, 0–100 A ±0.5 %, 0–9999 kWh ±0.5 %, resolución 1 Wh | 5 V, 60 mA; aislamiento óptico | UART Modbus-RTU | S/ 70 |
| Caudalímetro | **YF-S201 (1/2")** | 1–30 L/min, ±10 %, F = 7.5 × Q | 5–18 V, 15 mA | GPIO con interrupción | S/ 30 |
| Temperatura y humedad | **DHT22 (AM2302)** | −40 a 80 °C ±0.5 °C; 0–100 % HR ±3 % | 3.3–5 V, 2 mA | Bus único | S/ 20 |
| Alarma acústica | **Buzzer activo 5 V** | ≥ 85 dB a 10 cm | 5 V, 100 mA | GPIO + transistor | S/ 4 |
| Indicador de estado | **LED RGB cátodo común** | 5 estados operativos | 3.3 V, 30 mA | PWM (LEDC) | S/ 5 |

### 8.2. Justificación de las alternativas evaluadas (Spike Stories)

| Spike | Alternativas comparadas | Decisión y razón |
|---|---|---|
| **SP-01** Detección de intrusión | PIR HC-SR501 (S/ 10) frente a sensor ultrasónico HC-SR04 (S/ 12) | **PIR.** El ultrasónico mide distancia pero genera falsos positivos con cortinas metálicas y mercadería apilada. El PIR detecta calor corporal, que es la señal de interés. Se complementa con el reed para confirmar apertura física. |
| **SP-02** Detección de humo | MQ-2 (S/ 10) frente a MQ-135 (S/ 15) | **MQ-2.** El MQ-135 está orientado a calidad del aire; el MQ-2 responde específicamente a humo y gases de combustión. **Limitación declarada:** no es un detector certificado según NFPA 72; para el producto comercial deberá migrarse a un detector fotoeléctrico homologado. |
| **SP-03** Medición eléctrica | PZEM-004T v3 (S/ 70) frente a SCT-013-030 + ADS1115 (S/ 45 + S/ 25) | **PZEM-004T.** Entrega tensión, corriente, potencia activa, factor de potencia y energía acumulada ya calculados y con ±0.5 % certificado. El SCT-013 solo da corriente y obliga a implementar el cálculo de potencia real en el ESP32, lo que degrada la exactitud del cobro. |
| **SP-04** Protocolo | MQTT frente a HTTP | **MQTT.** Ver la comparación del paso 4. |
| **SP-06** Autenticación | API Key rotativa frente a certificados X.509 por dispositivo | **API Key rotativa** para el prototipo, por simplicidad de aprovisionamiento; se documenta X.509 como evolución para producción. |

### 8.3. Advertencias de instalación

El **PZEM-004T se conecta al lado de 220 V AC** del tablero del local. La instalación debe realizarla personal con conocimiento eléctrico, con el circuito desenergizado y usando la bornera aislada del módulo. El **MQ-2 requiere un precalentamiento de 24 a 48 horas** antes de su primera calibración, y su umbral debe ajustarse contra la línea base de cada local, porque la concentración de fondo varía según el rubro del comercio.

---

## Paso 9. Selection of the microcontroller and radio transceivers

| Rol | Componente | Justificación | Precio ref. |
|---|---|---|---:|
| **Nodo sensor/actuador** | **ESP32 DevKit V1 (NodeMCU-32, 30 pines)** | Doble núcleo a 240 MHz, 520 KB SRAM, 4 MB flash. **WiFi 802.11 b/g/n y BLE integrados**, lo que elimina el costo de un transceptor externo. Acelerador AES/SHA por hardware, necesario para el TLS del paso 4. ADC de 12 bits, UART, I2C, SPI y PWM suficientes para los 9 nodos del paso 3. | S/ 35 |
| **Cámara del nodo** | **ESP32-CAM** | Integra microcontrolador y sensor OV2640 con codificador JPEG por hardware. Se mantiene como módulo separado para que la captura no compita con el lazo de seguridad del ESP32 principal. | S/ 40 |
| **Gateway concentrador** | **Raspberry Pi 4 Model B (4 GB)** | Ejecuta el Edge API en Python/Flask, el broker Mosquitto y la base de datos local de la cola offline. Ethernet Gigabit y WiFi de doble banda. Capacidad sobrada para los 120 nodos de una galería grande. | S/ 420 |
| **Transceptor del nodo** | Integrado en el ESP32 (WiFi 2.4 GHz) | Alcance verificado de 25 m con obstrucción, dentro del requisito del paso 4. No se requiere transceptor adicional. | — |
| **Alternativa para locales sin cobertura** | **LoRa SX1278 433 MHz** | Se documenta como contingencia para sótanos o locales alejados del punto de acceso: alcance de cientos de metros a costa de un ancho de banda que no permite transmitir imágenes. | S/ 45 |

### 9.1. Lista de compra — prototipo de demostración

Configuración mínima para evidenciar el flujo de extremo a extremo exigido por el enunciado del trabajo final: **2 locales monitoreados + 1 gateway**.

| Cant. | Componente | Unitario | Subtotal |
|---:|---|---:|---:|
| 2 | ESP32 DevKit V1 | S/ 35 | S/ 70 |
| 2 | ESP32-CAM | S/ 40 | S/ 80 |
| 2 | Sensor PIR HC-SR501 | S/ 10 | S/ 20 |
| 2 | Reed magnético MC-38 | S/ 6 | S/ 12 |
| 2 | Sensor de humo MQ-2 | S/ 10 | S/ 20 |
| 1 | PZEM-004T v3 | S/ 70 | S/ 70 |
| 1 | Caudalímetro YF-S201 | S/ 30 | S/ 30 |
| 2 | DHT22 | S/ 20 | S/ 40 |
| 2 | Buzzer activo 5 V | S/ 4 | S/ 8 |
| 2 | LED RGB + resistencias | S/ 5 | S/ 10 |
| 2 | Fuente 5 V / 2 A | S/ 18 | S/ 36 |
| 2 | TP4056 + batería 18650 + MT3608 | S/ 33 | S/ 66 |
| 2 | Protoboard, jumpers y caja plástica | S/ 25 | S/ 50 |
| 1 | Raspberry Pi 4 Model B 4 GB | S/ 420 | S/ 420 |
| 1 | microSD 32 GB clase 10 | S/ 30 | S/ 30 |
| 1 | Fuente USB-C 5 V / 3 A + case con ventilador | S/ 85 | S/ 85 |
| | | **Total** | **≈ S/ 1 047** |

**Variante económica.** Sustituyendo la Raspberry Pi 4 por una **Raspberry Pi Zero 2 W (≈ S/ 130)**, o ejecutando el Edge API en una laptop del equipo durante la demostración, el total baja a **≈ S/ 757** o **≈ S/ 512** respectivamente. El PZEM-004T y el caudalímetro pueden instalarse en un solo nodo y el segundo nodo limitarse a seguridad, que es lo que el enunciado pide: *un subconjunto relevante de características*.

### 9.2. Proveedores en Perú

| Proveedor | Alcance | Enlace |
|---|---|---|
| **Naylamp Mechatronics** | El más completo para ESP32, sensores y módulos. Precios confirmados: ESP32 DevKit V1 S/ 35, ESP32-WROVER S/ 30, MQ-2 S/ 10 | naylampmechatronics.com |
| **Electromania** | Sensores y módulos; alternativa cuando Naylamp está sin stock | electromania.pe |
| **Tesla Electronic** | Kits de sensores para Arduino/ESP32 | teslaelectronic.com.pe |
| **Mercado Libre Perú** | Raspberry Pi, PZEM-004T y componentes con entrega en Lima | mercadolibre.com.pe |

> **Advertencia de disponibilidad:** al momento de la consulta, varios modelos de ESP32 figuraban **sin stock** en Naylamp. Conviene verificar disponibilidad antes de comprometer el diseño y considerar el **ESP32-WROVER (S/ 30, en stock)** como reemplazo directo del DevKit V1.

---

## Paso 10. Definition of the data processing for each node and in Cloud

### 10.1. Procesamiento en el nodo sensor/actuador

| # | Algoritmo | Descripción |
|---|---|---|
| 1 | **Inicialización e identidad** | Al primer arranque genera y persiste en NVS un identificador único derivado de la MAC del ESP32 (MS-01). |
| 2 | **Antirrebote del PIR** | Confirma la detección si el pin permanece activo durante 3 lecturas consecutivas a 10 Hz, para descartar disparos espurios. |
| 3 | **Filtro de ventana horaria** | Contrasta el evento contra el horario de atención configurado. Fuera del horario genera alerta; dentro solo registra (MS-04). |
| 4 | **Promedio móvil del MQ-2** | Ventana circular de 10 muestras; compara contra el umbral calibrado y dispara el buzzer localmente (MS-05). |
| 5 | **Captura del evento** | Ordena al ESP32-CAM una captura JPEG a 800×600 y la asocia al identificador del evento. |
| 6 | **Integración del caudal** | Cuenta pulsos por interrupción durante una ventana de 1 s y acumula el volumen. |
| 7 | **Consulta Modbus al medidor** | Lee tensión, corriente, potencia y energía acumulada cada 60 s. |
| 8 | **Persistencia local** | Escribe cada registro en SPIFFS antes de intentar transmitirlo (MS-07). |
| 9 | **Cola de reintento** | Backoff exponencial; tras 5 intentos fallidos conserva el registro para reenvío posterior (MS-08). |

### 10.2. Procesamiento en el gateway (Edge)

| # | Algoritmo | Descripción |
|---|---|---|
| 1 | **Bootstrap del almacenamiento** | Inicializa las estructuras locales en la primera solicitud tras arrancar (MS-09). |
| 2 | **Validación de API Key** | Rechaza con 401 la telemetría de dispositivos no registrados (MS-02). |
| 3 | **Normalización de la telemetría** | Convierte el payload del nodo al esquema `Telemetry` / `Measurement` del dominio. |
| 4 | **Evaluación de reglas** | Aplica cada `MonitoringRule` activa mediante su `Threshold` y `ComparisonOperator`, y emite `ThresholdExceededEvent`. |
| 5 | **Agrupación de notificaciones** | Consolida alertas del mismo tipo y local dentro de una ventana de 5 minutos. |
| 6 | **Cola de sincronización** | Acumula la telemetría mientras no haya internet y la reenvía ordenada al restablecerse. |

### 10.3. Procesamiento en la nube

| # | Algoritmo | Descripción |
|---|---|---|
| 1 | **Ingesta y persistencia** | Valida y almacena la telemetría en la tabla particionada por tiempo. |
| 2 | **Cálculo del consumo del periodo** | Diferencia entre la lectura acumulada de cierre y la de apertura del periodo. |
| 3 | **Cálculo de la línea base** | Promedio de los consumos de los periodos anteriores del mismo local. |
| 4 | **Detección de desviación** | Compara el periodo actual contra la línea base y emite alerta si supera el margen configurado. |
| 5 | **Agregación del inmueble** | Precalcula los indicadores del tablero consolidado. |
| 6 | **Enrutamiento de notificaciones** | Resuelve el destinatario según la relación usuario–local y despacha vía Firebase Cloud Messaging. |

---

## Paso 11. Analysis of the processing time

### 11.1. Tiempo por algoritmo

| Etapa | Operación | Tiempo estimado |
|---|---|---|
| Nodo | Lectura de GPIO (PIR, reed) | < 1 µs |
| Nodo | Confirmación por 3 lecturas a 10 Hz | 200 ms |
| Nodo | Lectura del ADC con promedio de 10 muestras | 2 ms |
| Nodo | Transacción Modbus con el PZEM-004T | 40 ms |
| Nodo | Captura y compresión JPEG 800×600 | 400 ms |
| Nodo | Serialización JSON y publicación MQTT en WiFi local | 50 ms |
| Edge | Validación de API Key y normalización | 10 ms |
| Edge | Evaluación de reglas activas | 5 ms |
| Edge | Escritura en la cola local | 15 ms |
| Edge → Nube | Petición HTTPS con TLS ya establecido | 500 ms |
| Nube | Persistencia y enrutamiento de la notificación | 300 ms |
| Nube → Teléfono | Entrega por Firebase Cloud Messaging | 2 000 ms |

### 11.2. Cadenas de extremo a extremo

**Cadena de intrusión (SV-01)**

```
PIR 1 µs + confirmación 200 ms + captura 400 ms + MQTT 50 ms
  + Edge 30 ms + HTTPS 500 ms + nube 300 ms + FCM 2 000 ms
  = 3 480 ms  ≈ 3.5 s     frente al objetivo TD-04 de 5 s  ✔
```

**Cadena de humo (SV-02)**

```
Local:  ADC 2 ms + confirmación 2 muestras 1 000 ms + buzzer 50 ms
        = 1 052 ms ≈ 1.1 s   frente al objetivo TD-01 de 1.5 s  ✔

Remota: 1 052 ms + MQTT 50 ms + Edge 30 ms + HTTPS 500 ms
        + nube 300 ms + FCM 2 000 ms
        = 3 932 ms ≈ 3.9 s   frente al objetivo TD-02 de 5 s  ✔
```

**Cadena de telemetría de consumo (SV-03)**

```
Modbus 40 ms + serialización 50 ms + Edge 30 ms + HTTPS 500 ms + nube 300 ms
  = 920 ms  ≈ 0.9 s    frente al objetivo TD-07/TD-08 de 30 s  ✔
```

### 11.3. Conclusión del análisis

Las tres cadenas cumplen sus objetivos con margen. **El componente dominante es la entrega push de Firebase (2 s), que está fuera del control del equipo**, y el segundo es la captura de imagen (400 ms). Por eso la alarma acústica local se dispara en 1.1 s sin esperar ninguna confirmación remota: la seguridad de las personas no puede depender de la latencia de un servicio de terceros.

---

## Paso 12. Definition of the graphical user interface

| Plataforma | Usuario | Servicios que expone | Características de la interfaz |
|---|---|---|---|
| **Web Application (Angular)** | Gallery Administrator | SV-01 a SV-05, SV-07 a SV-09 | Tablero consolidado con estado de los locales, incidentes activos y consumo del periodo. Vista de administración de locales, inquilinos y dispositivos. Diseñada para pantalla de computadora, que es la herramienta principal de este segmento. |
| **Mobile Application (Flutter/Dart)** | Tenant | SV-01 a SV-04, SV-06 a SV-08 | Tablero del propio local con estado de seguridad y consumo. Notificaciones push con acción directa para alertas de intrusión y humo. Interfaz de una sola columna, pensada para uso con una mano mientras se atiende el negocio. |
| **Landing Page estática** | Visitante | Comunicación de valor | Contenido y llamadas a la acción diferenciados por segmento, que redirigen al registro o a la descarga de la aplicación. |
| **Web Application (Angular)** | Maintenance Technician / Soporte | SV-09, SV-10 | Vistas tabulares de diagnóstico, logs del dispositivo y estado de firmware. |

**Criterios transversales de interfaz**, derivados del perfil de usuario definido en el Capítulo I:

- Ninguna pantalla exige configuración técnica ni interpretación de datos especializados: los usuarios de ambos segmentos carecen de formación técnica y el segmento de inquilinos incluye personas mayores.
- La información cuantitativa se presenta con visualizaciones comparativas —consumo del periodo frente a la línea base— antes que con cifras absolutas sin contexto.
- El alcance de la información está delimitado por rol de forma explícita y visible: el inquilino ve únicamente su local. Esta condición no es solo técnica, es el requisito que el Capítulo II identificó como determinante para que el inquilino acepte la instalación del dispositivo.
- Las alertas críticas llegan como notificación push y no como una pantalla que el usuario deba consultar, porque el valor del producto depende de que el usuario actúe **durante** el evento y no después.

---

## Observación sobre el modelo de dominio

El desarrollo del paso 3 evidencia una **inconsistencia con el modelo táctico** documentado en la sección 4.2 del informe: las enumeraciones `SensorType` y `MeasurementType` solo contemplan `TEMPERATURE`, `HUMIDITY`, `WATER` y `ELECTRICITY`, pero la capa física exige además los tipos correspondientes a la **detección de movimiento**, la **apertura de acceso** y la **detección de humo**, que son precisamente las variables del núcleo del problema descrito en el Capítulo I y de las historias MS-04 y MS-05.

Se recomienda extender ambas enumeraciones con los valores `MOTION`, `DOOR_STATE` y `SMOKE`, y añadir la entidad correspondiente a la evidencia visual asociada al evento de intrusión, antes de iniciar la implementación del Sprint 1.
