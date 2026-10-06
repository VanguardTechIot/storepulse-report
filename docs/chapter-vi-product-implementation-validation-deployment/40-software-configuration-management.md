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
| Frontend Web Application | https://github.com/VanguardTechIot/storepulse-web-application | Activo. Proyecto Angular inicializado con su configuración base y ruteo. |
| Landing Page | `VanguardTechIot/storepulse-landing-page` | Por crear al iniciar su implementación en el Sprint 1. |
| REST API (Web Services) | `VanguardTechIot/storepulse-platform` | Por crear en el Sprint que incorpore los primeros endpoints. |

Los repositorios de la Edge API, la Mobile Application y la Embedded Application se crearán bajo la misma organización
cuando esos productos ingresen al alcance de un Sprint.

**Workflow de control de versiones: GitFlow**

El equipo aplica GitFlow según el modelo de ramificación propuesto por Vincent Driessen. Las ramas y sus reglas son
las siguientes:

| Rama | Propósito | Regla |
|:---|:---|:---|
| `main` | Versión estable de cada producto. Solo recibe fusiones desde `release/*` y `hotfix/*`. | Cada fusión se etiqueta con una versión semántica (`v1.0.0`). |
| `develop` | Rama de integración. Contiene el trabajo validado del Sprint en curso. | Recibe Pull Requests desde `feature/*`; no se hace *commit* directo. |
| `feature/<story-id>-<short-description>` | Una rama por Story del Sprint Backlog, creada desde `develop`. | Ejemplos: `feature/vs-04-subscription-plans`, `feature/us-20-intrusion-alert`. Se elimina al fusionarse. |
| `release/<major>.<minor>.<patch>` | Preparación de una versión al cierre de cada Sprint, creada desde `develop`. Solo admite correcciones y ajustes de versión. | Ejemplo: `release/1.0.0`. Se fusiona en `main` y de vuelta en `develop`. |
| `hotfix/<major>.<minor>.<patch>` | Corrección urgente sobre una versión ya publicada, creada desde `main`. | Ejemplo: `hotfix/1.0.1`. Se fusiona en `main` y en `develop`. |

En el repositorio del informe, donde no existen Stories, las ramas `feature/` toman el nombre de la sección que
modifican (`feature/35-information-architecture`, `feature/chapter-4-bounded-contexts`), convención ya aplicada en su
historial. Ambos repositorios activos cuentan hoy con las ramas `main` y `develop`.

Toda integración a `develop` se realiza mediante **Pull Request** revisado por al menos un integrante distinto al autor.

**Versionamiento semántico**

Las versiones de cada producto siguen **Semantic Versioning 2.0.0** con el formato `MAJOR.MINOR.PATCH`:

- `MAJOR` se incrementa ante cambios incompatibles, por ejemplo un cambio en el contrato de la REST API que obligue a
  actualizar la Web Application.
- `MINOR` se incrementa al agregar funcionalidad compatible, lo que ocurre al cierre de cada Sprint (`1.0.0` en el
  Sprint 1, `1.1.0` en el Sprint 2, `1.2.0` en el Sprint 3).
- `PATCH` se incrementa en correcciones compatibles liberadas mediante `hotfix/*`.

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

**Landing Page (sitio estático)**

1. El sitio se compone de archivos HTML, CSS y JavaScript sin paso de compilación, ubicados en la raíz del repositorio
   `storepulse-landing-page`.
2. Al fusionar una rama `release/*` en `main`, el servicio de hosting estático toma el contenido del repositorio y lo
   publica sobre HTTPS.
3. Los enlaces de acceso del Landing Page apuntan a las rutas de inicio de sesión y registro de la Web Application.

**Frontend Web Application (Angular)**

1. El repositorio `storepulse-web-application` se construye con `npm ci && npm run build`, que genera el artefacto de
   producción en `dist/storepulse-web-application/browser`.
2. El servicio de hosting publica ese directorio desde la rama `main`; las rutas del lado del cliente se resuelven con
   una regla de redirección a `index.html`.
3. La URL base de la REST API se define en los archivos de entorno de Angular (`environment.ts` para desarrollo y
   `environment.production.ts` para producción).

El servicio de hosting del Landing Page y de la Web Application, así como la configuración de despliegue de la REST
API, la Edge API, la Mobile Application y la Embedded Application, se definirán y documentarán en esta sección en el
Sprint en que cada producto se despliegue por primera vez.

**Deployment Diagram**

El siguiente Deployment Diagram de C4 Model, presentado en la sección 4.1.3.4, resume la distribución física de los
contenedores sobre los nodos de la solución: el dispositivo ESP32 y el Edge Device dentro de la galería comercial, y la
REST API, la base de datos y el Landing Page en la nube, consumidos desde el computador del administrador y el teléfono
del inquilino.

![StorePulse - Deployment Diagram](https://www.plantuml.com/plantuml/proxy?src=https://raw.githubusercontent.com/VanguardTechIot/storepulse-report/refs/heads/develop/assets/architecture/04-storepulse-deployment.puml)
