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
| Sprint n Velocity | 13 story Points                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Sum of Story Points | 13 Story Points (Incluyendo Visitor Stories como VS-01, VS-02, VS-03, VS-04, VS-05, VS-06, VS-07, VS-08 y VS-09 correspondientes al Landing Page).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |


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


