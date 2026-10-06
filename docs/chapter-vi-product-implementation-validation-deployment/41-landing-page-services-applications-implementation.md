# 6.2. Landing Page, Services & Applications Implementation 

En esta sección se explica y evidencia el proceso de implementación, pruebas, documentación y despliegue del Landing 
Page, Web Services, Web Applications, Mobile Applications y Embedded Applications que conforman la solución StorePulse.
Para esta primera etapa de desarrollo, el esfuerzo del equipo se 
concentra en la ejecución y documentación del Sprint 1 que tiene como objetivo principal la construcción y 
el despliegue de la Landing Page como primer entregable del proyecto, utilizando HTML5, CSS3 y JavaScript. De esta manera, 
se establece el canal digital inicial para presentar el modelo de negocio a los administradores de galerías comerciales
y a los inquilinos, cumpliendo con la meta técnica de implementar y desplegar exitosamente las primeras versiones del 
sitio web estático y de las Frontend Web Applications.

## 6.2.1. Sprint 1

En esta sección se registra y explica el avance de la solución StorePulse en términos de producto y trabajo 
colaborativo correspondiente al Sprint 1. Para esta primera iteración, alineada con los objetivos de evaluación. 
El esfuerzo del equipo se enfoca en establecer los cimientos digitales e informativos de 
la plataforma. De acuerdo con la priorización definida en el Product Backlog, el alcance principal de este sprint 
abarca la implementación y el despliegue de la primera versión de la Landing Page como primer entregable del
proyecto, así como el despliegue inicial de las Frontend Web Applications. A lo largo de este apartado se detallarán
las actividades realizadas por VanguardTech, abarcando la planificación de la iteración, la asignación de tareas 
en el Sprint Backlog, y las evidencias concretas de desarrollo, pruebas, ejecución, documentación de servicios 
y configuración de despliegue.

### 6.2.1.1. Sprint Planning 1

En esta sección se detallan los aspectos principales y los acuerdos definidos durante el Sprint Planning Meeting 
correspondiente al Sprint 1 del proyecto StorePulse. El objetivo de esta reunión fue establecer las bases para el 
primer ciclo de desarrollo, definiendo la capacidad del equipo (Velocity) y seleccionando las historias de usuario 
prioritarias del Product Backlog. Para este primer sprint, el equipo determinó que el mayor valor de negocio reside en 
la construcción y despliegue de la Landing Page informativo, así como en la configuración inicial del entorno para las 
Frontend Web Applications. A continuación, se presenta el cuadro resumen de la planificación, el cual incluye los datos
de la reunión, el Sprint Goal formulado bajo el enfoque recomendado enfocado en el negocio y los usuarios, y el 
esfuerzo total estimado en Story Points.

| **Sprint #** | **Sprint 1**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| :--- |:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Sprint Planning Background** |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Date | 29 - 09 - 2026                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Time | 2:00 PM                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Location | Aula - 8741                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Prepared By | Araujo Ingunza, Renzo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Attendees (to planning meeting) | Araujo, Renzo / Díaz, Henry / Cordova, Sebastián / Esquirva, Miguel / Carranza, Joaquín / Curi, Angelo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Sprint n – 1 Review Summary | No aplica (al ser el primer Sprint del proyecto, no existen resultados ni feedback de un sprint previo).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Sprint n – 1 Retrospective Summary | No aplica (al ser el primer Sprint del proyecto, no existen retrospectivas previas).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Sprint Goal & User Stories** |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Sprint n Goal | **Our focus is on** providing gallery administrators and tenants with a deployed Landing Page that clearly explains the value proposition, and establishing the initial deployment of the Frontend Web Applications.<br><br>**We believe it delivers** a reliable digital channel to attract early adopters, communicate our services (features, subscription plans, and team), and test our value proposition, while setting a solid technical foundation for the development team.<br><br>**This will be confirmed when** visitors can successfully access the website to read about StorePulse's features and terms, and the frontend baseline is accessible in the cloud environment. |
| Sprint n Velocity | 12 story Points                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Sum of Story Points | 12 Story Points (Incluyendo Visitor Stories como VS-01, VS-02, VS-03, VS-04, VS-05, VS-06, VS-07, VS-08 y VS-09 correspondientes al Landing Page).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |


### 6.2.1.2. Aspect Leaders and Collaborators

En esta sección se presenta el Leadership-and-Collaboration Matrix (LACX) correspondiente al Sprint 1, el cual detalla 
quién asume el rol de líder (L) y quiénes actúan como colaboradores (C) para cada aspecto dentro del alcance de la 
iteración. Esta matriz tiene como fin brindar mayor claridad y efectividad en la comunicación al interior del 
equipo durante el desarrollo de las tareas planificadas.

Para este primer Sprint, el alcance funcional y técnico se ha dividido en tres aspectos principales alineados al Sprint Goal:
1. **Landing Page Implementation:** Abarca el desarrollo con HTML5, CSS3 y JavaScript del sitio web estático informativo
de StorePulse. Cabe resaltar que, por lineamientos del proyecto, todos los participantes deben colaborar activamente en 
la implementación de este aspecto.
2. **Frontend Web Applications Configuration:** Involucra la configuración inicial del entorno de desarrollo para las 
aplicaciones web (Angular) y la estructuración base del proyecto.
3. **Software Deployment & Environment Setup:** Comprende la configuración de repositorios en GitHub, estrategias de 
ramificación (GitFlow) y el despliegue inicial en la nube de la Landing Page y el entorno Frontend.

