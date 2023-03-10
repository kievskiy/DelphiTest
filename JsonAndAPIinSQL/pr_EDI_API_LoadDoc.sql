CREATE 
PROCEDURE pr_EDI_API_LoadDoc @dd int  
AS      
BEGIN      
  
  SET NOCOUNT ON      
  SET ANSI_WARNINGS OFF  
    
  
  declare @auth varchar(200), @address varchar(200), @name varchar(200), @status int, @dialid nvarchar(200)  
  declare @stat int, @docid nvarchar(200), @newadr varchar(200), @address2 varchar(200), @prov smallint  
  declare @resp nvarchar(max) = null, @selling int, @cl int  
  declare @rb varbinary(max) = null  
  
  select @auth = EAA_Autorization,  
         @address = PrEDI_AddresAPI,  
         @address2 = PrEDI_AddresAPIs,  
         @name = PrEDI_Name,  
         @status = DD_EDIStatus,  
         @dialid = dd_dealID,
         @prov = PrEDI_ID,
         @selling = DD_Selling,
         @cl = DD_Client
    from ProviderEDI  
         join Client on Cl_ProviderEDI = PrEDI_ID  
         join DocDemand on DD_Client = Cl_ID   
         join EDI_API_Authorization on EAA_Client = DD_Selling and EAA_ProviderEDI = PrEDI_ID and EAA_Type = 0  
    where DD_ID = @dd  
          and PrEDI_TypeAccess = 1  
  
  if @auth is null  
    throw 50100, 'Не установлен токен авторизации провайдера~или провайдер не переключен в режим связи по API...~(pr_EDI_API_LoadDocv)', 10  
  
  if @address is null  
    throw 50100, 'Не введен адрес провайдера~или провайдер не переключен в режим связи по API...~(pr_EDI_API_LoadDoc)', 10  
  
  if @status = 0  
    return  
  
  if upper(right(rtrim(@address), 10)) <> '/DOCUMENTS'  
    set @address = rtrim(@address) + '/documents'  
  
  
  
  drop table if exists #edistatus  
  create table #edistatus(id varchar(255), number varchar(255), id_sdoc varchar(255), type int, date_created varchar(200), auth varchar(200))  
  exec pr_EDI_API_GetStatus @dd, 1, @stat out  
  
  if @stat = 1   
    return  
  
  if @status = 1 
  begin  
    
    set @docid = (select top 1 id from #edistatus where type = 3 order by date_created desc)   
    if @docid is not null  
    begin  
      set @newadr = @address + '/' + @docid + '/original'  
      select @resp = dbo.EDI_API_Get_Text(@newadr, 'application/json; charset=utf-8', @auth) 

      if @resp is not null  
      begin  
        set @newadr = 'DESADV reject ' + @newadr  
        exec EDIGetDesAdv @resp, @newadr, 1, @docid, @dialid   
      end  
      return  
    end  
  
    set @docid = (select top 1 id from #edistatus where type = 2 order by date_created desc)   
    if @docid is not null  
    begin  
      set @newadr = @address + '/' + @docid + '/original'  
      select @resp = dbo.EDI_API_Get_Text(@newadr, 'application/json; charset=utf-8', @auth) 
      if @resp is not null  
      begin  
        set @newadr = 'ORDERSP ' + @newadr  
        exec EDIGetOrderSP @resp, @newadr, @dialid  
      end  
      set @status = (select dd_edistatus from docdemand where dd_id = @dd)  
    end  
  end  
  
  
  set @docid = (select top 1 id   
                  from #edistatus  
                       left join DocdemandDA on number = DDA_Number  collate Cyrillic_General_CI_AS and dda_type = 0  
                  where type = 4 and dda_id is null  
                  order by date_created desc)   
  
  if @docid is not null  
  begin  
    set @newadr = @address + '/' + @docid + '/original'  
    select @resp = dbo.EDI_API_Get_Text(@newadr, 'application/json; charset=utf-8', @auth) 
    if @resp is not null  
    begin  
      set @newadr = 'DESADV ' + @newadr  
      exec EDIGetDesAdv @resp, @newadr, 1, @docid, @dialid   
    end  
    set @status = (select dd_edistatus from docdemand where dd_id = @dd)  
  end  

  
  set @docid = (select top 1 id   
    from #edistatus  
                       left join DocdemandDA on number = DDA_Number collate Cyrillic_General_CI_AS and dda_type = 1 and DDA_SignedSuppl = 0  
                  where type = 5 and dda_id is null  
                  order by date_created desc)   
  if @docid is not null  
  begin  
    set @newadr = @address + '/' + @docid + '/original'  
    select @resp = dbo.EDI_API_Get_Text(@newadr, 'application/json; charset=utf-8', @auth) 
    if @resp is not null  
    begin  
      set @newadr = 'COMDOC_006 ' + @newadr  
      exec EDIGet_ComDoc_006RNP @resp, @newadr, 0, @docid, @dialid, 0  
    end  
    set @status = (select dd_edistatus from docdemand where dd_id = @dd)  
  end  
  
  
  set @docid = (select top 1 id   
                  from #edistatus  
                       left join DocdemandDA on number = DDA_Number collate Cyrillic_General_CI_AS and dda_type = 1 and DDA_SignedSuppl = 1  
                  where type = 9 and dda_id is null  
                  order by date_created desc)   
  if @docid is not null  
  begin  
    set @newadr = @address2 + '/' + @docid + '/p7s'  
    select @rb = dbo.EDI_API_Get_Binary(@newadr, 'application/json; charset=utf-8', @auth)   
    set @resp = cast(@rb as nvarchar(max))  
    if @resp is not null  
    begin  
      set @newadr = 'COMDOC_006 ' + @newadr  
      exec EDIGet_ComDoc_006RNP @resp, @newadr, 0, @docid, @dialid, 1  
    end  
    set @status = (select dd_edistatus from docdemand where dd_id = @dd)  
  end  
  

  
  delete #edistatus  where 1=1
  exec pr_EDI_API_GetList 1, @prov, @selling, 1  

  update aa
    set DDA_IsInactive = 1, DDA_ShopUnload = null
    from DocDemandDA as aa
         join #edistatus on id = dda_dealid collate SQL_Latin1_General_CP1251_CI_AS
    where type = 5 and DDA_IsInactive = 0 and DDA_DocDemand = @dd
  

  
  
  delete edi_api_filespost
    where ea_sdoc in (select dda_id from docdemandda where dda_type = 1 and dda_docdemand = @dd)

  select @address = PrEDI_AddresAPIo,
         @name = PrEDI_Name
    from ProviderEDI
    where prEDI_id = @prov

  select @auth = EAA_Autorization
    from EDI_API_Authorization
    where EAA_Client = @selling
          and EAA_ProviderEDI = @prov
          and EAA_Type = 1

  drop table if exists #edistatusfiles
  create table #edistatusfiles(t_id nvarchar(200), t_number nvarchar(200), t_title nvarchar(200), t_status int, t_type  varchar(200), t_date_created nvarchar(200), t_auth varchar(200))

  if @auth is null
    throw 50100, 'Не установлен токен авторизации пары провайдер-покупатель...~(pr_EDI_API_GetListFiles)', 10

  if @address is null
    throw 50100, 'Не введен адрес провайдера~или провайдер не переключен в режим связи по API...~(pr_EDI_API_GetListFiles)', 10

  set @address = rtrim(@address) + '/incoming-documents'

  declare @d datetime = dateadd(month, -2, GetDate()) 
  declare @v varchar(50) = 'date_created_from=' + convert(varchar, @d, 23) + 'T' + convert(varchar, @d, 108) + '.000000'

  set @address += '?' + @v
  select @resp = dbo.EDI_API_Get_Text(@address, 'application/json; charset=utf-8', @auth)

  if rtrim(ltrim(@resp)) = '' or @resp is null
    return

  if ISJSON(@resp) = 0 
    return

  drop table if exists #__edist
  select *
    into #__edist
    FROM OPENJSON (json_query(@resp, '$.documents'))  
    WITH (  
      ID       varchar(200)  N'$.id',
      number   varchar(200)  N'$.number',
      title    varchar(200)  N'$.title',
      status   int           N'$.status',
      type     varchar(200)  N'$.type',
      date_created varchar(200)  N'$.date_created'
         ) as oa01
  
    insert into #edistatusfiles
      select *, @auth 
      from #__edist

    delete #edistatusfiles
    where case when t_type = 'DELNOT' and charindex('_', t_number) > 0 
                                      then substring(t_number, 1, charindex('_', t_number) - 1)
                                      else t_number 
                                      end
       not in (select dda_number from docdemandda where dda_docdemand = @dd and dda_type = 1 and dda_isinactive = 0)

  declare @testbase bit = iif(master.dbo.IsPrimaryReplica() = 1, 0, 1)  

  declare @dda int 
  declare @now smalldatetime = cast(GetDate() as date)

  declare @cKey1 sysname, @ckey2 sysname, @ckey3 sysname    
  declare @ta smallint, @ac bit
  declare @numb int, @mess varchar(max)
  declare @namefile varchar(200) = ''
  
  select @address = PrEDI_AddresAPIo,
         @name = PrEDI_Name,
         @ta = PrEDI_TypeAccess,
         @ac = PrEDI_Active  
    from ProviderEDI
    where prEDI_id = @prov

  if @ta <> 1 return
  if @ac = 0 return

  declare @id nvarchar(255), @tp varchar(200), @send int, @title nvarchar(200), @number nvarchar(200)
  
  set @cl = @selling
  declare @body nvarchar(1000) = 
'{
"force": true
}'
    exec prInitLoopCounter @@SPID, @@ProcID, 1, @cKey2 out
    
    declare c1 cursor local for
    select dda_id, DDA_Number, t_id, t_type, t_auth, DDA_Send, t_title 
      from DocDemandDA
           join #edistatusfiles on case when t_type = 'DELNOT' and charindex('_', t_number) > 0 
                                      then substring(t_number, 1, charindex('_', t_number) - 1)
                                      else t_number 
                                      end = DDA_Number collate SQL_Latin1_General_CP1251_CI_AS
      where DDA_Type = 1 and dda_rejected = 0 and DDA_isInactive = 0
      order by t_type

    open c1
    fetch next from c1 into @dda, @number, @id, @tp, @auth, @send, @title
    while @@FETCH_STATUS = 0
    begin
      exec prClackLoopCounter @cKey2, 100000
      set @newadr = @address + '/documents/' + @id + '/xml-to-pdf' 

      exec HTTP_Request_A_EDI @newadr, @resp out, @rb out, null, 'POST', 'application/json; charset=utf-8', @auth, @body, @select = 0
      select @rb = dbo.EDI_API_Get_Binary(@newadr, 'application/json; charset=utf-8', @auth) 

      if @rb is null or len(@rb) < 200
      begin
        insert into EDIReceiveLog(ERL_FileName, ERL_File, ERL_ReceiveNote, ERL_ReceiveStatus)
          select @newadr, compress(cast(@rb as nvarchar(max))), 'Ошибочный печатный оригинал документа', -1
        fetch next from c1 into @dda, @number, @id, @tp, @auth, @send, @title
        continue
      end 

      update EDI_API_GenIDForNames set EAG_Number += 1
      
      select @numb = EAG_Number 
      from EDI_API_GenIDForNames
      
      set @namefile = right('0000000000' + cast(@numb as varchar), 10) + '.pdf'
      if dbo.FileSave(iif(@testbase = 1, '\test', '') + '\EDI_API_Files', @namefile, @rb) <> 1
      begin   
        insert into EDIReceiveLog(ERL_FileName, ERL_File, ERL_ReceiveNote, ERL_ReceiveStatus)
          select @newadr, compress(cast(@rb as nvarchar(max))), 'Ошибка сохранения файла PDF ' + iif(@testbase = 1, '\test', '') + '\EDI_API_Files' + @namefile + ' c номером ' + @number, -1
        fetch next from c1 into @dda, @number, @id, @tp, @auth, @send, @title
        continue
      end

      if @send = 0
      begin
        insert into EDI_API_FilesPost(EA_SDoc, EA_Name, EA_Note)
          select @dda, @namefile, isnull(@title, '')

        declare @signatures varchar(MAX)

        SELECT @signatures = dbo.EDI_API_Get_Text
                ('https://vchasno.ua/api/v2/documents/' + @id + '/signatures',
                 'application/json; charset=utf-8',
                   @auth)
        
        UPDATE DocDemandDA
        SET DDA_Vchasno_Id = @id, DDA_Vchasno_signatures = @signatures
        WHERE dda_id = @dda

        update docdemandda 
        set DDA_SignedSuppl = 1 
        where dda_id = @dda 
              and DDA_SignedSuppl = 0

      end
      else begin
        insert into EDI_API_PodpDoc(EA_SDoc, EA_Name, EA_Note)
          select @dda, @namefile, isnull(@title, '')
      end

       insert into EDIReceiveLog(ERL_FileName, ERL_File, ERL_ReceiveNote, ERL_ReceiveStatus)
          select @newadr, null, 'Успешно загружен файл ' + iif(@testbase = 1, '\test', '') + '\EDI_API_Files' + @namefile, 0

      fetch next from c1 into @dda, @number, @id, @tp, @auth, @send, @title
    end
    close c1
    deallocate c1
  

END
GO