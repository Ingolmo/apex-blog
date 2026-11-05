# Exportación de referencia

Generada en Oracle APEX 26.1.0 a partir de la aplicación 111. Las exportaciones SQL y APEXlang
incluyen las páginas de los ejemplos anteriores y la página 20 Mi colección.

No se incluyen secretos. Proporciona una credencial propia si utilizas las páginas NL2IR.
El checksumSalt se neutraliza en el material público: tras importar, regenera el valor con
**Shared Components → Security Attributes → Expire Bookmarks** antes de compartir tu instalación.

La fuente APEXlang normaliza el alias de exportación del Row Selector de página 8, de A a P,
para evitar su colisión con GAME_ID al validar. No cambia la clave seleccionada ni la lógica
servidor. El SQL único conserva la representación generada por APEX.
