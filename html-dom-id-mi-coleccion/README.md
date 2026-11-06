# HTML DOM ID en APEX: personalizar Inicio

Ejemplo del artículo en preparación **HTML DOM ID en APEX: el Static ID que ya no era el que buscaba**.
El enlace a Hashnode se añadirá al publicar.

Continúa [la selección múltiple](../seleccion-multiple-interactive-report/): transforma la
cabecera de **1 · Inicio** en la misma app, conservando sus accesos y los ejemplos V0–V4 y
Preparar propuesta. HTML DOM ID permite acotar el CSS de la bienvenida; no añade informes.
El laboratorio de cabecera no requiere IA ni llamadas externas.

La aplicación se ofrece en [SQL único](application/sql/f111.sql) y en
[APEXlang](application/apexlang/a-que-jugamos/). Son dos formatos del mismo resultado: importa
**uno**. Los objetos de base de datos se preparan aparte según la ruta elegida.

## Requisitos

- Oracle APEX 26.1 y Universal Theme 26.1; el ejemplo utiliza Iris.
- Un workspace, un esquema de parsing y un usuario para acceder a la aplicación.
- SQLcl 26.1 con soporte APEXlang y esquema REST habilitado si eliges ese formato.
- Un servicio IA propio sólo para usar NL2IR. La página Inicio y su montaje HTML/CSS no necesitan
  llamadas a un proveedor de IA.

Los datos son sintéticos. No se incluyen usuarios, contraseñas ni claves.

## Ruta A: instalar desde cero

1. Ejecuta [database/install.sql](database/install.sql) en el esquema de parsing. Incluye
   los objetos de los ejercicios anteriores, los 28 juegos y las 32 partidas iniciales.
2. Importa una de las versiones de la aplicación siguiendo las instrucciones de abajo.
   Elige un ID libre; el ID de origen es 111.
3. Si vas a usar NL2IR, asigna tu propio servicio y credencial en el workspace.
4. Abre **Inicio** desde el menú lateral y realiza las comprobaciones finales.

## Ruta B: ampliar tu aplicación existente

1. Usa la app del ejemplo de selección múltiple y el mismo esquema de parsing. Guarda una
   exportación de respaldo. En nuestro entorno seguimos trabajando sobre la app **111**.
2. Ejecuta [database/verify.sql](database/verify.sql). Comprueba las tablas, la vista y el
   paquete existentes sin modificar datos. Este incremento no requiere DDL ni recargar juegos.
3. Para conservar tus cambios propios, sigue el montaje de Builder que aparece abajo.
   También puedes importar la aplicación completa sobre el mismo ID: sustituirá toda su
   definición por la versión de esta carpeta, incluidos los cambios que tengas en Builder.
4. Abre la página 1 y comprueba también los recorridos anteriores.

## Importar la aplicación

### SQL único

En **App Builder → Import**, selecciona [application/sql/f111.sql](application/sql/f111.sql).
Indica workspace, esquema de parsing e ID de aplicación. Para la ruta A, usa un ID nuevo;
para sustituir la versión anterior en la ruta B, selecciona su ID tras guardar el respaldo.
Revisa el resumen antes de instalar. La importación no instala los objetos de base de datos.

### APEXlang

Desde esta carpeta, con SQLcl conectado al esquema de parsing:

```text
apex validate -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE
apex import -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE -schema TU_ESQUEMA -id ID_DESTINO -alias A-QUE-JUGAMOS
```

Elige el ID según la ruta A o B y otro alias si ya está ocupado por una aplicación distinta.
Las páginas anteriores conservan referencias a servicios IA y credenciales sin secreto;
enlaza los de tu entorno sólo si vas a usar NL2IR. Consulta [NOTICE.md](NOTICE.md) sobre la preparación del export
y la regeneración de bookmarks tras importar.

## Transformar la cabecera de Inicio en Builder

1. Guarda una copia de la app y una captura de **1 · Inicio** antes de cambiarla: tiene un
   Hero con título, imagen y texto, seguido de dos accesos. No crees una página nueva.
2. Selecciona la región Static Content **¿A qué jugamos?**. Conserva su Static ID de
   componente (`home-hero` en el ejemplo); no lo desbloquees para aplicar CSS.
3. Cambia **Template: Hero → Blank with Attributes** y **Slot: Breadcrumb Bar → Body**.
   Mantén la secuencia 10, por delante de **Elige un recorrido** (20). La posición Body
   aporta el margen exterior de la página. No cambies la lista ni sus enlaces.
4. Retira **Image → File URL** del Hero. Conserva el archivo compartido de icono de la app.
5. En **Advanced → HTML DOM ID**, escribe `collection_intro`, sin #. Pega
   [snippets/intro.html](snippets/intro.html) en **Source → HTML Code**: texto con h1 y SVG
   decorativo propio. No repitas ese ID dentro del HTML.
6. Pega [snippets/page.css](snippets/page.css) en **Page → CSS → Inline**. Integra las reglas
   con el CSS propio que ya tengas. Las variables de Universal Theme toman los colores de
   Iris; las clases propias organizan el contenido. No se cambia el tema global.
7. Guarda, ejecuta Inicio y compara con la captura original al mismo tamaño. El resultado
   conserva los accesos, con una bienvenida separada de la barra y del contenido inferior.

## Qué comprobar

- Un único elemento con ID `collection_intro`; Static ID `home-hero` conservado en Builder.
- Fondo claro con un matiz del color principal de Iris, texto del tema, sin borde visible
  y sombra suave. La cabecera tiene aire alrededor y mantiene los dos accesos debajo.
- Las rutas Evaluar NL2IR y Seleccionar filas siguen funcionando. No hace falta consumir
  IA para comprobar el cambio de cabecera.
- A menos de 640 px se oculta la ilustración. Comprobar texto, foco, encabezados, contraste
  y presentación en los estilos/anchuras que utilice tu app.

## Archivos

| Ruta | Contenido |
| --- | --- |
| database/install.sql | Objetos y datos completos para instalar desde cero. |
| database/verify.sql | Comprobaciones del esquema existente, sin modificar datos. |
| application/sql/f111.sql | Aplicación completa en SQL único. |
| application/apexlang/a-que-jugamos/ | La misma aplicación en APEXlang. |
| snippets/intro.html | HTML de la bienvenida. |
| snippets/page.css | CSS Inline de la página. |

Consulta la [licencia MIT](../LICENSE) del repositorio.
