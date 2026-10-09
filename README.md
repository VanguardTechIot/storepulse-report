# StorePulse Report

Repositorio oficial del informe académico del proyecto **StorePulse**, desarrollado por el equipo **VanguardTech** para el curso **Desarrollo de Soluciones IoT** de la Universidad Peruana de Ciencias Aplicadas.

StorePulse es una solución IoT orientada a la seguridad perimetral y la gestión transparente de servicios básicos en galerías comerciales. La propuesta integra dispositivos físicos con sensores y medidores (Embedded Applications), procesamiento en el borde (Edge Computing), una RESTful API centralizada en la nube, y aplicaciones Web/Mobile adaptativas para que administradores e inquilinos gestionen su patrimonio de forma remota, segura y transparente.

## Información del Proyecto

| Campo | Descripción |
| --- | --- |
| Universidad | Universidad Peruana de Ciencias Aplicadas |
| Carrera | Ingeniería de Software |
| Curso | Desarrollo de Soluciones IoT |
| Código del curso | 1ASI0572 |
| NRC | 8741 |
| Startup | VanguardTech |
| Producto | StorePulse |
| Ciclo académico | 202602 |

## Propósito del Repositorio

Este repositorio contiene el **informe académico del proyecto StorePulse**.

El informe se gestiona como un documento versionado mediante archivos Markdown, imágenes, diagramas y evidencias del proyecto.

Aunque este repositorio está orientado a documentación, se trabaja con un flujo similar al desarrollo de software para mantener trazabilidad, colaboración ordenada y control de calidad en los cambios realizados.

---

## Estructura del Repositorio

```text
project-report/
├── assets/
│   ├── architecture/
│   ├── branding/
│   ├── iot/
│   ├── lean-ux/
│   ├── requirements/
│   ├── research/
│   ├── sprints/
│   ├── team/
│   ├── ui/
│   ├── ux/
│   └── videos/
├── docs/
│   ├── front-matter/
│   │   ├── 01-cover.md
│   │   ├── 02-version-log.md
│   │   ├── 03-collaboration-insights.md
│   │   ├── 04-content.md
│   │   └── 05-student-outcome.md
│   ├── chapter-i-introduction/
│   ├── chapter-ii-requirements-elicitation-and-analysis/
│   ├── chapter-iii-requirements-specification/
│   ├── chapter-iv-solution-software-design/
│   ├── chapter-v-solution-ui-ux-design/
│   ├── chapter-vi-product-implementation-validation-and-deployment/
│   ├── annexes/
│   ├── 98-conclusions.md
│   └── 99-bibliography.md
└── README.md
```

## Secciones Principales

| Carpeta / Archivo                                                | Contenido                                                                                             |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| `docs/front-matter/`                                              | Carátula, registro de versiones, collaboration insights, contenido y student outcome.                |
| `docs/chapter-i-introduction/`                                    | Perfil de la startup, perfil de la solución, proceso Lean UX y segmentos objetivo.                    |
| `docs/chapter-ii-requirements-elicitation-and-analysis/`          | Análisis competitivo, entrevistas, needfinding, EventStorming y lenguaje ubicuo.                       |
| `docs/chapter-iii-requirements-specification/`                    | User stories, impact mapping y product backlog.                                                        |
| `docs/chapter-iv-solution-software-design/`                       | Diseño estratégico y táctico con DDD, bounded contexts y diagramas de arquitectura.                  |
| `docs/chapter-v-solution-ui-ux-design/`                           | Guías de estilo, arquitectura de información, diseño UI, prototipos y diseño del dispositivo IoT.   |
| `docs/chapter-vi-product-implementation-validation-and-deployment/` | Gestión de configuración, implementación por sprint, evidencia de testing y evidencia de despliegue. |
| `docs/98-conclusions.md`                                          | Conclusiones y recomendaciones del proyecto.                                                            |
| `docs/99-bibliography.md`                                         | Referencias bibliográficas utilizadas en el informe.                                                   |
| `docs/annexes/`                                                   | Anexos, evidencias complementarias y materiales de soporte.                                             |

## Flujo de Trabajo

El equipo utiliza un flujo de trabajo basado en ramas para desarrollar cada sección del informe de manera organizada e independiente.

