CREATE OR ALTER PROCEDURE pr_GetUserRightAccessShopPlace @SAPlId        SMALLINT,
                                               @Data_Source   VARCHAR (100),
                                               @Shop_Type     SMALLINT
AS
BEGIN
   ---------------------
   SET ANSI_WARNINGS ON  
   SET ANSI_NULLS ON   
   ---------------------
   DECLARE @SQL   NVARCHAR (MAX)

   IF master.dbo.IsPrimaryReplica () = 1
      SET @SQL =
               'DECLARE @SAPlId        SMALLINT, @Data_Source   VARCHAR (100), @Shop_Type       SMALLINT'
             + ' SET @Data_Source = '''           
             + @Data_Source 
             + ''''               
             + ' SET @SAPlId = '
             + CAST (@SAPlId AS NVARCHAR)
             + ''
             + ' SET @Shop_Type = '
             + CAST (@Shop_Type AS NVARCHAR)
             + ''               
             + '     SELECT DISTINCT'
             + '            Pl_BDName AS BDName,'
             + '            pl_Id,            '
             + '            Shop_Type,'
             + '            Pl_Name,'
             + '            Pl_IPAdrec AS Data_Source,'
             + '            PWD,'
             + '              ''Provider=SQLOLEDB.1;Password='''
             + '            + PWD'
             + '            + '';Persist Security Info=True;User ID=sa;Initial Catalog='''
             + '            + Pl_BDName COLLATE SQL_Latin1_General_CP1251_CI_AS'
             + '            + '';Data Source='''
             + '            + Pl_IPAdrec PlConnectionString'
             + '     FROM electro..Place p'
             + '          CROSS APPLY (SELECT * FROM Get_Shop_Type(PL_ID)) c1'
             + '          CROSS APPLY'
             + '          (SELECT SMMerchManagement.dbo.UnCryptingPas (Pl_Password) COLLATE SQL_Latin1_General_CP1251_CI_AS AS PWD) ps'
             + '     WHERE PL_Type = 2'
             + '       AND PL_DateEnd IS NULL'
             + '       AND Pl_TempClose = 0'
             + '       AND PL_Activate = 1'
             + '       AND ((@Shop_Type = 0)'
             + '         OR (Shop_Type = @Shop_Type))'
             + '     ORDER BY Shop_Type, pl_Id';
   ELSE
      SET @SQL =
               'DECLARE @SAPlId        SMALLINT, @Data_Source   VARCHAR (100), @Shop_Type       SMALLINT'
             + ' SET @Data_Source = '''           
             + @Data_Source 
             + ''''               
             + ' SET @SAPlId = '
             + CAST (@SAPlId AS NVARCHAR)
             + ''
             + ' SET @Shop_Type = '
             + CAST (@Shop_Type AS NVARCHAR)
             + ''
             + '        SELECT DISTINCT'
             + '               name AS BDName,'
             + '               pl_Id,               '
             + '               Shop_Type,'
             + '               Pl_Name,'
             + '               @Data_Source AS Data_Source,'
             + '               PWD,'
             + '                 ''Provider=SQLOLEDB.1;Password='''
             + '               + PWD'
             + '               + '';Persist Security Info=True;User ID=sa;Initial Catalog='''
             + '               + Pl_BDName COLLATE SQL_Latin1_General_CP1251_CI_AS'
             + '               + '';Data Source='''
             + '               + @Data_Source PlConnectionString'
             + '        FROM Shops.master.sys.databases'
             + '             INNER JOIN electro..Place'
             + '                ON [name] = Pl_BDName COLLATE SQL_Latin1_General_CP1251_CI_AS'
             + '               AND ((Pl_BDName <> ''ShopAccount'')'
             + '                 OR (pl_id = @SAPlId))'
             + '             CROSS APPLY (SELECT * FROM Get_Shop_Type(PL_ID)) c1'
             + '             CROSS APPLY (SELECT ''1111'' COLLATE SQL_Latin1_General_CP1251_CI_AS AS PWD) ps             '
             + '        WHERE PL_Type = 2'
             + '          AND PL_DateEnd IS NULL'
             + '          AND Pl_TempClose = 0'
             + '          AND PL_Activate = 1'
             + '          AND ((@Shop_Type = 0)'
             + '            OR (Shop_Type = @Shop_Type))'
             + '        ORDER BY Shop_Type, pl_Id';

   EXEC sp_executeSQL @Sql
END
GO


GRANT EXECUTE ON pr_GetUserRightAccessShopPlace TO ElectroBasic
GO


EXEC sp_addextendedproperty N'#BaseTable', N'Place', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_GetUserRightAccessShopPlace', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Description', N'Возвращает набор ТТ для чекаксеса с пабамертами подключений', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_GetUserRightAccessShopPlace', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Type', N'select', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_GetUserRightAccessShopPlace', NULL, NULL
GO