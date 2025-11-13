prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.10'
,p_default_workspace_id=>8265727415005104
,p_default_application_id=>104
,p_default_id_offset=>0
,p_default_owner=>'WKSP_AJWS'
);
end;
/
 
prompt APPLICATION 104 - Object Storage Plugin
--
-- Application Export:
--   Application:     104
--   Name:            Object Storage Plugin
--   Date and Time:   02:34 Wednesday November 12, 2025
--   Exported By:     AJOSHI
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 31061478354059015
--   Manifest End
--   Version:         24.2.10
--   Instance ID:     7665353681817082
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/process_type/aj_object_storage_upload
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(31061478354059015)
,p_plugin_type=>'PROCESS TYPE'
,p_name=>'AJ_OBJECT_STORAGE_UPLOAD'
,p_display_name=>'Object Storage Upload Plugin'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_PROC:APEX_APPL_AUTOMATION_ACTIONS:APEX_APPL_TASKDEF_ACTIONS:APEX_APPL_WORKFLOW_ACTIVITIES'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION UPLOAD_FILE',
'  ( P_PROCESS IN APEX_PLUGIN.T_PROCESS',
'  , P_PLUGIN  IN APEX_PLUGIN.T_PLUGIN',
'  )',
'RETURN APEX_PLUGIN.T_PROCESS_EXEC_RESULT',
'AS',
'',
'    --PARAMETERS/ATTRIBUTES FOR THE PLUGIN',
'    L_USER_OCID    P_PROCESS.ATTRIBUTE_01%TYPE := P_PROCESS.ATTRIBUTE_01;',
'    L_TENANCY_OCID P_PROCESS.ATTRIBUTE_02%TYPE := P_PROCESS.ATTRIBUTE_02;',
'    L_PRIVATE_KEY  P_PROCESS.ATTRIBUTE_03%TYPE := P_PROCESS.ATTRIBUTE_03;',
'    L_FINGERPRINT  P_PROCESS.ATTRIBUTE_04%TYPE := P_PROCESS.ATTRIBUTE_04;',
'    L_REGION       P_PROCESS.ATTRIBUTE_05%TYPE := P_PROCESS.ATTRIBUTE_05;',
'    L_NAMESPACE    P_PROCESS.ATTRIBUTE_06%TYPE := P_PROCESS.ATTRIBUTE_06;',
'    L_BUCKET       P_PROCESS.ATTRIBUTE_07%TYPE := P_PROCESS.ATTRIBUTE_07;',
'	L_FILENAME     P_PROCESS.ATTRIBUTE_08%TYPE := P_PROCESS.ATTRIBUTE_08;',
'	',
'	--RETURN RESULT',
'    L_RESULT       APEX_PLUGIN.T_PROCESS_EXEC_RESULT;',
'	',
'	--MISC',
'	L_CRED_FOUND     NUMBER;',
'	L_FILECONTENT    BLOB;',
'	L_FILENAMEACTUAL VARCHAR2(4000);',
'	',
'	CURSOR C_CHECK_CREDENTIAL IS',
'		SELECT 1',
'		FROM   ALL_CREDENTIALS',
'		WHERE  CREDENTIAL_NAME = ''OCI_OBJECT_STORAGE_CRED'';',
'		',
'BEGIN',
'',
'    --SET APEX DEBUG',
'    IF APEX_APPLICATION.G_DEBUG AND SUBSTR(:DEBUG,6) >= 6',
'    THEN',
'        APEX_PLUGIN_UTIL.DEBUG_PROCESS',
'          ( P_PLUGIN  => P_PLUGIN',
'          , P_PROCESS => P_PROCESS',
'          );',
'    END IF;',
'	',
'	--PLUGIN MAIN LOGIC BEGIN--',
'	',
'	--CHECK IF THE CREDENTIAL ALREADY EXISTS',
'	L_CRED_FOUND := 0;',
'	OPEN  C_CHECK_CREDENTIAL;',
'	FETCH C_CHECK_CREDENTIAL',
'	INTO  L_CRED_FOUND;',
'	CLOSE C_CHECK_CREDENTIAL;',
'	',
'	--IF NOT FOUND, THEN CREATE IT',
'	IF NVL(L_CRED_FOUND,0) = 0 THEN',
'		BEGIN',
'		  DBMS_CLOUD.CREATE_CREDENTIAL ',
'		  (',
'			CREDENTIAL_NAME => ''OCI_OBJECT_STORAGE_CRED'',',
'			USER_OCID       => L_USER_OCID,',
'			TENANCY_OCID    => L_TENANCY_OCID,',
'			PRIVATE_KEY     => L_PRIVATE_KEY,',
'			FINGERPRINT     => L_FINGERPRINT',
'		  );',
'		EXCEPTION',
'		WHEN OTHERS THEN',
'			RAISE;',
'		END;',
'	END IF;',
'	',
'	BEGIN',
'		SELECT BLOB_CONTENT',
'			  ,FILENAME',
'		INTO   L_FILECONTENT',
'		      ,L_FILENAMEACTUAL',
'		FROM   APEX_APPLICATION_TEMP_FILES',
'		WHERE  NAME = L_FILENAME;',
'	EXCEPTION',
'	WHEN OTHERS THEN',
'		RAISE;',
'	END;',
'	',
'	BEGIN',
'		--UPLOAD FILE TO OBJECT STORAGE',
'		DBMS_CLOUD.PUT_OBJECT',
'		(',
'		 credential_name => ''OCI_OBJECT_STORAGE_CRED'',',
'		 object_uri 	 => ''https://objectstorage.'' || L_REGION || ''.oraclecloud.com/n/'' || L_NAMESPACE || ''/b/'' || L_BUCKET || ''/o/'' || L_FILENAMEACTUAL,',
'		 contents 		 => L_FILECONTENT',
'		 );',
'	EXCEPTION',
'	WHEN OTHERS THEN',
'		RAISE;',
'	END;',
'	',
'	L_RESULT.SUCCESS_MESSAGE := ''File: '' || L_FILENAMEACTUAL || '' has been successfully uploaded to Bucket: '' || L_BUCKET;',
'    RETURN L_RESULT;',
'	',
'	--PLUGIN MAIN LOGIC END--',
'	',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        RAISE;',
'END UPLOAD_FILE;',
''))
,p_api_version=>1
,p_execution_function=>'UPLOAD_FILE'
,p_substitute_attributes=>true
,p_version_scn=>39339731974453
,p_subscribe_plugin_settings=>true
,p_help_text=>'This APEX Plugin facilitates easy file uploads from within APEX application to the Object Storage Buckets.'
,p_version_identifier=>'1.0'
,p_plugin_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Developed by Amod Joshi',
'Contact: amodjjoshi@gmail.com'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31062163747068939)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'User OCID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31062480568071137)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Tenancy OCID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31062725814073012)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Private Key'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31063074909074112)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Fingerprint'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31063399523075185)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Region'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31063646444076367)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Namespace'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31063927983077129)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Bucket'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(31064252441079335)
,p_plugin_id=>wwv_flow_imp.id(31061478354059015)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Filename'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
