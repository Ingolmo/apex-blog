whenever oserror exit failure rollback
whenever sqlerror exit sql.sqlcode rollback

prompt Installing ALD_CUSTOMERS in the current schema...

@@tables/ald_customers.sql
@@seed/ald_customers.sql

prompt Database baseline installed.
