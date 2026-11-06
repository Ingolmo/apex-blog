# Exportación de referencia

Generada en Oracle APEX 26.1.0 a partir de la aplicación 111. Las exportaciones SQL y APEXlang
incluyen las páginas de los ejemplos anteriores y la cabecera de Inicio (página 1) actualizada.
Este ejemplo no añade páginas ni informes.

No se incluyen secretos. Proporciona una credencial propia si utilizas las páginas NL2IR.
El checksumSalt se neutraliza en el material público: tras importar, regenera el valor con
**Shared Components → Security Attributes → Expire Bookmarks** antes de compartir tu instalación.

La fuente APEXlang normaliza el alias de exportación del Row Selector de página 8, de A a P,
para evitar su colisión con GAME_ID al validar. No cambia la clave seleccionada ni la lógica
servidor. El SQL único conserva la representación generada por APEX.

La descarga conserva el servicio Open AI de referencia ya usado en los ejemplos anteriores,
sin secreto. La conexión IA que utilice el autor en su workspace no se distribuye como
requisito del lab. Configura tu propio servicio sólo si ejecutas las páginas NL2IR.
