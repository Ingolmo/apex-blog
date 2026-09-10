# Exportación de referencia

Generada en Oracle APEX 26.1.0 a partir de la aplicación 111, el 10 de septiembre de 2026.

La aplicación está disponible en dos formatos:

- `application/apexlang/a-que-jugamos/`: fuente APEXlang.
- `application/sql/f111.sql`: exportación SQL estándar de APEX.

No contiene secretos. Ambas exportaciones incluyen la definición de una credencial sin valor; proporciona siempre una credencial propia del entorno de destino.

Las exportaciones neutralizan deliberadamente el `checksumSalt` para que no contengan un secreto reutilizable. Después de importar la aplicación, regenera ese valor desde `Shared Components > Security Attributes` mediante `Expire Bookmarks` antes de utilizarla fuera de un entorno de pruebas.
