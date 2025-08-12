prompt --application/pages/page_groups
begin
--   Manifest
--     PAGE GROUPS: 110
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.7'
,p_default_workspace_id=>23403492094676104
,p_default_application_id=>110
,p_default_id_offset=>0
,p_default_owner=>'PROJECTS_DEMO'
);
wwv_flow_imp_page.create_page_group(
 p_id=>wwv_flow_imp.id(23432125844661469)
,p_group_name=>'Administration'
);
wwv_flow_imp.component_end;
end;
/
