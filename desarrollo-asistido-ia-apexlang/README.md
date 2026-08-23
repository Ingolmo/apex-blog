# Desarrollo asistido con IA y APEXlang

Material reproducible del artículo **[Probando el desarrollo asistido con IA y APEXlang en Oracle APEX 26.1](https://juanl.hashnode.dev/desarrollo-asistido-ia-apexlang)**.

El laboratorio parte de una aplicación APEX existente con tres páginas:

- página 1: Home;
- página 2: informe de clientes;
- página 3: formulario de alta y modificación sobre `ALD_CUSTOMERS`.

El artículo recorre dos cambios independientes:

1. una validación que exige `P3_EMAIL` cuando `P3_CONTACT_CHANNEL = EMAIL`;
2. la conversión de los valores estáticos del selector en una LOV compartida, reutilizada en las páginas 2 y 3.

## Contenido

```text
desarrollo-asistido-ia-apexlang/
├── AGENTS.md
├── README.md
├── applications/        # estado aceptado después de los dos ejemplos
├── baseline/            # export APEXlang inicial
├── changes/             # diff independiente de cada ejemplo
├── database/            # tabla portable y datos sintéticos
├── downloads/           # ZIP preparados para importar desde App Builder
└── spec/                # alcance y criterios de aceptación
```

`baseline/` y `applications/` contienen árboles APEXlang completos. Los archivos de `changes/` permiten estudiar cada intervención sin confundir ambos diffs.

## Requisitos

- Oracle APEX 26.1;
- SQLcl compatible con el `mmdVersion` `26.1.0+3102` del export;
- Java compatible con la versión de SQLcl utilizada;
- Oracle SQL Developer for VS Code, si se quiere reproducir el flujo del artículo;
- Node.js y `npx` únicamente si se van a instalar las skills del agente.

Las skills utilizadas en el experimento pueden instalarse, si no existen ya, con:

```shell
npx skills add oracle/skills/apex
npx skills add oracle/skills/db
```

## Ruta rápida desde el navegador

No es obligatorio utilizar SQLcl para preparar el punto de partida. Todo el laboratorio puede arrancarse desde el navegador con SQL Workshop y App Builder.

### 1. Crear la tabla y los datos

Descargue [`database/install-sql-workshop.sql`](./database/install-sql-workshop.sql) y, dentro del workspace de APEX:

1. abra **SQL Workshop > SQL Scripts**;
2. pulse **Upload** y seleccione el archivo;
3. compruebe que está trabajando con el esquema que utilizará la aplicación;
4. ejecute el script y revise el resultado.

El script crea `ALD_CUSTOMERS` e inserta dos filas sintéticas. No elimina ni sustituye objetos existentes, por lo que fallará si la tabla ya existe.

### 2. Importar la aplicación inicial

Descargue [`downloads/demo-apex-lang-baseline.zip`](./downloads/demo-apex-lang-baseline.zip) y siga estos pasos:

1. abra **App Builder > Import**;
2. arrastre o seleccione el ZIP;
3. confirme que el tipo detectado es **APEXlang**;
4. elija el parsing schema donde creó `ALD_CUSTOMERS`;
5. asigne un Application ID libre e importe la aplicación.

La importación de APEXlang desde App Builder requiere Oracle APEX 26.1, ORDS 26.1.1 o posterior y al menos un esquema del workspace habilitado para REST. Si hace falta, el propio asistente mostrará la opción **REST Enable Schema**.

También se incluye [`downloads/demo-apex-lang-final.zip`](./downloads/demo-apex-lang-final.zip) con el estado aceptado después de los dos ejemplos. Importe ese ZIP con otro Application ID si quiere comparar ambas aplicaciones sin sustituir la inicial.

## Crear el punto de partida manualmente

Si prefiere construir la aplicación en App Builder en lugar de importar el ZIP:

1. cree una aplicación llamada `Demo APEX_LANG` con una página Home;
2. añada como página 2 un Interactive Report sobre `ALD_CUSTOMERS`;
3. añada como página 3 un formulario modal sobre la misma tabla, utilizando `CUSTOMER_ID` como clave primaria;
4. conecte el informe con el formulario para crear y editar clientes;
5. configure `CONTACT_CHANNEL` como Select List con los valores estáticos `Email;EMAIL` y `Phone;PHONE`.

Esta ruta reproduce el punto de partida funcional, pero APEX puede asignar identificadores y metadata diferentes. Si quiere aplicar los parches o comparar exactamente los diffs del artículo, utilice el ZIP del baseline.

## Ruta con SQLcl

### Recrear el esquema

La carpeta `database/` contiene un único objeto portable y dos filas sintéticas. Revise siempre la conexión antes de ejecutar SQL. En un esquema vacío destinado al laboratorio:

```sql
@database/install.sql
```

El script no incluye teardown. La limpieza es destructiva y depende del entorno, por lo que queda fuera del recorrido principal.

### Partir del export inicial

Copie `baseline/demo-apex-lang/` a la carpeta `applications/` de su propio laboratorio y consérvelo primero mediante un commit o una copia recuperable. Desde la raíz de ese laboratorio, los ciclos del artículo son:

```sql
apex validate -input './applications/demo-apex-lang'
apex import -input './applications/demo-apex-lang'
```

Una validación correcta no autoriza la importación. Revise el diff y el destino; importe solo sobre una aplicación de laboratorio y después de una aprobación humana explícita.

Para reproducir los cambios de forma secuencial, aplique primero `changes/example-1-conditional-validation.patch` y, sobre ese estado aceptado, `changes/example-2-shared-lov.patch`. `applications/demo-apex-lang/` permite comparar directamente el resultado final.

### Exportar su propia aplicación

El artículo utiliza una conexión al esquema de parsing y este comando desde SQLcl:

```sql
apex export -applicationid <APP_ID> -dir './applications' -exptype APEXLANG
```

No exporte sobre una carpeta que contenga cambios locales sin revisar antes el riesgo de sobrescritura.

## Nota de seguridad sobre el export público

El export real contenía el `checksumSalt` oculto que APEX utiliza para la protección del estado de sesión. Este repositorio no publica el valor del laboratorio: ambas copias de `application.apx` utilizan deliberadamente una secuencia pública de ceros. La [documentación de seguridad de APEX 26.1](https://docs.oracle.com/en/database/oracle/apex/26.1/htmdb/configuring-security-attributes.html) explica la función del atributo y cómo regenerarlo.

Después de importar este ejemplo, regenere el salt desde **Shared Components → Security → Session State Protection → Expire Bookmarks** antes de utilizar la aplicación. Por esa sanitización, el paquete público no es byte a byte idéntico al export validado durante el experimento; la metadata funcional de los dos ejemplos sí se conserva.

Los nombres `P9999_USERNAME` y `P9999_PASSWORD` presentes en la página de login son nombres de items declarativos; el repositorio no contiene usuarios ni contraseñas.

## Límites

- La generación inicial de la aplicación no forma parte del experimento.
- No se publica ninguna conexión, wallet, contraseña, token o log de ejecución.
- No se modifica manualmente `.apex/apexlang.json`.
- Los resultados funcionales se verificaron sobre una aplicación local y datos sintéticos; no constituyen una garantía general para otras aplicaciones.
