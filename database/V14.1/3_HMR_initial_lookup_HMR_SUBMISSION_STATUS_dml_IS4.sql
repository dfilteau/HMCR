-- =============================================
-- Author:		Ben Driver
-- Create date: 2020-01-15
-- Updates: 
--	2020-01-15: : Initial script (BD)
-- Description:	Dedicated load of initial values for HMR_SUBMISSION_STATUS
-- =============================================

USE HMR_DEV; -- uncomment appropriate instance
--USE HMR_TST;
--USE HMR_UAT;
--USE HMR_PRD;
GO

DELETE FROM [dbo].[HMR_SUBMISSION_STATUS] WHERE STATUS_ID IS NOT NULL;
GO

ALTER SEQUENCE [dbo].[HMR_SUBM_STAT_ID_SEQ]
RESTART WITH 1
GO

/* Load user context variables.   */

DECLARE @utcdate DATETIME = (SELECT getutcdate() AS utcdate)
DECLARE @app_guid UNIQUEIDENTIFIER = (SELECT CASE WHEN SUSER_SID() IS NOT NULL THEN SUSER_SID() ELSE (SELECT CONVERT(uniqueidentifier,STUFF(STUFF(STUFF(STUFF('B00D00A0AC0A0D0C00DD00F0D0C00000',9,0,'-'),14,0,'-'),19,0,'-'),24,0,'-'))) END AS  app_guid)
DECLARE @app_user VARCHAR(30) = (SELECT CASE WHEN SUBSTRING(SUSER_NAME(),CHARINDEX('\',SUSER_NAME())+1,LEN(SUSER_NAME())) IS NOT NULL THEN SUBSTRING(SUSER_NAME(),CHARINDEX('\',SUSER_NAME())+1,LEN(SUSER_NAME())) ELSE CURRENT_USER END AS app_user)
DECLARE @app_user_dir VARCHAR(12) = (SELECT CASE WHEN LEN(SUBSTRING(SUSER_NAME(),0,CHARINDEX('\',SUSER_NAME(),0)))>1 THEN SUBSTRING(SUSER_NAME(),0,CHARINDEX('\',SUSER_NAME(),0)) ELSE 'WIN AUTH' END AS app_user_dir)


/* Insert Initial Region Entries */

INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('FR', 'File Received', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('FE', 'File Error', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('DS', 'Duplicate Submission', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('DP', 'Data validation In-progress', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('DE', 'Data error', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('VS', 'Data validation successful', 'F', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('RR', 'Row Received', 'R', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('DR', 'Duplicate Row', 'R', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('RE', 'Row Error', 'R', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);
INSERT INTO HMR_SUBMISSION_STATUS (STATUS_CODE, DESCRIPTION, STATUS_TYPE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('RS', 'Row data validation successful', 'R', @app_user,@utcdate,@app_guid,@app_user_dir,@app_user,@utcdate,@app_guid,@app_user_dir);


GO

