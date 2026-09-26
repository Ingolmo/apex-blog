# Selección múltiple en Interactive Reports con APEX 26.1

Ejemplo del artículo [Selección múltiple en Interactive Reports con APEX 26.1](https://juanl.hashnode.dev/seleccion-multiple-interactive-report-oracle-apex-26-1). Continúa *¿A qué jugamos?*: la página **Preparar propuesta** usa `APEX$ROW_SELECTOR` para recoger varias claves de un Interactive Report y añadir los juegos a una propuesta del usuario conectado. Las páginas V0–V4 de NL2IR siguen disponibles para comparar el recorrido completo.

El repositorio incluye la aplicación completa en [APEXlang](application/apexlang/a-que-jugamos/) y en [un único SQL de APEX](application/sql/f111.sql). Ambas son alternativas de importación de la misma aplicación; instala **una** de ellas. Los objetos de base de datos se instalan antes, con una de las dos rutas siguientes.

## Requisitos

- Oracle APEX 26.1 y un workspace con esquema de parsing donde se puedan crear tablas, vistas y paquetes.
- Para importar APEXlang, SQLcl 26.1 con soporte de APEXlang y el esquema REST habilitado.
- Para usar las páginas NL2IR, un servicio de IA generativa configurado en el workspace. La página del selector no llama al servicio de IA.
- Una conexión al esquema de parsing para ejecutar los scripts SQL. No se incluyen credenciales ni claves.

Los datos son sintéticos. La importación no instala los objetos de base de datos automáticamente.

## Ruta A: instalar todo desde cero

1. En un esquema de laboratorio, ejecuta [database/install.sql](database/install.sql) con SQLcl o SQL Workshop. Crea `NL2IR_GAMES`, `NL2IR_PLAY_SESSIONS`, `NL2IR_V_LIBRARY`, las dos tablas de propuestas y `NL2IR_GAME_NIGHT_API`; carga los 28 juegos y las 32 partidas del ejemplo original. El script conserva filas ya existentes con las mismas claves y se puede volver a ejecutar en un esquema compatible.
2. Importa **una** de las versiones de la aplicación siguiendo las instrucciones de abajo. Usa un ID libre. El ID de origen es `111`.
3. Si vas a usar NL2IR, configura tu propio servicio de IA y asígnalo a la aplicación. El servicio `Open AI` incluido en la exportación es una definición sin secreto; durante la importación debes vincular una credencial de tu entorno o cambiar la referencia por un servicio existente.
4. Abre **Preparar propuesta** con un usuario autenticado. Marca dos juegos y comprueba que `P8_SELECTED_GAME_IDS` muestra sus IDs separados por dos puntos. Pulsa **Añadir a la propuesta** y verifica la propuesta del usuario.

## Ruta B: continuar el ejercicio NL2IR anterior

1. Usa el **mismo esquema de parsing** que ya contiene el ejercicio de [nl2ir-a-que-jugamos](../nl2ir-a-que-jugamos/). Verifica que existen `NL2IR_GAMES` y `NL2IR_V_LIBRARY`.
2. Ejecuta sólo [database/upgrade-from-nl2ir.sql](database/upgrade-from-nl2ir.sql). Crea las tablas de propuestas y el paquete de servidor; no modifica los datos ni la vista del ejercicio anterior. Se puede volver a ejecutar en un esquema compatible.
3. Importa la aplicación completa de esta carpeta. Para conservar la app NL2IR original, elige un **ID distinto** del que usa esa app, por ejemplo `112` si está libre. Si eliges el mismo ID, APEX reemplazará la aplicación existente tras la confirmación de importación.
4. Mantén o vuelve a asignar el servicio de IA de tu workspace para las páginas V0–V4. Entra en **Preparar propuesta** y realiza la prueba anterior.

La ruta B instala una versión ampliada de la aplicación, no un parche de página 8. Las dos exportaciones contienen también la navegación nueva: **Inicio**, **Evaluar NL2IR** y **Preparar propuesta**.

## Importar la aplicación

### SQL único de APEX

En **App Builder > Import**, selecciona [application/sql/f111.sql](application/sql/f111.sql). Indica el workspace, el esquema de parsing y un ID de aplicación libre. Revisa el resumen de importación antes de instalar. La exportación es un único archivo SQL de la aplicación; ejecuta aparte el script de base de datos de la ruta elegida.

### APEXlang

Desde la raíz de esta carpeta, con SQLcl conectado al esquema de parsing:

```text
apex validate -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE
apex import -input application/apexlang/a-que-jugamos -workspace TU_WORKSPACE -schema TU_ESQUEMA -id ID_LIBRE
```

`deployments/default.json` conserva el ID de origen `111`; `-id` permite elegir otro. La definición APEXlang referencia el servicio `open-ai` y su credencial sin secreto. Puedes enlazar tu credencial al importarlo o cambiar `service: @open-ai` en `application.apx` por el static ID de un servicio que ya exista. No escribas claves en los archivos del repositorio.

Tras importar cualquiera de las dos variantes, revisa **Shared Components > Security Attributes** y usa **Expire Bookmarks** para regenerar el `checksumSalt` neutralizado en la exportación antes de compartir la app fuera de un entorno de pruebas.

## Qué comprobar

- En **Preparar propuesta**, el IR muestra una fila por juego y `GAME_ID` es su clave primaria. `APEX$ROW_SELECTOR` tiene multiselección y **Show Select All**; la selección llega a `P8_SELECTED_GAME_IDS` sin JavaScript personalizado.
- **Añadir a la propuesta** usa una Dynamic Action declarativa con confirmación, envío o aviso si no hay selección.
- `NL2IR_GAME_NIGHT_API` toma las claves como entrada no confiable: localiza un borrador del usuario autenticado, exige juegos activos y evita duplicados. El proceso limpia el item después de añadirlos.
- Prueba una selección repetida, un filtro y la paginación. Un refresh de la región reinicia la selección; completa la acción antes de refrescar.

El item de IDs se deja visible y editable para enseñar el enlace con el selector. No es un control de seguridad. La autorización y las comprobaciones de claves se hacen en el servidor.

## Archivos

| Ruta | Contenido |
| --- | --- |
| `database/install.sql` | Esquema y datos completos para empezar desde cero. |
| `database/upgrade-from-nl2ir.sql` | Sólo los objetos añadidos para la propuesta. |
| `application/apexlang/a-que-jugamos/` | Aplicación completa en APEXlang. |
| `application/sql/f111.sql` | Aplicación completa en un único SQL importable. |

Consulta la [licencia MIT](../LICENSE) del repositorio.
