/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 11.1.0                     */
/* Target DBMS:           MS SQL Server 2017                              */
/* Project file:          APP_HMR.dez                                     */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Alter database script                           */
/* Created on:            2020-02-10 17:49                                */
/* ---------------------------------------------------------------------- */

-- =============================================
-- Author:		Ben Driver
-- Create date: 2020-02-10
-- Updates: 
--	
-- 
-- Description:	Incremnetal DML in support of sprint 5.
--  - Rename HMR_WILDLIFE_REPORT.START_OFFSET to OFFSET
--
--
-- =============================================

USE HMR_DEV; -- uncomment appropriate instance
--USE HMR_TST;
--USE HMR_UAT;
--USE HMR_PRD;
GO

/* ---------------------------------------------------------------------- */
/* Drop triggers                                                          */
/* ---------------------------------------------------------------------- */

GO


DROP TRIGGER [dbo].[HMR_WLDLF_RPT_A_S_IUD_TR]
GO


DROP TRIGGER [dbo].[HMR_WLDLF_RPT_I_S_I_TR]
GO


DROP TRIGGER [dbo].[HMR_WLDLF_RPT_I_S_U_TR]
GO


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] DROP CONSTRAINT [HMR_WLDLF_RPT_HMR_SRV_ARA_FK]
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] DROP CONSTRAINT [HMR_WLDLF_RPT_SUBM_OBJ_FK]
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] DROP CONSTRAINT [HMR_WLDLF_RRT_SUBM_STAT_FK]
GO


/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_WILDLIFE_REPORT"                                  */
/* ---------------------------------------------------------------------- */

GO


EXEC sp_rename '[dbo].[HMR_WILDLIFE_REPORT].[START_OFFSET]', 'OFFSET', 'COLUMN'
GO


/* ---------------------------------------------------------------------- */
/* Drop and recreate table "dbo.HMR_WILDLIFE_REPORT_HIST"                 */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] DROP CONSTRAINT [HMR_WLDLF_H_PK]
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] DROP CONSTRAINT [HMR_WLDLF_H_UK]
GO


CREATE TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST_TMP] (
    [WILDLIFE_REPORT_HIST_ID] BIGINT DEFAULT NEXT VALUE FOR [HMR_WILDLIFE_REPORT_H_ID_SEQ] NOT NULL,
    [EFFECTIVE_DATE_HIST] DATETIME DEFAULT getutcdate() NOT NULL,
    [END_DATE_HIST] DATETIME,
    [WILDLIFE_RECORD_ID] NUMERIC(18) NOT NULL,
    [SUBMISSION_OBJECT_ID] NUMERIC(18) NOT NULL,
    [ROW_NUM] NUMERIC(18),
    [VALIDATION_STATUS_ID] NUMERIC(18),
    [RECORD_TYPE] VARCHAR(1),
    [SERVICE_AREA] NUMERIC(18) NOT NULL,
    [ACCIDENT_DATE] DATETIME,
    [TIME_OF_KILL] VARCHAR(1),
    [LATITUDE] NUMERIC(16,8),
    [LONGITUDE] NUMERIC(16,8),
    [HIGHWAY_UNIQUE] VARCHAR(16),
    [LANDMARK] VARCHAR(8),
    [OFFSET] NUMERIC(7,3),
    [NEAREST_TOWN] VARCHAR(150),
    [WILDLIFE_SIGN] VARCHAR(1),
    [QUANTITY] NUMERIC(18),
    [SPECIES] NUMERIC(18),
    [SEX] VARCHAR(1),
    [AGE] VARCHAR(1),
    [COMMENT] VARCHAR(1024),
    [CONCURRENCY_CONTROL_NUMBER] BIGINT NOT NULL,
    [APP_CREATE_USERID] VARCHAR(30) NOT NULL,
    [APP_CREATE_TIMESTAMP] DATETIME NOT NULL,
    [APP_CREATE_USER_GUID] UNIQUEIDENTIFIER NOT NULL,
    [APP_CREATE_USER_DIRECTORY] VARCHAR(12) NOT NULL,
    [APP_LAST_UPDATE_USERID] VARCHAR(30) NOT NULL,
    [APP_LAST_UPDATE_TIMESTAMP] DATETIME NOT NULL,
    [APP_LAST_UPDATE_USER_GUID] UNIQUEIDENTIFIER NOT NULL,
    [APP_LAST_UPDATE_USER_DIRECTORY] VARCHAR(12) NOT NULL,
    [DB_AUDIT_CREATE_USERID] VARCHAR(30) NOT NULL,
    [DB_AUDIT_CREATE_TIMESTAMP] DATETIME NOT NULL,
    [DB_AUDIT_LAST_UPDATE_USERID] VARCHAR(30) NOT NULL,
    [DB_AUDIT_LAST_UPDATE_TIMESTAMP] DATETIME NOT NULL)
GO


