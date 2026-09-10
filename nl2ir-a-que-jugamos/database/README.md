# Datos de partida

Ejecuta `install.sql` con el esquema de parsing de la aplicación antes de importarla. El script no borra objetos ni datos existentes: crea los objetos que faltan e inserta únicamente las filas de muestra que no existan.

La aplicación no instala estos objetos automáticamente mediante Supporting Objects. Así se puede revisar el script y decidir explícitamente en qué esquema se crea el conjunto de datos antes de importar la aplicación.
