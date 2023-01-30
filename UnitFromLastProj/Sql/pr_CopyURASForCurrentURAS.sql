CREATE OR ALTER PROCEDURE pr_CopyURASForCurrentURAS @SAPl_Id INT, --29
                                                    @Data_Source NVARCHAR (MAX), -- 'SQL-T1.dom.loc\MSSQL2016'
                                                    @Id            INT -- 3
AS
BEGIN
   DECLARE
     @Pl_Id          INT,
     @Server         NVARCHAR (MAX),
     @PWD            NVARCHAR (MAX),
     @BDName         NVARCHAR (MAX)
  
    DROP TABLE IF EXISTS #Temp_Place

   CREATE TABLE #Temp_Place
   (
      BDName                VARCHAR (100),
      pl_Id                 INT,
      Shop_Type             INT,
      Pl_Name               VARCHAR (70),
      Data_Source           VARCHAR (100),
      PWD                   VARCHAR (100),
      PlConnectionString    VARCHAR (1000)
   )

   INSERT INTO #Temp_Place (BDName,
                      pl_Id,
                      Shop_Type,
                      Pl_Name,
                      Data_Source,
                      PWD,
                      PlConnectionString)
   
   EXEC pr_GetUserRightAccessShopPlace @SAPl_Id, @Data_Source, 0

    DECLARE
       pl CURSOR LOCAL FOR 
          SELECT pl_Id, Data_Source, PWD, BDName 
          FROM #Temp_Place 
               CROSS APPLY (SELECT *
                            FROM UserRightAccessShop
                            WHERE URAS_ID = @Id) t
               OUTER APPLY (SELECT *
                            FROM UserRightAccessShopUnloadLog
                            WHERE URAUL_SDoc = @Id AND URAUL_Pl_Id = Pl_Id) t2
          WHERE CONVERT (VARCHAR, URAS_DateUpdate, 20) <> CONVERT (VARCHAR, IsNull (URAUL_URAS_DateUpdate, getdate ()), 20)
          ORDER BY pl_Id

    OPEN pl
    FETCH NEXT FROM pl
         INTO @Pl_Id,
              @Server,
              @PWD,
              @BDName

    WHILE @@FETCH_STATUS = 0
    BEGIN
       EXEC
          pr_CopyURASInCurrentShop @Id,
          @Pl_Id,
          @Server,
          @PWD,
          @BDName
       FETCH NEXT FROM pl
            INTO @Pl_Id,
                 @Server,
                 @PWD,
                 @BDName
    END

    CLOSE pl
    DEALLOCATE pl
  
END
go

GRANT EXECUTE ON pr_CopyURASForCurrentURAS TO ElectroBasic
GO

EXEC sp_addextendedproperty N'#BaseTable', N'UserRightAccessShopUnloadLog', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASForCurrentURAS', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Description', N'Копируем конкретное право на все магазины', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASForCurrentURAS', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Type', N'insert', 'SCHEMA', N'dbo', 'PROCEDURE', N'pr_CopyURASForCurrentURAS', NULL, NULL
GO

