SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
  -- drop table UserRightAccessShopLog
CREATE TABLE UserRightAccessShopLog (
    URASL_ID                INT NOT NULL IDENTITY,
    URASL_SDoc              INT NOT NULL, -- Id
    URASL_Event             VARCHAR(20) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Шо сделали 
    URASL_Code_Old          INT NULL, -- Старый код URA_Code
    URASL_Code_New          INT NOT NULL, -- Новый код URA_Code
    URASL_Name_Old          varchar(255) COLLATE SQL_Latin1_General_CP1251_CI_AS NULL, -- Старое примечание URAS_Name
    URASL_Name_New          varchar(255) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Новое примечание URAS_Name
    URASL_MessError_Old     VARCHAR (255) COLLATE SQL_Latin1_General_CP1251_CI_AS, -- Сообщение об ошибке старое
    URASL_MessError_New     VARCHAR (255) COLLATE SQL_Latin1_General_CP1251_CI_AS,-- Сообщение об ошибке  новое
    URASL_ScriptSMBig_Old   varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NULL, -- Старый скрипт URA_ScriptSMBig
    URASL_ScriptSMBig_New   varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Новый скрипт URA_ScriptSMBig
    URASL_ScriptSMSmall_Old varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NULL, -- Старый скрипт URA_ScriptSMSmall
    URASL_ScriptSMSmall_New varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Новый скрипт URA_ScriptSMSmall
    URASL_ScriptSA_Old      varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NULL,  -- Старый скрипт URA_ScriptSA
    URASL_ScriptSA_New      varchar(max) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL,  -- Новый скрипт URA_ScriptSA
    URASL_HOSTNAME          varchar(255) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL,  -- HOSTNAME
    URASL_LoginName         varchar(255) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- LoginName
    URASL_EventTime         datetime NOT NULL, -- Когда изменили
    URASL_WhoInput          int NULL -- Хто это сделал?!!!
  )
GO

  EXEC sp_addextendedproperty N'MS_Description',
  N'Логирование UserRightAccessShop',
  'SCHEMA',
  N'dbo',
  'TABLE',
  N'UserRightAccessShopLog',
  NULL,
  NULL
GO

GRANT SELECT, INSERT, DELETE, UPDATE ON UserRightAccessShopLog TO Electrobasic
go