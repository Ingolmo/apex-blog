create or replace package projects_demo.pd_customers_api is
    procedure get_row (
        p_id           in number,
        p_name         out varchar2,
        p_last_name    out varchar2,
        p_email        out varchar2,
        p_phone_number out number,
        p_create_date  out date,
        p_update_date  out date
    );

    procedure insert_row (
        p_id           in number default null,
        p_name         in varchar2 default null,
        p_last_name    in varchar2 default null,
        p_email        in varchar2 default null,
        p_phone_number in number default null,
        p_create_date  in date default null,
        p_update_date  in date default null
    );

    procedure update_row (
        p_id           in number default null,
        p_name         in varchar2 default null,
        p_last_name    in varchar2 default null,
        p_email        in varchar2 default null,
        p_phone_number in number default null,
        p_create_date  in date default null,
        p_update_date  in date default null
    );

    procedure delete_row (
        p_id in number
    );

end pd_customers_api;
/


-- sqlcl_snapshot {"hash":"994edcd072c8be8a326374825a3246053a1399ee","type":"PACKAGE_SPEC","name":"PD_CUSTOMERS_API","schemaName":"PROJECTS_DEMO","sxml":""}