unit uShopReturnDoc;

interface

uses Variants, SysUtils, DB, ADODB, Classes, StrUtils, uShopCommunication;

type

  TShopReturnDoc = class(TCustomCommunication)
  protected
    function ShopReturnDocIn : Boolean;
    function ShopReturnDocOut : Boolean;
    function ShopReturnDocSingleDiscounts : Boolean;
    function ShopReturnDemandShop : Boolean;
    function ShopReturnRegisterShop : Boolean;
    function ShopReturnApplContract : Boolean;
    function ShopReturnApplContractRevision : Boolean;
    function ShopReturnCounterfoil : Boolean;
  public
    procedure Communication; override;
    procedure RollbackCommunication; override;
  end;

implementation

uses ONumUtils, DateUtils, Math, ComObj;

function TShopReturnDoc.ShopReturnDocIn : Boolean;
begin
  Result := True;
  ShowStep('Возврат прихода');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select DI_ID, DI_Document, DI_Operate, DI_DocSource, DI_ShopLoad ' +
    'from DocIn where DI_ID = :ID and DI_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        Writeln(FTextFile, 'ReturnDocIn');
        FIDLoad := FqListAdmin.FieldByName('DI_ShopLoad').AsInteger;
        Writeln(FTextFile, 'DI' + IntToHex(FqListAdmin.FieldByName('DI_DocSource').AsLargeInt, 10));
        AddNote('Возврат прихода ' + FqListAdmin.FieldByName('DI_Document').AsString + ' источник ' +
          FqListAdmin.FieldByName('DI_DocSource').AsString);
      end else Result := False;
      if Result then Result := ExecuteUser('update DocIn set DI_ShopLoad = Null where DI_ID = ' +
        IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnDocIn', E.Message);
      on E: EOleException do Result := AddError('ShopReturnDocIn', E.Message);
      on E: Exception do Result := AddError('ShopReturnDocIn', E.Message);
      else Result := AddError('ShopReturnDocIn', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnCounterfoil : Boolean;
begin
  Result := True;
  ShowStep('Возврат корешка');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select CouS_ID, CouS_IDBase,Cous_ShopLoad ' +
                      'from CounterfoilShop where CouS_ID = :ID and Cous_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        Writeln(FTextFile, 'Counterfoil');
        FIDLoad := FqListAdmin.FieldByName('Cous_ShopLoad').AsInteger;
        Writeln(FTextFile, 'Cf' + IntToHex(FqListAdmin.FieldByName('CouS_IDBase').AsLargeInt, 10));
        AddNote('Возврат корешка ' + FqListAdmin.FieldByName('CouS_IDBase').AsString);
      end else Result := False;
      if Result then Result := ExecuteUser('update CounterfoilShop set Cous_ShopLoad = Null where Cous_ID = ' +
        IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnCounterfoil', E.Message);
      on E: EOleException do Result := AddError('ShopReturnCounterfoil', E.Message);
      on E: Exception do Result := AddError('ShopReturnCounterfoil', E.Message);
      else Result := AddError('ShopReturnCounterfoil', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnDocOut : Boolean;
begin
  Result := True;
  ShowStep('Возврат расхода');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select DO_ID, DO_Document, DO_Operate, DO_Client, DO_Selling, DO_DateMove, ' +
    'DO_DocSource, DO_ShopLoad from DocOut where DO_ID = :ID and DO_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        FIDLoad := FqListAdmin.FieldByName('DO_ShopLoad').AsInteger;
        Writeln(FTextFile, 'ReturnDocOut');
        Writeln(FTextFile, 'DO' + IntToHex(FqListAdmin.FieldByName('DO_DocSource').AsLargeInt, 10));
        AddNote('Возврат расхода ' + FqListAdmin.FieldByName('DO_Document').AsString + ' источник ' +
          FqListAdmin.FieldByName('DO_DocSource').AsString);
      end else Result := False;
      if Result then Result := ExecuteUser('update DocOut set DO_ShopLoad = Null where DO_ID = ' +
        IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnDocOut', E.Message);
      on E: EOleException do Result := AddError('ShopReturnDocOut', E.Message);
      on E: Exception do Result := AddError('ShopReturnDocOut', E.Message);
      else Result := AddError('ShopReturnDocOut', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnDocSingleDiscounts : Boolean;
begin
  Result := True;
  ShowStep('Возврат документа цен для разовых скидок');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select DSD_ID, DSD_ShopLoad from DocSingleDiscounts where DSD_ID = :ID and DSD_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        Writeln(FTextFile, 'ReturnDocSingleDiscounts');
        FIDLoad := FqListAdmin.FieldByName('DSD_ShopLoad').AsInteger;
        Writeln(FTextFile, 'DSD' + IntToHex(FqListAdmin.FieldByName('DSD_ID').AsInteger, 8));
        AddNote('Возврат документа цен для разовых скидок ' + FqListAdmin.FieldByName('DSD_ID').AsString);
      end else Result := False;
      if Result then Result := ExecuteAdmin('update DocSingleDiscounts set DSD_ShopLoad = Null where DSD_ID = ' + IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnDocSingleDiscounts', E.Message);
      on E: EOleException do Result := AddError('ShopReturnDocSingleDiscounts', E.Message);
      on E: Exception do Result := AddError('ShopReturnDocSingleDiscounts', E.Message);
      else Result := AddError('ShopReturnDocSingleDiscounts', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnDemandShop : Boolean;
begin
  Result := True;
  ShowStep('Возврат обработанной заявки');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select DS_ID, DS_Document, DS_ShopLoad from DemandShop where DS_ID = :ID and DS_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        Writeln(FTextFile, 'ReturnDemandShop');
        FIDLoad := FqListAdmin.FieldByName('DS_ShopLoad').AsInteger;
        Writeln(FTextFile, 'DS' + IntToHex(FqListAdmin.FieldByName('DS_Document').AsLargeInt, 10));
        AddNote('Возврат обработанной заявки ' + FqListAdmin.FieldByName('DS_Document').AsString);
      end else Result := False;
      if Result then Result := ExecuteUser('update DemandShop set DS_ShopLoad = Null where DS_ID = ' +
        IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnDemandShop', E.Message);
      on E: EOleException do Result := AddError('ShopReturnDemandShop', E.Message);
      on E: Exception do Result := AddError('ShopReturnDemandShop', E.Message);
      else Result := AddError('ShopReturnDemandShop', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnRegisterShop : Boolean;
begin
  Result := True;
  ShowStep('Возврат реестра');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select RS_ID, RS_ShopLoad from RegisterShop where RS_ID = :ID and RS_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        Writeln(FTextFile, 'ReturnRegisterShop');
        FIDLoad := FqListAdmin.FieldByName('RS_ShopLoad').AsInteger;
        Writeln(FTextFile, 'RS' + IntToHex(FqListAdmin.FieldByName('RS_ID').AsInteger, 8));
        AddNote('Возврат реестра ' + FqListAdmin.FieldByName('RS_ID').AsString);
      end else Result := False;
      if Result then Result := ExecuteAdmin('update RegisterShop set RS_ShopLoad = Null where RS_ID = ' + IntToStr(FIDDoc));
    except
      on E: EDatabaseError do Result := AddError('ShopReturnRegisterShop', E.Message);
      on E: EOleException do Result := AddError('ShopReturnRegisterShop', E.Message);
      on E: Exception do Result := AddError('ShopReturnRegisterShop', E.Message);
      else Result := AddError('ShopReturnRegisterShop', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnApplContract : Boolean;
begin
  Result := True;
  ShowStep('Возврат заявки на договор');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select AC_ID, AC_IDOffice, AC_ShopLoad, Con_Warehouse from ApplContract, Config where AC_ID = :ID and AC_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        if FqListAdmin.FieldByName('Con_Warehouse').AsString = '' then
        begin
           Result := AddError('ShopReturnApplContract', 'Не заполнен путь к хранилищу файлов...');
           Exit;
        end;
        Writeln(FTextFile, 'ReturnApplContract');
        FIDLoad := FqListAdmin.FieldByName('AC_ShopLoad').AsInteger;
        Result := ExecuteAdmin('declare @nID int, @nShopLoad int ' +
          '  set @nID = ' + IntToStr(FIDDoc) +
          '  set @nShopLoad = ' + IntToStr(FIDLoad) +

          ' if Exists(select ACF_ID from ApplContract inner join ApplContractFiles on AC_ID = ACF_SDoc and ' +
          '    ACF_IDOffice is not Null and (ACF_Contract = 0 or ACF_Contract = 1 and ACF_Type = 0) ' +
          '    where AC_ID = @nID and AC_ShopLoad = @nShopLoad ' +
          '  union all ' +
          '  select ACF_ID from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '    ACF_IDOffice is not Null and ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '     where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'begin ' +
          '  delete ' + FqListAdmin.FieldByName('Con_Warehouse').AsString + '.dbo.FileStorage where FS_Type = 10 and FS_Name in ( ' +
          '    select ''ACFiles'' + dbo.ZStr(ACF_ID, 10) + ACF_FileExt from ApplContract inner join ApplContractFiles on AC_ID = ACF_SDoc and ' +
          '      ACF_IDOffice is not Null and (ACF_Contract = 0 or ACF_Contract = 1 and ACF_Type = 0) ' +
          '      where AC_ID = @nID and AC_ShopLoad = @nShopLoad ' +
          '      union all ' +
          '    select ''ACFiles'' + dbo.ZStr(ACF_ID, 10) + ACF_FileExt from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '      ACF_IDOffice is not Null and ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '      where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +

          '  delete ApplContractFiles where ACF_ID in ( ' +
          '    select ACF_ID from ApplContract inner join ApplContractFiles on AC_ID = ACF_SDoc and ' +
          '      (ACF_Contract = 0 or ACF_Contract = 1 and ACF_Type = 0) ' +
          '      where AC_ID = @nID and AC_ShopLoad = @nShopLoad ' +
          '      union all ' +
          '    select ACF_ID from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '      ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '      where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'end ' +

          'if Exists(select ACR_ID from ApplContractRevision where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'begin ' +
          '  update ApplContractRevision set ACR_ShopLoad = Null where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad ' +
          '  delete ApplContractRevision where ACR_SDoc = @nID and ACR_ShopLoad is Null ' +
          'end ' +

          'if Exists(select AC_ID from ApplContract where AC_ID = @nID and AC_ShopLoad = @nShopLoad) ' +
          '  update ApplContract set AC_ShopLoad = Null where AC_ID = @nID and AC_ShopLoad = @nShopLoad');
        if Result then
        begin
          Writeln(FTextFile, 'AC' + IntToHex(FqListAdmin.FieldByName('AC_IDOffice').AsInteger, 8));
          AddNote('Возврат заявки на договор ' + FqListAdmin.FieldByName('AC_IDOffice').AsString);
        end;
      end else Result := False;
    except
      on E: EDatabaseError do Result := AddError('ShopReturnApplContract', E.Message);
      on E: EOleException do Result := AddError('ShopReturnApplContract', E.Message);
      on E: Exception do Result := AddError('ShopReturnApplContract', E.Message);
      else Result := AddError('ShopReturnApplContract', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TShopReturnDoc.ShopReturnApplContractRevision : Boolean;
begin
  Result := True;
  ShowStep('Возврат ревизии к заявке на договор');
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select AC_ID, AC_IDOffice, ACR_SDoc, ACR_ShopLoad, Con_Warehouse ' +
    'from ApplContract, ApplContractRevision, Config where AC_ID = ACR_SDoc and ACR_ID = :ID and ACR_ShopLoad is not Null');
  FqListAdmin.Parameters.ParamByName('ID').Value := FIDDoc;
  try
    try
      FqListAdmin.Open;
      if Result and FqListAdmin.Active and (FqListAdmin.RecordCount = 1) then
      begin
        if FqListAdmin.FieldByName('Con_Warehouse').AsString = '' then
        begin
           Result := AddError('ShopReturnApplContractRevision', 'Не заполнен путь к хранилищу файлов...');
           Exit;
        end;
        Writeln(FTextFile, 'ReturnApplContractRevision');
        FIDLoad := FqListAdmin.FieldByName('ACR_ShopLoad').AsInteger;
        Result := ExecuteAdmin('declare @nID int, @nShopLoad int ' +
          '  set @nID = ' + FqListAdmin.FieldByName('ACR_SDoc').AsString +
          '  set @nShopLoad = ' + IntToStr(FIDLoad) +

          'if Exists(select ACF_ID from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '    ACF_IDOffice is not Null and ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '     where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'begin ' +
          '  delete ' + FqListAdmin.FieldByName('Con_Warehouse').AsString + '.dbo.FileStorage where FS_Type = 10 and FS_Name in ( ' +
          '    select ''ACFiles'' + dbo.ZStr(ACF_ID, 10) + ACF_FileExt from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '      ACF_IDOffice is not Null and ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '      where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +

          '  delete ApplContractFiles where ACF_ID in ( ' +
          '    select ACF_ID from ApplContractRevision inner join ApplContractFiles on ACR_SDoc = ACF_SDoc and ' +
          '      ACF_Contract = 1 and ACF_Type = ACR_Order ' +
          '      where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'end ' +

          'if Exists(select ACR_ID from ApplContractRevision where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad) ' +
          'begin ' +
          '  update ApplContractRevision set ACR_ShopLoad = Null where ACR_SDoc = @nID and ACR_ShopLoad = @nShopLoad ' +
          '  delete ApplContractRevision where ACR_SDoc = @nID and ACR_ShopLoad is Null ' +
          'end ' +

          'update ApplContract set AC_IsTurnBuh = ''Y'', AC_ShopUnload = 1 where AC_ID = @nID');
        if Result then
        begin
          Writeln(FTextFile, 'ACR' + IntToHex(FqListAdmin.FieldByName('AC_IDOffice').AsInteger, 8));
          AddNote('Возврат ревизии к заявке на договор ' + FqListAdmin.FieldByName('AC_IDOffice').AsString);
        end;
      end else Result := False;
    except
      on E: EDatabaseError do Result := AddError('ShopReturnApplContractRevision', E.Message);
      on E: EOleException do Result := AddError('ShopReturnApplContractRevision', E.Message);
      on E: Exception do Result := AddError('ShopReturnApplContractRevision', E.Message);
      else Result := AddError('ShopReturnApplContractRevision', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

procedure TShopReturnDoc.Communication;
begin
  case FTypeDoc of
    1 : FOk := ShopReturnDocIn;
    4 : FOk := ShopReturnDocOut;
    7 : FOk := ShopReturnDocSingleDiscounts;
    9 : FOk := ShopReturnDemandShop;
    12: FOk := ShopReturnRegisterShop;
    13: FOk := ShopReturnApplContract;
    14: FOk := ShopReturnApplContractRevision;
    15: FOk := ShopReturnCounterfoil;
    else FOk := False;
  end;
end;

procedure TShopReturnDoc.RollbackCommunication;
begin
    // Откат возврата документа
  if FOk then Exit;

  ShowStep('Откат возврата документа');
  if FIDLoad = 0 then Exit;

  case FTypeDoc of
    1 : ExecuteUser('update DocIn set DI_ShopLoad = ' + IntToStr(FIDLoad) + ' where DI_ID = ' + IntToStr(FIDDoc));
    4 : ExecuteUser('update DocOut set DO_ShopLoad = ' + IntToStr(FIDLoad) + ' where DO_ID = ' + IntToStr(FIDDoc));
    7 : ExecuteAdmin('update DocSingleDiscounts set DSD_ShopLoad = ' + IntToStr(FIDLoad) + ' where DSD_ID in (' + FSIDDoc + ')');
    9 : ExecuteUser('update DemandShop set DS_ShopLoad = ' + IntToStr(FIDLoad) + ' where DS_ID = ' + IntToStr(FIDDoc));
    12 : ExecuteAdmin('update RegisterShop set ES_ShopLoad = ' + IntToStr(FIDLoad) + ' where RS_ID = ' + IntToStr(FIDDoc));
    13 : ExecuteAdmin('update ApplContract set AC_ShopLoad = ' + IntToStr(FIDLoad) + ' where AC_ID = ' + IntToStr(FIDDoc));
    15: ExecuteAdmin('update CounterfoilShop set Cous_ShopLoad = ' + IntToStr(FIDLoad) + ' where CouS_ID = ' + IntToStr(FIDDoc));
  end;
end;

end.
