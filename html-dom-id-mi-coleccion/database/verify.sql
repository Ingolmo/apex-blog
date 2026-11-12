-- Read-only checks for the existing laboratory schema.
whenever sqlerror exit sql.sqlcode rollback
set serveroutput on
declare
    l_count number;
begin
    select count(*) into l_count from user_tables
     where table_name in ('NL2IR_GAMES','NL2IR_PLAY_SESSIONS','NL2IR_GAME_NIGHTS','NL2IR_GAME_NIGHT_OPTIONS');
    if l_count <> 4 then
        raise_application_error(-20001,'Install the complete laboratory database first.');
    end if;
    select count(*) into l_count from user_objects
     where object_name in ('NL2IR_V_LIBRARY','NL2IR_GAME_NIGHT_API')
       and status = 'VALID';
    if l_count <> 3 then
        raise_application_error(-20002,'The view and API specification/body must be valid.');
    end if;
    dbms_output.put_line('Required laboratory objects are present and valid.');
end;
/
select count(*) game_count from nl2ir_games;
select count(*) session_count from nl2ir_play_sessions;
