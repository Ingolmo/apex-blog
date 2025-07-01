# ⚙️ Data Generator en Oracle APEX

Este proyecto acompaña al artículo publicado en el blog:  
📖 [Todo lo que debes saber sobre Data Generator en Oracle APEX](https://juanl.hashnode.dev/tu-url-final-aqui)  
Exploramos cómo usar la utilidad **Data Generator** de Oracle APEX para poblar nuestras aplicaciones con datos realistas de forma rápida y controlada.

---

## 📁 Contenido de esta carpeta

- `data_generator_demo_app.sql` → Export de la aplicación APEX. Incluye los objetos de base de datos `DG_PERSONAS` y `DG_MASCOTAS` como parte del script de instalación.
- `data_generator_post.json` → Export de un Blueprint de Data Generator creado en el ejemplo.

---

## 🛠️ Instalación paso a paso

### 1. Importar la app en Oracle APEX

1. Accede a tu [entorno APEX](https://apex.oracle.com/) (o el que estés usando).
2. Dirígete a **App Builder** y selecciona **Importar**.
3. Sube el archivo `data_generator_demo_app.sql`.
4. Sigue el asistente de instalación:
   - Si se solicita, acepta la creación de **supporting objects** (tablas, secuencias, etc.) si no has creado los objetos por ti mismo, siguiendo las instrucciones de post.
   - Finaliza el proceso y ejecuta la app.

> **Nota:** Esta app incluye las tablas `DG_PERSONAS` y `DG_MASCOTAS`, incluyendo un par de informes interactivos y algún gráfico en la pantalla principal para ilustar el efecto de la generación de datos.

---

### 2. Importar el blueprint en Data Generator

1. Entra en tu entorno APEX y navega a la utilidad:  
   **SQL Workshop > Utilities > Data Generator**
2. Selecciona la opción **Create Blueprint > Import JSON File**.
3. Sube el archivo `data_generator_post.json` o pega su contenido en la pestaña oportuna.
4. Una vez importado, selecciona el blueprint **DATA_GENERATOR_POST**.
5. Haz clic en **Generate Data**, elige tu conexión (workspace/schema) y ejecuta la generación.

> Puedes modificar el número de registros antes de generar, afectando el valor de escalado (Row Scaling). Por defecto, se generan en cada invocación 50 personas y 100 mascotas. El blueprint está diseñado para insertar directamente en la tablas `DG_PERSONAS` y `DG_MASCOTAS` si seleccionas la opción Insert Into Database.

---

## 📌 Requisitos

- Entorno APEX (local o en la nube)
- Permisos para crear objetos y ejecutar scripts
- Acceso a la utilidad **Data Generator** (disponible desde APEX 22.1+)

---

## 💬 Comentarios y mejoras

Si encuentras algún problema con la app o el blueprint, no dudes en abrir un issue o sugerencia.  
¡Y si este ejemplo te fue útil, me encantaría que lo compartas o dejes un comentario en el blog!

---

## 📎 Enlaces útiles

- [Oracle APEX Data Generator (Documentación oficial)](https://docs.oracle.com/en/database/oracle/apex/24.2/aeutl/using-data-generator.html)
- [Blog juanl.hashnode.dev](https://juanl.hashnode.dev/)

---

¡Gracias por pasarte por aquí!
