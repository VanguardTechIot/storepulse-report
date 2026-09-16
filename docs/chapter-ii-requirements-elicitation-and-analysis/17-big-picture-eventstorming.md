## 2.4. Big Picture EventStorming

En esta sección, el equipo presenta el desarrollo del **Big Picture EventStorming**, 
una dinámica colaborativa realizada para entender a profundidad el dominio de negocio de 
StorePulse. A diferencia de un análisis funcional o técnico, esta sesión buscó que el equipo 
construyera una comprensión compartida de cómo ocurren las cosas en una galería comercial, 
plasmando los eventos de dominio más significativos, los actores y sistemas externos reales 
del negocio, y sus relaciones causales a lo largo de una línea de tiempo, sin considerar 
todavía los componentes de la solución (dispositivos, servicios, aplicaciones) que eventualmente 
los soportarán.

* **Etapa 1: Open & Explore**

En esta etapa el equipo hizo una lluvia de ideas con el objetivo de capturar todos los hechos relevantes posibles 
que ocurren en el negocio de manera que fueron capturadas en *Domain Events* con notas de color naranja.<br>
![big-picture-eventstorming-stage-1.png](../../assets/research/big-picture-eventstorming-stage-1.png)

Como se observa esta representación del brainstorming muestra todos los procesos por los que atraviesa el negocio,
desde que se aperturan los locales, tomando en cuenta eventos como el inicio del humo en el local, eventos de ingreso 
de un intruso, las alertas que se emiten hasta el registro y pago de las facturas. Esta etapa el equipo se centró en 
identificar los eventos sin tener en cuenta el orden de los mismos. 

* **Etapa 2: Explore (Ordenamiento y Narrativa)**

En esta etapa el equipo se centró en el ordenamiento cronológico de izquierda a derecha de los eventos,
esta vez con la incorporación de los actores, sistemas externos y los puntos de dolor o hotspots.<br>
![big-picture-eventstorming-stage-2.png](../../assets/research/big-picture-eventstorming-stage-2.png)

Muestra la línea de tiempo de eventos de dominio desde la apertura de la galería hasta los hilos paralelos de seguridad,
incendio, facturación y comunicación con el inquilino, con actores (amarillo), sistemas externos (azul) y 
hotspots (rosado) identificados durante la sesión de narración.