INSERT INTO [dbo].[HMR_WILDLIFE_REPORT_HIST_TMP]
    ([WILDLIFE_REPORT_HIST_ID],[EFFECTIVE_DATE_HIST],[END_DATE_HIST],[WILDLIFE_RECORD_ID],[SUBMISSION_OBJECT_ID],[ROW_NUM],[VALIDATION_STATUS_ID],[RECORD_TYPE],[SERVICE_AREA],[ACCIDENT_DATE],[TIME_OF_KILL],[LATITUDE],[LONGITUDE],[HIGHWAY_UNIQUE],[LANDMARK],[OFFSET],[NEAREST_TOWN],[WILDLIFE_SIGN],[QUANTITY],[SPECIES],[SEX],[AGE],[COMMENT],[CONCURRENCY_CONTROL_NUMBER],[APP_CREATE_USERID],[APP_CREATE_TIMESTAMP],[APP_CREATE_USER_GUID],[APP_CREATE_USER_DIRECTORY],[APP_LAST_UPDATE_USERID],[APP_LAST_UPDATE_TIMESTAMP],[APP_LAST_UPDATE_USER_GUID],[APP_LAST_UPDATE_USER_DIRECTORY],[DB_AUDIT_CREATE_USERID],[DB_AUDIT_CREATE_TIMESTAMP],[DB_AUDIT_LAST_UPDATE_USERID],[DB_AUDIT_LAST_UPDATE_TIMESTAMP])
SELECT
    [WILDLIFE_REPORT_HIST_ID],[EFFECTIVE_DATE_HIST],[END_DATE_HIST],[WILDLIFE_RECORD_ID],[SUBMISSION_OBJECT_ID],[ROW_NUM],[VALIDATION_STATUS_ID],[RECORD_TYPE],[SERVICE_AREA],[ACCIDENT_DATE],[TIME_OF_KILL],[LATITUDE],[LONGITUDE],[HIGHWAY_UNIQUE],[LANDMARK],[START_OFFSET],[NEAREST_TOWN],[WILDLIFE_SIGN],[QUANTITY],[SPECIES],[SEX],[AGE],[COMMENT],[CONCURRENCY_CONTROL_NUMBER],[APP_CREATE_USERID],[APP_CREATE_TIMESTAMP],[APP_CREATE_USER_GUID],[APP_CREATE_USER_DIRECTORY],[APP_LAST_UPDATE_USERID],[APP_LAST_UPDATE_TIMESTAMP],[APP_LAST_UPDATE_USER_GUID],[APP_LAST_UPDATE_USER_DIRECTORY],[DB_AUDIT_CREATE_USERID],[DB_AUDIT_CREATE_TIMESTAMP],[DB_AUDIT_LAST_UPDATE_USERID],[DB_AUDIT_LAST_UPDATE_TIMESTAMP]
FROM [dbo].[HMR_WILDLIFE_REPORT_HIST]
GO


DROP TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST]
GO


EXEC sp_rename '[dbo].[HMR_WILDLIFE_REPORT_HIST_TMP]', 'HMR_WILDLIFE_REPORT_HIST', 'OBJECT'
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] ADD CONSTRAINT [HMR_WLDLF_H_PK] 
    PRIMARY KEY CLUSTERED ([WILDLIFE_REPORT_HIST_ID])
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] ADD CONSTRAINT [HMR_WLDLF_H_UK] 
    UNIQUE ([WILDLIFE_REPORT_HIST_ID], [END_DATE_HIST])
GO


/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] ADD CONSTRAINT [HMR_WLDLF_RPT_HMR_SRV_ARA_FK] 
    FOREIGN KEY ([SERVICE_AREA]) REFERENCES [dbo].[HMR_SERVICE_AREA] ([SERVICE_AREA_NUMBER])
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] ADD CONSTRAINT [HMR_WLDLF_RPT_SUBM_OBJ_FK] 
    FOREIGN KEY ([SUBMISSION_OBJECT_ID]) REFERENCES [dbo].[HMR_SUBMISSION_OBJECT] ([SUBMISSION_OBJECT_ID])
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT] ADD CONSTRAINT [HMR_WLDLF_RRT_SUBM_STAT_FK] 
    FOREIGN KEY ([VALIDATION_STATUS_ID]) REFERENCES [dbo].[HMR_SUBMISSION_STATUS] ([STATUS_ID])
GO


/* ---------------------------------------------------------------------- */
/* Repair/add triggers                                                    */
/* ---------------------------------------------------------------------- */

GO


