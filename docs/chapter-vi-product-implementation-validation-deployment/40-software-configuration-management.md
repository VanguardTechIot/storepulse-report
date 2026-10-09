# Capítulo VI: Product Implementation, Validation & Deployment

En este capítulo el equipo explica y evidencia el proceso de implementar, comprobar, desplegar y validar la solución
StorePulse, compuesta por el Landing Page, la Web Application del administrador, la Mobile Application del inquilino, la
REST API central, la Edge API y la Embedded Application del dispositivo IoT. Los procesos core del negocio (detección de
intrusión y humo, medición de consumo, facturación verificable) y los procesos de soporte (Identity and Access
Management, Profiles and Preferences, Subscriptions and Payments) se distribuyen entre estos productos digitales según
los Bounded Contexts definidos en el Capítulo IV. El capítulo se organiza en dos secciones: Software Configuration
Management, donde se fijan las decisiones y convenciones que mantienen la consistencia durante el ciclo de vida, y la
implementación por Sprints, donde se registran las evidencias de desarrollo, pruebas, despliegue y colaboración de cada
iteración.

## 6.1. Software Configuration Management

En esta sección el equipo establece las decisiones y convenciones que permitirán mantener la consistencia durante el
ciclo de vida de StorePulse. Se incluyen secciones internas para Software Development Environment Configuration, Source
Code Management, Source Code Style Guide & Conventions y Software Deployment Configuration. Las convenciones se
describen para los productos cuyo desarrollo ya inició (Landing Page y Web Application) y se extenderán a los demás
productos conforme se incorporen a los siguientes Sprints.

### 6.1.1. Software Development Environment Configuration

A continuación se especifican los productos de software que el equipo utiliza para colaborar en el ciclo de vida de la
solución, agrupados por tipo de actividad. Para cada producto se indica su propósito dentro del proyecto y la ruta de
referencia (productos SaaS) o de descarga (productos que se ejecutan en el computador del integrante).

**Project Management**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| Trello | Product Backlog y Sprint Backlogs: una tarjeta por Story con sus Story Points, organizadas en listas To Do, In Progress y Done. | https://trello.com |
| GitHub | Organización `VanguardTechIot`, que agrupa los repositorios del informe y de cada producto, con Pull Requests para la revisión entre pares. | https://github.com/VanguardTechIot |

**Requirements Management**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| UXPressia | Fichas de User Persona e Impact Maps de los Capítulos II y III. | https://uxpressia.com |
| Figma | Lean UX Canvas del Capítulo I. | https://www.figma.com |
| Markdown | Redacción de User Stories, criterios de aceptación en Gherkin y Product Backlog dentro del repositorio del informe. | https://www.markdownguide.org |

**Product UX/UI Design**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| Figma | Style guidelines, wireframes, mock-ups y prototipos del Landing Page y de las aplicaciones. | https://www.figma.com |
| Structurizr | Diagramas C4 de nivel Context, Container y Deployment a partir del DSL del workspace. | https://structurizr.com |
| PlantUML (C4-PlantUML) | Component Diagrams, Class Diagrams y Database Diagrams de cada Bounded Context, renderizados desde los archivos `.puml` del repositorio. | https://plantuml.com |

**Software Development**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| Visual Studio Code | Editor para el Landing Page (HTML5, CSS3, JavaScript) y para la Web Application en Angular. | https://code.visualstudio.com/download |
| WebStorm | IDE para la Web Application en Angular y TypeScript. | https://www.jetbrains.com/webstorm/download |
| Node.js (LTS) y npm | Ejecución de Angular CLI, Prettier y las herramientas de prueba del frontend. | https://nodejs.org/en/download |
| Angular CLI 22 | Generación de componentes, servicios y rutas de la Web Application, y construcción del artefacto de producción. | https://angular.dev/tools/cli |
| Git | Control de versiones distribuido en cada computador del equipo. | https://git-scm.com/downloads |

Los entornos de desarrollo de la REST API, la Edge API, la Mobile Application y la Embedded Application se
especificarán en esta sección cuando cada producto ingrese al alcance de un Sprint, respetando las tecnologías
definidas en el Capítulo IV (ASP.NET Core, Python con Flask, Flutter y C++ sobre ESP32).

**Software Testing**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| Cucumber.js y Playwright | Acceptance Tests del Landing Page a partir de archivos `.feature` en Gherkin derivados de los criterios de aceptación de la sección 3.1. | https://cucumber.io · https://playwright.dev |
| Vitest | Unit Tests de componentes y servicios de la Web Application, incluido en el proyecto Angular. | https://vitest.dev |

**Software Documentation**

| Producto | Propósito en el proyecto | Ruta |
|:---|:---|:---|
| Markdown y GitHub | Redacción y versionamiento del informe en el repositorio `storepulse-report`. | https://github.com/VanguardTechIot/storepulse-report |

### 6.1.2. Source Code Management

El equipo utiliza **GitHub** como plataforma y sistema de control de versiones, bajo la organización `VanguardTechIot`.
Cada producto digital de la solución cuenta con su propio repositorio, de modo que su ciclo de versiones y sus pruebas
sean independientes. En los repositorios de Web Services se incluirá el proyecto junto con sus archivos de pruebas
unitarias y de integración/aceptación.

| Producto | Repositorio | Estado |
|:---|:---|:---|
| Informe del proyecto | https://github.com/VanguardTechIot/storepulse-report | Activo. Capítulos en Markdown, diagramas `.puml` y `.dsl`, evidencias. |
| Frontend Web Application | https://github.com/VanguardTechIot/storepulse-web-application | Activo. Angular organizado por Bounded Contexts; versión 0.1.1 publicada en Firebase Hosting. |
| Landing Page | https://github.com/VanguardTechIot/storepulse-landing-page | Activo. Sitio estático en HTML5, CSS3 y JavaScript; versión 1.0.0 publicada en GitHub Pages. |
| REST API (Web Services) | `VanguardTechIot/storepulse-platform` | Por crear en el Sprint que incorpore los primeros endpoints. |

Los repositorios de la Edge API, la Mobile Application y la Embedded Application se crearán bajo la misma organización
cuando esos productos ingresen al alcance de un Sprint.

**Workflow de control de versiones: GitFlow**

El equipo aplica GitFlow según el modelo de ramificación propuesto por Vincent Driessen. Las ramas y sus reglas son
las siguientes:

| Rama | Propósito | Regla |
|:---|:---|:---|
| `main` | Versión estable de cada producto. Solo recibe fusiones desde `release/*` y `hotfix/*`. | Cada fusión se etiqueta con su versión semántica (`v0.1.0`). |
| `develop` | Rama de integración. Contiene el trabajo validado del Sprint en curso. | Recibe Pull Requests desde `feature/*`; no se hace *commit* directo. |
| `feature/<story-id>-<short-description>` | Una rama por Story del Sprint Backlog, creada desde `develop`. | Ejemplos: `feature/vs-04-subscription-plans`, `feature/us-20-intrusion-alert`. Se elimina al fusionarse. |
| `release/v<major>.<minor>.<patch>` | Preparación de una versión al cierre de cada Sprint, creada desde `develop`. Solo admite correcciones y el ajuste de la versión en `package.json`. | Ejemplo: `release/v0.1.0`. Se fusiona en `main` y de vuelta en `develop`. |
| `hotfix/v<major>.<minor>.<patch>` | Corrección urgente sobre una versión ya publicada, creada desde `main`. | Ejemplo: `hotfix/v0.1.1`. Se fusiona en `main` y en `develop`. |

En el repositorio del informe, donde no existen Stories, las ramas `feature/` toman el nombre de la sección que
modifican (`feature/35-information-architecture`, `feature/chapter-4-bounded-contexts`), convención ya aplicada en su
historial. Los tres repositorios activos cuentan hoy con las ramas `main` y `develop`, y las ramas `release/*` y
`hotfix/*` se crean y se cierran con la extensión git-flow.

Toda integración a `develop` se realiza mediante **Pull Request** revisado por al menos un integrante distinto al autor.

**Versionamiento semántico**

Las versiones de cada producto siguen **Semantic Versioning 2.0.0** con el formato `MAJOR.MINOR.PATCH`:

- `MAJOR` se incrementa ante cambios incompatibles, por ejemplo un cambio en el contrato de la REST API que obligue a
  actualizar la Web Application.
- `MINOR` se incrementa al agregar funcionalidad compatible, lo que ocurre al cierre de cada Sprint.
- `PATCH` se incrementa en correcciones compatibles liberadas mediante `hotfix/*`.