A continuación, se presenta la matriz LACX con la distribución de responsabilidades del equipo de VanguardTech:

| Team Member (Last Name, First Name) | GitHub Username | Landing Page Implementation Leader (L) / Collaborator (C) | Frontend Web Applications Configuration Leader (L) / Collaborator (C) | Software Deployment & Environment Setup Leader (L) / Collaborator (C) |
|:------------------------------------|:----------------| :---: | :---: | :---: |
| Araujo Ingunza, Renzo               | RnArauj0        | C | C | L |
| Díaz Gutierrez, Henry Kevin         | HenryDiaz12     | C | L | C |
| Córdova Valdivia, Sebastián         | Sevas04         | L | C | C |
| Curi Marcelo, Angelo                | AngeloC12       | C | C | C |
| Miguel Esquirva, Miguel             | juandyoff  | C | C | C |
| Carranza, Joaquín                   | thepima         | C | C | C |

### 6.2.1.3. Sprint Backlog 1

En esta sección se presenta el Sprint Backlog correspondiente al Sprint 1, el cual refleja la organización 
detallada de las tareas necesarias para cumplir con el Sprint Goal. El principal objetivo de esta 
iteración es proveer a los administradores de galerías e inquilinos, una Landing Page desplegado que 
comunique la propuesta de valor de StorePulse de forma diferenciada, además de establecer el entorno y 
despliegue inicial de las aplicaciones Frontend.

A continuación, se presenta una captura del tablero de control utilizado (Trello), junto con el enlace 
público para su revisión. Posteriormente, se detalla la tabla de control de estado del Sprint, 
especificando las User/Visitor Stories asignadas, las tareas (Work-Items) derivadas de su descomposición 
técnica, su estimación en horas, el responsable asignado según la matriz LACX y el estado de avance.
![trello-sprint-1.png](../../assets/sprints/trello-sprint-1.png)

https://trello.com/b/ZAyHEpKs 

**Sprint # 1**

| Story Id | Story Title | Task Id | Task Title | Task Description | Estimation (Hours) | Assigned To | Status (To-do / In-Process / To-Review / Done) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| VS-01 | Conocer el propósito de StorePulse| TSK-01 | Diseño de Header y Hero Section | Maquetar la sección principal (Hero) del Landing Page en HTML/CSS. | 3 | Córdova, Sebastián | Done |
| VS-02 | Conocer los beneficios según segmento | TSK-02 | Maquetación de Sección de Beneficios | Construir la sección de beneficios diferenciando la propuesta de valor para cada segmento. | 4 | Córdova, Sebastián | Done |
| VS-03 | Conocer el funcionamiento de la solución | TSK-03 | Implementación de Sección "Cómo Funciona" | Diseñar la sección que explica el flujo de la plataforma con iconos y descripciones. | 3 | Curi, Angelo | Done |
| VS-04 | Conocer los planes de suscripción | TSK-04 | Diseño de Pricing Table | Crear la tabla de precios estática mostrando los planes de suscripción. | 4 | Curi, Angelo | Done |
| VS-05 | Resolver dudas frecuentes| TSK-05 | Desarrollo de Acordeón FAQ | Implementar una sección interactiva de preguntas frecuentes con JavaScript. | 3 | Carranza, Joaquin | Done |
| VS-06 | Acceder o registrarse en la plataforma | TSK-06 | Integración de botones de redirección | Configurar botones de Sign In y Sign Up hacia las rutas iniciales de la plataforma. | 2 | Díaz, Henry | Done |
| VS-07 | Conocer al equipo de StorePulse | TSK-07 | Creación de Sección "About Us" | Maquetar la sección del equipo incluyendo las fotografías, nombres y roles. | 2 | Carranza, Joaquin | Done |
| VS-08 | Consultar los términos de servicio | TSK-08 | Maquetación de Terms of Service | Crear el archivo HTML para los Términos de Servicio y enlazarlo en el footer. | 2 | Esquirva, Miguel | Done |
| VS-09 | Consultar la política de privacidad | TSK-09 | Maquetación de Privacy Policy | Crear el archivo HTML para la Política de Privacidad y enlazarlo en el footer. | 2 | Esquirva, Miguel | Done |
| - | Constraint Técnico | TSK-10 | Configuración de Repositorios en GitHub | Crear repositorios para el proyecto aplicando GitFlow y convenciones iniciales. | 2 | Araujo, Renzo | Done |
| - | Constraint Técnico | TSK-11 | Configuración base de Angular | Inicializar el proyecto Angular, configurando el ruteo base y dependencias de arquitectura. | 4 | Díaz, Henry | Done |
| - | Constraint Técnico | TSK-12 | Despliegue en la Nube | Desplegar el Landing Page y el entorno base de la Web App en el hosting de nube elegido. | 3 | Araujo, Renzo | Done |