CREATE TRIGGER [dbo].[HMR_WLDLF_RPT_A_S_IUD_TR] ON HMR_WILDLIFE_REPORT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update HMR_WILDLIFE_REPORT_HIST set END_DATE_HIST = @curr_date where WILDLIFE_RECORD_ID in (select WILDLIFE_RECORD_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into HMR_WILDLIFE_REPORT_HIST ([WILDLIFE_RECORD_ID], [SUBMISSION_OBJECT_ID], [ROW_NUM], [VALIDATION_STATUS_ID], [RECORD_TYPE], [SERVICE_AREA], [ACCIDENT_DATE], [TIME_OF_KILL], [LATITUDE], [LONGITUDE], [HIGHWAY_UNIQUE], [LANDMARK], [OFFSET], [NEAREST_TOWN], [WILDLIFE_SIGN], [QUANTITY], [SPECIES], [SEX], [AGE], [COMMENT], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_USERID], [APP_CREATE_TIMESTAMP], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_AUDIT_CREATE_USERID], [DB_AUDIT_CREATE_TIMESTAMP], [DB_AUDIT_LAST_UPDATE_USERID], [DB_AUDIT_LAST_UPDATE_TIMESTAMP], WILDLIFE_REPORT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [WILDLIFE_RECORD_ID], [SUBMISSION_OBJECT_ID], [ROW_NUM], [VALIDATION_STATUS_ID], [RECORD_TYPE], [SERVICE_AREA], [ACCIDENT_DATE], [TIME_OF_KILL], [LATITUDE], [LONGITUDE], [HIGHWAY_UNIQUE], [LANDMARK], [OFFSET], [NEAREST_TOWN], [WILDLIFE_SIGN], [QUANTITY], [SPECIES], [SEX], [AGE], [COMMENT], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_USERID], [APP_CREATE_TIMESTAMP], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_AUDIT_CREATE_USERID], [DB_AUDIT_CREATE_TIMESTAMP], [DB_AUDIT_LAST_UPDATE_USERID], [DB_AUDIT_LAST_UPDATE_TIMESTAMP], (next value for [dbo].[HMR_WILDLIFE_REPORT_H_ID_SEQ]) as [WILDLIFE_REPORT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO


CREATE TRIGGER [dbo].[HMR_WLDLF_RPT_I_S_I_TR] ON HMR_WILDLIFE_REPORT INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into HMR_WILDLIFE_REPORT ("WILDLIFE_RECORD_ID",
      "SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID",
      "RECORD_TYPE",
      "SERVICE_AREA",
      "ACCIDENT_DATE",
      "TIME_OF_KILL",
      "LATITUDE",
      "LONGITUDE",
      "HIGHWAY_UNIQUE",
      "LANDMARK",
      "OFFSET",
      "NEAREST_TOWN",
      "WILDLIFE_SIGN",
      "QUANTITY",
      "SPECIES",
      "SEX",
      "AGE",
      "COMMENT",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_USERID",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "WILDLIFE_RECORD_ID",
      "SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID",
      "RECORD_TYPE",
      "SERVICE_AREA",
      "ACCIDENT_DATE",
      "TIME_OF_KILL",
      "LATITUDE",
      "LONGITUDE",
      "HIGHWAY_UNIQUE",
      "LANDMARK",
      "OFFSET",
      "NEAREST_TOWN",
      "WILDLIFE_SIGN",
      "QUANTITY",
      "SPECIES",
      "SEX",
      "AGE",
      "COMMENT",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_USERID",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO


CREATE TRIGGER [dbo].[HMR_WLDLF_RPT_I_S_U_TR] ON HMR_WILDLIFE_REPORT INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.WILDLIFE_RECORD_ID = deleted.WILDLIFE_RECORD_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update HMR_WILDLIFE_REPORT
    set "WILDLIFE_RECORD_ID" = inserted."WILDLIFE_RECORD_ID",
      "SUBMISSION_OBJECT_ID" = inserted."SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID" = inserted."VALIDATION_STATUS_ID",
      "RECORD_TYPE" = inserted."RECORD_TYPE",
      "SERVICE_AREA" = inserted."SERVICE_AREA",
      "ACCIDENT_DATE" = inserted."ACCIDENT_DATE",
      "TIME_OF_KILL" = inserted."TIME_OF_KILL",
      "LATITUDE" = inserted."LATITUDE",
      "LONGITUDE" = inserted."LONGITUDE",
      "HIGHWAY_UNIQUE" = inserted."HIGHWAY_UNIQUE",
      "LANDMARK" = inserted."LANDMARK",
      "OFFSET" = inserted."OFFSET",
      "NEAREST_TOWN" = inserted."NEAREST_TOWN",
      "WILDLIFE_SIGN" = inserted."WILDLIFE_SIGN",
      "QUANTITY" = inserted."QUANTITY",
      "SPECIES" = inserted."SPECIES",
      "SEX" = inserted."SEX",
      "AGE" = inserted."AGE",
      "COMMENT" = inserted."COMMENT",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_AUDIT_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_AUDIT_LAST_UPDATE_USERID = user_name()
    from HMR_WILDLIFE_REPORT
    inner join inserted
    on (HMR_WILDLIFE_REPORT.WILDLIFE_RECORD_ID = inserted.WILDLIFE_RECORD_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO

