# Example 1 — conditional email-presence validation

Status: **accepted after validation, approved import and functional tests**.

## Application context

```text
Application: Demo APEX_LANG
Alias: DEMO-APEX-LANG
Application ID: 100
Workspace / parsing schema: DEV_BLOG
Form page: 3
Table: ALD_CUSTOMERS
```

The real item names are `P3_CONTACT_CHANNEL` and `P3_EMAIL`. In the original baseline, `P3_CONTACT_CHANNEL` was a Select List with static return values `EMAIL` and `PHONE`, and the form allowed `EMAIL` with a null `P3_EMAIL`.

## Requested change

Create exactly one server-side conditional validation on page 3 that prevents saving when `P3_CONTACT_CHANNEL = EMAIL` and `P3_EMAIL` is null.

Use this exact error message:

```text
Introduce una dirección de correo electrónico cuando el canal de contacto sea Email.
```

Associate the validation with `P3_EMAIL` when technically supported by the verified APEXlang metadata.

## Exclusions

Do not alter:

- `ALD_CUSTOMERS`;
- the report definition;
- form DML;
- the `P3_CONTACT_CHANNEL` Select List or its static values;
- unrelated items;
- other pages;
- shared components;
- navigation;
- security;
- unrelated metadata;
- `.apex/apexlang.json`.

Do not add email-format validation, client-side JavaScript, a database constraint, a trigger or another implementation of the same business rule.

## Acceptance evidence

1. `EMAIL` with an email saved successfully.
2. `EMAIL` without an email was blocked with the exact approved message.
3. `PHONE` without an email saved successfully.
4. The report, form update, DML and static `P3_CONTACT_CHANNEL` Select List remained functional.
5. No unrelated component change was observed.

The post-import insertion regression was not repeated to avoid creating and deleting an artificial row.
