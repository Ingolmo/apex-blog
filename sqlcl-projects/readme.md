# Oracle APEX y SQLcl Projects: CI/CD explicado paso a paso

Este repositorio contiene el **resultado exportado** de la aplicación *Customers App* (ID 110) utilizando la funcionalidad **Projects** de [Oracle SQLcl](https://www.oracle.com/database/technologies/appdev/sqlcl.html), pensada para integrar el versionado y la automatización CI/CD en entornos Oracle APEX.

La estructura de carpetas responde al formato estándar que genera SQLcl Projects:

```
📂 .dbtools/ # Configuración interna de SQLcl Projects (no modificar manualmente)
📂 dist/ # Paquetes listos para despliegue (scripts compilados y empaquetados)
📂 src/ # Código fuente estructurado para desarrollo y control de versiones
├── 📂 apex/ # Export de aplicaciones APEX en formato legible (por páginas, shared components, etc.)
├── 📂 data/ # Scripts de carga de datos iniciales o de prueba
├── 📂 ddl/ # Definición de objetos de base de datos (tablas, vistas, índices, etc.)
├── 📂 plsql/ # Código PL/SQL (paquetes, funciones, procedimientos)
└── 📂 rest/ # Definiciones de servicios REST habilitados en la base de datos
```


> ℹ️ Una explicación paso a paso de cómo generar este proyecto y configurar un flujo CI/CD con SQLcl Projects se encuentra en el post:  
> [**Oracle APEX y SQLcl Projects: CI/CD explicado paso a paso**](https://juanl.hashnode.dev/oracle-apex-y-sqlcl-projects-cicd-explicado-paso-a-paso)  
> *(Este repositorio forma parte del material complementario del artículo).*

## Ejemplo: crear modelo QuickSQL y generar la aplicación

A continuación, un ejemplo de cómo partir de un script QuickSQL, generar el modelo en la base de datos y crear la aplicación APEX desde SQLcl:

```sql
-- 1. Generar objetos para el ejemplo usando QuickSQL
pd_customers /api
    name
    last_name
    email           /uk
    phone_number
    create_date
    update_date

-- 2. Revisar y ejecutar el script generado

-- 3. Crear aplicación a partir de la ejecución del script
```

Estas instrucciones permiten colocarse en el punto de partida necesario para ejecutar los pasos dispuestos en el blog, y lanzar un versionado de esta aplicación utilizando SQLcl Projects.

## Licencia
Este repositorio se distribuye únicamente con fines educativos y de demostración.