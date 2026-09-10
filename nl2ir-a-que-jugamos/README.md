# NL2IR en español: ¿A qué jugamos?

Aplicación de ejemplo para el artículo [NL2IR en español con Oracle APEX 26.1: ¿a qué jugamos?](https://juanl.hashnode.dev/nl2ir-a-que-jugamos-oracle-apex-26-1). Usa una colección ficticia de juegos de mesa y cuatro informes interactivos para observar cómo cambian las consultas en lenguaje natural cuando se mejora el contexto.

No es un catálogo de juegos ni una demostración de un proveedor de IA: es un laboratorio pequeño y reproducible. Sus 28 juegos y 32 partidas son datos sintéticos creados para comprobar filtros, agrupaciones, ambigüedades y valores de referencia.

## Requisitos

- Oracle APEX 26.1.0 o posterior.
- Un esquema de parsing con permiso para crear tablas, secuencias y vistas.
- Un servicio de IA generativa configurado en el workspace. El laboratorio se probó con el proveedor OpenAI y el modelo `gpt-5.4-nano`.
- Para importar la versión APEXlang: SQLcl compatible con APEX 26.1 y un esquema REST habilitado para APEXlang.

No se incluyen claves, valores de credencial ni datos reales. Los valores de `checksumSalt` de las dos exportaciones se han neutralizado deliberadamente.

## Instalación

1. Conéctate al esquema que utilizará la aplicación y ejecuta [`database/install.sql`](database/install.sql). Es idempotente: crea o completa las tablas `NL2IR_GAMES` y `NL2IR_PLAY_SESSIONS`, sus secuencias y la vista `NL2IR_V_LIBRARY`.
2. Configura el servicio de IA en **Workspace Utilities > Generative AI Services**:
   - crea una credencial propia; nunca la añadas al repositorio;
   - crea o selecciona un servicio generativo compatible, con el proveedor, URL base y modelo de tu entorno;
   - habilítalo para App Builder si quieres usar sus asistentes desde el constructor.
3. Importa la aplicación por una de estas dos vías.
4. En **Shared Components > Application Definition Attributes**, asigna el servicio generativo al atributo de IA de la aplicación si no quedó resuelto durante la importación.
5. Ejecuta las páginas V0–V4 y prueba las preguntas propuestas más abajo.

Después de importar cualquiera de las dos exportaciones, regenera el `checksumSalt` de la aplicación antes de usarla fuera de un entorno de pruebas. En APEX, abre `Shared Components > Security Attributes` y utiliza `Expire Bookmarks` para invalidar los enlaces y valores protegidos generados con el salt neutralizado de la exportación. Esto evita dejar una clave pública y predecible en una aplicación con Session State Protection.

### Importar el SQL estándar

En App Builder elige **Import**, selecciona [`application/sql/f111.sql`](application/sql/f111.sql) y asigna un identificador de aplicación disponible. El export incluye una definición de servicio `Open AI` que pide la credencial al importar; puedes conservarla y aportar tu credencial, o bien usar un servicio ya existente y asignarlo después a la aplicación.

### Importar APEXlang

Esta variante incluye la definición del servicio `open-ai` y una credencial HTTP sin secreto. Después de importarla, asigna tu propia clave a esa credencial o, si ya cuentas con un servicio de workspace, cambia la referencia `service: @open-ai` de [`application.apx`](application/apexlang/a-que-jugamos/application.apx) por el static ID de tu servicio antes de importar. Nunca añadas el valor de una clave al fichero de credencial.

Desde el directorio que contiene `application/apexlang/a-que-jugamos`, valida e importa con SQLcl. Sustituye los marcadores por los valores de tu entorno:

```text
apex validate -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE
apex import -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE -schema TU_ESQUEMA -id 111
```

El fichero `deployments/default.json` conserva el identificador de origen `111`. Para publicar junto a otras aplicaciones, pasa un identificador libre mediante `-id`.

## Qué contiene cada página

| Página | Propósito |
| --- | --- |
| V0 · Metadatos técnicos | Punto de partida: nombres de columnas y códigos internos. |
| V1 · Columnas comprensibles | Etiquetas legibles, sin contexto adicional. |
| V2 · Contexto | Instrucciones generales del informe y de sus columnas. |
| V3 · Valores de referencia | Códigos explicados mediante listas de valores. |
| V4 · Columnas derivadas | Añade `Jugado` y la diferencia de duración para preguntas más naturales. |

Pruebas útiles: `algo para seis en menos de una hora`, `¿hemos jugado a algo sin competir?`, `zer geratzen da jokatu gabe?` y `agrupa los juegos por tipo y cuenta cuántos hay`.

## Datos y privacidad

APEX envía al proveedor de IA la pregunta y la información necesaria para interpretar el informe, como nombres de columnas, sus instrucciones y los valores de referencia habilitados. No envía automáticamente todas las filas del informe como si fueran una exportación de datos. Aun así, revisa el comportamiento y las políticas del proveedor que elijas: no pongas secretos, datos personales ni información sensible en etiquetas, instrucciones o valores de referencia.

El resultado generado es una propuesta de filtro, ordenación o agrupación. Sigue sujeto a los permisos, autorizaciones y filtros de la propia aplicación; pruébalo con perfiles de usuario reales antes de habilitarlo en producción.

## Licencia

Consulta la licencia del repositorio principal.
