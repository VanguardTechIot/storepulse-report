### 4.1.3. Software Architecture

En esta sección se presenta la arquitectura de software de StorePulse, una solución IoT distribuida para la supervisión de seguridad, el monitoreo del consumo de servicios básicos y la gestión de información de facturación en galerías comerciales. La arquitectura se modela mediante el C4 Model, utilizando cuatro perspectivas: System Landscape, System Context, Container y Deployment.

La propuesta mantiene una REST API monolítica como núcleo de negocio en la nube, complementada por una Edge API local y una Embedded Application ejecutada en los dispositivos IoT. Esta distribución permite procesar la información generada por los dispositivos en el entorno Edge y centralizar la información en la nube para su consulta y gestión mediante las aplicaciones Web y Mobile.

#### 4.1.3.1. Software Architecture System Landscape Diagram

El System Landscape Diagram presenta una visión general del ecosistema organizacional de StorePulse, identificando los principales roles internos de la organización, los usuarios externos y los sistemas externos que interactúan con la solución. En esta vista no se detallan los contenedores, componentes internos ni la distribución física de la infraestructura.

Dentro del límite organizacional de StorePulse se consideran los siguientes elementos:

- **Maintenance Technician:** responsable de realizar actividades de mantenimiento relacionadas con la infraestructura y los dispositivos IoT de la galería comercial.
- **Support / Customer Service:** responsable de brindar soporte y atención relacionada con la solución StorePulse.
- **StorePulse:** sistema principal que permite la supervisión y gestión de la seguridad, el consumo y la información de facturación de los locales comerciales.

Fuera del límite organizacional se encuentran los siguientes actores y sistemas externos:

- **Visitor:** persona que consulta la información pública de StorePulse.
- **Gallery Administrator:** responsable de supervisar el inmueble, gestionar información de consumo y facturación y recibir alertas.
- **Tenant:** usuario que supervisa su propio local, consulta información de consumo y facturación y recibe alertas.
- **IoT Device:** conjunto de dispositivos físicos, sensores y medidores utilizados para recopilar información relacionada con la seguridad y el consumo de los servicios monitoreados.
- **Stripe:** servicio externo utilizado para procesar los pagos asociados a las suscripciones de StorePulse.

Esta perspectiva permite comprender el contexto organizacional de StorePulse y las principales entidades que forman parte de su ecosistema.

![StorePulse - System Landscape](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/01-storepulse-system-landscape.puml&fmt=svg&v=4)
#### 4.1.3.2. Software Architecture Context Level Diagram

El System Context Diagram muestra a StorePulse como el sistema central y presenta los principales usuarios y sistemas externos que interactúan directamente con él. En este nivel no se detallan los contenedores internos, las tecnologías utilizadas, las bases de datos ni la infraestructura de despliegue, ya que estos elementos corresponden a niveles posteriores del modelo C4.

Los principales elementos que interactúan con StorePulse son:

- **Visitor:** consulta la información pública proporcionada por StorePulse.
- **Gallery Administrator:** utiliza StorePulse para supervisar el inmueble, gestionar información relacionada con la operación y recibir alertas.
- **Tenant:** utiliza StorePulse para supervisar su propio local y consultar información relacionada con el consumo y la facturación.
- **IoT Device:** representa los dispositivos físicos, sensores y medidores utilizados para recopilar información de seguridad y consumo. StorePulse puede enviar comandos y configuraciones hacia estos dispositivos.
- **Stripe:** servicio externo utilizado por StorePulse para procesar los pagos asociados a las suscripciones.

El diagrama permite visualizar las principales interacciones externas de StorePulse sin profundizar en la implementación interna del sistema.
![StorePulse - System Context](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/02-storepulse-system-context.puml&fmt=svg&v=4)
#### 4.1.3.3. Software Architecture Container Level Diagram

El Container Level Diagram representa la estructura interna de alto nivel de StorePulse, mostrando los principales contenedores de software que conforman el sistema, las tecnologías utilizadas y las relaciones existentes entre ellos.

Los principales contenedores que conforman StorePulse son:

