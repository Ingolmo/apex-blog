# Example 2 — shared contact-channel LOV

Status: **accepted after connected validation, approved import and functional checks**.

## Application context

```text
Application: Demo APEX_LANG
Alias: DEMO-APEX-LANG
Application ID: 100
Workspace / parsing schema: DEV_BLOG
Report page: 2
Form page: 3
Table: ALD_CUSTOMERS
```

The input state must be a recoverable checkpoint of the accepted example 1. The original immutable export remains under `baseline/`.

## Requested change

Create one reusable shared LOV for the contact channel with display and return semantics equivalent to the existing static values:

```text
Email -> EMAIL
Phone -> PHONE
```

Use that shared LOV:

- as the LOV source of `P3_CONTACT_CHANNEL` on page 3;
- for the corresponding contact-channel column on the page 2 report, using the APEX-supported report-column integration confirmed by the APEXlang grammar and compiler metadata.

Before editing, confirm the exact shared-component declaration, the report column integration and the files expected to change. Do not infer unsupported APEXlang properties.

## Exclusions

Do not alter `ALD_CUSTOMERS`, the allowed return values, form DML, the accepted validation from example 1, unrelated report columns, other pages, navigation, security or unrelated shared components.

## Acceptance tests

1. The shared LOV exists once and returns exactly `EMAIL` and `PHONE`.
2. Page 3 uses the shared LOV and still inserts or updates both values correctly.
3. Page 2 renders the contact channel using the shared LOV semantics without changing filtering, sorting or row retrieval.
4. The accepted conditional validation from example 1 still passes its three cases.
5. No unrelated component changes.

## Gates

- Show the complete diff and pass live `apex validate` before requesting import approval.
- Import only after explicit human approval, revalidating and importing the same reviewed tree in one SQLcl session.
- Do not execute direct DDL, ad hoc DML or database scripts.

## Acceptance evidence

1. App Builder contains one static shared LOV `CONTACT_CHANNEL` with `Email -> EMAIL` and `Phone -> PHONE`.
2. Page 3 uses the shared LOV from `P3_CONTACT_CHANNEL`; `EMAIL` with an email and `PHONE` without an email saved successfully, while `EMAIL` without an email remained blocked by example 1.
3. Page 2 uses the same named LOV for display and exact-match filtering, retains two rows and shows the labels `Email` and `Phone`.
4. The final connected validation and explicitly approved import passed with no unresolved APEXlang problems.
5. The accepted diff is limited to `shared-components/lovs.apx`, `pages/p00003-ald-customer.apx` and `pages/p00002-customers.apx`.

The post-import insertion regression was not repeated; no direct DDL, ad hoc DML or database script was executed.
