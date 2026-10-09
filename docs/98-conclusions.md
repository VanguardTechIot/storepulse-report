# Conclusiones

## Conclusiones y Recomendaciones

### Conclusiones

StorePulse responde a una necesidad real del negocio: la gestión de galerías comerciales sigue dependiendo de
inspecciones manuales, WhatsApp y prorrateos estimados, mientras que los administradores e inquilinos no cuentan con
información verificable ni alertas automáticas. Las entrevistas confirmaron que este problema afecta a ambos segmentos
y validan el objetivo general del proyecto.

La solución no solo mejora la operación, sino que también fortalece la confianza entre las partes. El control de acceso
por rol es esencial para la adopción: los inquilinos aceptan la instalación del sistema solo si su información queda
aislada y protegida, mientras el administrador obtiene la visión consolidada del inmueble. Esta decisión se mantuvo
hasta la implementación, donde la aplicación web queda reservada al Gallery Administrator y el inquilino es dirigido a la
aplicación móvil.

El proyecto mantiene una trazabilidad sólida desde la evidencia hasta el producto. Las entrevistas sustentaron los
arquetipos, las hipótesis y el Impact Mapping; estas decisiones se convirtieron en historias del backlog, luego en los
nueve Bounded Contexts del diseño táctico y finalmente en los wireframes, mock-ups y prototipos del Capítulo V, que
referencian las user stories que cubre cada pantalla.

El diseño táctico quedó completo para los nueve Bounded Contexts del Context Map, incluido Utility Billing, que en la
entrega anterior estaba pendiente. Con ello, cada contexto cuenta con sus capas de dominio, interfaz, aplicación e
infraestructura, y con sus diagramas de componentes, de clases y de base de datos, lo que dio una base común para que
cada integrante implementara su parte de la aplicación web.

El diseño de la experiencia se sustentó en un Style Guide con tokens de color, tipografía y espaciado, y en una
arquitectura de información bilingüe (inglés y español). La consistencia entre el Landing Page y la aplicación web,
exigida por el enunciado, se apoya en estas mismas definiciones. El diseño del dispositivo IoT siguió la metodología de
doce pasos y propone nodos independientes por función sobre ESP32, de modo que la falla de un nodo no afecta a los demás.

En el Sprint 1 el equipo cumplió el Sprint Goal: el Landing Page se publicó en GitHub Pages con las nueve Visitor
Stories comprometidas (12 Story Points) y sus 13 escenarios de aceptación BDD aprobados, y la aplicación web se desplegó
en Firebase Hosting. El trabajo se organizó con GitFlow y Conventional Commits, y la matriz de liderazgo y colaboración
permitió que los seis integrantes participaran en la implementación del Landing Page, como exige el enunciado.

La integración de la aplicación web mostró la importancia de acordar convenciones antes de desarrollar en paralelo. Al
unir el trabajo de varios integrantes surgieron conflictos en los componentes compartidos (clases base, traducciones,
estilos y layout). Se resolvieron adoptando un solo patrón para todo el proyecto: interfaces de repositorio en la capa
de dominio con su implementación en infraestructura, un único servicio de traducción con claves comunes y un layout
compartido que integra la sesión del usuario.

### Recomendaciones

Alinear el Sprint 1 del informe con el estado real de la aplicación web. La sección 6.2.1 describe solo la
configuración base de Angular, pero el repositorio ya contiene los nueve Bounded Contexts implementados y desplegados.
Se recomienda registrar ese avance como parte del Sprint 2, con sus user stories, tareas y evidencias, y completar los
identificadores y fechas reales de commits que siguen pendientes en la tabla de 6.2.1.4.

Construir y documentar la REST API en el Sprint 2. Hoy la aplicación web trabaja contra un servidor de datos local
(json-server) y varios contextos aún usan datos en memoria. Al implementar la REST API con ASP.NET Core y Entity
Framework Core, documentarla con OpenAPI (Swagger) y desplegarla, solo cambiará la implementación de cada repositorio
de infraestructura, gracias a la separación por capas aplicada.

Ampliar la suite de pruebas de la aplicación web y reportarla en el informe. Existen pruebas unitarias del dominio en
la mayoría de contextos, pero Resource and Asset Management, Utility Billing y los componentes compartidos aún no
tienen pruebas. Junto con las pruebas unitarias y de integración de la REST API, deben incluirse en la sección de
Testing Suite Evidence del siguiente sprint.

Cumplir los requisitos transversales del enunciado en la aplicación web. Falta publicar la página de Términos y
condiciones enlazada desde el footer de la aplicación (en el Landing Page ya existe). También conviene corregir el
contraste de los colores de estado (éxito y advertencia), que alcanzan entre 3,0:1 y 3,3:1 y no llegan al 4,5:1 del
criterio WCAG 2.1 AA declarado en el Style Guide.

Mantener el informe consistente con las decisiones técnicas. La sección 5.2 indica que la aplicación web usa
`ngx-translate`, pero durante la integración se reemplazó por un servicio de traducción propio. Además, conviene
resolver las advertencias de tamaño del build de producción y unificar la ubicación de los archivos de rutas entre
contextos.

Preparar el alcance de la siguiente entrega. Según el enunciado, en el Sprint 2 debe desplegarse la primera versión de
la aplicación móvil y de las demás aplicaciones (Edge API y Embedded Application), y deben completarse las Validation
Interviews (6.3) y el Video About-the-Product (6.4), que todavía no tienen contenido.

## Video About-the-Team
