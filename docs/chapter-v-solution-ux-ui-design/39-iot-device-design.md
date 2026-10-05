# 5.6. IoT Device Design

Esta sección presenta el diseño de los dispositivos IoT de StorePulse: el nodo de local, el nodo de área común y el Edge Device de la galería. El diseño se sustenta en la metodología de doce pasos para sistemas IoT propuesta por Balestrieri et al. (2018) y se modela en Cirkit Designer.

Las decisiones de diseño responden a cuatro criterios:

- **Continuidad:** la detección y el registro de eventos funcionan sin internet y durante un corte de energía (EP-09).
- **Trazabilidad con los requisitos:** cada función del dispositivo responde a una historia de la sección 3.1 (MS-01 a MS-09).
- **Bajo costo por local:** un mismo nodo reúne seguridad, humo y consumo, con componentes disponibles en el mercado local.
- **Instalación no invasiva:** el nodo se comunica por WiFi y se alimenta de un tomacorriente, sin cableado nuevo entre locales.
- **Interfaz física mínima:** el inquilino no configura nada en el dispositivo. Solo percibe su estado mediante un LED, definido en la guía de estilos de la sección 5.1.2.

La organización del dispositivo sigue la arquitectura de información de la sección 5.2: cada nodo pertenece a un local o a un área común, y el estado que muestra el LED es el mismo que las aplicaciones presentan para ese local.

#### Metodología de diseño IoT en 12 pasos

Los pasos recorren las cuatro capas de la arquitectura de referencia: Physical Layer, Data Exchange Layer, Information Integration Layer y Application Service Layer.

![Metodología IoT en 12 pasos](../../assets/iot-device-design/design-steps.png)
