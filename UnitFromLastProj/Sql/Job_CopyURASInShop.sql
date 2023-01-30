CREATE OR ALTER PROCEDURE Job_CopyURASInShop @SAPl_Id INT, --29
                                             @Data_Source NVARCHAR (MAX) -- 'SQL-T1.dom.loc\MSSQL2016'
                                                    
AS
BEGIN
   DECLARE @Id   INT
   DECLARE
      @Server   NVARCHAR (MAX) = '',
      @Pl_Id    INT,
      @Res      BIT

   DROP TABLE IF EXISTS #PlaceForURAS

   CREATE TABLE #PlaceForURAS
   (
      BDName                VARCHAR (100),
      pl_Id                 INT,
      Shop_Type             INT,
      Pl_Name               VARCHAR (70),
      Data_Source           VARCHAR (100),
      PWD                   VARCHAR (100),
      PlConnectionString    VARCHAR (1000)
   )

   INSERT INTO #PlaceForURAS (BDName,
                        pl_Id,
                        Shop_Type,
                        Pl_Name,
                        Data_Source,
                        PWD,
                        PlConnectionString)

   EXEC pr_GetUserRightAccessShopPlace @SAPl_Id, @Data_Source, 0

   ALTER TABLE #PlaceForURAS
      ADD _IsActive BIT NOT NULL DEFAULT 0

   IF master.dbo.IsPrimaryReplica () = 1
      BEGIN
         DECLARE
            pl CURSOR LOCAL FOR SELECT pl_Id, Data_Source FROM #PlaceForURAS

         OPEN pl
         FETCH NEXT FROM pl   INTO @Pl_Id, @Server

         WHILE @@FETCH_STATUS = 0
         BEGIN
            SET @Res = 0
            EXECUTE electro.dbo.PingServer @Server, @Res OUTPUT

            MERGE INTO #PlaceForURAS AS a
            USING (SELECT @Pl_Id _pl_id, @Res AS res) AS b
            ON a.Pl_Id = b._Pl_Id
            WHEN MATCHED
            THEN
               UPDATE SET _IsActive = b.res
            WHEN NOT MATCHED
            THEN
               INSERT (pl_id, _IsActive)
               VALUES (@Pl_Id, @Res);

            FETCH NEXT FROM pl   INTO @Pl_Id, @Server
         END

         CLOSE pl
         DEALLOCATE pl
      END
   ELSE
      BEGIN
         UPDATE #PlaceForURAS
         SET _IsActive = 1
      END

   DROP TABLE IF EXISTS #Temp_URAS_Result

   SELECT URAS_Id,
          pl_Id,
          CASE
             WHEN CONVERT (VARCHAR, URAS_DateUpdate, 20) =
                  CONVERT
                  (VARCHAR, IsNull (URAUL_URAS_DateUpdate, getdate ()), 20)
             THEN
                cast (1 AS BIT)
             ELSE
                cast (0 AS BIT)
          END AS URAUL_Success
   INTO #Temp_URAS_Result
   FROM #PlaceForURAS p1
        CROSS APPLY (SELECT * FROM UserRightAccessShop) t1
        OUTER APPLY (SELECT *
                     FROM UserRightAccessShopUnloadLog
                     WHERE URAUL_SDoc = URAS_Id AND URAUL_Pl_Id = Pl_Id) t2
   ORDER BY pl_Id

   DELETE FROM #Temp_URAS_Result
   WHERE URAUL_Success = 1

   MERGE UserRightAccessShopUnloadLog AS target
   USING (SELECT URAS_Id AS _URAUL_SDoc,
                 t1.pl_Id AS _URAUL_Pl_Id,
                 cast (0 AS BIT) AS _URAUL_Success,
                 getdate (),
                 'Магазин не пингуется' AS _URAUL_ErrMsg
          FROM #Temp_URAS_Result t1
               INNER JOIN #PlaceForURAS t2
                  ON t1.pl_Id = t2.pl_Id AND t2._IsActive = 0)
         AS source (_URAUL_SDoc,
                    _URAUL_Pl_Id,
                    _URAUL_Success,
                    _URAUL_UnloadTime,
                    _URAUL_ErrMsg)
   ON (    target.URAUL_SDoc = source._URAUL_SDoc
       AND target.URAUL_Pl_Id = source._URAUL_Pl_Id)
   WHEN MATCHED
   THEN
      UPDATE
         SET target.URAUL_Success = source._URAUL_Success,
             target.URAUL_UnloadTime = source._URAUL_UnloadTime,
             target.URAUL_ErrMsg = source._URAUL_ErrMsg
   WHEN NOT MATCHED
   THEN
      INSERT (URAUL_SDoc,
              URAUL_Pl_Id,
              URAUL_Success,
              URAUL_ErrMsg,
              URAUL_UnloadTime)
      VALUES (_URAUL_SDoc,
              _URAUL_Pl_Id,
              _URAUL_Success,
              _URAUL_ErrMsg,
              _URAUL_UnloadTime);

   DECLARE
      @PWD      NVARCHAR (MAX),
      @BDName   NVARCHAR (MAX)

   DECLARE
      pl CURSOR LOCAL FOR
         SELECT URAS_Id,
                t1.pl_Id,
                Data_Source,
                PWD,
                BDName
         FROM #Temp_URAS_Result t1
              INNER JOIN #PlaceForURAS t2
                 ON t1.pl_Id = t2.pl_Id AND t2._IsActive = 1

   OPEN pl
   FETCH NEXT FROM pl
        INTO @Id,
             @Pl_Id,
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
           INTO @Id,
                @Pl_Id,
                @Server,
                @PWD,
                @BDName
   END

   CLOSE pl
   DEALLOCATE pl
END
GO

GRANT EXECUTE ON Job_CopyURASInShop TO ElectroBasic
GO

EXEC sp_addextendedproperty N'#BaseTable', N'UserRightAccessShopUnloadLog', 'SCHEMA', N'dbo', 'PROCEDURE', N'Job_CopyURASInShop', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Description', N'Копируем все право на все магазины', 'SCHEMA', N'dbo', 'PROCEDURE', N'Job_CopyURASInShop', NULL, NULL
GO
EXEC sp_addextendedproperty N'#Type', N'insert', 'SCHEMA', N'dbo', 'PROCEDURE', N'Job_CopyURASInShop', NULL, NULL
GO

