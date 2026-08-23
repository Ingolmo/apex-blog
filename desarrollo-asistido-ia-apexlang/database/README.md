# Database source

This directory contains the portable, reviewable database source required to recreate the article laboratory. It is separate from the APEX application export because APEXlang represents application metadata, not the parsing schema.

The verified laboratory contains one application-owned database object: `ALD_CUSTOMERS`. Its definition is stored one object per file under `tables/`. Synthetic baseline rows are stored separately under `seed/` so readers can distinguish schema from sample data.

```text
database/
├── README.md
├── install.sql
├── tables/
│   └── ald_customers.sql
└── seed/
    └── ald_customers.sql
```

The SQL is intentionally schema-unqualified and omits storage, tablespace and other environment-specific clauses. Run it only as the intended parsing-schema owner in an empty laboratory schema and only after reviewing the target connection. Nothing in this repository authorizes an agent to execute it.

`install.sql` is the explicit entry point. No teardown script is published: cleanup is environment-specific and destructive, and is not required to reproduce either article example.
