SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
  -- drop table UserRightAccessShopUnloadLog
CREATE TABLE UserRightAccessShopUnloadLog (
    URAUL_ID                INT NOT NULL IDENTITY,               -- Id
    URAUL_SDoc              INT NOT NULL,                        -- Id в UserRightAccessShop
    URAUL_Pl_Id             SmallInt not null,                   -- Ссылка на магазин
    URAUL_Success           Bit NOT NULL DEFAULT 0,              -- Успешно скопировалось?
    URAUL_ErrMsg            Varchar(1000),                       -- Сообщение об ошибке при копировании
    URAUL_URAS_DateUpdate   datetime NULL,                       -- Какое состояние копировали из URAS_DateUpdate UserRightAccessShop
    URAUL_UnloadTime        datetime NOT NULL default getdate(), -- Когда выгружали на ТТ
    CONSTRAINT [UK_URAUL_ByPlace] UNIQUE (URAUL_SDoc, URAUL_Pl_Id),
    CONSTRAINT [FK_URAUL_Place] FOREIGN KEY (URAUL_Pl_Id) REFERENCES Place(Pl_Id)
  )
GO


EXEC sp_addextendedproperty N'MS_Description',
  N'Логирование выгрузки на ТТ UserRightAccessShop',
  'SCHEMA',
  N'dbo',
  'TABLE',
  N'UserRightAccessShopUnloadLog',
  NULL,
  NULL
GO

GRANT SELECT, INSERT, DELETE, UPDATE ON UserRightAccessShopUnloadLog TO Electrobasic
go