create or replace package body projects_demo.pd_customers_api is

    procedure get_row (
        p_id           in number,
        p_name         out varchar2,
        p_last_name    out varchar2,
        p_email        out varchar2,
        p_phone_number out number,
        p_create_date  out date,
        p_update_date  out date
    ) is
    begin
        for c1 in (
            select
                *
            from
                pd_customers
            where
                id = p_id
        ) loop
            p_name := c1.name;
            p_last_name := c1.last_name;
            p_email := c1.email;
            p_phone_number := c1.phone_number;
            p_create_date := c1.create_date;
            p_update_date := c1.update_date;
        end loop;
    end get_row;

    procedure insert_row (
        p_id           in number default null,
        p_name         in varchar2 default null,
        p_last_name    in varchar2 default null,
        p_email        in varchar2 default null,
        p_phone_number in number default null,
        p_create_date  in date default null,
        p_update_date  in date default null
    ) is
    begin
        insert into pd_customers (
            id,
            name,
            last_name,
            email,
            phone_number,
            create_date,
            update_date
        ) values ( p_id,
                   p_name,
                   p_last_name,
                   p_email,
                   p_phone_number,
                   p_create_date,
                   p_update_date );

    end insert_row;

    procedure update_row (
        p_id           in number default null,
        p_name         in varchar2 default null,
        p_last_name    in varchar2 default null,
        p_email        in varchar2 default null,
        p_phone_number in number default null,
        p_create_date  in date default null,
        p_update_date  in date default null
    ) is
    begin
        update pd_customers
        set
            id = p_id,
            name = p_name,
            last_name = p_last_name,
            email = p_email,
            phone_number = p_phone_number,
            create_date = p_create_date,
            update_date = p_update_date
        where
            id = p_id;

    end update_row;

    procedure delete_row (
        p_id in number
    ) is
    begin
        delete from pd_customers
        where
            id = p_id;

    end delete_row;

end pd_customers_api;
/


-- sqlcl_snapshot {"hash":"8d15c05c2ec0b56479a8f1c701a4a31ea53bfe87","type":"PACKAGE_BODY","name":"PD_CUSTOMERS_API","schemaName":"PROJECTS_DEMO","sxml":""}