### Ramas Principales

| Rama | Propósito |
| --- | ----------------------------------------------------------------------------------------------- |
| `main` | Contiene la versión estable del informe.  |
| `develop` | Rama de integración para cambios validados antes de pasar a una versión estable. |
| `feature/<section-name>` | Ramas utilizadas para trabajar secciones específicas, mejoras o nuevas evidencias del informe. |

### Ejemplos de Ramas

```text
feature/report-directory-restructure
feature/chapter-4-bounded-contexts
feature/chapter-1-team-profiles
feature/sprint-2-evidence
fix/report-formatting
```

## Convención de Commits

Este repositorio sigue la convención **Conventional Commits**.

Aunque el repositorio contiene principalmente documentación, los commits se redactan de acuerdo con la intención del cambio realizado. Por ello, no todos los commits deben usar `docs:`. Si el cambio agrega una nueva sección, corrige contenido, reorganiza estructura o ajusta formato, se utiliza el tipo de commit correspondiente.

### Tipos de Commit Recomendados

| Tipo | Uso |
| --- | --- |
| `feat:` | Agrega una nueva sección, diagrama, tabla, evidencia o artefacto del informe. |
| `fix:` | Corrige contenido, formato, redacción, numeración o rutas de imágenes. |
| `refactor:` | Reorganiza la estructura del informe sin cambiar el significado del contenido. |
| `style:` | Mejora la presentación visual, espaciado, tamaño de imágenes o formato Markdown. |
| `chore:` | Actualiza organización del repositorio, assets o archivos auxiliares. |
| `docs:` | Extrae, mueve o reestructura contenido documental sin cambiar su significado. |

### Ejemplos de Commits

```text
feat: add identity and access management bounded context
fix: correct member surname in cover page table
style: adjust logo size in front-matter cover
refactor: reorganize chapter folders with sequential numbering
chore: add UPC logo to branding assets
docs: extract cover page into own md file
```

## Lineamientos para Pull Requests

Antes de integrar una rama, cada integrante debe verificar que:

- La sección en Markdown se visualice correctamente.
- Las rutas de imágenes funcionen.
- Las tablas sean legibles.
- Los títulos respeten la numeración del informe.
- El cambio corresponda a la sección asignada.
- Los commits sigan la convención definida.
- La rama esté actualizada con los últimos cambios de `develop`.

## Lineamientos para Imágenes y Assets

Todas las imágenes utilizadas en el informe deben almacenarse dentro de `assets/`, organizadas por tema (no por capítulo), cada una con su propio `explain.md` que documenta su propósito y convención de nombres:

```text
assets/architecture/
assets/branding/
assets/iot/
assets/lean-ux/
assets/requirements/
assets/research/
assets/sprints/
assets/team/
assets/ui/
assets/ux/
assets/videos/
```

Para insertar imágenes en el informe, se deben usar rutas relativas desde el archivo `.md` que las referencia:

```html
<img src="../../assets/team/renzo-araujo.png" alt="Renzo Araujo" width="80">
```

## Integrantes del Equipo

| Código | Integrante |
| --- | --- |
| u202113612 | Araujo Ingunza, Renzo José |
| u202111041 | Córdova Valdivia, Sebastián |
| u202022387 | Curi Marcelo, Angelo Marcio |
| u202310837 | Esquivel León, Miguel Juan Diego |
| u201819674 | Diaz Gutierrez, Henry Kevin |
| u20191b935 | Carranza Tesén, Joaquín Enrique |

StorePulse nace frente a un problema real: galerías comerciales que dependen de inspecciones manuales esporádicas y cobros estimados, generando conflictos constantes entre dueños e inquilinos y dejando expuestos locales sin monitoreo de seguridad confiable. Este informe documenta el proceso de análisis, diseño y validación de una solución IoT orientada a transformar esa realidad, conectando sensores, software y decisiones operativas en un mismo ecosistema.

Más que un repositorio de documentación, este proyecto representa la evolución de una idea hacia una propuesta tecnológica con propósito: dotar a administradores e inquilinos de un ecosistema accesible que automatice la seguridad perimetral y transparente el consumo de servicios básicos, con datos cuantitativos en tiempo real.