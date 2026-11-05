# Evidencia y límites del laboratorio

Montaje del 5 de noviembre de 2026 en Oracle APEX 26.1.0, Universal Theme 26.1, estilo Iris.
La app de desarrollo sigue siendo la 111; la nueva página es 20, Mi colección.

## Comprobado

- Creación desde V4 mediante Create Page as Copy, dentro de la misma aplicación.
- Guardado de HTML, IDs DOM y CSS confirmado en Builder.
- Las páginas 0–8 y 9999 y la configuración de aplicación conservan su fuente anterior.
  La ampliación añade únicamente la página 20 y una entrada en Navigation Menu.
- La página 20 no añade botones, Dynamic Actions, consultas distintas ni objetos de dominio.
- Las propiedades exportadas incluyen collection_intro y my_collection. HTML y CSS coinciden
  con snippets. La consulta y el contexto NL2IR proceden de la página 7.
- Las tablas, vista y paquete anteriores están presentes y válidos. El dataset sigue teniendo
  28 juegos y 32 partidas; no se ejecutó una nueva carga ni una escritura de dominio.
- Exportación SQL completa generada desde la app guardada. Fuente APEXlang pública validada
  con SQLcl 26.1; el alias duplicado del Row Selector de página 8 se normaliza sólo en ese formato.
- Las tres capturas son de Builder, con checksum en manifest.json. No se altera la autenticación.

## Pendiente en ejecución

Login de aplicación, antes/después visual, inspección del DOM renderizado, filtros, paginación,
refresh, NL2IR, teclado, encabezados, contraste, distintas anchuras y zoom. El login de Builder
es independiente de la sesión de ejecución; ésta no estuvo disponible durante el montaje.

No se ha reimportado el snapshot público en otro entorno. Estos límites impiden presentar
el ejemplo como publicación terminada; el PR queda como borrador para revisión y validación.

## Comprobación posterior con sesión de ejecución

Capturas de escritorio a 1920 × 1080 mediante screenshot del viewport completo, independiente
del panel lateral del chat. Los IDs collection_intro y my_collection aparecen una sola vez.
El estilo calculado confirma padding de 24 px y borde lateral de 4 px en la bienvenida, y
borde superior de 2 px en el informe. La búsqueda nativa Carcassonne devuelve una fila;
retirar el filtro y recargar restaura los 28 juegos. No se ha modificado la app para capturar.

Se conservan las capturas 04 (colección) y 05 (filtro). Quedan pendientes el antes sin CSS,
la prueba NL2IR, paginación, revisión completa de teclado/encabezados, móvil, zoom y contraste.
La comprobación anterior de falta de login describe el primer montaje, no el estado actual.