Mientras un producto está en desarrollo inicial y su alcance aún no está completo, su versión mayor es `0`: la Web
Application publica `0.1.0` en el Sprint 1 y `0.2.0` en el Sprint 2, y alcanzará `1.0.0` con la versión final del
Sprint 3. El Landing Page, cuyo alcance quedó completo en el Sprint 1, se publicó directamente como `1.0.0`.

Las versiones publicadas al cierre del Sprint 1 son las siguientes:

| Producto | Rama de origen | Versión (tag) | Fecha | Contenido |
|:---|:---|:---|:---|:---|
| Landing Page | `release/1.0.0` | `1.0.0` | 09/10/2026 | Primera versión completa del sitio informativo. |
| Web Application | `release/v0.1.0` | `v0.1.0` | 09/10/2026 | Primera versión con los nueve Bounded Contexts del administrador. |
| Web Application | `hotfix/v0.1.1` | `v0.1.1` | 09/10/2026 | Configuración de Firebase Hosting y de la URL de la API para producción. |

El tag del Landing Page se creó sin el prefijo `v`; a partir de su siguiente versión seguirá la convención
`v<major>.<minor>.<patch>` de los demás repositorios.

**Mensajes de commit: Conventional Commits**

Los mensajes de commit siguen la especificación **Conventional Commits** con la estructura
`<type>(<scope>): <description>`, redactados en inglés, en modo imperativo y con un máximo de 72 caracteres en la
primera línea. El `scope` corresponde a la sección o al Bounded Context afectado.

| Tipo | Uso | Ejemplo |
|:---|:---|:---|
| `feat` | Nueva funcionalidad asociada a una Story. | `feat(pricing): add subscription plans table` |
| `fix` | Corrección de un defecto. | `fix(landing): correct broken image paths` |
| `docs` | Cambios en documentación o en el informe. | `docs(information-architecture): add searching and navigation systems` |
| `style` | Formato sin cambio de comportamiento. | `style(landing): apply prettier to css files` |
| `refactor` | Reestructuración sin cambio funcional. | `refactor(web): extract shared layout component` |
| `test` | Agregado o corrección de pruebas. | `test(landing): add faq acceptance scenarios` |
| `chore` | Tareas de mantenimiento que no afectan el código fuente. | `chore: ignore .idea directory` |

### 6.1.3. Source Code Style Guide & Conventions

Toda la nomenclatura del código fuente (identificadores, archivos, rutas, mensajes de commit y archivos `.feature`) se
escribe en **inglés**, de acuerdo con el Ubiquitous Language definido en la sección 2.5. A continuación se indican las
guías adoptadas para los lenguajes en uso y las convenciones principales que el equipo aplica.

| Lenguaje / Artefacto | Guía adoptada | Convenciones principales |
|:---|:---|:---|
| HTML5 | W3Schools HTML Style Guide and Coding Conventions; Google HTML/CSS Style Guide | Elementos y atributos en minúsculas; etiquetas siempre cerradas; atributos entre comillas dobles; etiquetas semánticas (`header`, `nav`, `main`, `section`, `footer`); atributo `alt` en todas las imágenes; indentación de 2 espacios. |
| CSS3 | Google HTML/CSS Style Guide; metodología BEM | Nombres de clase en `kebab-case` con bloques, elementos y modificadores (`plan-card__price--highlighted`); variables CSS para los colores y tipografías del style guide; sin selectores por `id`; una declaración por línea. |
| JavaScript | Google JavaScript Style Guide | `camelCase` para variables y funciones, `PascalCase` para clases, `UPPER_SNAKE_CASE` para constantes; `const` por defecto y `let` cuando se reasigna, nunca `var`; comillas simples; punto y coma obligatorio. |
| TypeScript y Angular | Google TypeScript Style Guide; Angular coding style guide | Un componente por archivo con sufijos `.component.ts`, `.service.ts`, `.model.ts`; archivos en `kebab-case`; interfaces y clases en `PascalCase`; componentes *standalone*; formato con Prettier (`printWidth` 100, comillas simples) y `.editorconfig` del repositorio (2 espacios, UTF-8, salto de línea final). |
| Gherkin (archivos `.feature`) | Gherkin Conventions for Readable Specifications | Un archivo por Story, nombrado como la Story (`subscription-plans.feature`); `Feature` con la descripción *As a / I want / So that*; escenarios en tiempo presente y tercera persona; un `When` por escenario; sin detalles de interfaz. |
| Markdown (informe) | Markdown Guide | Un archivo por sección numerada; encabezados ATX; tablas con alineación explícita; imágenes referenciadas desde `assets/` con texto alternativo. |

