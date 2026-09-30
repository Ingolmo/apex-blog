# Scripts de base de datos

Ejecuta un solo script con el esquema de parsing antes de importar la aplicación:

- [`install.sql`](install.sql): instalación completa desde cero, con catálogo, partidas, vista, propuestas y API.
- [`upgrade-from-nl2ir.sql`](upgrade-from-nl2ir.sql): ampliación del ejercicio NL2IR anterior, sin tocar su catálogo ni la vista.

Los scripts no borran objetos ni datos. Comprueba que el esquema elegido es un laboratorio y que los objetos `NL2IR_` existentes tienen la estructura del ejemplo. La aplicación no ejecuta Supporting Objects automáticamente.
