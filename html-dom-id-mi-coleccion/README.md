# HTML DOM ID en APEX: Mi colección

Ejemplo del artículo en preparación **HTML DOM ID en APEX: el Static ID que ya no era el que buscaba**.
El enlace a Hashnode se añadirá al publicar.

Continúa [la selección múltiple](../seleccion-multiple-interactive-report/): añade la página
**20 · Mi colección** a la misma app, conservando V0–V4 y Preparar propuesta. Incluye una
bienvenida cálida con ilustración propia, el informe de V4 y los ajustes HTML/CSS del ejemplo.

La aplicación se ofrece en [SQL único](application/sql/f111.sql) y en
[APEXlang](application/apexlang/a-que-jugamos/). Son dos formatos del mismo resultado: importa
**uno**. Los objetos de base de datos se preparan aparte según la ruta elegida.

## Requisitos

- Oracle APEX 26.1 y Universal Theme 26.1; el ejemplo utiliza Iris.
- Un workspace, un esquema de parsing y un usuario para acceder a la aplicación.
- SQLcl 26.1 con soporte APEXlang y esquema REST habilitado si eliges ese formato.
- Un servicio IA propio sólo para usar NL2IR. El montaje HTML/CSS y la búsqueda de texto del
  informe no necesitan llamadas a un proveedor de IA.

Los datos son sintéticos. No se incluyen usuarios, contraseñas ni claves.

## Ruta A: instalar desde cero

1. Ejecuta [database/install.sql](database/install.sql) en el esquema de parsing. Incluye
   los objetos de los ejercicios anteriores, los 28 juegos y las 32 partidas iniciales.
2. Importa una de las versiones de la aplicación siguiendo las instrucciones de abajo.
   Elige un ID libre; el ID de origen es 111.
3. Si vas a usar NL2IR, asigna tu propio servicio y credencial en el workspace.
4. Abre **Mi colección** desde el menú lateral y realiza las comprobaciones finales.

## Ruta B: ampliar tu aplicación existente

1. Usa la app del ejemplo de selección múltiple y el mismo esquema de parsing. Guarda una
   exportación de respaldo. En nuestro entorno seguimos trabajando sobre la app **111**.
2. Ejecuta [database/verify.sql](database/verify.sql). Comprueba las tablas, la vista y el
   paquete existentes sin modificar datos. Este incremento no requiere DDL ni recargar juegos.
3. Para conservar tus cambios propios, sigue el montaje de Builder que aparece abajo.
   También puedes importar la aplicación completa sobre el mismo ID: sustituirá toda su
   definición por la versión de esta carpeta, incluidos los cambios que tengas en Builder.
4. Abre la página 20 y comprueba también los recorridos anteriores.

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
La definición referencia el servicio open-ai y una credencial sin secreto; enlaza los de tu
entorno antes de usar NL2IR. Consulta [NOTICE.md](NOTICE.md) sobre la preparación del export
y la regeneración de bookmarks tras importar.

## Construir la página en Builder

1. Dentro de la app existente: **Create Page → Create Page as Copy → Page in this application**.
   Copia la página **7 · V4 · Columnas derivadas** a una página libre, aquí la 20. Nombre:
   **Mi colección**; alias: MI-COLECCION. Crea una entrada de menú sin padre con ese nombre.
2. En la página nueva retira los botones GO_TO_VERSION_3 y GO_TO_CHECKBOX. Conserva las
   páginas originales y la consulta, columnas, formatos y configuración NL2IR del informe.
3. Reutiliza la región Static Content copiada de V4: nombre **Bienvenida a mi colección**,
   Slot **Body**, secuencia 10 y plantilla **Blank with Attributes**.
4. Pega [snippets/intro.html](snippets/intro.html), que incluye el SVG decorativo propio. En **Advanced → HTML DOM ID**, escribe
   collection_intro, sin #. Conserva su Static ID; no repitas el ID en el HTML interior.
5. Renombra la región de informe a **Mi colección**, secuencia 20. Mantén la plantilla
   **Interactive Report** y asigna my_collection en **HTML DOM ID**.
6. Guarda y ejecuta para comprobar el punto de partida. Después pega
   [snippets/page.css](snippets/page.css) en **Page → CSS → Inline**, guarda y ejecuta de nuevo.
7. Si no creaste la entrada de menú en el asistente, añádela apuntando a la nueva página.

## Qué comprobar

- La bienvenida muestra una superficie marfil, texto verde petróleo y una ilustración
  decorativa de juegos. El informe queda separado por espacio, conservando su estilo nativo.
- Hay un único elemento con ID collection_intro y otro con ID my_collection en el DOM.
- Buscar Carcassonne con el filtro de texto devuelve una fila; quitarlo y recargar recupera
  los 28 juegos del dataset inicial. Con datos propios, el recuento puede ser diferente.
- Comprueba controles, paginación, foco, encabezados y presentación a distintas anchuras.
  Por debajo de 640 px se oculta la ilustración y permanece el texto de bienvenida.
  Si configuraste IA, repite una pregunta del ejemplo V4 para comprobar NL2IR.

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
