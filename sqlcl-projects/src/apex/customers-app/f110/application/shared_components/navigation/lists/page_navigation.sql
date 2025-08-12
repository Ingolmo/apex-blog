prompt --application/shared_components/navigation/lists/page_navigation
begin
--   Manifest
--     LIST: Page Navigation
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.7'
,p_default_workspace_id=>23403492094676104
,p_default_application_id=>110
,p_default_id_offset=>0
,p_default_owner=>'PROJECTS_DEMO'
);
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(23468091411661137)
,p_name=>'Page Navigation'
,p_list_status=>'PUBLIC'
,p_version_scn=>41528879294110
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(23468420235661136)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Customers'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp.component_end;
end;
/
