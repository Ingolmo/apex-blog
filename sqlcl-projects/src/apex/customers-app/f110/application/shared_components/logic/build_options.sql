prompt --application/shared_components/logic/build_options
begin
--   Manifest
--     BUILD OPTIONS: 110
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.7'
,p_default_workspace_id=>23403492094676104
,p_default_application_id=>110
,p_default_id_offset=>0
,p_default_owner=>'PROJECTS_DEMO'
);
wwv_flow_imp_shared.create_build_option(
 p_id=>wwv_flow_imp.id(23425981573661492)
,p_build_option_name=>'Commented Out'
,p_build_option_status=>'EXCLUDE'
,p_version_scn=>41528879291663
);
wwv_flow_imp.component_end;
end;
/
