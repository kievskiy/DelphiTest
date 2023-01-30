CREATE OR ALTER
TRIGGER UserRightAccessShop_InsUpdDel ON UserRightAccessShop FOR INSERT, UPDATE, DELETE NOT FOR REPLICATION
AS
  ---------------------
  SET NOCOUNT ON
  SET ANSI_WARNINGS OFF
  ---------------------
  DECLARE @UserID   INT
  EXEC GetUser @UserID OUTPUT

  IF @UserID = 0
           THROW 50100, 'Вы неправильно зарегистрированы.~Обратитесь к администратору...~(UserRightAccessTT_InsUpdDel)', 10

  IF EXISTS (SELECT 1
          FROM deleted d LEFT JOIN inserted i ON i.URAS_ID = d.URAS_ID
          WHERE i.URAS_ID IS NULL)
           THROW 50100, 'Физическое удаление записий из реестра доступа для ТТ запрещено...~(UserRightAccessTT_InsUpdDel)', 10

  
IF EXISTS
      (SELECT 1
       FROM UserRightAccessShop u
            INNER JOIN inserted i ON u.URAS_ID <> i.URAS_ID
       WHERE (IsNull (U.URAS_Code, 0) = IsNull (i.URAS_Code, 0))
         AND (u.URAS_IsDel = 0)
         AND (i.URAS_IsDel = 0))
                THROW 50100, 'Не может быть два актуальных кода доступа...~(UserRightAccessTT_InsUpdDel)', 10

  UPDATE UserRightAccessShop
  SET URAS_DateUpdate = GetDate ()
  WHERE URAS_ID IN (SELECT I.URAS_ID
                     FROM Inserted I LEFT JOIN Deleted D ON I.URAS_ID = D.URAS_ID
                     WHERE (IsNull (i.URAS_Code, 0) <> IsNull (d.URAS_Code, 0))
                        OR (IsNull (i.URAS_Name, '') <> IsNull (d.URAS_Name, ''))
                        OR (IsNull (i.URAS_MessError, '') <> IsNull (d.URAS_MessError, ''))
                        OR (IsNull (i.URAS_ScriptSA, '') <> IsNull (d.URAS_ScriptSA, ''))
                        OR (IsNull (i.URAS_ScriptSMBig, '') <> IsNull (d.URAS_ScriptSMBig, ''))
                        OR (IsNull (i.URAS_ScriptSMSmall, '') <> IsNull (d.URAS_ScriptSMSmall, ''))
                        OR i.URAS_IsDel <> d.URAS_IsDel)

  INSERT INTO UserRightAccessShopLog (URASL_SDoc,
                                      URASL_Event,
                                      URASL_Code_Old,
                                      URASL_Code_New,
                                      URASL_Name_Old,
                                      URASL_Name_New,
                                      URASL_MessError_Old,
                                      URASL_MessError_New,
                                      URASL_ScriptSMBig_Old,
                                      URASL_ScriptSMBig_New,
                                      URASL_ScriptSMSmall_Old,
                                      URASL_ScriptSMSmall_New,
                                      URASL_ScriptSA_Old,
                                      URASL_ScriptSA_New,
                                      URASL_HOSTNAME,
                                      URASL_LoginName,
                                      URASL_EventTime,
                                      URASL_WhoInput)
     SELECT i.URAS_ID,
            CASE
               WHEN d.URAS_ID IS NULL THEN 'Insert'
               WHEN d.URAS_IsDel = 0 AND i.URAS_IsDel = 1 THEN 'Delete'
               ELSE 'Edit'
            END,
            d.URAS_Code,
            i.URAS_Code,
            d.URAS_Name,
            i.URAS_Name,
            d.URAS_MessError,
            i.URAS_MessError,
            d.URAS_ScriptSMBig,
            i.URAS_ScriptSMBig,
            d.URAS_ScriptSMSmall,
            i.URAS_ScriptSMSmall,
            d.URAS_ScriptSA,
            i.URAS_ScriptSA,
            IsNull(CAST(i.URAS_WhoUpdate As VARCHAR),'') + ' ' + HOST_NAME () AS URAL_HOSTNAME,
            ORIGINAL_LOGIN (),
            getdate (),
            @UserID
     FROM Inserted I LEFT JOIN Deleted D ON I.URAS_ID = D.URAS_ID
               
  
go