CREATE OR ALTER PROCEDURE pr_CopyURASInCurrentShop @URAS_ID       INT, --2
                                                   @URAUL_Pl_Id   INT, -- 164 
                                                   @Server        VARCHAR (MAX), -- 'SQL-T1.dom.loc\MSSQL2016'
                                                   @Pwd           VARCHAR (MAX), -- '1111'
                                                   @Database      VARCHAR (MAX)  -- 'ShopAccount'
AS
BEGIN
   DECLARE
      @SQL               NVARCHAR (MAX),
      @URAS_Code         INT = 111,
      @URAS_Name         VARCHAR (255),
      @URAS_MessError    VARCHAR (255),
      @URAS_Script       VARCHAR (MAX),
      @URAUL_Success     BIT = 0,
      @URAUL_ErrMsg      NVARCHAR (4000) = '',
      @URAS_IsDel        BIT,
      @URAS_DateUpdate   DATETIME,
      @URAS_DateLoad     DATETIME = getdate ()
  
   IF NOT EXISTS
         (SELECT 1
          FROM UserRightAccessShop
          WHERE URAS_ID = @URAS_ID)
                        THROW 50100, 'Нет записи с таким URAS_ID....~(pr_CopyURASInShop)', 10

   SELECT @URAS_Code = URAS_Code,
          @URAS_Name = URAS_Name,
          @URAS_MessError = IsNull (URAS_MessError, ''),
          @URAS_Script =
             CASE
                WHEN Shop_Type = 1 THEN URAS_ScriptSMBig
                WHEN Shop_Type = 2 THEN URAS_ScriptSMSmall
                ELSE URAS_ScriptSA
             END,
          @URAS_DateUpdate = URAS_DateUpdate,
          @URAS_IsDel = URAS_IsDel
   FROM UserRightAccessShop u CROSS APPLY (SELECT * FROM Get_Shop_Type (@URAUL_Pl_Id)) t
   WHERE URAS_ID = @URAS_ID
   SET @SQL =
            'DECLARE                                                      '
          + '   @URAS_ID           INT,                                   '
          + '   @URAS_Code         INT,                                   '
          + '   @URAS_Name         VARCHAR (255),                         '
          + '   @URAS_MessError    VARCHAR (255),                         '
          + '   @URAS_Script       VARCHAR (MAX),                         '
          + '   @URAS_IsDel        BIT,                                   '
          + '   @URAS_DateUpdate   DATETIME,                              '
          + '   @URAS_DateLoad     DATETIME = getdate ()                  '
          + 'SELECT @URAS_ID = '''
          + cast (@URAS_ID AS VARCHAR)
          + ''',                                                          '
          + '       @URAS_Code = '''
          + cast (@URAS_Code AS VARCHAR)
          + ''',                                                          '
          + '       @URAS_Name = '''
          + @URAS_Name
          + ''',                                                          '
          + '       @URAS_MessError = '''
          + @URAS_MessError
          + ''',                                                          '
          + '       @URAS_Script = '''
          + replace(@URAS_Script,'''','''''')
          + ''',                                                          '
          + '       @URAS_IsDel = '
          + cast (@URAS_IsDel AS VARCHAR)
          + ',                                                            '
          + '       @URAS_DateUpdate = '''
          + CONVERT (VARCHAR, @URAS_DateUpdate, 20)
          + '''                                                           '
          + 'IF EXISTS(SELECT 1 FROM                                      '
          + 'OPENDATASOURCE(''SQLNCLI'','
          + Char (39)
          + 'SERVER='
          + @Server
          + ';UID=sa;'
          + 'PWD='
          + @Pwd
          + ';'
          + 'DATABASE='
          + @Database
          + ''''
          + ').'
          + @Database
          + '.dbo.UserRightAccessShop WHERE URAS_ID = @URAS_ID)           '
          + ' BEGIN'
          + '   UPDATE OPENDATASOURCE(''SQLNCLI'', '
          + Char (39)
          + 'SERVER='
          + @Server
          + ';UID=sa;'
          + 'PWD='
          + @Pwd
          + ';'
          + 'DATABASE='
          + @Database
          + ''''
          + ').'
          + @Database
          + '.dbo.UserRightAccessShop                                     '
          + '    SET URAS_Code = @URAS_Code,                              '
          + '              URAS_Name = @URAS_Name,                        '
          + '              URAS_MessError = @URAS_MessError,              '
          + '              URAS_Script = @URAS_Script,                    '
          + '              URAS_IsDel = @URAS_IsDel,                      '
          + '              URAS_DateUpdate = @URAS_DateUpdate,            '
          + '              URAS_DateLoad = @URAS_DateLoad                 '
          + '    WHERE URAS_ID = @URAS_ID                                 '
          + ' END'
          + '   ELSE                                                      '
          + ' BEGIN                                                       '
          + '     INSERT INTO OPENDATASOURCE(''SQLNCLI'', '
          + Char (39)
          + 'SERVER='
          + @Server
          + ';UID=sa;'
          + 'PWD='
          + @Pwd
          + ';'
          + 'DATABASE='
          + @Database
          + ''''
          + ').'
          + @Database
          + '.dbo.UserRightAccessShop(URAS_ID,                                                        '
          + '           URAS_Code,                                        '
          + '           URAS_Name,                                        '
          + '           URAS_MessError,                                   '
          + '           URAS_Script,                                      '
          + '           URAS_IsDel,                                       '
          + '           URAS_DateUpdate,                                  '
          + '           URAS_DateLoad)                                    '
          + '   VALUES (@URAS_ID,                                         '
          + '           @URAS_Code,                                       '
          + '           @URAS_Name,                                       '
          + '           @URAS_MessError,                                  '
          + '           @URAS_Script,                                     '
          + '           @URAS_IsDel,                                      '
          + '           @URAS_DateUpdate,                                 '
          + '           @URAS_DateLoad)                                   '
          + ' END'

   BEGIN TRY
      EXEC sp_executeSQL @Sql
      SET @URAUL_Success = 1
   END TRY
   BEGIN CATCH
      SET @URAUL_ErrMsg = 'Ошибка: ' + Error_Message ()
   END CATCH

   DROP TABLE IF EXISTS #Result

   CREATE TABLE #Result
   (
      _URAUL_Success            BIT,
      _URAUL_URAS_DateUpdate    DATETIME,
      _URAUL_UnloadTime         DATETIME,
      _URAUL_ErrMsg             VARCHAR (1000)
   )

   IF @URAUL_ErrMsg <> ''
      BEGIN
         INSERT INTO #Result (_URAUL_Success,
                              _URAUL_URAS_DateUpdate,
                              _URAUL_UnloadTime,
                              _URAUL_ErrMsg)
            SELECT 0,
                   NULL,
                   getdate (),
                   @URAUL_ErrMsg
      END
   ELSE
      BEGIN
         SET @SQL =
                  'DECLARE                                                      '
                + '   @URAS_ID           INT,                                   '
                + '   @URAS_Code         INT,                                   '
                + '   @URAS_Name         VARCHAR (255),                         '
                + '   @URAS_MessError    VARCHAR (255),                         '
                + '   @URAS_Script       VARCHAR (MAX),                         '
                + '   @URAS_IsDel        BIT,                                   '
                + '   @URAS_DateUpdate   DATETIME = getdate ()  ,                '
                + '   @URAS_DateLoad     DATETIME = getdate ()                  '
                + 'SELECT @URAS_ID = '''
                + cast (@URAS_ID AS VARCHAR)
                + ''','
                + '       @URAS_Code = '''
                + cast (@URAS_Code AS VARCHAR)
                + ''','
               /* + '       @URAS_Name = '''
                + @URAS_Name
                + ''',                                        '
                + '       @URAS_MessError = '''
                + @URAS_MessError
                + ''',                              '
                + '       @URAS_Script = '''
                + @URAS_Script
                + ''',                                              '*/
                + '       @URAS_IsDel = '
                + cast (@URAS_IsDel AS VARCHAR)
                + ',                                                    '
                + '       @URAS_DateUpdate = '''
                + CONVERT (VARCHAR, @URAS_DateUpdate, 20)
                + '''                            '
                + 'SELECT 1, URAS_DateUpdate, URAS_DateLoad FROM '
                + 'OPENDATASOURCE(''SQLNCLI'', '
                + Char (39)
                + 'SERVER='
                + @Server
                + ';UID=sa;'
                + 'PWD='
                + @Pwd
                + ';'
                + 'DATABASE='
                + @Database
                + ''''
                + ').'
                + @Database
                + '.dbo.UserRightAccessShop WHERE URAS_ID = @URAS_ID           '
                + '                           AND URAS_Code = @URAS_Code       '
                /*+ '                           AND URAS_Name = '''
                + @URAS_Name
                + '''                              '
                + '                           AND URAS_MessError = '''
                + @URAS_MessError
                + '''                              '
                + '                           AND URAS_Script = @URAS_Script'*/
                + '                           AND URAS_IsDel = '
                + cast (@URAS_IsDel AS VARCHAR)
                + '                           AND URAS_DateUpdate ='''
                + CONVERT (VARCHAR, @URAS_DateUpdate, 20)
                + '''                                   '

         BEGIN TRY
            INSERT INTO #Result (_URAUL_Success, _URAUL_URAS_DateUpdate, _URAUL_UnloadTime)
            EXEC sp_executeSQL @SQL
         END TRY
         BEGIN CATCH
            INSERT INTO #Result (_URAUL_Success,
                                 _URAUL_URAS_DateUpdate,
                                 _URAUL_UnloadTime,
                                 _URAUL_ErrMsg)
               SELECT 0,
                      null,--getdate (),
                      getdate (),
                      Error_Message ()
         END CATCH

         IF (SELECT count (*) FROM #Result) = 0
            INSERT INTO #Result (_URAUL_Success,
                                 _URAUL_URAS_DateUpdate,
                                 _URAUL_UnloadTime,
                                 _URAUL_ErrMsg)
               SELECT 0,
                      getdate (),
                      getdate (),
                      'Что-то пошло не так....'
      END

   MERGE UserRightAccessShopUnloadLog AS target
   USING (SELECT @URAS_ID AS _URAUL_SDoc,
                 @URAUL_Pl_Id AS _URAUL_Pl_Id,
                 _URAUL_Success,
                 _URAUL_URAS_DateUpdate,
                 _URAUL_UnloadTime,
                 _URAUL_ErrMsg
          FROM #Result) AS source (_URAUL_SDoc,
                                   _URAUL_Pl_Id,
                                   _URAUL_Success,
                                   _URAUL_URAS_DateUpdate,
                                   _URAUL_UnloadTime,
                                   _URAUL_ErrMsg)
   ON (target.URAUL_SDoc = source._URAUL_SDoc AND target.URAUL_Pl_Id = source._URAUL_Pl_Id)
   WHEN MATCHED
   THEN
      UPDATE SET target.URAUL_Success = source._URAUL_Success,
                 target.URAUL_URAS_DateUpdate = source._URAUL_URAS_DateUpdate,
                 target.URAUL_UnloadTime = source._URAUL_UnloadTime,
                 target.URAUL_ErrMsg = source._URAUL_ErrMsg
   WHEN NOT MATCHED
   THEN
      INSERT (URAUL_SDoc,
              URAUL_Pl_Id,
              URAUL_Success,
              URAUL_ErrMsg,
              URAUL_URAS_DateUpdate,
              URAUL_UnloadTime)
      VALUES (_URAUL_SDoc,
              _URAUL_Pl_Id,
              _URAUL_Success,
              _URAUL_ErrMsg,
              _URAUL_URAS_DateUpdate,
              _URAUL_UnloadTime);
  
END
go

GRANT EXECUTE ON pr_CopyURASInCurrentShop TO ElectroBasic
GO

EXEC sp_addextendedproperty N'#BaseTable', N'UserRightAccessShopUnloadLog', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASInCurrentShop', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Description', N'Копируем конкретное право на конкретный магазин', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASInCurrentShop', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Type', N'insert', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASInCurrentShop', NULL, NULL
GO

