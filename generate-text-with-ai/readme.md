# 🤖 Generate Text with AI en Oracle APEX

Este proyecto acompaña al artículo publicado en el blog:  
📖 [Generate Text with AI en Oracle APEX 24.2: un ejemplo útil más allá del típico resumen](https://juanl.hashnode.dev/generate-text-with-ai-oracle-apex-handoff-turnos)

En este ejemplo exploramos cómo usar la acción dinámica **Generate Text with AI** de Oracle APEX para generar una nota de handoff entre turnos a partir del contexto introducido por el usuario en un formulario.

La idea del ejemplo es mostrar una forma sencilla y útil de incorporar IA generativa en una aplicación APEX real, utilizando un caso pequeño y fácil de reproducir.

---

## 📁 Contenido de esta carpeta

- `generate_text_with_ai_demo_app.sql` → Export de la aplicación APEX de ejemplo.
- `README.md` → Instrucciones de instalación y puesta en marcha.

---

## 🛠️ Instalación paso a paso

### 1. Configurar el servicio de IA en el workspace

Antes de importar o probar la aplicación, es necesario tener configurado en Oracle APEX un servicio de IA generativa compatible.

Este paso es imprescindible para que la acción dinámica **Generate Text with AI** pueda funcionar correctamente.

De forma resumida, el proceso sería este:

1. Accedemos a la consola de nuestro proveedor de IA.
2. Generamos la credencial necesaria para autenticarnos frente al servicio (por ejemplo, una API key, según el proveedor).
3. En Oracle APEX, accedemos a **App Builder > Workspace Utilities > Generative AI Services**.
4. Creamos un nuevo servicio de IA generativa.
5. Seleccionamos el proveedor correspondiente y rellenamos la información necesaria.
6. Si procede, creamos o asociamos la credencial requerida durante este mismo proceso.
7. Probamos la conexión y guardamos la configuración.

Una vez creado el servicio en el workspace, conviene también dejarlo disponible para la aplicación, aunque esto es opcional:

8. Abrimos la aplicación en **App Builder**.
9. Accedemos a **Application Definition > AI**.
10. Seleccionamos el servicio de IA que acabamos de crear como servicio por defecto de la aplicación.

> **Nota:** En el blog ya expliqué cómo configuramos la conexión a un proveedor de IA en Oracle APEX en esta entrada anterior:  
> [De Turing a APEX: una mirada a la Inteligencia Artificial aplicada al Low Code](https://juanl.hashnode.dev/de-turing-a-apex-una-mirada-a-la-inteligencia-artificial-aplicada-al-low-code)


---

### 2. Importar la app en Oracle APEX

1. Accede a tu entorno Oracle APEX.
2. Dirígete a **App Builder** y selecciona **Import**.
3. Sube el archivo `generate_text_with_ai_demo_app.sql`.
4. Sigue el asistente de instalación hasta completar la importación.
5. Finaliza el proceso y abre la aplicación.

> **Nota:** Esta aplicación incluye una página de ejemplo centrada en la generación de una nota de handoff entre turnos dentro de un escenario de recepción de hotel.

---

### 3. Configurar el servicio en la acción dinámica

Una vez importada la aplicación, será necesario revisar la configuración de la acción dinámica que utiliza la funcionalidad de IA.

1. Abre la aplicación en **App Builder**.
2. Navega a la **Página 2**.
3. Localiza la acción dinámica correspondiente al botón de generación.
4. Configura en esa acción dinámica el servicio de IA previamente definido en tu entorno.

> Dependiendo de cómo esté configurado tu workspace, puede que también necesites revisar otros atributos relacionados con la integración de IA dentro de la propia aplicación.

---

### 4. Ejecutar la demo

1. Lanza la aplicación.
2. Accede a la **Página 2**.
3. Introduce un contexto de turno en el campo correspondiente.
4. Pulsa el botón para generar la nota de handoff.
5. Revisa la salida generada.

El ejemplo está pensado para generar siempre la nota final en español, aunque el texto de entrada pueda venir en otros idiomas.

---

## 📌 Requisitos

- Entorno Oracle APEX con soporte para **Generate Text with AI**
- Servicio de IA generativa configurado en el entorno
- Permisos para importar aplicaciones APEX
- Acceso a **App Builder** para revisar la configuración de la acción dinámica

---

## 💬 Comentarios y mejoras

Si encuentras algún problema con la app o tienes alguna sugerencia de mejora, no dudes en abrir un issue o compartirlo.

Y si este ejemplo te resulta útil, te animo a revisar el artículo completo en el blog, donde se explica el enfoque, la lógica del caso de uso y algunas consideraciones prácticas para incorporar IA generativa en aplicaciones APEX reales.

---

## 📎 Enlaces útiles

- [Artículo del blog](https://juanl.hashnode.dev/generate-text-with-ai-oracle-apex-handoff-turnos)
- [Post previo sobre la conexión del proveedor de IA](https://juanl.hashnode.dev/de-turing-a-apex-una-mirada-a-la-inteligencia-artificial-aplicada-al-low-code)
- [Oracle APEX Documentation](https://docs.oracle.com/en/database/oracle/apex/)
- [Blog juanl.hashnode.dev](https://juanl.hashnode.dev/)

---

¡Gracias por pasarte por aquí!