- **Landing Page:** página web pública desarrollada con HTML5, CSS3 y JavaScript, utilizada para proporcionar información pública y permitir el acceso a las aplicaciones de StorePulse.
- **Web Application:** aplicación web desarrollada con Angular, utilizada por el Gallery Administrator para supervisar el inmueble y gestionar información del sistema.
- **Mobile Application:** aplicación móvil desarrollada con Flutter y Dart, utilizada por el Tenant para monitorear su local, consultar información de consumo y recibir alertas.
- **REST API:** API monolítica desarrollada con ASP.NET Core y .NET, responsable de centralizar la lógica de negocio y proporcionar los servicios utilizados por las aplicaciones Web y Mobile.
- **Edge API:** API desarrollada con Python y Flask que opera en el entorno Edge. Se encarga de recibir, validar y procesar la información proveniente de los dispositivos IoT antes de sincronizarla con la nube.
- **Database:** base de datos MySQL utilizada para almacenar información de usuarios, consumo, seguridad, estadísticas y demás información gestionada por StorePulse.
- **Embedded Application:** aplicación embebida desarrollada en C++ que controla el dispositivo IoT, recopila la información de los sensores y transmite los datos hacia el entorno Edge.

El flujo principal de información proveniente de los dispositivos IoT se desarrolla desde el **IoT Device** hacia la **Embedded Application**, posteriormente hacia la **Edge API** y finalmente hacia la **REST API**, donde la información puede ser centralizada y almacenada en la **Database**.

Por otro lado, el **Gallery Administrator** utiliza la **Web Application** y el **Tenant** utiliza la **Mobile Application**. Ambas aplicaciones consumen los servicios proporcionados por la **REST API** mediante HTTPS/JSON. La **REST API** también se comunica con **Stripe** mediante HTTPS/REST para procesar los pagos asociados a las suscripciones.

El diagrama permite visualizar la estructura lógica de StorePulse y las principales tecnologías utilizadas para implementar sus funcionalidades.

![StorePulse - Container Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/03-storepulse-container.puml&fmt=svg&v=4)
#### 4.1.3.4. Software Architecture Deployment Diagram

El Deployment Diagram representa la distribución física de los contenedores de software de StorePulse sobre la infraestructura donde serán ejecutados. Esta vista permite identificar los nodos físicos y de infraestructura asociados al entorno de la galería comercial, el procesamiento Edge, la infraestructura Cloud y los dispositivos utilizados por los usuarios.

Los principales nodos de despliegue son:

- **Commercial Gallery:** representa la infraestructura física de la galería comercial. Contiene los dispositivos IoT y el Edge Device encargado del procesamiento local.
- **IoT Device:** dispositivo físico que contiene los sensores y medidores utilizados para recopilar información. Sobre este nodo se ejecuta la **Embedded Application**, desarrollada en C++.
- **Edge Device:** dispositivo local encargado del procesamiento Edge. Sobre este nodo se ejecuta la **Edge API**, desarrollada con Python y Flask.
- **Cloud:** infraestructura donde se ejecutan los principales servicios centralizados de StorePulse.
    - **Application Server:** aloja la **REST API**, desarrollada con ASP.NET Core y .NET.
    - **Database Server:** aloja la **Database**, desarrollada en MySQL.
    - **Web Server:** aloja la **Landing Page**, desarrollada con HTML5, CSS3 y JavaScript.
- **Administrator Computer:** computadora utilizada por el Gallery Administrator, donde se ejecuta la **Web Application** desarrollada con Angular.
- **Tenant Mobile Device:** dispositivo móvil utilizado por el Tenant, donde se ejecuta la **Mobile Application** desarrollada con Flutter y Dart.

La comunicación entre los elementos desplegados se realiza mediante los siguientes mecanismos:

- **Embedded Application → Edge API:** HTTP/JSON.
- **Edge API → REST API:** HTTPS/JSON.
- **Web Application → REST API:** HTTPS/JSON.
- **Mobile Application → REST API:** HTTPS/JSON.
- **REST API → Database:** Entity Framework Core.

Esta distribución permite mantener el procesamiento de los datos IoT cercano a los dispositivos mediante Edge Computing, mientras que la lógica de negocio y la persistencia centralizada se mantienen en la infraestructura Cloud.

![StorePulse - Deployment Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/04-storepulse-deployment.puml&fmt=svg&v=4)