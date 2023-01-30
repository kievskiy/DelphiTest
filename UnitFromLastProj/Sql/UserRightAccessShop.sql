SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
-- Drop table UserRightAccessShop
CREATE TABLE UserRightAccessShop
(
   URAS_ID               INT NOT NULL IDENTITY,                                          -- Id
   URAS_Code             INT NOT NULL,                                                   -- Код
   URAS_Name             VARCHAR (255) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Наименование
   URAS_MessError        VARCHAR (255) COLLATE SQL_Latin1_General_CP1251_CI_AS,          -- Сообщение при ошибке
   URAS_ScriptSMBig      VARCHAR (MAX) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Скрипт для большого супера 
   URAS_ScriptSMSmall    VARCHAR (MAX) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Скрипт для малого супера
   URAS_ScriptSA         VARCHAR (MAX) COLLATE SQL_Latin1_General_CP1251_CI_AS NOT NULL, -- Скрипт для прилавка
   URAS_IsDel            BIT NOT NULL DEFAULT 0,                                         -- Признак удаления 
   URAS_DateUpdate       DATETIME NULL,                                                  -- Когда обновилось (создалось)
   URAS_WhoUpdate        INT NULL,                                                       -- Хто это сделал?
   PRIMARY KEY (URAS_ID)
)
go

GRANT  SELECT, INSERT, DELETE, UPDATE ON UserRightAccessShop TO Electrobasic
go

EXEC
  sys.sp_addextendedproperty @name = N'MS_Description',
                             @value = N'Права доступа на ТТ',
                             @level0type = N'SCHEMA',
                             @level0name = N'dbo',
                             @level1type = N'TABLE',
                             @level1name = N'UserRightAccessShop'