Las guías para C#, Python, Dart y C++ se incorporarán a esta tabla cuando inicie la implementación de la REST API, la
Edge API, la Mobile Application y la Embedded Application, tomando como referencia las convenciones oficiales de cada
lenguaje (Microsoft C# Coding Conventions, PEP 8, Effective Dart y Google C++ Style Guide).

### 6.1.4. Software Deployment Configuration

En esta sección se especifica la configuración del despliegue de la solución y los pasos necesarios para que, a partir
de los repositorios de código fuente, se publique cada producto digital. El principio general es que el despliegue se
realiza desde la rama `main` de cada repositorio, de modo que lo publicado corresponda siempre a una versión etiquetada.

| Producto | Hosting | URL pública | Origen del despliegue |
|:---|:---|:---|:---|
| Landing Page | GitHub Pages | https://vanguardtechiot.github.io/storepulse-landing-page/ | Rama `main` de `storepulse-landing-page` |
| Frontend Web Application | Firebase Hosting (proyecto `storepulse-web-app`) | https://storepulse-web-app.web.app | Compilación de producción de la rama `main` de `storepulse-web-application` |
| API simulada (json-server) | Render (Web Service gratuito) | https://storepulse-web-application.onrender.com/api/v1 | Carpeta `server/` de la rama `main` de `storepulse-web-application` |

**Landing Page (GitHub Pages)**

1. El sitio se compone de archivos HTML, CSS y JavaScript sin paso de compilación (`index.html`, `styles.css`,
   `script.js`, `terms.html` y `privacy.html`), ubicados en la raíz del repositorio `storepulse-landing-page`.
2. GitHub Pages publica sobre HTTPS el contenido de la rama `main`, por lo que cada fusión de una rama `release/*` en
   `main` actualiza el sitio sin pasos adicionales.
3. Los enlaces de acceso del Landing Page apuntan a las rutas de inicio de sesión y registro de la Web Application.

**Frontend Web Application (Firebase Hosting)**

1. Desde la rama `main`, el proyecto se construye con `npm ci && npx ng build`, que genera el artefacto de producción
   en `dist/storepulse-web-application/browser`.
2. El archivo `firebase.json` define ese directorio como carpeta pública y una regla de reescritura de todas las rutas
   hacia `index.html`, de modo que las rutas de Angular (por ejemplo `/profile`) no respondan 404 al recargar la página.
   El archivo `.firebaserc` asocia el repositorio con el proyecto `storepulse-web-app`.
3. La publicación se realiza con Firebase CLI mediante `firebase deploy --only hosting`, con una cuenta autorizada en
   el proyecto.
4. La URL base de la API se define en los archivos de entorno de Angular: `environment.development.ts` apunta al
   servidor local (`http://localhost:3000/api/v1`) y `environment.ts`, que se usa en la compilación de producción,
   apunta a la API publicada en Render.

**API simulada (Render)**

Mientras la REST API no se implemente, la Web Application consume una API simulada con json-server que respeta las
rutas y contratos definidos en las Technical Stories (por ejemplo, `GET /api/v1/users/{userId}/profile` de TS-04). Se
despliega en Render como Web Service con la carpeta `server` como directorio raíz, el comando de construcción
`npm install json-server@0.17.4` y el comando de inicio
`npx json-server db.json --routes routes.json --host 0.0.0.0 --port $PORT`. En el plan gratuito el servicio se
suspende tras 15 minutos sin uso y los datos modificados se restablecen al reiniciarse.

La configuración de despliegue de la REST API, la Edge API, la Mobile Application y la Embedded Application se
documentará en esta sección en el Sprint en que cada producto se despliegue por primera vez.

**Deployment Diagram**

El siguiente Deployment Diagram de C4 Model, presentado en la sección 4.1.3.4, resume la distribución física de los
contenedores sobre los nodos de la solución: el dispositivo ESP32 y el Edge Device dentro de la galería comercial, y la
REST API, la base de datos y el Landing Page en la nube, consumidos desde el computador del administrador y el teléfono
del inquilino.

![StorePulse - Deployment Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/04-storepulse-deployment.puml)
