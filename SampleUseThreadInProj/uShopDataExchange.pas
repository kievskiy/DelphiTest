unit uShopDataExchange;
{$INCLUDE definitions.inc}

interface

uses Variants, SysUtils, DB, ADODB, {$IFDEF TRADE}DataModule,{$ENDIF}
     Classes;//, SyncObjs;

type

  TSendDataExchange  = class(TThread)
  private
  protected
    FService : boolean;
    FOk : boolean;
    FStartTheFlow : boolean;
    FPlace : Integer;
    FNameShop : string;
    FLogDataExchange : String;
    FRegFilesPath : String;
    FOMFilesPath : String;
    FHelpFilesPath : String;
    FGroupFilesPath : String;
    FARTLPFilesPath : String;
    FARSLPFilesPath : String;
    FSCLPFilesPath : String;
    FBookComplaintFilesPath : String;
    FMAPMFilesPath : String;
    FShopCollectionFilePath : String;
    FACFilesPath : String;
    FPersonFilesAnkPath : String;
    FDemandRepairFilesPath : string;
    FSupermarcet : boolean;
    FSendSupplier : boolean;
    FSalon : boolean;
    FPlacePresence : boolean;
    FSubdivision : Integer;
    FDepartment : Integer;
    FWarehouse : String;
    FWarehousePhoto : String;
    FErrorChat : String;
    FLayOutPhotoPath : String;
    FLayOutPhotoPathDoc : String;
    FPersonFiles : String;
    FMCRFiles : String;
    FCounterfoilReturnFile : String;
    FDocRROFiles : string;
    FShopInvSheetFile : String;
    FDataSource : String;
    FBDName : String;
    FUserName : String;
    FPassword : String;
    FconMain: TADOConnection;
    FqMain: TADOQuery;
    FconShop: TADOConnection;
    FqShop: TADOQuery;
    FqShopFile: TADOQuery;
    FShowSendDataExchange : TThreadProcedure;
    FEndSendDataExchange : TThreadProcedure;
    FIPAdresShop : String;
    FBDNameShop : String;
    FPasswordShop : String;
    FShopDocInFile:string;
    FMeterLeaseActFiles: String;
    FPersonHappyFile : String;
    FActDamageTovarListPhoto : String;
    FActReceptSupplierFile : String;
    FDocDemandReclamationTovarListPhoto : String;

    FNameOfStep : String;
    FMax : Integer;
    FPos : Integer;

    FDatePeriod : Variant;

    FActions: TStringList;

    function IsSkipAction(pAction:String):Boolean;

    function GetConnected : boolean;
    function GetErrorChat : string;
    function GetNameOfStep : String;

    function FormStepResult(const ACount : integer; AName : String = '';
      ANameEmpty : String = ''; const ATextAdd : String = '') : string;
    procedure SetShowSendDataExchange(AValue : TThreadProcedure);
    procedure SaveLog(const AType, ASendName : Integer; const ANote : string);
    procedure DoShowSendDataExchange(ANameOfStep : string; AMax : integer = 0; APos : integer = 0);
    procedure DoConnect;

    function BasaOpen(const ACommandText, AParams : string; const AValues: OleVariant; var cError : string) : Boolean; overload;
    function BasaOpen(const ACommandText : string; var cError : string) : Boolean; overload;
    function ShopOpen(const ACommandText, AParams : string; const AValues: OleVariant; var cError : string) : Boolean; overload;
    function ShopOpen(const ACommandText : string; var cError : string) : Boolean; overload;
    function BasaSetNextID(var cError : string) : Boolean;
    function ShopSetNextID(var cError : string) : Boolean;

    function CompareTable(AStepID : Integer; ATableBase, ATable, AExcepFields : String; AWhere : String = '';
      ASearchDateUpdate : boolean = True; AAllData : boolean = False; AFields : String = '') : boolean; overload;
    function CompareTable(AStepID : Integer; ATable, AExcepFields : String) : boolean; overload;
    function CompareTableClient(AStepID : Integer; ATableBase, ATable, AExcepFields : String; AWhere : String = '';
      ASearchDateUpdate : boolean = True; AAllData : boolean = False; AFields : String = '') : boolean;

    function StepProcessing(ASendName : integer) : boolean;
    // получение размера и даты файла
    procedure GetFileSizeDate(AFileName : string; var ASize : Integer; var ADate : TDateTime );
    // проверка существования файла
    function GetFileExists(AFileName : string) : Boolean;

    function SendPresencePlace : Boolean;
    function SendReglament : Boolean;
    function SendRegStaff : Boolean;
    function SendRegFile : Boolean;
    function SendBegunokTurn : Boolean;
    function SendReadMeReg : Boolean;
    function LoadReadMeReg : Boolean;
    function SendPerson : Boolean;
    function SendPersonFilial : Boolean;
    function SendPersonJob : Boolean;
    function SendOfficeMemoFile : Boolean;
    function LoadOfficeMemoFile : Boolean;
    function SendPersonPass : Boolean;
    function SendTovarPhoto : Boolean;
    function LoadARTLP : Boolean;
    function LoadActReceptSupplPhoto : Boolean;
    function LoadActReceptSupplEDIPhoto : Boolean;
    function LoadStoreCheckListPhotoPhoto : Boolean;
    function UnloadARTLP : Boolean;
    function UnloadARTPlaceLlistPhoto: Boolean;
    function SendHelpFile : boolean;
    function SendGroupsFile : boolean;
    function SendPersonDeduct : Boolean;
    function LoadBookComplaint : boolean;
    function LoadMAPMFiles : boolean;
    function LoadShopCollectionFile : boolean;
    function LoadShopCollectionListFile : boolean;
    function SendPersonMoving : Boolean;
    function LoadLayoutPhoto : boolean;
    function LoadApplContractFiles : boolean;
    function LoadApplContractFilesRetail : boolean;
    function SendApplContractFiles : boolean;
    function ReturnApplContractFiles : boolean;
    function SendPlanogram : boolean;
    function LoadLayoutPhotoDoc : boolean;
    function SendLayoutPhotoDoc : boolean;
    function SendInventCardPhoto : boolean;
    function SendPersonHappyFile : boolean;
    function TakeActDamageTovarListPhoto: boolean;
    function TakeActReceptSupplierFile: boolean;
    function TakeActReceptSupplierEDIFile: boolean;

    function TakeDocDemandReclamationPhoto: boolean;
    function LoadPersonFiles : boolean;
    function LoadMCRFiles : boolean;
    function DelLayoutPhotoDoc : boolean;
    function DelLayoutPhoto : boolean;
    function DelDocInFile : boolean;
    function DelOfficeMemo : boolean;
    function DelOfficeMemoFile : boolean;
    function DelOfficeMemoFileOld : boolean;
    function DelMCRFiles : boolean;
    function LoadDocRROFiles : boolean;
    function LoadCounterfoilReturnFile: boolean;
    function DelDismissedEmployeeFile : boolean;
    function DelInventSheetFile : boolean;
    function LoadShopInvShetFile: boolean;
    function LoadShopInvShetPerson: boolean;
    function DelDocRROFiles : boolean;
    function LoadShopPersonPass: boolean;
    function LoadDocInFiles: boolean;   //Загрузка файлов по приходным документам
    function LoadMeterLeaseActFiles: boolean;
    function LoadDemandTovarFiles : Boolean; // Загрузка прикрепленных файлов к "Заявка под клиента" на офис с магазина
    function LoadOfficeMemo: boolean; // Загрузка СЗ с магазинов
    function SendPersonFilesAnk: boolean; // Отправка анкет (файлов) на мазагин с офиса
    function LoadPersonFilesAnk : boolean; // Загрузка анкет (файлов) на офис с мазагина
    function LoadDemandRepairFiles: boolean;//Файлы для заявок на ремонт из ТТ
    function LoadDemandRepairAssets: Boolean; //Забираем с ТТ. Заявки на ремонт

    procedure Execute; override;
  public
    { Public declarations }
    constructor Create(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String; pActions:String=''); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure Connect; overload;
    procedure Connect(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String); overload;
    procedure SetParam(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String; pActions:String='');
    procedure SendDataExchange;

    property Place : Integer read FPlace;
    property Connected : boolean read GetConnected;
    property StartTheFlow : boolean read FStartTheFlow;
    property LogDataExchange : String read FLogDataExchange;
    property ErrorChat : String read FErrorChat;
    property ErrorChatFull : String read GetErrorChat;
    property SendOk : boolean read FOk write FOK;
    property NameOfStep : String read GetNameOfStep;
    property MaxPosition : Integer read FMax;
    property Position : Integer read FPos;
    property Terminated;
    property OnShowSendDataExchange : TThreadProcedure read FShowSendDataExchange write SetShowSendDataExchange;
    property OnEndSendDataExchange : TThreadProcedure read FEndSendDataExchange write FEndSendDataExchange;
  end;

//var
//  CSReglament: TCriticalSection;
//  CSOfficeMemo: TCriticalSection;
//  CSGroups: TCriticalSection;

implementation

uses ONumUtils, DateUtils, Math, TRexCrypting; //, uShopCommunication;//, DataModule;

constructor TSendDataExchange.Create(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String; pActions:String='');
begin
  inherited Create(True);
  FService := True;
  FPlace := APlace;
  FDataSource := ADataSource;
  FBDName := ABDName;
  FUserName := AUserName;
  FPassword := APassword;

  FOK := False;
  FStartTheFlow := True;
  FNameShop := '';
  FLogDataExchange := '';
  FRegFilesPath := '';
  FOMFilesPath := '';
  FHelpFilesPath := '';
  FGroupFilesPath := '';
  FARTLPFilesPath := '';
  FARSLPFilesPath := '';
  FSCLPFilesPath := '';
  FBookComplaintFilesPath := '';
  FLayOutPhotoPath := '';
  FLayOutPhotoPathDoc := '';
  FMAPMFilesPath := '';
  FShopCollectionFilePath := '';
  FACFilesPath := '';
  FPersonFilesAnkPath := '';
  FDemandRepairFilesPath := '';
  FSupermarcet := False;
  FSendSupplier := False;
  FSalon := False;
  FSubdivision := 0;
  FDepartment := 0;
  FPlacePresence := False;
  FWarehouse := '';
  FWarehousePhoto := '';
  FErrorChat := '';
  FNameOfStep := '';
  FPersonFiles:='';
  FMCRFiles:='';
  FCounterfoilReturnFile:='';
  FDocRROFiles := '';
  FShopInvSheetFile:='';
  FShopDocInFile:='';
  FMeterLeaseActFiles:='';
  FMax := 0;
  FPos := 0;
  FShowSendDataExchange := Nil;
  FEndSendDataExchange := Nil;
  FDatePeriod := Null;

  FconMain := TADOConnection.Create(Nil);
  FconMain.LoginPrompt := False;
  FconMain.CommandTimeout := 360;
  FqMain := TADOQuery.Create(Nil);
  FqMain.Connection := FconMain;
  FqMain.CommandTimeout := 360;

  FconShop := TADOConnection.Create(Nil);
  FconShop.LoginPrompt := False;
  FconShop.CommandTimeout := 360;
  FqShop := TADOQuery.Create(Nil);
  FqShop.Connection := FconShop;
  FqShop.CommandTimeout := 360;
  FqShopFile := TADOQuery.Create(Nil);
  FqShopFile.Connection := FconShop;
  FqShopFile.CommandTimeout := 360;
  FActions:= TStringList.Create;
  FActions.Delimiter:=',';
  FActions.DelimitedText:=UpperCase(pActions);
end;

constructor TSendDataExchange.Create;
begin
  Create(0, '', '', '', '');
end;

destructor TSendDataExchange.Destroy;
begin
  FqShopFile.Free;
  FqShop.Free;
  FconShop.Free;
  FqMain.Free;
  FconMain.Free;
  FActions.Free;

  inherited Destroy;
end;

function TSendDataExchange.GetConnected : boolean;
begin
  Result := FconShop.Connected;
end;

function TSendDataExchange.GetErrorChat : string;
begin
  if FErrorChat <> '' then
    Result := 'Магазин ' + IntToStr(FPlace) + ' - ' + FNameShop + '~' + FErrorChat
  else Result := '';
end;

function TSendDataExchange.GetFileExists(AFileName: string): Boolean;
var SP : TADOStoredProc;
    PathName, FileName : string;
begin
  Result := False;
  {$IFDEF TRADE}
    PathName := ExtractFilePath(AFileName);
    FileName := ExtractFileName(AFileName);

    sp := CreateProc('sp_FileExistsFromSecure', False, 3);
    sp.Parameters.ParamByName('@FilePath').Value := PathName;
    sp.Parameters.ParamByName('@FileName').Value := FileName;
    try
      try
        sp.Open;
        Result := sp.FieldByName('Exist').AsBoolean;
      except on E:Exception do
        SMessage('Ошибка при вызове sp_FileExistsFromSecure:~' + E.Message);
      end;
    finally
      sp.Free;
    end;
  {$ELSE}
    Result := FileExists(AFileName)
  {$ENDIF}
end;

procedure TSendDataExchange.GetFileSizeDate(AFileName: string;
  var ASize: Integer; var ADate: TDateTime);
var SP : TADOStoredProc;
begin
  {$IFDEF TRADE}
    sp := CreateProc('sp_GetFileSizeDate', False, 3);
    sp.Parameters.ParamByName('@FileName').Value := AFileName;
    try
      try
        sp.Open;
        ASize := sp.FieldByName('_Size').AsInteger;
        ADate := sp.FieldByName('_Date').AsDateTime;
      except on E:Exception do
        SMessage('Ошибка при вызове sp_GetFileSizeDate:~' + E.Message);
      end;
    finally
      sp.Free;
    end;
  {$ELSE}
    ASize := GetFileSize(AFileName);
    ADate := GetFileDate(AFileName);
  {$ENDIF}
end;

function TSendDataExchange.GetNameOfStep : String;
begin
  Result := FNameOfStep;
  if FMax > 1 then Result := Result + '. Количество записей ' + IntToStr(FMax);
end;

function TSendDataExchange.IsSkipAction(pAction: String): Boolean;
begin
  if FActions.Count>0 then
    Result:=FActions.IndexOf(UpperCase(pAction))=-1
  else
    Result:=False;
end;

function TSendDataExchange.FormStepResult(const ACount : integer; AName : String = '';
  ANameEmpty : String = ''; const ATextAdd : String = '') : string;
begin
  if not Terminated then
  begin
    if AName = '' then AName := 'Обновлено - %u записей';
    if ANameEmpty = '' then ANameEmpty := 'Отличий нет';
    if ACount <> 0 then Result := Format(AName, [ACount])
    else Result := ANameEmpty;
    if ATextAdd <> '' then Result := Result + ATextAdd;
  end else Result := 'Прервано';
end;

procedure TSendDataExchange.SetShowSendDataExchange(AValue : TThreadProcedure);
begin
  FShowSendDataExchange := AValue;
  FService := not Assigned(FShowSendDataExchange);
end;

procedure TSendDataExchange.SaveLog(const AType, ASendName : Integer; const ANote : string);
begin
  if FService and FconMain.Connected then
  begin
    try
      {$IFDEF SHOPDATAEXCHANGE}
      FconMain.Execute('insert LogDataExchange (LDE_Type,LDE_SendName,LDE_Place,LDE_Note,LDE_Project) values (' + IntToStr(AType) + ',' +
        IntToSVar(ASendName) + ', ' + IntToSVar(FPlace) + ', ' + StrToQuery(ANote) + ', ' +
        StrToQuery('Electro ShopDataExchange') + ')')
      {$ELSE}
      {$IFDEF SHOPDATAEXCHANGEFILES}
      FconMain.Execute('insert LogDataExchange (LDE_Type,LDE_SendName,LDE_Place,LDE_Note,LDE_Project) values (' + IntToStr(AType) + ',' +
        IntToSVar(ASendName) + ', ' + IntToSVar(FPlace) + ', ' + StrToQuery(ANote) + ', ' +
        StrToQuery('Electro ShopDataExchangeFiles') + ')')
      {$ELSE}
      FconMain.Execute('insert LogDataExchange (LDE_Type,LDE_SendName,LDE_Place,LDE_Note) values (' + IntToStr(AType) + ',' +
        IntToSVar(ASendName) + ', ' + IntToSVar(FPlace) + ', ' + StrToQuery(ANote) + ')')
      {$ENDIF}
      {$ENDIF}
    except
    end;
  end else if ANote <> '' then FLogDataExchange := FLogDataExchange + '~' + '  ' + ANote;
end;

procedure TSendDataExchange.DoShowSendDataExchange(ANameOfStep : string; AMax : integer = 0; APos : integer = 0);
  var nPos : integer;
begin

  if ANameOfStep = '' then ANameOfStep := FNameOfStep;
  if (FNameOfStep = ANameOfStep) and (AMax = 0) then AMax := FMax;

  if AMax >= 1 then nPos := APos * 100 div AMax else nPos := 0;

  if Assigned(FShowSendDataExchange) then
  begin
    if (FNameOfStep <> ANameOfStep) or (FMax <> AMax) or (FPos <> nPos) then
    begin
      FMax := AMax;
      FPos := nPos;
      if FNameOfStep <> ANameOfStep then
      begin
        FNameOfStep := ANameOfStep;
        FLogDataExchange := FLogDataExchange + '~' + ANameOfStep;
      end;
      Synchronize(FShowSendDataExchange);
    end;
  end else
  begin
    FMax := AMax;
    FPos := nPos;
    FNameOfStep := ANameOfStep;
  end;
end;


function TSendDataExchange.BasaOpen(const ACommandText, AParams : string; const AValues: OleVariant; var cError : string) : Boolean;
  var I, L : Integer;
begin
  if FqMain.Active then FqMain.Close;
  try
    FqMain.SQL.Text := ACommandText;
    if not VarIsNull(AValues) then
    begin
      if VarIsArray(AValues) then
      begin
        L := VarArrayHighBound(AValues, 1) + 1;
        if (AParams <> '') and (L > (CountToken(AParams, ','))) then
          L := CountToken(AParams, ',');
      end else L := 1;
      if AParams <> '' then
      begin
        for I := 0 to L - 1 do if Assigned(FqMain.Parameters.FindParam(Trim(Token(AParams, ',', I + 1)))) then
          FqMain.Parameters.ParamByName(Trim(Token(AParams, ',', I + 1))).Value :=
          VarArrayGet(AValues, I);
      end else
      begin
        for I := 0 to L - 1 do FqMain.Parameters.Items[I + 1].Value :=
          VarArrayGet(AValues, I);
      end;
    end;
    FqMain.Open;
  except
    on E: EDatabaseError do cError := E.Message;
    on E: Exception do cError := E.Message;
  end;
  Result := FqMain.Active;
end;

function TSendDataExchange.BasaOpen(const ACommandText : String; var cError : string) : Boolean;
begin
  Result := BasaOpen(ACommandText, '', Null, cError);
end;

function TSendDataExchange.ShopOpen(const ACommandText, AParams : string; const AValues: OleVariant; var cError : string) : Boolean;
  var I, L : Integer;
begin
  if FqShop.Active then FqShop.Close;
  try
    FqShop.SQL.Text := ACommandText;
    if not VarIsNull(AValues) then
    begin
      if VarIsArray(AValues) then
      begin
        L := VarArrayHighBound(AValues, 1) + 1;
        if (AParams <> '') and (L > (CountToken(AParams, ','))) then
          L := CountToken(AParams, ',');
      end else L := 1;
      if AParams <> '' then
      begin
        for I := 0 to L - 1 do if Assigned(FqShop.Parameters.FindParam(Trim(Token(AParams, ',', I + 1)))) then
          FqShop.Parameters.ParamByName(Trim(Token(AParams, ',', I + 1))).Value :=
          VarArrayGet(AValues, I);
      end else
      begin
        for I := 0 to L - 1 do FqShop.Parameters.Items[I + 1].Value :=
          VarArrayGet(AValues, I);
      end;
    end;
    FqShop.Open;
  except
    on E: EDatabaseError do cError := E.Message;
    on E: Exception do cError := E.Message;
  end;
  Result := FqShop.Active;
end;

function TSendDataExchange.ShopOpen(const ACommandText : string; var cError : string) : Boolean;
begin
  Result := ShopOpen(ACommandText, '', Null, cError);
end;

function TSendDataExchange.BasaSetNextID(var cError : string) : Boolean;
  var nID : Integer;
begin
  cError := '';
  if FqMain.Active then
  begin
    FqMain.Last;
    nID := FqMain.Fields[0].AsInteger;
    FqMain.Close;
  end else nID := 0;
  try
    FqMain.Parameters.ParamByName('ID').Value := nID;
    FqMain.Open;
    FqMain.First;
  except
    on E: EDatabaseError do cError := E.Message;
    on E: Exception do cError := E.Message;
  end;
  Result := FqMain.Active;
end;

function TSendDataExchange.ShopSetNextID(var cError : string) : Boolean;
  var nID : Integer;
begin
  cError := '';
  if FqShop.Active then
  begin
    FqShop.Last;
    nID := FqShop.Fields[0].AsInteger;
    FqShop.Close;
  end else nID := 0;
  try
    FqShop.Parameters.ParamByName('ID').Value := nID;
    FqShop.Open;
    FqShop.First;
  except
    on E: EDatabaseError do cError := E.Message;
    on E: Exception do cError := E.Message;
  end;
  Result := FqShop.Active;
end;

function TSendDataExchange.CompareTable(AStepID : Integer; ATableBase, ATable, AExcepFields : String; AWhere : String = '';
  ASearchDateUpdate : boolean = True; AAllData : boolean = False; AFields : String = '') : boolean;

  var nID, nCount, nCountAll, nPos, I : Integer; cListField, cIDField, cDateUpdate,
      cPermision, cIns, cUpd, cError : String; cPermBit : boolean;

  function FieldToString(AField : string) : String;
  begin
    if FqMain.FieldByName(AField).IsNull then Result := 'Null'
    else case FqMain.FieldByName(AField).DataType of
      ftString, ftFixedChar, ftWideString, ftMemo : Result := StrToQuery(FqMain.FieldByName(AField).AsString);
      ftDate, ftTime, ftDateTime : Result := DateTimeToQuery(FqMain.FieldByName(AField).AsDateTime);
      ftBoolean : Result := BoolToBit(FqMain.FieldByName(AField).AsBoolean);
      ftBlob : Result := ImageToQuery(FqMain.FieldByName(AField).AsBytes);
      else Result := FqMain.FieldByName(AField).AsString;
    end;
  end;

  function FieldToStringList : String;
    var J : Integer;
  begin
    Result := '';
    for J := 1 to CountToken(cListField, ',') do
    begin
      if Result <> '' then Result := Result + ',';
      Result := Result + FieldToString(Token(cListField, ',', J));
    end;
  end;

  function CompareData : boolean;
    var J : Integer;
  begin
    Result := True;
    for J := 2 to CountToken(cListField, ',') do
      if (FqMain.FieldByName(Token(cListField, ',', J)).DataType = ftBlob) and
        (ImageToQuery(FqMain.FieldByName(Token(cListField, ',', J)).AsBytes) <>
        ImageToQuery(FqShop.FieldByName(Token(cListField, ',', J)).AsBytes)) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in [ftString, ftFixedChar, ftWideString, ftMemo]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsString <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsString) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in [ftDate, ftDateTime, ftTime]) and
        (RoundSum(FqMain.FieldByName(Token(cListField, ',', J)).AsCurrency) <>
        RoundSum(FqShop.FieldByName(Token(cListField, ',', J)).AsCurrency)) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in
        [ftBCD, ftSmallint, ftInteger, ftWord, ftFloat, ftSingle, ftCurrency]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsExtended <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsExtended) or
      not (FqMain.FieldByName(Token(cListField, ',', J)).DataType in
        [ftString, ftFixedChar, ftWideString, ftMemo, ftDate, ftDateTime, ftTime,
        ftBCD, ftSmallint, ftInteger, ftWord, ftFloat, ftSingle, ftCurrency, ftBlob]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsVariant <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsVariant) then
      begin
        Result := False;
        Break;
      end;
  end;

  function FieldToStringUpdate : String;
    var J : Integer;
  begin
    Result := '';
    for J := 2 to CountToken(cListField, ',') do
    begin
      if Result <> '' then Result := Result + ',';
      Result := Result + Token(cListField, ',', J) + ' = ' + FieldToString(Token(cListField, ',', J));
    end;
  end;

begin
  Result := False; nCountAll := 0;
  try
    if not BasaOpen('select * from SendName where SN_ID = ' + IntToStr(AStepID), cError) then Exit;

    if FqMain.RecordCount <> 1 then
    begin
      cError := 'Не найдено описание шага: ' + IntToStr(AStepID);
      Exit;
    end;

    DoShowSendDataExchange(FqMain.FieldByName('SN_Name').AsString);
    SaveLog(11, AStepID, '');

    if Terminated then Exit;

    cDateUpdate := ''; cListField := ''; cIDField := ''; cPermision := ''; cPermBit := False;

    if not ShopOpen('select top 1 * from ' + ATable, cError) then Exit;;
    if not BasaOpen('select top 1 * from ' + ATableBase, cError) then Exit;

    try
      for I := 0 to FqMain.FieldCount - 1 do
        if Assigned(FqShop.FindField(FqMain.Fields[I].FieldName)) then
        begin
          if not CheckTokenTrim(AExcepFields, FqMain.Fields[I].FieldName, ',') then
            cListField := cListField + IfStr(cListField = '', '', ',') + FqMain.Fields[I].FieldName;
        end;
      if AFields <> '' then cListField := AFields;

      cIDField := Token(cListField, ',', 1);

      if ASearchDateUpdate and Assigned(FqMain.FindField(Token(cListField, '_', 1) + '_DateUpdate')) then
      begin
        cDateUpdate := Token(cListField, '_', 1) + '_DateUpdate';
        AAllData := FDatePeriod = Null;
      end else AAllData := AAllData or (FDatePeriod = Null);

      if Assigned(FqMain.FindField(Token(cListField, '_', 1) + '_Permision')) then
      begin
        cPermision := Token(cListField, '_', 1) + '_Permision';
        cPermBit := FqMain.FieldByName(Token(cListField, '_', 1) + '_Permision').DataType = ftBoolean;
      end;

      if (cDateUpdate = '') or (FDatePeriod = Null) then
      begin
        if not BasaOpen('select Count(*) as CountLoad from ' + ATableBase +
          IfStr(AWhere <> '', ' where ' + AWhere, ''), cError) then Exit;
      end else if not BasaOpen('select Count(*) as CountLoad from ' + ATableBase + ' where ' +
        IfStr(AWhere <> '', AWhere + ' and ', '') +
        cDateUpdate +' >= :Date', 'Date', VarArrayOf([FDatePeriod]), cError) then Exit;

      nID := FqMain.FieldByName('CountLoad').AsInteger;
      if (cDateUpdate = '') or (FDatePeriod = Null) then
      begin
        if not BasaOpen('select top 1000 ' + cListField +
          ' from '  + ATableBase + ' where ' + IfStr(AWhere <> '', '(' + AWhere + ') and ', '') +
          cIDField + ' > :ID order by ' + cIDField, 'ID', VarArrayOf([0]), cError) then Exit;
      end else if not BasaOpen('select top 1000 ' + cListField + ' from '  + ATableBase +
        ' where (' + IfStr(AWhere <> '', '' + AWhere + ' and ', '') + cDateUpdate + ' >= :Date) and ' +
        cIDField + ' > :ID order by ' + cIDField,
        'ID,Date', VarArrayOf([0, FDatePeriod]), cError) then Exit;

      if not ShopOpen('select Count(*) as CountLoad from ' + ATable, cError) then Exit;
      DoShowSendDataExchange('', Max(nID, FqShop.FieldByName('CountLoad').AsInteger));

      if not ShopOpen('select top 1000 ' + cListField + ' from '  + ATable +
        ' where ' + cIDField + ' > :ID order by ' + cIDField, 'ID', VarArrayOf([0]), cError) then Exit;
      if not AAllData and (FqMain.RecordCount = 0) and (FqShop.RecordCount > 0) then Exit;

      cIns := ''; cUpd := ''; nCount := 0; nCountAll := 0; nPos := 0;
      FqMain.First; FqShop.First;
      while not FqMain.Eof or (FqMain.RecordCount > 0) or not FqShop.Eof or (FqShop.RecordCount > 0) do
      begin
        DoShowSendDataExchange('', 0, nPos + FqMain.RecNo);

        if FqMain.Eof and (FqMain.RecordCount > 0) then
        begin
          nPos := nPos + FqMain.RecordCount;
          if not BasaSetNextID(cError) then Exit;
          if Terminated then Exit;
        end;

        if FqShop.Eof and (FqShop.RecordCount > 0) then
        begin
          if not ShopSetNextID(cError) then Exit;
          if Terminated then Exit;
        end;

        if not FqMain.Eof and not FqShop.Eof and (FqMain.FieldByName(cIDField).AsInteger = FqShop.FieldByName(cIDField).AsInteger) then
        begin
          if not CompareData then
          begin
            Inc(nCount);
            cUpd := cUpd + 'update ' + ATable + ' set ' + FieldToStringUpdate +
              ' where ' + cIDField + ' = ' + FqMain.FieldByName(cIDField).AsString + ';'#13#10;
          end;
          FqMain.Next; FqShop.Next;
        end else if not FqMain.Eof and (FqShop.Eof or
          (FqMain.FieldByName(cIDField).AsInteger < FqShop.FieldByName(cIDField).AsInteger)) then
        begin
          Inc(nCount);
          if cIns <> '' then cIns := cIns + ',';
          cIns := cIns + '(' + FieldToStringList + ')';
          FqMain.Next;
        end else if not FqShop.Eof then
        begin
          if AAllData then
          begin
            try
              FconShop.Execute('delete from ' + ATable + ' where ' + cIDField + ' = ' +
                FqShop.FieldByName(cIDField).AsString)
            except
              try
                FconShop.Execute('update ' + ATable + ' set ' + cPermision + ' = ' +
                  IfStr(cPermBit, '0', '''N''') + ' where ' + cIDField + ' = ' + FqShop.FieldByName(cIDField).AsString)
              except
              end;
            end;
            Inc(nCountAll);
          end;
          FqShop.Next;
        end;

        if FqMain.Eof and (nCount <> 0) or (nCount = 300) then
        begin
          if cIns <> '' then FconShop.Execute('insert into ' + ATable + '(' + cListField + ') Values ' + cIns);
          if cUpd <> '' then FconShop.Execute(cUpd);
          Inc(nCountAll, nCount);
          cIns := ''; cUpd := ''; nCount := 0;
        end;

        if not AAllData and FqMain.Eof and (FqMain.RecordCount = 0) then Break;

        if Terminated then Exit;
      end;
    except
      on E: EDatabaseError do cError := E.Message;
      on E: Exception do cError := E.Message;
      else cError := 'Ошибка сравнения таблицы: ' + ATableBase;
    end;
    Result := True;
  finally
    FqMain.Close;
    FqShop.Close;
    try
      if Result then SaveLog(13, AStepID, FormStepResult(nCountAll))
      else SaveLog(12, AStepID, cError);
    except
    end;
    Result := True;
  end;

end;

function TSendDataExchange.CompareTable(AStepID : Integer; ATable, AExcepFields : String) : boolean;
begin
  Result := CompareTable(AStepID, ATable, ATable, AExcepFields);
end;

function TSendDataExchange.CompareTableClient(AStepID : Integer; ATableBase, ATable, AExcepFields : String; AWhere : String = '';
      ASearchDateUpdate : boolean = True; AAllData : boolean = False; AFields : String = '') : boolean;
var nID, nCount, nCountAll, nPos, I : Integer; cListField, cIDField, cDateUpdate,
      cPermision, cIns, cUpd, cError : String; cPermBit : boolean;
      cLastSyncDate, cIDs : string;

  function FieldToString(AField : string) : String;
  begin
    if FqMain.FieldByName(AField).IsNull then Result := 'Null'
    else case FqMain.FieldByName(AField).DataType of
      ftString, ftFixedChar, ftWideString, ftMemo : Result := StrToQuery(FqMain.FieldByName(AField).AsString);
      ftDate, ftTime, ftDateTime : Result := DateTimeToQuery(FqMain.FieldByName(AField).AsDateTime);
      ftBoolean : Result := BoolToBit(FqMain.FieldByName(AField).AsBoolean);
      ftBlob : Result := ImageToQuery(FqMain.FieldByName(AField).AsBytes);
      else Result := FqMain.FieldByName(AField).AsString;
    end;
  end;

  function FieldToStringList : String;
    var J : Integer;
  begin
    Result := '';
    for J := 1 to CountToken(cListField, ',') do
    begin
      if Result <> '' then Result := Result + ',';
      Result := Result + FieldToString(Token(cListField, ',', J));
    end;
  end;

  function CompareData : boolean;
    var J : Integer;
  begin
    Result := True;
    for J := 2 to CountToken(cListField, ',') do
      if (FqMain.FieldByName(Token(cListField, ',', J)).DataType = ftBlob) and
        (ImageToQuery(FqMain.FieldByName(Token(cListField, ',', J)).AsBytes) <>
        ImageToQuery(FqShop.FieldByName(Token(cListField, ',', J)).AsBytes)) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in [ftString, ftFixedChar, ftWideString, ftMemo]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsString <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsString) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in [ftDate, ftDateTime, ftTime]) and
        (RoundSum(FqMain.FieldByName(Token(cListField, ',', J)).AsCurrency) <>
        RoundSum(FqShop.FieldByName(Token(cListField, ',', J)).AsCurrency)) or
      (FqMain.FieldByName(Token(cListField, ',', J)).DataType in
        [ftBCD, ftSmallint, ftInteger, ftWord, ftFloat, ftSingle, ftCurrency]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsExtended <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsExtended) or
      not (FqMain.FieldByName(Token(cListField, ',', J)).DataType in
        [ftString, ftFixedChar, ftWideString, ftMemo, ftDate, ftDateTime, ftTime,
        ftBCD, ftSmallint, ftInteger, ftWord, ftFloat, ftSingle, ftCurrency, ftBlob]) and
        (FqMain.FieldByName(Token(cListField, ',', J)).AsVariant <>
        FqShop.FieldByName(Token(cListField, ',', J)).AsVariant) then
      begin
        Result := False;
        Break;
      end;
  end;

  function FieldToStringUpdate : String;
    var J : Integer;
  begin
    Result := '';
    for J := 2 to CountToken(cListField, ',') do
    begin
      if Result <> '' then Result := Result + ',';
      Result := Result + Token(cListField, ',', J) + ' = ' + FieldToString(Token(cListField, ',', J));
    end;
  end;

begin
  Result := False; nCountAll := 0;
  try
    if not BasaOpen('select * from SendName where SN_ID = ' + IntToStr(AStepID), cError) then Exit;

    if FqMain.RecordCount <> 1 then
    begin
      cError := 'Не найдено описание шага: ' + IntToStr(AStepID);
      Exit;
    end;

    DoShowSendDataExchange(FqMain.FieldByName('SN_Name').AsString);
    SaveLog(11, AStepID, '');

    if Terminated then Exit;

    cDateUpdate := ''; cListField := ''; cIDField := ''; cPermision := ''; cPermBit := False;

    if not ShopOpen('select top 1 * from ' + ATable, cError) then Exit;;
    if not BasaOpen('select top 1 * from ' + ATableBase, cError) then Exit;

    try
      for I := 0 to FqMain.FieldCount - 1 do
        if Assigned(FqShop.FindField(FqMain.Fields[I].FieldName)) then
        begin
          if not CheckTokenTrim(AExcepFields, FqMain.Fields[I].FieldName, ',') then
            cListField := cListField + IfStr(cListField = '', '', ',') + FqMain.Fields[I].FieldName;
        end;
      if AFields <> '' then cListField := AFields;

      cIDField := Token(cListField, ',', 1);

      if ASearchDateUpdate and Assigned(FqMain.FindField(Token(cListField, '_', 1) + '_DateUpdate')) then
      begin
        cDateUpdate := Token(cListField, '_', 1) + '_DateUpdate';
        AAllData := FDatePeriod = Null;
      end else AAllData := AAllData or (FDatePeriod = Null);

      if Assigned(FqMain.FindField(Token(cListField, '_', 1) + '_Permision')) then
      begin
        cPermision := Token(cListField, '_', 1) + '_Permision';
        cPermBit := FqMain.FieldByName(Token(cListField, '_', 1) + '_Permision').DataType = ftBoolean;
      end;

      if not BasaOpen('select Max(LDE_Date) as LastSyncDate from LogDataExchange where LDE_SendName = ' + IntToStr(AStepID)
         + ' and LDE_Place = ' + IntToStr(FPlace), cError) then Exit;

      cLastSyncDate := FormatDateTime ('yyyymmdd', FqMain.FieldByName('LastSyncDate').AsDateTime);

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('declare @IDs varchar (1024)');
      FqMain.SQL.Add('set @IDs = ''''');
      FqMain.SQL.Add('select @IDs += cast(SL_SDoc as varchar) + '','' from SysLog where SL_Key = 50 and SL_Date > ' + QuotedStr(cLastSyncDate));
      FqMain.SQL.Add('if @IDs != '''' set @IDs = substring(@IDs, 1, (len(@IDs) - 1)) ');
      FqMain.SQL.Add('select @IDs as IDs');

      FqMain.Open;

      cIDs := FqMain.FieldByName('IDs').AsString;

      if cIDs <> '' then
        FconShop.Execute('delete from ' + ATable + ' where ' + cIDField + ' in (' + cIDs + ')');


      if (cDateUpdate = '') or (FDatePeriod = Null) then
      begin
        if not BasaOpen('select Count(*) as CountLoad from ' + ATableBase + ' where ' +
          IfStr(AWhere <> '', AWhere + ' and ', '') + '(Cl_DateInput > ' + QuotedStr(cLastSyncDate) + ' or Cl_DateUpdate > ' + QuotedStr(cLastSyncDate) + ')', cError) then Exit;
      end else if not BasaOpen('select Count(*) as CountLoad from ' + ATableBase + ' where ' +
        IfStr(AWhere <> '', AWhere + ' and ', '') +
        cDateUpdate +' >= :Date', 'Date', VarArrayOf([FDatePeriod]), cError) then Exit;

      nID := FqMain.FieldByName('CountLoad').AsInteger;

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('declare @IDs varchar (1024)');
      FqMain.SQL.Add('set @IDs = ''''');
      FqMain.SQL.Add('select @IDs += cast(CL_ID as varchar) + '','' from Client where ' +
                      IfStr(AWhere <> '', AWhere + ' and ', '') +
                     '(Cl_DateInput > ' + QuotedStr(cLastSyncDate) +
                     ' or Cl_DateUpdate > ' + QuotedStr(cLastSyncDate) + ')');
      FqMain.SQL.Add('if @IDs != '''' set @IDs = substring(@IDs, 1, (len(@IDs) - 1)) ');
      FqMain.SQL.Add('select @IDs as IDs');

      FqMain.Open;

      cIDs := FqMain.FieldByName('IDs').AsString;

      if (cDateUpdate = '') or (FDatePeriod = Null) then
      begin
        if not BasaOpen('select ' + cListField +
          ' from '  + ATableBase + ' where ' + cIDField + ' in (' + cIDs + ') order by ' + cIDField, cError) then Exit;
      end else if not BasaOpen('select ' + cListField + ' from '  + ATableBase +
        ' where (' + IfStr(AWhere <> '', '' + AWhere + ' and ', '') + cDateUpdate + ' >= :Date) and ' +
        cIDField + ' > :ID order by ' + cIDField,
        'ID,Date', VarArrayOf([0, FDatePeriod]), cError) then Exit;

      if not ShopOpen('select Count(*) as CountLoad from ' + ATable + ' where ' + cIDField + ' in (' + cIDs + ')', cError) then Exit;
      DoShowSendDataExchange('', Max(nID, FqShop.FieldByName('CountLoad').AsInteger));

      if not ShopOpen('select ' + cListField + ' from '  + ATable
        + ' where ' + cIDField + ' in (' + cIDs + ')', cError) then Exit;

      cIns := ''; cUpd := ''; nCount := 0; nCountAll := 0; nPos := 0;
      FqMain.First; FqShop.First;
      while not FqMain.Eof or (FqMain.RecordCount > 0) or not FqShop.Eof or (FqShop.RecordCount > 0) do
      begin
        DoShowSendDataExchange('', 0, nPos + FqMain.RecNo);

        if not FqMain.Eof and not FqShop.Eof and (FqMain.FieldByName(cIDField).AsInteger = FqShop.FieldByName(cIDField).AsInteger) then
        begin
          if not CompareData then
          begin
            Inc(nCount);
            cUpd := cUpd + 'update ' + ATable + ' set ' + FieldToStringUpdate +
              ' where ' + cIDField + ' = ' + FqMain.FieldByName(cIDField).AsString + ';'#13#10;
          end;
          FqMain.Next; FqShop.Next;
        end else if not FqMain.Eof and (FqShop.Eof or
          (FqMain.FieldByName(cIDField).AsInteger < FqShop.FieldByName(cIDField).AsInteger)) then
        begin
          Inc(nCount);
          if cIns <> '' then cIns := cIns + ',';
          cIns := cIns + '(' + FieldToStringList + ')';
          FqMain.Next;
        end;

        if FqMain.Eof and (nCount <> 0) then
        begin
          if cIns <> '' then FconShop.Execute('insert into ' + ATable + '(' + cListField + ') Values ' + cIns);
          if cUpd <> '' then FconShop.Execute(cUpd);
          Inc(nCountAll, nCount);
          cIns := ''; cUpd := ''; nCount := 0;
        end;

        if not AAllData and FqMain.Eof and (FqMain.RecordCount = 0) then Break;

        if Terminated then Exit;
      end;
    except
      on E: EDatabaseError do cError := E.Message;
      on E: Exception do cError := E.Message;
      else cError := 'Ошибка сравнения таблицы: ' + ATableBase;
    end;
    Result := True;


  finally
    FqMain.Close;
    FqShop.Close;
    try
      if Result then SaveLog(13, AStepID, FormStepResult(nCountAll))
      else SaveLog(12, AStepID, cError);
    except
    end;
    Result := True;
  end;
end;

function TSendDataExchange.StepProcessing(ASendName : integer) : boolean;
begin
  Result := False;
  try
    FqMain.Close;
    FqMain.SQL.Clear;
    try
      FqMain.SQL.Add('select LDE_ID from LogDataExchange where Cast(LDE_Date as Date) = Cast(GetDate() as Date) and ' +
        'LDE_Type = 13 and LDE_SendName = ' + IntToStr(ASendName) + ' and LDE_Place = ' + IntToStr(FPlace));
      FqMain.Open;
      Result := FQMain.RecordCount > 0;
    except
    end;
  finally
    FqMain.SQL.Clear;
    FqMain.Close;
  end;
end;

procedure TSendDataExchange.DoConnect;
  function TestPath(cPath: String): String;
  begin
    Result:=cPath;
    if (length(cPath) > 0) AND
       (cPath[length(cPath)] <> '/') then
        Result := cPath + '/';
//    if Pos('FILESERVICE',uppercase(Result))>0 then
//      Result:=StringReplace(Result,'FILESERVICE','FileService\Test',[]);
  end;
begin
    // Проверка переменных

  if (FPlace = 0) or (FDataSource = '') or (FBDName = '') or (FUserName = '') or (FPassword = '') then
  begin
    FErrorChat := 'Не заполнены параметры подключения...';
    DoShowSendDataExchange(FErrorChat);
    FStartTheFlow := False;
    Exit;
  end;

  // Подключение к основной БД
  DoShowSendDataExchange('Подключение к основной БД');
//  FconMain.ConnectionString := 'Provider=SQLNCLI;Persist Security Info=False;Initial Catalog=' +
  FconMain.ConnectionString := 'Provider=SQLNCLI11;Persist Security Info=False;Initial Catalog=' +
    FBDName + ';Data Source= ' + FDataSource;

  try
    FconMain.Open(FUserName, FPassword);
    FconMain.Execute('Set Transaction Isolation Level Read Uncommitted');
  except
    on E: EDatabaseError do FErrorChat := '~' + E.Message;
    on E: Exception do FErrorChat := '~' + E.Message;
    else FErrorChat := '~Ошибка подключения с ' + FDataSource;
  end;

    // Получение путей
  if not Terminated and FconMain.Connected then
  begin
    DoShowSendDataExchange('Получение путей');
    FqMain.SQL.Clear;
    FqMain.SQL.Add(
      ' select Con_RegFilesPath, Con_OMFilesPath, Con_ARTLPFilesPath, Con_ARSLPFilesPath, ' +
      '   Con_HelpFilesPath, Con_GroupFilesPath, Con_BookFilesPath, ' +
      '   Con_MAPMFilesPath, Con_LayOutPhotoPath, Con_ACFilesPath, ' +
      '   Con_PersonFilesPath, Con_ShopCollectionFilePath, Con_MCRFiles, ' +
      '   Con_DocRROFiles, Con_CounterfoilReturnFile,Con_ShopInvSheetFile, ' +
      '   Con_ShopDocIntFile, Con_SCLPFilesPath, Con_MeterLeaseActFiles, '+
      '   Con_PersonHappyfile, Con_ActDamageTovarListPhoto, Con_PersonFilesAnk,Con_DocDemandReclamationListPhoto, '+
      '   Con_ActReceptSupplierFile ' +
      ' from Config');

    try
      FqMain.Open;
      FRegFilesPath := FqMain.FieldByName('Con_RegFilesPath').AsString;
      FOMFilesPath := FqMain.FieldByName('Con_OMFilesPath').AsString;
      FHelpFilesPath := FqMain.FieldByName('Con_HelpFilesPath').AsString;
      FGroupFilesPath := FqMain.FieldByName('Con_GroupFilesPath').AsString;
      FARTLPFilesPath := FqMain.FieldByName('Con_ARTLPFilesPath').AsString;
      FARSLPFilesPath := FqMain.FieldByName('Con_ARSLPFilesPath').AsString;
      FSCLPFilesPath  := FqMain.FieldByName('Con_SCLPFilesPath').AsString;
      FACFilesPath := FqMain.FieldByName('Con_ACFilesPath').AsString;
      FPersonHappyFile := FqMain.FieldByName('Con_PersonHappyfile').AsString;
      FActDamageTovarListPhoto := FqMain.FieldByName('Con_ActDamageTovarListPhoto').AsString;
      if (length(FActDamageTovarListPhoto) > 0) AND
         (FActDamageTovarListPhoto[length(FActDamageTovarListPhoto)] <> '/') then
        FActDamageTovarListPhoto := FActDamageTovarListPhoto+'/';

      FActReceptSupplierFile := FqMain.FieldByName('Con_ActReceptSupplierFile').AsString;
      if (length(FActReceptSupplierFile) > 0) AND
         (FActReceptSupplierFile[length(FActReceptSupplierFile)] <> '/') then
        FActReceptSupplierFile := FActReceptSupplierFile+'/';

      FDocDemandReclamationTovarListPhoto := FqMain.FieldByName('Con_DocDemandReclamationListPhoto').AsString;
      if (length(FDocDemandReclamationTovarListPhoto) > 0) AND
         (FDocDemandReclamationTovarListPhoto[length(FDocDemandReclamationTovarListPhoto)] <> '/') then
        FDocDemandReclamationTovarListPhoto := FDocDemandReclamationTovarListPhoto+'/';
      if (length(FARTLPFilesPath) > 0) AND
         (FARTLPFilesPath[length(FARTLPFilesPath)] <> '/') then
        FARTLPFilesPath := FARTLPFilesPath+'/';
      FBookComplaintFilesPath := FqMain.FieldByName('Con_BookFilesPath').AsString;
      FMAPMFilesPath := FqMain.FieldByName('Con_MAPMFilesPath').AsString;
      if (length(FMAPMFilesPath) > 0) AND
         (FMAPMFilesPath[length(FMAPMFilesPath)] <> '/') then
        FMAPMFilesPath := FMAPMFilesPath+'/';
      FShopCollectionFilePath := FqMain.FieldByName('Con_ShopCollectionFilePath').AsString;
      if (length(FShopCollectionFilePath) > 0) AND
         (FShopCollectionFilePath[length(FShopCollectionFilePath)] <> '/') then
        FShopCollectionFilePath := FShopCollectionFilePath+'/';
      if (length(FBookComplaintFilesPath) > 0) AND
         (FBookComplaintFilesPath[length(FBookComplaintFilesPath)] <> '/') then
        FBookComplaintFilesPath := FBookComplaintFilesPath+'/';
      FLayOutPhotoPath := FqMain.FieldByName('Con_LayOutPhotoPath').AsString;
      if (length(FLayOutPhotoPath) > 0) AND
         (FLayOutPhotoPath[length(FLayOutPhotoPath)] <> '/') then
        FLayOutPhotoPath := FLayOutPhotoPath+'/';
      FLayOutPhotoPathDoc := FqMain.FieldByName('Con_LayOutPhotoPath').AsString;
     if (length(FLayOutPhotoPathDoc) > 0) then
      begin
        if (FLayOutPhotoPathDoc[length(FLayOutPhotoPathDoc)] = '/') then
          SetLength(FLayOutPhotoPathDoc, length(FLayOutPhotoPathDoc) - 1);
        FLayOutPhotoPathDoc := FLayOutPhotoPathDoc + 'Doc/';
      end;
       FShopInvSheetFile := FqMain.FieldByName('Con_ShopInvSheetFile').AsString;
       if (length(FShopInvSheetFile) > 0) AND
         (FShopInvSheetFile[length(FShopInvSheetFile)] <> '/') then
       FShopInvSheetFile := FShopInvSheetFile+'/';

       FShopDocInFile := FqMain.FieldByName('Con_ShopDocIntFile').AsString;
       if (length(FShopDocInFile) > 0) AND
         (FShopDocInFile[length(FShopDocInFile)] <> '\') then
       FShopDocInFile := FShopDocInFile+'\';

      FPersonFiles := FqMain.FieldByName('Con_PersonFilesPath').AsString;
      if (length(FPersonFiles) > 0) AND
         (FPersonFiles[length(FPersonFiles)] <> '/') then
          FPersonFiles := FPersonFiles+'/';
      FMCRFiles := FqMain.FieldByName('Con_MCRFiles').AsString;
      if (length(FMCRFiles) > 0) AND
         (FMCRFiles[length(FMCRFiles)] <> '/') then
          FMCRFiles := FMCRFiles+'/';

      FCounterfoilReturnFile:=TestPath(FqMain.FieldByName('Con_CounterfoilReturnFile').AsString);
      FDocRROFiles := TestPath(FqMain.FieldByName('Con_DocRROFiles').AsString);
      FMeterLeaseActFiles := TestPath(FqMain.FieldByName('Con_MeterLeaseActFiles').AsString);
      FPersonFilesAnkPath := TestPath(FqMain.FieldByName('Con_PersonFilesAnk').AsString);
      FDemandRepairFilesPath := TestPath('\\dom.loc\dfs\secure\DemandRepairFiles'); //23888

    except
      on E: EDatabaseError do FErrorChat := E.Message;
      on E: Exception do FErrorChat := E.Message;
      else FErrorChat := 'Ошибка получения путей...'
    end;

    if not FqMain.Active or (FErrorChat <> '') then FconMain.Close;
    if FqMain.Active then FqMain.Close;
  end;

    // Данные о магазине
  if not Terminated and FconMain.Connected then
  begin
    DoShowSendDataExchange('Данные о магазине');
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select Pl_ID, Pl_Name, Pl_Supermarcet, Pl_SendSupplier, Pl_Salon, Pl_IPAdrec, Pl_BDName, Pl_Password,');
    FqMain.SQL.Add('case when not Exists(select LDE_Place from LogDataExchange where LDE_Place = Pl_ID and LDE_Type = 13 and LDE_SendName = 1) or ');
    FqMain.SQL.Add('Exists(select LDE_Place from LogDataExchange where LDE_Place = Pl_ID and LDE_Type = 13 and LDE_SendName = 1 group by LDE_Place');
    FqMain.SQL.Add('having (Max(LDE_Date) < cast(GetDate() as Date) or Datepart(hh, Max(LDE_Date)) < 14 and Datepart(hh, GetDate()) >= 14))');
  	FqMain.SQL.Add('then 0 else 1 end as LDE_PlacePresence,');
    FqMain.SQL.Add('(select top 1 Su_ID from Subdivision where Su_TimeBoard = 1 and Su_Depart = Pl_Depart) as Pl_Subdivision,');
    FqMain.SQL.Add('(select top 1 Su_Department from Subdivision where Su_TimeBoard = 1 and Su_Depart = Pl_Depart) as Pl_Department');
    FqMain.SQL.Add('from Place where Pl_ID = ' + IntTostr(FPlace));
    FqMain.SQL.Add('order by Pl_ID');

    try
      FqMain.Open;
      FNameShop := FqMain.FieldByName('Pl_Name').AsString;
      FSupermarcet := FqMain.FieldByName('Pl_Supermarcet').AsBoolean;
      FSendSupplier := FqMain.FieldByName('Pl_SendSupplier').AsBoolean;
      FSalon := FqMain.FieldByName('Pl_Salon').AsBoolean;
      FSubdivision := FqMain.FieldByName('Pl_Subdivision').AsInteger;
      FDepartment := FqMain.FieldByName('Pl_Department').AsInteger;
      if (FDepartment <> 30100) and (FDepartment <> 30200) then FDepartment := FSubdivision;
      FPlacePresence := FqMain.FieldByName('LDE_PlacePresence').AsInteger = 1;
    except
      on E: EDatabaseError do FErrorChat := E.Message;
      on E: Exception do FErrorChat := E.Message;
      else FErrorChat := 'Ошибка открытия справочника магазинов...'
    end;
    if not FqMain.Active or (FErrorChat <> '') then FconMain.Close;
  end;

    // Соединение с магазином
  if not Terminated and FqMain.Active then
  begin
   DoShowSendDataExchange('Соединение с магазином');
//   FconShop.ConnectionString := 'Provider=SQLNCLI10;Persist Security Info=False;Initial Catalog=' +
   FconShop.ConnectionString := 'Provider=SQLNCLI11;Persist Security Info=False;Initial Catalog=' +
     FqMain.FieldByName('Pl_BDName').AsString + ';Data Source= ' + FqMain.FieldByName('Pl_IPAdrec').AsString;


    try
      FconShop.Open('sa',UnCryptingPassword(FqMain.FieldByName('Pl_Password').AsString));
      FconShop.Execute('Set Transaction Isolation Level Read Uncommitted');
    except
      on E: EDatabaseError do FErrorChat := E.Message;
      on E: Exception do FErrorChat := E.Message;
      else FErrorChat := 'Ошибка соединения с магазином'
    end;

    FIPAdresShop := FqMain.FieldByName('Pl_IPAdrec').AsString;
    FBDNameShop := FqMain.FieldByName('Pl_BDName').AsString;
    FPasswordShop := UnCryptingPassword(FqMain.FieldByName('Pl_Password').AsString);

    if FconShop.Connected then
    begin
      FqShop.Close;
      FqShop.SQL.Clear;
      FqShop.SQL.Add('select Con_Warehouse, Con_WarehousePhoto from Config');
      try
        FqShop.Open;
        if FqShop.RecordCount = 1 then
        begin
          FWarehouse := FqShop.FieldByName('Con_Warehouse').AsString;
          FWarehousePhoto := FqShop.FieldByName('Con_WarehousePhoto').AsString;
        end;
      except
        on E: EDatabaseError do FErrorChat := E.Message;
        on E: Exception do FErrorChat := E.Message;
        else FErrorChat := 'Ошибка определения наличия хранилища'
      end;
      FqShop.Close;
      FqShop.SQL.Clear;
      if FErrorChat <> '' then FconShop.Close;
    end;
  end;

  if not FconShop.Connected and FconMain.Connected then FconMain.Close;
  if not FService then FLogDataExchange := FErrorChat;
  FStartTheFlow := False;
end;

procedure TSendDataExchange.Connect;
begin
  if not Connected then DoConnect;
end;

procedure TSendDataExchange.Connect(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String);
begin
  FPlace := APlace;
  FDataSource := ADataSource;
  FBDName := ABDName;
  FUserName := AUserName;
  FPassword := APassword;

  if not Connected then DoConnect;
end;

procedure TSendDataExchange.SetParam(const APlace : Integer; const ADataSource, ABDName, AUserName, APassword : String; pActions:String='');
begin
  FPlace := APlace;
  FDataSource := ADataSource;
  FBDName := ABDName;
  FUserName := AUserName;
  FPassword := APassword;
  FActions.DelimitedText:=UpperCase(pActions);
end;

// Непосредстванно отправка

function TSendDataExchange.SendPresencePlace : Boolean;
  var S, cPlace : String; I, J, nCount : Integer;
begin
  Result:=True;
  if IsSkipAction('SendPresencePlace') then Exit;

  Result := False; nCount := 0;
  if not FconShop.Connected then Exit;

  try
    SaveLog(11, 1, '');
    cPlace := '0'; I := 0; S := '';
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select Pl_ID from Place where Pl_Type = 2 order by Pl_ID');
    FqMain.Open;
    while not FqMain.Eof do
    begin
      cPlace := cPlace + ',' + FqMain.FieldByName('Pl_ID').AsString;
      FqMain.Next;
    end;

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select PP_ID, PP_Tovar, PP_Saldo, PP_PlaceList from PresencePlace ' +
      'where PP_Place = :Place order by PP_Tovar');

    FconShop.Execute('if Exists(select PP_ID from PresencePlace where PP_Place not in (' + cPlace + ')) ' +
      'update PresencePlace set PP_Saldo = 0.0 where PP_Place not in (' + cPlace + ')');

    FormatSettings.CurrencyString := '.';
    DoShowSendDataExchange('Обновление остатков по складам', CountToken(cPlace, ','));
    for J := 1 to CountToken(cPlace, ',') do
    begin
      DoShowSendDataExchange('', 0, J);
      FqMain.Close; FqShop.Close;
      FqMain.SQL.Clear;
      if Token(cPlace, ',', J) = '0' then
        FqMain.SQL.Add('exec PresencePlaceRozn')
      else FqMain.SQL.Add('select Pr_Place, Pr_Tovar, Sum(Pr_Saldo) as Pr_Saldo, ' +
        'Null as Pr_PlaceList from Presence, Tovar ' +
        'where Pr_Place = ' +  Token(cPlace, ',', J) +
        ' and Pr_Tovar = Tov_ID and Tov_Groups not in (select Gr_ID from Groups where Gr_ShopSaldo = 0)' +
        'group by Pr_Place, Pr_Tovar having Sum(Pr_Saldo) <> 0 order by Pr_Tovar');
      FqShop.Parameters.ParamByName('Place').Value := StrToInt(Token(cPlace, ',', J));
      FqMain.Open; FqShop.Open;
      if FqMain.Active and FqShop.Active then
      begin
        while not FqMain.Eof or not FqShop.Eof do
        begin
          if FqShop.Eof then
          begin
            Inc(I);
            S := S + ' insert PresencePlace (PP_Place,PP_Tovar,PP_Saldo,PP_PlaceList) values (' +
              IntToStr(FqMain.FieldByName('Pr_Place').AsInteger) + ',' +
              IntToStr(FqMain.FieldByName('Pr_Tovar').AsInteger) +  ',' +
              FqMain.FieldByName('Pr_Saldo').AsString + ',' +
              StrToQuery(FqMain.FieldByName('Pr_PlaceList').AsString) + ')';
            FqMain.Next;
          end else if FqMain.Eof then
          begin
            if FqShop.FieldByName('PP_Saldo').AsCurrency <> 0 then
            begin
              Inc(I);
              S := S + ' update PresencePlace set PP_Saldo = 0.0 where PP_ID = ' + FqShop.FieldByName('PP_ID').AsString;
            end;
            FqShop.Next;
          end else if FqMain.FieldByName('Pr_Tovar').AsInteger = FqShop.FieldByName('PP_Tovar').AsInteger then
          begin
            if (FqMain.FieldByName('Pr_Saldo').AsCurrency <> FqShop.FieldByName('PP_Saldo').AsCurrency) or
              (FqMain.FieldByName('Pr_PlaceList').AsString <> FqShop.FieldByName('PP_PlaceList').AsString) then
            begin
              Inc(I);
              S := S + ' update PresencePlace set PP_Saldo = ' +
                FqMain.FieldByName('Pr_Saldo').AsString +
                ', PP_PlaceList = ' + StrToQuery(FqMain.FieldByName('Pr_PlaceList').AsString) +
                ' where PP_ID = ' + FqShop.FieldByName('PP_ID').AsString;
            end;
            FqMain.Next; FqShop.Next;
          end else if FqMain.FieldByName('Pr_Tovar').AsInteger < FqShop.FieldByName('PP_Tovar').AsInteger then
          begin
            Inc(I);
            S := S + ' insert PresencePlace (PP_Place,PP_Tovar,PP_Saldo,PP_PlaceList) values (' +
              IntToStr(FqMain.FieldByName('Pr_Place').AsInteger) + ',' +
              IntToStr(FqMain.FieldByName('Pr_Tovar').AsInteger) +  ',' +
              FqMain.FieldByName('Pr_Saldo').AsString + ',' +
              StrToQuery(FqMain.FieldByName('Pr_PlaceList').AsString) + ')';
            FqMain.Next;
          end else if FqMain.FieldByName('Pr_Tovar').AsInteger > FqShop.FieldByName('PP_Tovar').AsInteger then
          begin
            if FqShop.FieldByName('PP_Saldo').AsCurrency <> 0 then
            begin
              Inc(I);
              S := S + ' update PresencePlace set PP_Saldo = 0.0 where PP_ID = ' + FqShop.FieldByName('PP_ID').AsString;
            end;
            FqShop.Next;
          end;

          if I >= 100 then
          begin
            FconShop.Execute(S);
            nCount := nCount + I; S := ''; I := 0;
          end;
        end;
        if Terminated then Break;
      end;
    end;
    FqMain.Close;
    FqMain.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

    nCount := nCount + I;
    if S <> '' then FconShop.Execute(S);
    FconShop.Execute('delete PresencePlace where PP_Saldo = 0');
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 1, FormStepResult(nCount, '', 'Остатки совпадают'))
    else SaveLog(12, 1, S);
  except
  end;
end;

function TSendDataExchange.SendPerson : Boolean;
  var S, cTable : String; I, nCount : Integer;
begin
  Result:=True;
  if IsSkipAction('SendPerson') then Exit;
  Result := False; nCount := 0;
  if not FconShop.Connected then Exit;

  DoShowSendDataExchange('Контроль сотрудников');
  try
    SaveLog(11, 7, '');
    I := 0; S := '';

    cTable := 'Person';
    if FSupermarcet then cTable := 'PersonBase';

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select Pe_ID, Pe_SurName, Pe_Name, Pe_Patronymic, Pe_Depart, Pe_Subdivision, Pe_Staff, ' +
      'Pe_Place, Pe_OfficeStaff, Pe_ShopStaff, Pe_Birthday, Pe_EnterJoin, Pe_Discharge, Pe_Fluorography from ' + cTable +
      ' order by Pe_ID');

    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select Pe_ID, Pe_SurName, Pe_Name, Pe_Patronymic, Pe_Depart, Pe_Subdivision, Pe_Birthday, ' +
      'Pe_EnterJoin, Pe_Discharge, Pe_Fluorography, Pe_Staff, St_PayTest, St_OfficeMemo, ' +
      'cast(case when Exists(select UR_ID from UserRight where UR_Person = Pe_ID and UR_Disconnect = 0) then 1 else 0 end as bit) as Pe_OfficeStaff, ' +
      '(select Pl_ID from Place inner join Depart on ' +
      'Dep_ID = Pl_Depart inner join Subdivision on Su_Depart = Dep_Id where Su_ID = Pe_Subdivision) as Pe_Place ' +
      'from Person left outer join Staff on St_ID = Pe_Staff ' +
      'order by Pe_ID');

    FqMain.Open; FqShop.Open;
    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if FqShop.Eof then
        begin
          FqMain.Next;
        end else if FqMain.Eof then
        begin
          FqShop.Next;
        end else if FqMain.FieldByName('Pe_ID').AsInteger = FqShop.FieldByName('Pe_ID').AsInteger then
        begin
          if (FqMain.FieldByName('Pe_SurName').AsVariant <> FqShop.FieldByName('Pe_SurName').AsVariant) or
            (FqMain.FieldByName('Pe_Name').AsVariant <> FqShop.FieldByName('Pe_Name').AsVariant) or
            (FqMain.FieldByName('Pe_Patronymic').AsVariant <> FqShop.FieldByName('Pe_Patronymic').AsVariant) or
            (FqMain.FieldByName('Pe_Birthday').AsVariant <> FqShop.FieldByName('Pe_Birthday').AsVariant) or
            (FqMain.FieldByName('Pe_EnterJoin').AsVariant <> FqShop.FieldByName('Pe_EnterJoin').AsVariant) or
            (FqMain.FieldByName('Pe_Discharge').AsVariant <> FqShop.FieldByName('Pe_Discharge').AsVariant) or
            (FqMain.FieldByName('Pe_Depart').AsVariant <> FqShop.FieldByName('Pe_Depart').AsVariant) or
            (FqMain.FieldByName('Pe_Subdivision').AsVariant <> FqShop.FieldByName('Pe_Subdivision').AsVariant) or
            (FqMain.FieldByName('Pe_Staff').AsVariant <> FqShop.FieldByName('Pe_Staff').AsVariant) or
            (FqMain.FieldByName('Pe_Fluorography').AsVariant <> FqShop.FieldByName('Pe_Fluorography').AsVariant) or
            (FqMain.FieldByName('Pe_Place').AsVariant <> FqShop.FieldByName('Pe_Place').AsVariant) or
            (FqMain.FieldByName('Pe_OfficeStaff').AsVariant <> FqShop.FieldByName('Pe_OfficeStaff').AsVariant) or
            (IfVar(not FqMain.FieldByName('Pe_Place').IsNull and (FqMain.FieldByName('St_OfficeMemo').AsBoolean or
              (FqMain.FieldByName('St_PayTest').AsCurrency <> 0)), True, False) <> FqShop.FieldByName('Pe_ShopStaff').AsVariant) then
          begin
            Inc(I);
            S := S + ' update ' + cTable +
              ' set Pe_SurName = ' + StrToQuery(FqMain.FieldByName('Pe_SurName').AsString) +
              ', Pe_Name = ' + StrToQuery(FqMain.FieldByName('Pe_Name').AsString) +
              ', Pe_Patronymic = ' + StrToQuery(FqMain.FieldByName('Pe_Patronymic').AsString) +
              ', Pe_Birthday = ' + DateToQuery(FqMain.FieldByName('Pe_Birthday').AsVariant) +
              ', Pe_EnterJoin = ' + DateToQuery(FqMain.FieldByName('Pe_EnterJoin').AsVariant) +
              ', Pe_Discharge = ' + DateToQuery(FqMain.FieldByName('Pe_Discharge').AsVariant) +
              ', Pe_Depart = ' + IntToSVar(FqMain.FieldByName('Pe_Depart').AsInteger) +
              ', Pe_Subdivision = ' + IntToSVar(FqMain.FieldByName('Pe_Subdivision').AsInteger) +
              ', Pe_Staff = ' + IntToSVar(FqMain.FieldByName('Pe_Staff').AsInteger) +
              ', Pe_Fluorography = ' + DateToQuery(FqMain.FieldByName('Pe_Fluorography').AsVariant) +
              ', Pe_Place = ' + IntToSVar(FqMain.FieldByName('Pe_Place').AsInteger) +
              ', Pe_OfficeStaff = ' + IfVar(FqMain.FieldByName('Pe_OfficeStaff').AsBoolean, '1', '0') +
              ', Pe_ShopStaff = ' + IfVar(not FqMain.FieldByName('Pe_Place').IsNull and
                (FqMain.FieldByName('St_OfficeMemo').AsBoolean or
                (FqMain.FieldByName('St_PayTest').AsCurrency <> 0)), '1', '0') +
              ' where Pe_ID = ' + FqShop.FieldByName('Pe_ID').AsString;
          end;
          FqMain.Next; FqShop.Next;
        end else if FqMain.FieldByName('Pe_ID').AsInteger < FqShop.FieldByName('Pe_ID').AsInteger then
        begin
          FqMain.Next;
        end else if FqMain.FieldByName('Pe_ID').AsInteger > FqShop.FieldByName('Pe_ID').AsInteger then
        begin
          FqShop.Next;
        end;

        if I >= 100 then
        begin
          FconShop.Execute(S);
          nCount := nCount + I; S := ''; I := 0;
        end;
        if Terminated then Break;
      end;
    end;

    FqMain.Close;
    FqMain.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

    nCount := nCount + I;
    if S <> '' then FconShop.Execute(S);
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 7, FormStepResult(nCount))
    else SaveLog(12, 7, S);
  except
  end;
end;

function TSendDataExchange.SendPersonFilial: Boolean;
  var S : String; I, nCount : Integer;
  Q: TADOQuery;
begin
  Result:=True;
  if IsSkipAction('SendPersonFilial') then Exit;
  if not FSupermarcet then Exit else Result := False;
  nCount := 0;
  if not FconShop.Connected then Exit;

  DoShowSendDataExchange('Контроль сотрудников филиалов');
  try
    SaveLog(11, 20, '');
    I := 0; S := '';

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select PF_ID, PF_SurName, PF_Name, PF_Patronymic, isnull(PF_Staff,0) PF_Staff, isnull(PF_Place,0) PF_Place' +
      ' from PersonFilial' +
      ' order by PF_ID');

    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add(
      'select Pe_ID, Pe_SurName, Pe_Name, Pe_Patronymic, Pe_Staff, Pe_Place, Pl_ID from (' +
      'select Pe_ID, Pe_SurName, Pe_Name, Pe_Patronymic, Pe_Staff, ' +
      '(select Pl_ID from Place inner join Depart on ' +
      'Dep_ID = Pl_Depart inner join Subdivision on Su_Depart = Dep_Id where Su_ID = Pe_Subdivision) as Pe_Place ' +
      'from Person left outer join Staff on St_ID = Pe_Staff) s ' +
      'left outer join Place on isnull(Pe_Place,0) = Pl_ID and PL_Filial = ' + IntToStr(FPlace) +
      ' order by Pe_ID');

    FqMain.Open; FqShop.Open;
    Q := TADOQuery.Create(nil);
    try
      Q.Connection := FconMain;
      Q.CommandTimeout := 180;
      if FqMain.Active and FqShop.Active then
      begin
        DoShowSendDataExchange('', FqMain.RecordCount);
        while not FqMain.Eof or not FqShop.Eof do
        begin
          DoShowSendDataExchange('', 0, FqMain.RecNo);
          if not FqMain.Eof and ((FqMain.FieldByName('Pe_ID').AsInteger < FqShop.FieldByName('Pf_ID').AsInteger) or FqShop.Eof) then
          begin
            if not FqMain.FieldByName('Pl_ID').IsNull then
              FconShop.Execute('insert PersonFilial (PF_ID,PF_SurName,PF_Name,PF_Patronymic,PF_Staff,PF_Place) values (' +
                FqMain.FieldByName('Pe_ID').AsString + ', ' +
                StrToQuery(FqMain.FieldByName('Pe_SurName').AsString) + ', ' +
                StrToQuery(FqMain.FieldByName('Pe_Name').AsString) + ', ' +
                StrToQuery(FqMain.FieldByName('Pe_Patronymic').AsString) + ', ' +
                IntToSVar(FqMain.FieldByName('Pe_Staff').AsInteger) + ', ' +
                IntToSVar(FqMain.FieldByName('Pe_Place').AsInteger) + ')');
            FqMain.Next;

          end else if FqMain.FieldByName('Pe_ID').AsInteger = FqShop.FieldByName('PF_ID').AsInteger then
          begin
            if (FqMain.FieldByName('Pe_SurName').AsVariant <> FqShop.FieldByName('PF_SurName').AsVariant) or
              (FqMain.FieldByName('Pe_Name').AsVariant <> FqShop.FieldByName('PF_Name').AsVariant) or
              (FqMain.FieldByName('Pe_Patronymic').AsVariant <> FqShop.FieldByName('PF_Patronymic').AsVariant) or
              (FqMain.FieldByName('Pe_Staff').AsVariant <> FqShop.FieldByName('PF_Staff').AsVariant) or
              (FqMain.FieldByName('Pe_Place').AsVariant <> FqShop.FieldByName('PF_Place').AsVariant) then
            begin
              Inc(I);
              Q.Close;
              Q.SQL.Add('select * from Place where Pl_ID = ' + IntToStr(FqMain.FieldByName('Pe_Place').AsInteger) +
                        ' and Pl_Filial = ' + IntToStr(FPlace));
              Q.Open;
              if Q.RecordCount > 0 then
                S := S + ' update PersonFilial' +
                  ' set PF_SurName = ' + StrToQuery(FqMain.FieldByName('Pe_SurName').AsString) +
                  ', PF_Name = ' + StrToQuery(FqMain.FieldByName('Pe_Name').AsString) +
                  ', PF_Patronymic = ' + StrToQuery(FqMain.FieldByName('Pe_Patronymic').AsString) +
                  ', PF_Staff = ' + IntToSVar(FqMain.FieldByName('Pe_Staff').AsInteger) +
                  ', PF_Place = ' + IntToSVar(FqMain.FieldByName('Pe_Place').AsInteger) +
                  ' where PF_ID = ' + FqShop.FieldByName('PF_ID').AsString
              else
                S := S + ' update PersonFilial' +
                  ' set PF_SurName = ' + StrToQuery(FqMain.FieldByName('Pe_SurName').AsString) +
                  ', PF_Name = ' + StrToQuery(FqMain.FieldByName('Pe_Name').AsString) +
                  ', PF_Patronymic = ' + StrToQuery(FqMain.FieldByName('Pe_Patronymic').AsString) +
                  ', PF_Staff = null, PF_Place = null' +
                  ' where PF_ID = ' + FqShop.FieldByName('PF_ID').AsString;
            end;
            FqMain.Next; FqShop.Next;
          end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('Pe_ID').AsInteger > FqShop.FieldByName('PF_ID').AsInteger) then
          begin
            FqShop.Next;
          end;

          if I >= 100 then
          begin
            FconShop.Execute(S);
            nCount := nCount + I; S := ''; I := 0;
          end;
          if Terminated then Break;
        end;
      end;

      FqMain.Close;
      FqMain.SQL.Clear;
      FqShop.Close;
      FqShop.SQL.Clear;

      nCount := nCount + I;
      if S <> '' then FconShop.Execute(S);
      Result := True;
    finally
      Q.Close; Q.Free;
    end;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 20, FormStepResult(nCount))
    else SaveLog(12, 20, S);
  except
  end;
end;

function TSendDataExchange.SendPersonJob : Boolean;
  var nCount : Integer; S : String;
begin
  Result:=True;
  if IsSkipAction('SendPersonJob') then Exit;
  if FSubdivision = 0 then Exit else Result := False;
  nCount := 0;

  DoShowSendDataExchange('Трудоустройство сотрудников');
  try
    SaveLog(11, 12, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('declare @Place smallint '+
      'set @Place = ' + IntToStr(FPlace) +
      'select PJ_ID, PJ_Primary, PJ_Person, PJ_Date, PJ_CPRegister, PJ_CPStaff, PJ_Duration  ' +
      '  from PersonJob,  ' +
      '  (select PJ_Person as CPPerson, PJ_CPRegister as CPRegister, MAX(PJ_Date) as MaxDate ' +
      '  from PersonJob where PJ_Person in (select Pe_ID from Person inner join Depart on Pe_Depart = Dep_ID ' +
      '  inner join Place on Dep_ID = Pl_Depart and Pl_Type = 2 and Pl_ID = @Place) and PJ_IsTurn = ''Y'' '+
      '  group by PJ_Person, PJ_CPRegister) as T1  '+
      '  where PJ_Person = CPPerson and PJ_CPRegister = CPRegister and PJ_Date = MaxDate and PJ_CPStaff is not Null '+
      '  order by PJ_ID');
    FqMain.Open;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select PJ_ID, PJ_Primary, PJ_Person, PJ_Date, PJ_CPRegister, PJ_CPStaff, PJ_Duration  ' +
      ' from PersonJob order by PJ_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if not FqMain.Eof and ((FqMain.FieldByName('PJ_ID').AsInteger < FqShop.FieldByName('PJ_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(nCount);
          FconShop.Execute('insert PersonJob (PJ_ID, PJ_Primary, PJ_Person, PJ_Date, PJ_CPRegister, PJ_CPStaff, PJ_Duration) values (' +
            FqMain.FieldByName('PJ_ID').AsString + ', ' +
            CharToBit(FqMain.FieldByName('PJ_Primary').AsString[1]) + ', ' +
            FqMain.FieldByName('PJ_Person').AsString + ', ''' +
            FormatDateTime('YYYYMMDD', FqMain.FieldByName('PJ_Date').AsDateTime) + ''', ' +
            FqMain.FieldByName('PJ_CPRegister').AsString + ', ' +
            StrToQuery(FqMain.FieldByName('PJ_CPStaff').AsString, False) + ', ' +
            FqMain.FieldByName('PJ_Duration').AsString + ')');
          FqMain.Next;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('PJ_ID').AsInteger > FqShop.FieldByName('PJ_ID').AsInteger) then
        begin
          Inc(nCount);
          FconShop.Execute('delete PersonJob where PJ_ID = ' + FqShop.FieldByName('PJ_ID').AsString);
          FqShop.Next;
        end else if FqMain.FieldByName('PJ_ID').AsInteger = FqShop.FieldByName('PJ_ID').AsInteger then
        begin
          if (FqMain.FieldByName('PJ_Primary').AsBoolean <> FqShop.FieldByName('PJ_Primary').AsBoolean) or
            (FqMain.FieldByName('PJ_Person').AsInteger <> FqShop.FieldByName('PJ_Person').AsInteger) or
            (FqMain.FieldByName('PJ_Date').AsDateTime <> FqShop.FieldByName('PJ_Date').AsDateTime) or
            (FqMain.FieldByName('PJ_CPRegister').AsInteger <> FqShop.FieldByName('PJ_CPRegister').AsInteger) or
            (FqMain.FieldByName('PJ_CPStaff').AsString <> FqShop.FieldByName('PJ_CPStaff').AsString) or
            (FqMain.FieldByName('PJ_Duration').AsInteger <> FqShop.FieldByName('PJ_Duration').AsInteger) then
          begin
            Inc(nCount);
            FconShop.Execute('update PersonJob set ' +
              ' PJ_Primary = '  + CharToBit(FqMain.FieldByName('PJ_Primary').AsString[1]) +
              ', PJ_Person = '  + FqMain.FieldByName('PJ_Person').AsString +
              ', PJ_Date = ''' + FormatDateTime('YYYYMMDD', FqMain.FieldByName('PJ_Date').AsDateTime) + '''' +
              ', PJ_CPRegister = ' + FqMain.FieldByName('PJ_CPRegister').AsString +
              ', PJ_CPStaff = ' + StrToQuery(FqMain.FieldByName('PJ_CPStaff').AsString, False) +
              ', PJ_Duration = ' + FqMain.FieldByName('PJ_Duration').AsString +
              ' where PJ_ID = ' + FqShop.FieldByName('PJ_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 12, FormStepResult(nCount))
    else SaveLog(12, 12, S);
  except
  end;

end;

function TSendDataExchange.SendReglament : Boolean;
  var nCount : Integer; S : String;
begin
  Result := True;
  if IsSkipAction('SendReglament') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit
  else Result := False;
  nCount := 0;

  DoShowSendDataExchange('Обновление регламентов');
  try
    SaveLog(11, 2, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select RGT_ID, RGT_Number, RGT_Name, RGT_Status, RGT_FIleName, RGT_Active ' +
      'from Reglament, RegSub where RGT_ID = RS_Reglament and RGT_Active = 1 and RS_Subdivision in (' +
      IntToStr(FDepartment) + ', ' + IntToStr(FSubdivision) +
      ') group by RGT_ID, RGT_Number, RGT_Name, RGT_Status, RGT_FIleName, RGT_Active order by RGT_ID');
    FqMain.Open;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select RGT_ID, RGT_Number, RGT_Name, RGT_Status, RGT_FIleName, RGT_Active ' +
      'from Reglament order by RGT_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if not FqMain.Eof and ((FqMain.FieldByName('RGT_ID').AsInteger < FqShop.FieldByName('RGT_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(nCount);
          FconShop.Execute('insert Reglament (RGT_ID, RGT_Number, RGT_Name, RGT_Status, RGT_FIleName, RGT_Active) values (' +
            FqMain.FieldByName('RGT_ID').AsString + ', ' +
            IntToSVar(FqMain.FieldByName('RGT_Number').AsInteger) + ', ' +
            StrToQuery(FqMain.FieldByName('RGT_Name').AsString, True) + ', ' +
            StrToQuery(FqMain.FieldByName('RGT_Status').AsString, False) + ', ' +
            StrToQuery(FqMain.FieldByName('RGT_FIleName').AsString, True) + ', ' +
            CharToBit(FqMain.FieldByName('RGT_Active').AsString[1]) + ')');
          FqMain.Next;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('RGT_ID').AsInteger > FqShop.FieldByName('RGT_ID').AsInteger) then
        begin
          if FqShop.FieldByName('RGT_Active').AsBoolean then
          begin
            Inc(nCount);
            FconShop.Execute('update Reglament set RGT_Active = 0 where RGT_ID = ' + FqShop.FieldByName('RGT_ID').AsString);
          end;
          FqShop.Next;
        end else if FqMain.FieldByName('RGT_ID').AsInteger = FqShop.FieldByName('RGT_ID').AsInteger then
        begin
          if (FqMain.FieldByName('RGT_ID').AsInteger <> FqShop.FieldByName('RGT_ID').AsInteger) or
            (FqMain.FieldByName('RGT_Number').AsInteger <> FqShop.FieldByName('RGT_Number').AsInteger) or
            (FqMain.FieldByName('RGT_Name').AsString <> FqShop.FieldByName('RGT_Name').AsString) or
            (FqMain.FieldByName('RGT_Status').AsString <> FqShop.FieldByName('RGT_Status').AsString) or
            (FqMain.FieldByName('RGT_FIleName').AsString <> FqShop.FieldByName('RGT_FIleName').AsString) or
            (FqMain.FieldByName('RGT_Active').AsString <> FqShop.FieldByName('RGT_Active').AsString) then
          begin
            Inc(nCount);
            FconShop.Execute('update Reglament set RGT_Number = ' + IntToSVar(FqMain.FieldByName('RGT_Number').AsInteger) +
              ', RGT_Name = ' + StrToQuery(FqMain.FieldByName('RGT_Name').AsString, True) +
              ', RGT_Status = ' + StrToQuery(FqMain.FieldByName('RGT_Status').AsString, False) +
              ', RGT_FIleName = ' + StrToQuery(FqMain.FieldByName('RGT_FIleName').AsString, True) +
              ', RGT_Active = ' + CharToBit(FqMain.FieldByName('RGT_Active').AsString[1]) +
              ' where RGT_ID = ' + FqShop.FieldByName('RGT_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 2, FormStepResult(nCount))
    else SaveLog(12, 2, S);
  except
  end;

end;

function TSendDataExchange.SendRegStaff : Boolean;
  var S : string; nCount : Integer;
begin
  Result := True;
  if IsSkipAction('SendRegStaff') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit;
  nCount := 0;

  DoShowSendDataExchange('Обновление доступов к регламентам');
  S := '';
  FqShop.Close;
  FqShop.SQl.Clear;
  FqShop.SQl.Add('select RGT_ID from Reglament where RGT_Active = 1 order by RGT_ID');
  try
    FqShop.Open;
    while not FqShop.Eof do
    begin
      S := S + IfStr(S = '', '', ',') + FqShop.FieldByName('RGT_ID').AsString;
      FqShop.Next;
    end;
  except
    S := '';
  end;
  FqShop.Close;
  FqShop.SQl.Clear;
  Result := S = '';
  if S = '' then Exit;

  try
    SaveLog(11, 3, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select RSt_ID, RSt_Staff, RSt_Reglament from RegStaff where RSt_Reglament in (' +
      S + ') order by RSt_ID');
    FqMain.Open;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select RSt_ID, RSt_Staff, RSt_Reglament from RegStaff order by RSt_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if not FqMain.Eof and ((FqMain.FieldByName('RSt_ID').AsInteger < FqShop.FieldByName('RSt_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(nCount);
          FconShop.Execute('insert RegStaff (RSt_ID, RSt_Staff, RSt_Reglament) values (' +
            FqMain.FieldByName('RSt_ID').AsString + ', ' +
            FqMain.FieldByName('RSt_Staff').AsString + ', ' +
            FqMain.FieldByName('RSt_Reglament').AsString + ')');
          FqMain.Next;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('RSt_ID').AsInteger > FqShop.FieldByName('RSt_ID').AsInteger) then
        begin
          Inc(nCount);
          FconShop.Execute('delete RegStaff where RSt_ID = ' + FqShop.FieldByName('RSt_ID').AsString);
          FqShop.Next;
        end else if FqMain.FieldByName('RSt_ID').AsInteger = FqShop.FieldByName('RSt_ID').AsInteger then
        begin
          if (FqMain.FieldByName('RSt_ID').AsInteger <> FqShop.FieldByName('RSt_ID').AsInteger) or
            (FqMain.FieldByName('RSt_Staff').AsInteger <> FqShop.FieldByName('RSt_Staff').AsInteger) or
            (FqMain.FieldByName('RSt_Reglament').AsInteger <> FqShop.FieldByName('RSt_Reglament').AsInteger) then
          begin
            Inc(nCount);
            FconShop.Execute('update RegStaff set RSt_Staff = ' + FqMain.FieldByName('RSt_Staff').AsString +
              ', RSt_Reglament = ' + FqMain.FieldByName('RSt_Reglament').AsString +
              ' where RSt_ID = ' + FqShop.FieldByName('RSt_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 3, FormStepResult(nCount))
    else  SaveLog(12, 3, S);
  except
  end;

end;

function TSendDataExchange.SendReadMeReg : Boolean;
  var S : string; nCount : Integer;
begin
  Result := True;
  if IsSkipAction('SendReadMeReg') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit;
  nCount := 0;

  DoShowSendDataExchange('Ознакомление с регламентом');
  S := '';
  FqShop.Close;
  FqShop.SQl.Clear;
  FqShop.SQl.Add('select RGT_ID from Reglament where RGT_Active = 1 order by RGT_ID');
  try
    FqShop.Open;
    while not FqShop.Eof do
    begin
      S := S + IfStr(S = '', '', ',') + FqShop.FieldByName('RGT_ID').AsString;
      FqShop.Next;
    end;
  except
    S := '';
  end;
  FqShop.Close;
  FqShop.SQl.Clear;
  Result := S = '';
  if S = '' then Exit;

  try
    SaveLog(11, 5, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select RMRL_ID, RMRL_SDoc, RMRL_Reglament, RMR_ID, RMR_SdocType, PS_Staff as RMR_Staff, ' +
      'ISNULL(RMR_Person, PS_Person) as RMR_Person ' +
      'from ReadMeReglamentList left outer join ReadMeReglament on RMR_ID = RMRL_Sdoc ' +
      'left outer join PersonStaff on RMR_Sdoc = PS_ID where RMRL_Reglament in (' + S + ') and ' +
      'ISNULL(RMR_Person, PS_Person) in (select Pe_ID from Person where Pe_Subdivision = ' + IntToStr(FSubdivision) + ' ) ' +
      'order by RMRL_ID, RMR_ID');
    FqMain.Open;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select RMRL_ID, RMRL_SDoc, RMRL_Reglament, RMR_ID, RMR_SdocType, RMR_Staff, RMR_Person ' +
      'from ReadMeReglamentList left outer join ReadMeReglament on RMR_ID = RMRL_Sdoc ' +
      'order by RMRL_ID, RMR_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);

        if not FqMain.Eof and ((FqMain.FieldByName('RMRL_ID').AsInteger <= FqShop.FieldByName('RMRL_ID').AsInteger) or FqShop.Eof) then
        begin
          if not FqShop.FieldByName('RMR_ID').IsNull and
            (FqMain.FieldByName('RMRL_ID').AsInteger = FqShop.FieldByName('RMRL_ID').AsInteger) then
          begin
            if (FqMain.FieldByName('RMR_SdocType').AsInteger <> FqShop.FieldByName('RMR_SdocType').AsInteger) or
              (FqMain.FieldByName('RMR_Staff').AsInteger <> FqShop.FieldByName('RMR_Staff').AsInteger) or
              (FqMain.FieldByName('RMR_Person').AsInteger <> FqShop.FieldByName('RMR_Person').AsInteger) then
            begin
              Inc(nCount);
              FconShop.Execute('update ReadMeReglament set RMR_SdocType = ' + FqMain.FieldByName('RMR_SdocType').AsString +
                ', RMR_Staff = ' + IntToSVar(FqMain.FieldByName('RMR_Staff').AsInteger) +
                ', RMR_Person = ' + FqMain.FieldByName('RMR_Person').AsString +
                ' where RMR_ID = ' + FqMain.FieldByName('RMR_ID').AsString);
            end;
          end else FconShop.Execute('if not Exists(select RMR_ID from ReadMeReglament where RMR_ID = ' +
            FqMain.FieldByName('RMR_ID').AsString + ') ' +
            'insert ReadMeReglament (RMR_ID, RMR_Staff, RMR_Person) values (' +
            FqMain.FieldByName('RMR_ID').AsString + ', ' +
            IntToSVar(FqMain.FieldByName('RMR_Staff').AsInteger) + ', ' +
            FqMain.FieldByName('RMR_Person').AsString + ')');
        end;

        if not FqMain.Eof and ((FqMain.FieldByName('RMRL_ID').AsInteger < FqShop.FieldByName('RMRL_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(nCount);
          FconShop.Execute('insert ReadMeReglamentList (RMRL_ID, RMRL_SDoc, RMRL_Reglament) values (' +
            FqMain.FieldByName('RMRL_ID').AsString + ', ' +
            FqMain.FieldByName('RMRL_SDoc').AsString + ', ' +
            FqMain.FieldByName('RMRL_Reglament').AsString + ')');
          FqMain.Next;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('RMRL_ID').AsInteger > FqShop.FieldByName('RMRL_ID').AsInteger) then
        begin
          Inc(nCount);
          FconShop.Execute('delete ReadMeReglamentList where RMRL_ID = ' + FqShop.FieldByName('RMRL_ID').AsString);
          FqShop.Next;
        end else if FqMain.FieldByName('RMRL_ID').AsInteger = FqShop.FieldByName('RMRL_ID').AsInteger then
        begin
          if (FqMain.FieldByName('RMRL_SDoc').AsInteger <> FqShop.FieldByName('RMRL_SDoc').AsInteger) or
            (FqMain.FieldByName('RMRL_Reglament').AsInteger <> FqShop.FieldByName('RMRL_Reglament').AsInteger) then
          begin
            Inc(nCount);
            FconShop.Execute('update ReadMeReglamentList set RMRL_Reglament = ' + FqMain.FieldByName('RMRL_Reglament').AsString +
              ', RMRL_SDoc = ' + FqMain.FieldByName('RMRL_SDoc').AsString +
              ' where RMRL_ID = ' + FqShop.FieldByName('RMRL_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 5, FormStepResult(nCount))
    else  SaveLog(12, 5, S);
  except
  end;
end;

function TSendDataExchange.SendRegFile : Boolean;
  const COUNT_READ = 10;
  var S, cFileName, cWarehouse : string; nSize, nID, nCount : integer; nDate : TDateTime;
      I : Integer;
      sp : TADOStoredProc;
      MS : TMemoryStream;
begin
  Result := True;
  if IsSkipAction('SendRegFile') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit;
  nCount := 0;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов к регламентам');
  S := '';
  FqShop.Close;
  FqShop.SQl.Clear;
  FqShop.SQl.Add('select RGT_ID from Reglament where RGT_Active = 1 order by RGT_ID');
  try
    FqShop.Open;
    while not FqShop.Eof do
    begin
      S := S + IfStr(S = '', '', ',') + FqShop.FieldByName('RGT_ID').AsString;
      FqShop.Next;
    end;
  except
    S := '';
  end;
  FqShop.Close;
  FqShop.SQl.Clear;
  Result := S = '';
  if S = '' then Exit;

  try
    SaveLog(11, 4, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select RGT_ID, RGT_FIleName from Reglament where RGT_FIleName is not Null and RGT_ID in (' +
      S + ') order by RGT_FIleName');
    FqMain.Open;

    if FqMain.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);

        cFileName := FRegFilesPath + IfStr(FRegFilesPath[Length(FRegFilesPath)] = '\', '', '\') +
        FqMain.FieldByName('RGT_FIleName').AsString;
        if not GetFileExists(cFileName) then
        begin
          SaveLog(12, 4, 'Не найден файл: ' + cFileName);
          FqMain.Next;
          Continue;
        end;

        GetFileSizeDate(cFileName, nSize, nDate);

        if FqShop.Active then FqShop.Close;
        FqShop.SQl.Clear;
        FqShop.SQl.Add('select FS_ID, FS_Name, FS_Size, FS_Date from ' + cWarehouse + ' where FS_Type = 0 and FS_Name = :FileName');
        FqShop.Parameters.ParamByName('FileName').Value := FqMain.FieldByName('RGT_FIleName').AsString;
        FqShop.Open;
        if FqShop.RecordCount > 0 then
        begin
          if (FqShop.FieldByName('FS_Size').AsInteger <> nSize) or
            (FqShop.FieldByName('FS_Date').AsDateTime <> nDate) then
          begin
            nID := FqShop.FieldByName('FS_ID').AsInteger;
            FqShop.SQl.Clear;
            FqShop.SQl.Add('select FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = ' + IntToStr(nID));
            FqShop.Open;
            FqShop.Edit;
            FqShop.FieldByName('FS_Size').AsInteger := nSize;
            FqShop.FieldByName('FS_Date').AsDateTime := nDate;
            // критическая секция для одного потока
//            csReglament.Enter;
//            try
//              TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
//            finally
//              csReglament.Leave;
//            end;
            //////////////////////////////////
            {$IFDEF TRADE}
            MS := TMemoryStream.Create;
            try
              MS.Position := 0;
              sp := CreateProc('sp_GetFileFromSecure', False, 3);
              try
                sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
                sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
                try
                  sp.Open;
                  TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                except on E:Exception do
                  SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
                end;
              finally
                sp.Free;
              end;
            {$ENDIF}
              I := 1;
              while I <= COUNT_READ do
              begin
                try
                  {$IFDEF TRADE}
                    if MS.Size > 0 then
                    begin
                      MS.Position := 0;
                      TBlobField(FqShop.FieldByName('FS_File')).LoadFromStream(MS);
                    end;
                  {$ELSE}
                    TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
                  {$ENDIF}

                  I := COUNT_READ + 1;
                except
                  on E : Exception do
                  begin
                    if I <= COUNT_READ then
                      Inc(I)
                    else
                      raise Exception.Create(E.Message + ' ' + IntToStr(I));
                  end;
                end;
              end;
              FqShop.Post;
              Inc(nCount);
            {$IFDEF TRADE}
            finally
              MS.Free;
            end;
            {$ENDIF}
          end;

        end else
        begin
          FqShop.SQl.Clear;
          FqShop.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
          FqShop.Open;
          FqShop.Insert;
          FqShop.FieldByName('FS_Type').AsInteger := 0;
          FqShop.FieldByName('FS_Name').AsString := ExtractFileName(cFileName);
          FqShop.FieldByName('FS_Size').AsInteger := nSize;
          FqShop.FieldByName('FS_Date').AsDateTime := nDate;
          // критическая секция для одного потока
//          csReglament.Enter;
//          try
//            TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
//          finally
//            csReglament.Leave;
//          end;
          //////////////////////////////////
          {$IFDEF TRADE}
          MS := TMemoryStream.Create;
          try
            MS.Position := 0;
            sp := CreateProc('sp_GetFileFromSecure', False, 3);
            try
              sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
              sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
              try
                sp.Open;
                TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              except on E:Exception do
                SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
              end;
            finally
              sp.Free;
            end;
            {$ENDIF}
            I := 1;
            while I <= COUNT_READ do
            begin
              try
                {$IFDEF TRADE}
                  if MS.Size > 0 then
                  begin
                    MS.Position := 0;
                    TBlobField(FqShop.FieldByName('FS_File')).LoadFromStream(MS);
                  end;
                {$ELSE}
                  TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
                {$ENDIF}

                I := COUNT_READ + 1;
              except
                on E : Exception do
                begin
                  if I <= COUNT_READ then
                    Inc(I)
                  else
                    raise Exception.Create(E.Message + ' ' + IntToStr(I));
                end;
              end;
            end;
            FqShop.Post;
            Inc(nCount);
          {$IFDEF TRADE}
          finally
            MS.Free;
          end;
          {$ENDIF}
        end;

        FqMain.Next;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 4, FormStepResult(nCount))
    else SaveLog(12, 4, S);
  except
  end;
end;

function TSendDataExchange.SendBegunokTurn : Boolean;
  var S, S1 : string; nID, nCount : integer;
begin
  Result:=True;
  if IsSkipAction('SendBegunokTurn') then Exit;
  if FSupermarcet then
  begin
    nCount := 0;

    DoShowSendDataExchange('Отправка подписей по обходным');
    S := ''; S1 := '';

    FqShop.Close;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select BG_ID from Begunok '+
                   '	inner join Begunoklist bl1 on bl1.BL_SDoc = Bg_ID '+
                   '  inner join Begunoklist bl2 on bl2.BL_SDoc = Bg_ID '+
                   'where (bl1.BL_BegunokTurn = 3 and bl1.BL_IsTurn = 0)'+
                   'and ((bl2.BL_BegunokTurn = 1 and bl2.BL_IsTurn = 1) '+
                   'or (bl2.BL_BegunokTurn = 8 and bl2.BL_IsTurn = 1))  ');
    try
      FqShop.Open;
      while not FqShop.Eof do
      begin
        S := S + IfStr(S = '', '', ',') + FqShop.FieldByName('BG_ID').AsString;
        FqShop.Next;
      end;
    except
      S := '';
    end;
    FqShop.Close;
    FqShop.SQl.Clear;
//    Result := S = '';
    if S = '' then Exit;

    try
      SaveLog(11, 42, '');
      FqMain.Close; FqShop.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('select BG_ID,BG_SDoc,BG_WhoInv, BG_DateInv from BegunokSMShop where BG_Place ='+IntToStr(FPlace)+
                                                                   ' and BG_IsInv = 1 and BG_SDoc in ('+S+')');
      FqMain.Open;

      if FqMain.Active then
      begin
        DoShowSendDataExchange('', FqMain.RecordCount);
        while not FqMain.Eof do
        begin
          DoShowSendDataExchange('', 0, FqMain.RecNo);
          if FqShop.Active then FqShop.Close;
          FqShop.SQl.Clear;
          FqShop.SQl.Add('select * from Begunok where BG_ID = :ID');
          FqShop.Parameters.ParamByName('ID').Value := FqMain.FieldByName('BG_SDoc').AsString;
          FqShop.Open;
          if FqShop.RecordCount > 0 then
          begin
            nID := FqShop.FieldByName('BG_ID').AsInteger;
            FqShop.SQl.Clear;
            FqShop.SQl.Add('select BL_IsTurn, Bl_DateTurn, BL_WhoTurn, BL_OfficeTurn from BegunokList where BL_BegunokTurn = 3 and BL_IsTurn = 0 and Bl_SDoc=' + IntToStr(nID));
            FqShop.Open;
            FqShop.Edit;
            FqShop.FieldByName('BL_IsTurn').AsBoolean := True;
            FqShop.FieldByName('Bl_DateTurn').AsDateTime := FqMain.FieldByName('BG_DateInv').AsDateTime;
            FqShop.FieldByName('BL_WhoTurn').AsInteger := FqMain.FieldByName('BG_WhoInv').AsInteger;
            FqShop.FieldByName('BL_OfficeTurn').AsBoolean := True;
            FqShop.Post;
            Inc(nCount);
          end;

          FqMain.Next;
          if Terminated then Break;
        end;
      end;
    except
      on E: Exception do S1 := E.Message;
    end;
    FqMain.Close;
    FqMain.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

    try

      if S1 = '' then SaveLog(13, 42, FormStepResult(nCount))
      else SaveLog(12, 42, S1);

    except
    end;
  end;
end;

function TSendDataExchange.LoadReadMeReg : Boolean;
  var nRecordsAffected, nCount : Integer; S : String;
begin
  Result := True;
  if IsSkipAction('LoadReadMeReg') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit
  else Result := False;
  nCount := 0; S := '';

  DoShowSendDataExchange('Подтверждение ознакомления с регламентом');
  try
    SaveLog(11, 6, '');
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select RMRL_ID, RMRL_IsRead, RMRL_DateRead, RMR_ID, RMR_IsRead, RMR_DateRead ' +
      'from ReadMeReglamentList left outer join ReadMeReglament on RMR_ID = RMRL_Sdoc ' +
      'where RMRL_IsRead = 1 or RMR_IsRead = 1 order by RMRL_ID, RMR_ID');
    FqShop.Open;

    if FqShop.Active then
    begin
      DoShowSendDataExchange('', FqShop.RecordCount);
      while not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqShop.RecNo);

        if FqShop.FieldByName('RMRL_IsRead').AsBoolean then
        begin
          FconMain.Execute('if not Exists(select RMRL_ID from ReadMeReglamentList where ' +
            'RMRL_IsRead = 1 and RMRL_ID = ' + FqShop.FieldByName('RMRL_ID').AsString + ') ' +
            'update ReadMeReglamentList set RMRL_IsRead = 1, RMRL_DateRead = ''' +
            FormatDateTime('yyyy-mm-dd hh:mm:ss', FqShop.FieldByName('RMRL_DateRead').AsDateTime) +
            ''' where RMRL_ID = ' + FqShop.FieldByName('RMRL_ID').AsString, nRecordsAffected);
          if nRecordsAffected > 0 then Inc(nCount);
        end;

        if FqShop.FieldByName('RMR_IsRead').AsBoolean then
        begin
          FconMain.Execute('if not Exists(select RMR_ID from ReadMeReglament where ' +
            'RMR_IsRead = 1 and RMR_ID = ' + FqShop.FieldByName('RMR_ID').AsString + ') ' +
            'update ReadMeReglament set RMR_IsRead = 1, RMR_DateRead = ''' +
            FormatDateTime('yyyy-mm-dd hh:mm:ss', FqShop.FieldByName('RMR_DateRead').AsDateTime) +
            ''' where RMR_ID = ' + FqShop.FieldByName('RMR_ID').AsString, nRecordsAffected);
          if nRecordsAffected > 0 then Inc(nCount);
        end;

        FqShop.Next;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 6, FormStepResult(nCount))
    else SaveLog(12, 6, S);
  except
  end;
end;

function TSendDataExchange.LoadShopCollectionFile: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
//  if IsSkipAction('LoadShopCollectionFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов инкассаций');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select * from ShopCollectionFile' + #13#10 +
                 'Where SCF_ID in (' + #13#10 +
                 '  Select SCF_ID From ShopCollection' + #13#10 +
                 '    Inner Join ShopCollectionFile ON SCF_SDoc = SC_ID' + #13#10 +
                 '  Where SCF_Load = 0' + #13#10 +
                 '    AND SC_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 29, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ShopCollectionFile '+
                         'Inner join ' + cWarehouse +' ON SCF_Name = FS_Name COLLATE DATABASE_DEFAULT '+
                         'where SCF_Name = ''' + FqMain.FieldByName('SCF_Name').AsString+'''');
      FqShopFile.Open;
      cFileName := FShopCollectionFilePath + FqMain.FieldByName('SCF_Name').AsString;
      if FqShopFile.RecordCount = 1 then
      begin

        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FShopCollectionFilePath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('SCF_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FShopCollectionFilePath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('SCF_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}

        FqMain.Edit;
        FqMain.FieldByName('SCF_Load').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
    FqShop.SQl.Clear;
    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 13 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 14');
    FqShop.ExecSQL;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получения файлов инкассации...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 29, FormStepResult(nCount))
    else SaveLog(12, 29, S);
  except
  end;
end;

function TSendDataExchange.LoadApplContractFilesRetail: boolean;
  var cFileName, cWarehouse, S : string; nCount : integer; bReload : Boolean;
      Q : TADOQuery;
      MS : TMemoryStream;
  const cPrefix : String = 'ACFiles';
begin
  Result := True;
  if IsSkipAction('LoadApplContractFilesRetail') then Exit;

  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к розничным заявкам на договора');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select AC_ID, AC_IDOffice, ACF_ID, ACF_Contract, ACF_Type, ACF_FileExt, ACF_Note, ACF_ShopUnload, IsNull(PE_IDBase, ACF_WhoInput) as ACF_WhoInput, ACF_DateInput');
  FqShop.SQL.Add('from ApplContract');
  FqShop.SQL.Add('inner join ApplContractFiles on AC_ID = ACF_SDoc');
  FqShop.SQL.Add('inner join VPerson on Pe_ID = ACF_WhoInput');
  FqShop.SQL.Add('where AC_ShopUnload is not null');
  FqShop.SQL.Add('  and ACF_IDOffice is null');
  FqShop.SQL.Add('  and ACF_ShopUnload = 0');
  FqShop.SQL.Add('  and AC_Form in (12, 16, 27)');
  FqShop.SQL.Add('  and AC_IsTurnDir = ''Y''');


  nCount := 0; S := '';
  try
    SaveLog(11, 21, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Clear;

      FqMain.SQL.Add('select AC_ID, IDENT_CURRENT(''ApplContractFiles'') + 1 as ACF_ID');
      FqMain.SQL.Add('from ApplContract');
      FqMain.SQL.Add('where AC_IDShop = ' + FqShop.FieldByName('AC_ID').AsString);
      FqMain.SQL.Add('and AC_Place = ' + IntToStr(FPlace));
      FqMain.Open;

      if FqMain.RecordCount > 0 then
      begin

        FconMain.Execute('insert ApplContractFiles (ACF_SDoc, ACF_Place, ACF_IDShop, ACF_Contract, ' +
            'ACF_Type, ACF_FileExt, ACF_Note, ACF_WhoInput, ACF_DateInput) values (' +
            FqMain.FieldByName('AC_ID').AsString + ',' + IntToSVar(FPlace) + ', ' +
            FqShop.FieldByName('ACF_ID').AsString + ',' + IfStr(FqShop.FieldByName('ACF_Contract').AsBoolean, '1', '0') + ',' +
            FqShop.FieldByName('ACF_Type').AsString + ',' + StrToQuery(FqShop.FieldByName('ACF_FileExt').AsString) + ',' +
            StrToQuery(FqShop.FieldByName('ACF_Note').AsString) + ',' +
            FqShop.FieldByName('ACF_WhoInput').AsString + ',' +
            StrToQuery(FormatDateTime('YYYY-MM-DD HH:NN:SS', FqShop.FieldByName('ACF_DateInput').AsDateTime)) + ')');

        FqShopFile.Close;
        FqShopFile.SQL.Clear;
        FqShopFile.SQL.Add('select FS_File from ' + cWarehouse +
            ' where FS_Type = 20 and FS_Name = ''' + cPrefix + format('%.4d', [FPlace])
             +Format('%.10d', [FqShop.FieldByName('ACF_ID').AsInteger]) +
              FqShop.FieldByName('ACF_FileExt').AsString + '''');

        FqShopFile.Open;

        if FqShopFile.RecordCount = 1 then
        begin
          cFileName := FACFilesPath + '\' + cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
            FqShop.FieldByName('ACF_FileExt').AsString;

          {$IFDEF TRADE}
          Q := CreateQuery(False);
          MS := TMemoryStream.Create;
          try
            TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
            MS.Position := 0;

            // Если файл уже есть, то его сперва надо удалить!
            if GetFileExists(cFileName) then
              // удалить файл!
            begin
              Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
              Q.Parameters.ParamByName('Folder').Value :=
                StringReplace(FARTLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
              Q.Parameters.ParamByName('File').Value :=
                cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
                FqShop.FieldByName('ACF_FileExt').AsString;
              Q.Open;
            end;

            Q.Close;
            Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FARTLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value :=
              cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
              FqShop.FieldByName('ACF_FileExt').AsString;
            Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
            Q.Open;
          finally
            MS.Free;
            Q.Close; Q.Free;
          end;
          {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
          {$ENDIF}

          FconMain.Execute('update ApplContractFiles set ACF_FileLoad = 1 where ACF_ID = ' +
            FqMain.FieldByName('ACF_ID').AsString);
          Inc(nCount);
        end;
        FqShopFile.Close;

        FconShop.Execute('update ApplContractFiles ' +
                         'set ACF_ShopUnload = 1, ' +
                         'ACF_IDOffice = ' + FqMain.FieldByName('ACF_ID').AsString +
                         'where ACF_ID = ' + FqShop.FieldByName('ACF_ID').AsString);


      end;
      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к розничным заявкам на договора...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 21, FormStepResult(nCount))
    else SaveLog(12, 21, S);
  except
  end;
end;

//Загрузка файлов по приходным документам
function TSendDataExchange.LoadDocInFiles: boolean;
  var cFileName,
      cWarehouse,
      cFile,
      S, sPArams : string;
      nCount, i : integer;
      FSecureFileName:string;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadDocInFiles') then Exit;

  Result := False;

  if FWarehouse = '' then
  begin
    S:='Нет или не прописана в конфигурации база Warehouse';
    Exit;
  end;
//  else
//    Result := False;

  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов приходному документу');
  /////////////////////////////////
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Declare @Document bigint, '+#13#10+
                 '        @Place int'+#13#10+
                 'set @Document =:Document'+#13#10+
                 'set @Place =:Place'+#13#10+
                 'select DD_ID ' +
                 'from DocDemand ' +
                 'inner join DocIn on DI_ID = DD_DocIn ' +
                 'where DI_DocSource = @Document'
                 );
   /////////////////////////////////
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(
        ' select * , IsNull(PE_IDBase,dif_WhoInput) as WhoInput'+
        ' from DocIn '+
		    ' inner join DocInFile on DIF_Sdoc = DI_ID '+
        ' inner join Vperson on Pe_ID = dif_WhoInput '+
        ' inner join '+ cWarehouse +' on FS_NAme = DIF_Name where FS_Type=20 '+
        ' and DI_Date >= ''20210901'' and DIF_IsUnload = 0');
  FqShop.Open;
  /////////////////////////////////
  DoShowSendDataExchange('', 0, FqShop.RecordCount);
  nCount := 0; S := '';
  try
    SaveLog(11, 40, '');
   // FqMain.Open;
    DoShowSendDataExchange('', FqShop.RecNo);
    while not FqShop.Eof do
    begin
      if FqShop.RecordCount >= 1 then
      begin
          for I := 0 to FqShop.RecordCount -1 do
          begin
              cFile:='';
              FqMain.Close;
              FqMain.Parameters.ParamByName('Document').Value:=FqShop.FieldByName('DI_Document').AsString;
              FqMain.Parameters.ParamByName('Place').Value:=FPlace;
              FqMain.Open;
              if not FqMain.Eof then
              begin
                cFile:= IntToStr(FPlace)+'_'+FqShop.FieldByName('DIF_Name').AsString;
                cFileName := FShopDocInFile + cFile;
                FSecureFileName := 'File_'+FqMain.FieldByName('DD_ID').AsString+FqShop.FieldByName('DIF_Name').AsString;

                {$IFDEF TRADE}
                Q := CreateQuery(False);
                MS := TMemoryStream.Create;
                try
                  TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
                  MS.Position := 0;

                  // Если файл уже есть, то его сперва надо удалить!
                  if GetFileExists(cFileName) then
                    // удалить файл!
                  begin
                    Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
                    Q.Parameters.ParamByName('Folder').Value :=
                      StringReplace(FShopDocInFile,'\\dom.loc\dfs\secure\','',[]);
                    Q.Parameters.ParamByName('File').Value := cFile;
                    Q.Open;
                  end;

                  Q.Close;
                  Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
                  Q.Parameters.ParamByName('Folder').Value :=
                    StringReplace(FShopDocInFile,'\\dom.loc\dfs\secure\','',[]);
                  Q.Parameters.ParamByName('File').Value := cFile;
                  Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
                  Q.Open;
                finally
                  MS.Free;
                  Q.Close; Q.Free;
                end;
                {$ELSE}
                TBlobField(FqShop.FieldByName('FS_File')).SaveToFile(cFileName);
                {$ENDIF}
                 /////////////////////////////////
                cFile:= IntToStr(FPlace)+'_'+FqShop.FieldByName('DIF_Name').AsString ;
                S:='';
                  try
                   sPArams := FqMain.FieldByName('DD_ID').AsString+','+QuotedStr(FqShop.FieldByName('DIF_Note').AsString)+','+
                              QuotedStr(FSecureFileName)+','+ QuotedStr(cFile)+ ','+FqShop.FieldByName('WhoInput').AsString;
                //    FconMain.Execute('insert into DocDemandFiles(DF_SDoc,DF_Note,DF_FileName,DF_SecureFileName,DF_Type) '+
                  //                  ' Values('+FqMain.FieldByName('DD_ID').AsString+','+
                    //                           QuotedStr(FqShop.FieldByName('DIF_Note').AsString)+','+
                      //                         QuotedStr(FSecureFileName)+','+
                        //                       QuotedStr(cFile)+
                          //                     ',2)');

                    FconMain.Execute('Exec DocDemandFiles_InsertandUpdate '+sPArams);

                  except  on E: Exception do
                    begin
                      S := E.Message;
                      SaveLog(12, 40, S)
                    end;
                  end;
                  if S='' then
                  begin
                    FqShop.Edit;
                    FqShop.FieldByName('DIF_IsUnload').AsBoolean := true;
                    FqShop.Post;
                    Inc(nCount);
                  end;
              end;
             FqShop.Next;
          end;
          FqShop.Close;

       if Terminated then Break;
      end;
   end;
   Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов прикрепленных к приходным документам ...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then
      SaveLog(13, 40, FormStepResult(nCount))
    else
       SaveLog(12, 40, S);
  except
  end;
end;


function TSendDataExchange.LoadShopInvShetFile: boolean;
  var cFileName, cWarehouse,cFile, S : string; nCount, i : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadShopInvShetFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов инвентаризации');
  /////////////////////////////////
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Declare @Document bigint, @Place int '+
                           'set @Document =:Document '+
                           'set @Place ='+IntToStr(FPlace)+' '+
                           'select IS_ID ' +
                           'from InvSheet ' +
                           '  left outer join InvSheetLink on ISL_SDoc = IS_ID ' +
                           'where (isnull(ISL_Child,IS_DocSource) = @Document) ' +
                           '   and (IS_Place = @Place)');
   /////////////////////////////////
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(
        ' select * '+
        ' from InvSheet '+
		    ' inner join InvShitFiles on ISF_Sdoc = IS_ID '+
        ' inner join '+ cWarehouse +' on FS_NAme = ISF_Name where FS_Type=18 '+
        ' and ISF_Load = 0');
  FqShop.Open;
  /////////////////////////////////
  DoShowSendDataExchange('', 0, FqShop.RecordCount);
  nCount := 0; S := '';
  try
    SaveLog(11, 40, '');
   // FqMain.Open;
    DoShowSendDataExchange('', FqShop.RecNo);
    while not FqShop.Eof do
    begin
      if FqShop.RecordCount >= 1 then
      begin
          for I := 0 to FqShop.RecordCount -1 do
          begin
              cFile:='';
              FqMain.Close;
              FqMain.Parameters.ParamByName('Document').Value:=FqShop.FieldByName('IS_Document').AsString;
              FqMain.Open;
              if not FqMain.Eof then
              begin
                cFileName := FShopInvSheetFile + IntToStr(FPlace)+'-'+FqShop.FieldByName('ISF_Name').AsString;
                {$IFDEF TRADE}
                Q := CreateQuery(False);
                MS := TMemoryStream.Create;
                try
                  TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
                  MS.Position := 0;
                   // Если файл уже есть, то его сперва надо удалить!
                  if GetFileExists(cFileName) then
                    // удалить файл!
                  begin
                    Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
                    Q.Parameters.ParamByName('Folder').Value :=
                      StringReplace(FShopInvSheetFile,'\\dom.loc\dfs\secure\','',[]);
                    Q.Parameters.ParamByName('File').Value :=
                      IntToStr(FPlace)+'-'+FqShop.FieldByName('ISF_Name').AsString;
                    Q.Open;
                  end;

                  Q.Close;
                  Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
                  Q.Parameters.ParamByName('Folder').Value :=
                    StringReplace(FShopInvSheetFile,'\\dom.loc\dfs\secure\','',[]);
                  Q.Parameters.ParamByName('File').Value :=
                    IntToStr(FPlace)+'-'+FqShop.FieldByName('ISF_Name').AsString;
                  Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
                  Q.Open;
                finally
                  MS.Free;
                  Q.Close; Q.Free;
                end;
                {$ELSE}
                TBlobField(FqShop.FieldByName('FS_File')).SaveToFile(cFileName);
                {$ENDIF}
                 /////////////////////////////////
                cFile:= IntToStr(FPlace)+'-'+FqShop.FieldByName('ISF_Name').AsString;
                  try
                   FconMain.Execute('insert into InvSheetFiles(ISF_Sdoc,ISF_Note,ISF_File,ISF_Name) '+
                                    ' Values('+FqMain.FieldByName('IS_ID').AsString+','+
                                               QuotedStr(FqShop.FieldByName('ISF_Note').AsString)+','+
                                               QuotedStr(cFile)+','+
                                               QuotedStr(FqShop.FieldByName('ISF_Name').AsString)+')');

                  except  on E: Exception do S := E.Message;

                  end;
                  FqShop.Edit;
                  FqShop.FieldByName('ISF_Load').AsBoolean := true;
                  FqShop.Post;
                  Inc(nCount);
              end;
             FqShop.Next;
          end;
          FqShop.Close;

       if Terminated then Break;
      end;
   end;
   Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов инвентаризации...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 40, FormStepResult(nCount))
    else SaveLog(12, 40, S);
  except
  end;
end;

function TSendDataExchange.LoadShopInvShetPerson: boolean;
  var cFileName, cWarehouse,cFile, S : string; nCount, i : integer;
begin
  Result:=True;
  if IsSkipAction('LoadShopInvShetPerson') then Exit;
  Result := False;
  DoShowSendDataExchange('Получение прикрепленных инвентаризаторов');
  /////////////////////////////////
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Declare @Document bigint, @Place int '+
                           'set @Document =:Document '+
                           'set @Place ='+IntToStr(FPlace)+' '+
                           'select IS_ID ' +
                           'from InvSheet ' +
                           '  left outer join InvSheetLink on ISL_SDoc = IS_ID ' +
                           'where (isnull(ISL_Child,IS_DocSource) = @Document) ' +
                           '   and (IS_Place = @Place)');
  try
     /////////////////////////////////
    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add(
          ' select IS_Document,ISP_Person,ISP_Upload '+
          ' from '+
          ' InvSheet ' +
          ' inner join  InvSheetPerson  on IS_ID = ISP_Sdoc'+
          ' and ISP_Upload = 0');
    FqShop.Open;
    /////////////////////////////////
    DoShowSendDataExchange('', 0, FqShop.RecordCount);
    nCount := 0; S := '';
    SaveLog(11, 40, '');
   // FqMain.Open;
    DoShowSendDataExchange('', FqShop.RecNo);
    while not FqShop.Eof do
    begin
      if FqShop.RecordCount >= 1 then
      begin
          for I := 0 to FqShop.RecordCount -1 do
          begin
              cFile:='';
              FqMain.Close;
              FqMain.Parameters.ParamByName('Document').Value:=FqShop.FieldByName('IS_Document').AsString;
              FqMain.Open;
              if not FqMain.Eof then
              begin
                  try
                   FconMain.Execute('insert into InvSheetPerson(ISP_Sdoc,ISP_Person) '+
                                    ' Values('+FqMain.FieldByName('IS_ID').AsString+','+
                                               FqShop.FieldByName('ISP_Person').AsString+')');

                  except  on E: Exception do S := E.Message;

                  end;
                  FqShop.Edit;
                  FqShop.FieldByName('ISP_Upload').AsBoolean := true;
                  FqShop.Post;
                  Inc(nCount);
              end;
             FqShop.Next;
          end;
          FqShop.Close;

       if Terminated then Break;
      end;
   end;
   Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение данных по прикрепленным инвентаризаторам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 40, FormStepResult(nCount))
    else SaveLog(12, 40, S);
  except
  end;
end;

function TSendDataExchange.LoadShopCollectionListFile: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadShopCollectionListFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов содержимого инкассаций');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(' select * from ShopCollectionListFile '+
                 ' where SCLF_ID in ( '+
                 '   select SCLF_ID From ShopCollection '+
                 '     inner join ShopCollectionList on SC_ID = SCL_SDoc '+
                 '     inner join ShopCollectionListFile on SCLF_SDoc = SCL_ID '+
                 '   where SCLF_Load = 0 '+
                 '     and SC_Place = '+ IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 29, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ShopCollectionListFile '+
                         'Inner join ' + cWarehouse +' ON SCLF_Name = FS_Name '+
                         'where SCLF_Name = ''' + FqMain.FieldByName('SCLF_Name').AsString+'''');
      FqShopFile.Open;
      cFileName := FShopCollectionFilePath + FqMain.FieldByName('SCLF_Name').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;
           // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FShopCollectionFilePath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value :=
              FqMain.FieldByName('SCLF_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FShopCollectionFilePath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value :=
            FqMain.FieldByName('SCLF_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('SCLF_Load').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
    FqShop.SQl.Clear;
    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 13 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 14');
    FqShop.ExecSQL;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получения файлов содержимого инкассации...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 29, FormStepResult(nCount))
    else SaveLog(12, 29, S);
  except
  end;
end;

function TSendDataExchange.SendOfficeMemoFile : Boolean;
  const COUNT_READ = 10;

  var S, cWarehouse, cFileName : string;
      nSize, nCount : integer; nDate : TDateTime;
      I : Integer;
      sp : TADOStoredProc;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('SendOfficeMemoFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  nCount := 0;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов к служебкам');
  try
    SaveLog(11, 8, '');

    FqMain.Close; FqMain.SQL.Clear;
    FqMain.SQL.Add('declare @nSubdivision int ' +
      'set @nSubdivision = ' + IntToStr(FSubdivision) + ' ' +
      'select T2.OMF_ID, T2.OMF_SdocType, T2.OMF_SDoc, T2.OMF_File, T2.OMF_Note, T2.OMF_Date, ' +
      '  T2.OMF_Visible, T2.OMF_DateVisible, T4.OM_IdOffice, OM_ID, ' +
      '  T3.OMF_ID as OMF_IDShop, OMF_IdOffice, OMF_SDocOffice, ' +
      '  T3.OMF_File as OMF_FileShop, T3.OMF_Note as OMF_NoteShop, T3.OMF_Date as OMF_DateShop, ' +
      '  OMF_IdOffice, T3.OMF_SdocType as OMF_SdocTypeShop, ' +
      '  T3.OMF_Visible as OMF_VisibleShop, T3.OMF_DateVisible as OMF_DateVisibleShop, ' +
      '  FS_ID  from ' +
      '(select OMF_ID, OMF_SdocType, OMF_SDoc, OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible from ' +
      '  OfficeMemoFile ' +
      '  inner join OfficeMemo on OM_ID = OMF_Sdoc '+
      '  inner join OfficeMemoList on OM_ID = OML_Sdoc '+//and OML_PlaceShop = '+ IntToStr(FPlace)+
      ' where OML_DateTurn >= DateAdd(month, -3, Cast(GetDate() as Date)) '+
      ' and OMF_SdocType = 0 and OMF_SDoc in (select OM_Id from OPENROWSET(''SQLNCLI'', ''SERVER=' + FIPAdresShop +
      '  ;UID=sa;PWD=' + FPasswordShop + ';DATABASE=' + FBDNameShop + ''', ' +
      '  ''select distinct OM_Id from ' +
      '  (select OM_IdOffice as OM_Id from OfficeMemo ' +
      '    inner join OfficeMemoList on OM_Id = OML_Sdoc ' +
      '  where OML_IsTurn = ''''N'''' ' +
      '  union all ' +
      '  select OM_IdOffice from OfficeMemoList ' +
			'		 inner join OfficeMemo on OM_Id = OML_Sdoc ' +
      '  where OML_DateTurn >= DateAdd(month, -10, Cast(GetDate() as Date)) ' +
      '  union all ' +
      '  select OM_IdOffice from OfficeMemo ' +
      '    left outer join OfficeMemoList on OM_Id = OML_Sdoc ' +
      '  where OML_Id is null) as T1 ' +
			'	where OM_Id is not Null''))' +
      ' group by OMF_ID,OMF_SdocType,OMF_SDoc,OMF_File,OMF_Note,OMF_Date,OMF_Visible,OMF_DateVisible '+
      'union all ' +
      'select OMF_ID, OMF_SdocType, OMF_SDoc, OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible from ' +
      '  OfficeMemoFile ' +
      '  inner join OfficeMemoList on OML_ID = OMF_Sdoc '+//and OML_PlaceShop = '+ IntToStr(FPlace)+
      ' where OML_DateTurn >= DateAdd(month, -3, Cast(GetDate() as Date)) '+
      ' and OMF_SdocType = 1 and OMF_Sdoc = OML_ID and ' +
      '  OML_SDoc in (select OM_Id from OPENROWSET(''SQLNCLI'', ''SERVER=' + FIPAdresShop +
      '  ;UID=sa;PWD=' + FPasswordShop + ';DATABASE=' + FBDNameShop + ''', ' +
      '  ''select distinct OM_Id from ' +
      '  (select OM_IdOffice as OM_Id from OfficeMemo ' +
      '    inner join OfficeMemoList on OM_Id = OML_Sdoc ' +
      '  where OML_IsTurn = ''''N'''' ' +
      '  union all ' +
      '  select OM_IdOffice from OfficeMemoList ' +
			'		 inner join OfficeMemo on OM_Id = OML_Sdoc ' +
      '  where OML_DateTurn >= DateAdd(month, -10, Cast(GetDate() as Date)) ' +
      '  union all ' +
      '  select OM_IdOffice from OfficeMemo ' +
      '    left outer join OfficeMemoList on OM_Id = OML_Sdoc ' +
      '  where OML_Id is null) as T1 ' +
			'	where OM_Id is not Null''))) T2 ' +
      'left outer join OPENROWSET(''SQLNCLI'', ''SERVER=' + FIPAdresShop +
      '  ;UID=sa;PWD=' + FPasswordShop + ';DATABASE=' + FBDNameShop + ''', ' +
      '  ''select OMF_ID, OMF_SdocType, OMF_IdOffice, OMF_SDoc, OMF_SDocOffice, OMF_File, OMF_Note, OMF_Date, ' +
      '  OMF_Visible, OMF_DateVisible, FS_ID from OfficeMemoFile ' +
      '  left outer join Warehouse.dbo.FileStorage on FS_Type = 1 and OMF_File = FS_Name COLLATE DATABASE_DEFAULT'') as T3 on T3.OMF_IdOffice = T2.OMF_Id ' +
      'left outer join OPENROWSET(''SQLNCLI'', ''SERVER=' + FIPAdresShop +
      '  ;UID=sa;PWD=' + FPasswordShop + ';DATABASE=' + FBDNameShop + ''', ' +
      '  ''select 0 as OM_SdocType, OM_ID, OM_IdOffice from OfficeMemo  where OM_IdOffice is not Null ' +
      '  union all ' +
      '  select 1, OML_ID, OML_IdOffice from OfficeMemoList where OML_IdOffice is not Null'') as T4 ' +
      '  on T4.OM_SdocType = T2.OMF_SdocType and T4.OM_IdOffice = T2.OMF_SDoc ' +
      'where OM_IdOffice is not Null and (FS_ID is Null or (T2.OMF_File <> T3.OMF_File COLLATE Cyrillic_General_CI_AS and ' +
      '  T2.OMF_Note <> T3.OMF_Note COLLATE Cyrillic_General_CI_AS and ' +
      '  T2.OMF_Date <> T3.OMF_Date and T2.OMF_Visible <> T3.OMF_Visible and ' +
      '  T2.OMF_DateVisible <> T3.OMF_DateVisible)) ' +
      'order by OMF_ID');
    FqMain.Open;

    if not FqMain.Active then Exit;

    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      if not FqMain.FieldByName('OMF_IDShop').IsNull then
      begin
        if (FqMain.FieldByName('OMF_IdOffice').AsInteger <> FqMain.FieldByName('OMF_ID').AsInteger) or
          (FqMain.FieldByName('OMF_SDocOffice').AsInteger <> FqMain.FieldByName('OMF_SDoc').AsInteger) or
          (FqMain.FieldByName('OMF_SdocTypeShop').AsInteger <> FqMain.FieldByName('OMF_SdocType').AsInteger) or
          (FqMain.FieldByName('OMF_FileShop').AsVariant <> FqMain.FieldByName('OMF_File').AsVariant) or
          (FqMain.FieldByName('OMF_NoteShop').AsVariant <> FqMain.FieldByName('OMF_Note').AsVariant) or
          (FqMain.FieldByName('OMF_DateShop').AsVariant <> FqMain.FieldByName('OMF_Date').AsVariant) or
          (FqMain.FieldByName('OMF_VisibleShop').AsVariant <> FqMain.FieldByName('OMF_Visible').AsVariant) or
          (FqMain.FieldByName('OMF_DateVisibleShop').AsVariant <> FqMain.FieldByName('OMF_DateVisible').AsVariant) then
        begin
          if FqShopFile.Active then FqShopFile.Close;
          FqShopFile.SQl.Clear;
          FqShopFile.SQl.Add('select OMF_ID, OMF_IdOffice, OMF_Sdoc, OMF_SdocOffice, OMF_SdocType, ' +
            'OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible ' +
            'from OfficeMemoFile where OMF_ID = ' + FqMain.FieldByName('OMF_IDShop').AsString);
          FqShopFile.Open;
          FqShopFile.Edit;
          FqShopFile.FieldByName('OMF_IdOffice').AsInteger := FqMain.FieldByName('OMF_ID').AsInteger;
          FqShopFile.FieldByName('OMF_SDoc').AsInteger := FqMain.FieldByName('OM_ID').AsInteger;
          FqShopFile.FieldByName('OMF_SdocOffice').AsInteger := FqMain.FieldByName('OMF_SDoc').AsInteger;
          FqShopFile.FieldByName('OMF_SdocType').AsInteger := FqMain.FieldByName('OMF_SdocType').AsInteger;
          FqShopFile.FieldByName('OMF_File').AsVariant := FqMain.FieldByName('OMF_File').AsVariant;
          FqShopFile.FieldByName('OMF_Note').AsVariant := FqMain.FieldByName('OMF_Note').AsVariant;
          FqShopFile.FieldByName('OMF_Date').AsVariant := FqMain.FieldByName('OMF_Date').AsVariant;
          FqShopFile.FieldByName('OMF_Visible').AsVariant := FqMain.FieldByName('OMF_Visible').AsVariant;
          FqShopFile.FieldByName('OMF_DateVisible').AsVariant := FqMain.FieldByName('OMF_DateVisible').AsVariant;
          FqShopFile.Post;
        end;
      end else
      begin

        if FqShopFile.Active then FqShopFile.Close;
        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('select OMF_ID, OMF_IdOffice, OMF_Sdoc, OMF_SdocOffice, OMF_SdocType, ' +
          'OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible ' +
          'from OfficeMemoFile where OMF_ID = 0');
        FqShopFile.Open;
        FqShopFile.Insert;
        FqShopFile.FieldByName('OMF_IdOffice').AsInteger := FqMain.FieldByName('OMF_ID').AsInteger;
        FqShopFile.FieldByName('OMF_SDoc').AsInteger := FqMain.FieldByName('OM_ID').AsInteger;
        FqShopFile.FieldByName('OMF_SdocOffice').AsInteger := FqMain.FieldByName('OMF_SDoc').AsInteger;
        FqShopFile.FieldByName('OMF_SdocType').AsInteger := FqMain.FieldByName('OMF_SdocType').AsInteger;
        FqShopFile.FieldByName('OMF_File').AsVariant := FqMain.FieldByName('OMF_File').AsVariant;
        FqShopFile.FieldByName('OMF_Note').AsVariant := FqMain.FieldByName('OMF_Note').AsVariant;
        FqShopFile.FieldByName('OMF_Date').AsVariant := FqMain.FieldByName('OMF_Date').AsVariant;
        FqShopFile.FieldByName('OMF_Visible').AsVariant := FqMain.FieldByName('OMF_Visible').AsVariant;
        FqShopFile.FieldByName('OMF_DateVisible').AsVariant := FqMain.FieldByName('OMF_DateVisible').AsVariant;
        FqShopFile.Post;
      end;

      if FqMain.FieldByName('FS_ID').IsNull then
      begin
        cFileName := FOMFilesPath + IfStr(FOMFilesPath[Length(FOMFilesPath)] = '\', '', '\') +
          FqMain.FieldByName('OMF_File').AsString;
        if GetFileExists(cFileName) then
        begin
          GetFileSizeDate(cFileName, nSize, nDate);

          FqShopFile.SQl.Clear;
          FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
          FqShopFile.Open;
          FqShopFile.Insert;
          FqShopFile.FieldByName('FS_Type').AsInteger := 1;
          FqShopFile.FieldByName('FS_Name').AsString := FqMain.FieldByName('OMF_File').AsVariant;
          FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
          FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
          // критическая секция для одного потока
//          csOfficeMemo.Enter;
//          try
//            TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
//          finally
//            csOfficeMemo.Leave;
//          end;
          //////////////////////////////////
          {$IFDEF TRADE}
          MS := TMemoryStream.Create;
          try
            MS.Position := 0;
            begin
              sp := CreateProc('sp_GetFileFromSecure', False, 3);
              try
                sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
                sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
                try
                  sp.Open;
                  TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                except on E:Exception do
                  SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
                end;
              finally
                sp.Free;
              end;
            end;
          {$ENDIF}
            I := 1;
            while I <= COUNT_READ do
            begin
              try
                {$IFDEF TRADE}
                  if MS.Size > 0 then
                  begin
                    MS.Position := 0;
                    TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
                  end;
                {$ELSE}
                  TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
                {$ENDIF}

                I := COUNT_READ + 1;
              except
                on E : Exception do
                begin
                  if I <= COUNT_READ then
                    Inc(I)
                  else
                    raise Exception.Create(E.Message + ' ' + IntToStr(I));
                end;
              end;
            end;
            FqShopFile.Post;
            Inc(nCount);
          {$IFDEF TRADE}
          finally
            MS.Free;
          end;
          {$ENDIF}

        end else SaveLog(12, 8, 'Не найден файл: ' + cFileName);
      end;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 8, FormStepResult(nCount))
    else SaveLog(12, 8, S);
  except
  end;
end;


function TSendDataExchange.LoadARTLP: Boolean;
  var cFileName, cWarehouse, S : string; nCount : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadARTLP') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к актам приема товара');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select *' + #13#10 +
                 'from' + #13#10 +
                   'ActReceptTovarListPhoto' + #13#10 +
                 'Where ARTLP_ID in (' + #13#10 +
                   'Select ARTLP_ID' + #13#10 +
                   'From' + #13#10 +
                     'ActReceptTovar' + #13#10 +
                     'Inner Join DocMove ON ART_SDoc = DM_ID' + #13#10 +
                     'Inner Join ActReceptTovarList ON ART_ID = ARTL_SDoc' + #13#10 +
                     'Inner Join ActReceptTovarListPhoto ON ARTL_ID = ARTLP_SDoc' + #13#10 +
                   'Where' + #13#10 +
                     'ARTLP_LoadFile = 0 AND' + #13#10 +
                     'DM_SPlace = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 13, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File,ARTLP_Smallimage from ActReceptTovarListPhoto '+
                         'Inner join ' + cWarehouse +' ON ARTLP_FileName = FS_Name COLLATE DATABASE_DEFAULT '+
                         'where ARTLP_FileName = ''' + FqMain.FieldByName('ARTLP_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FARTLPFilesPath + FqMain.FieldByName('ARTLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FARTLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARTLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FARTLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARTLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}

        FqMain.Edit;
        FqMain.FieldByName('ARTLP_SmallImage').Value := FqShopFile.FieldByName('ARTLP_SmallImage').Value;
        FqMain.FieldByName('ARTLP_LoadFile').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
    FqShop.SQl.Clear;
    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 2 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 90');
    FqShop.ExecSQL;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов актов приёма товара...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 13, FormStepResult(nCount))
    else SaveLog(12, 13, S);
  except
  end;
end;


function TSendDataExchange.LoadActReceptSupplPhoto : Boolean;
  var cFileName, cWarehouse, S : string; nCount : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadActReceptSupplPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к актам несоответствия товара (поставщик)');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('select * from ActReceptSupplierListPhoto' + #13#10 +
                 'where ARSLP_ID in (select ARSLP_ID from ActReceptSupplier' + #13#10 +
                 '    join ActReceptSupplierList on ARS_ID = ARSL_SDoc' + #13#10 +
                 '    join ActReceptSupplierListPhoto on ARSL_ID = ARSLP_SDoc' + #13#10 +
                 '  where ARSLP_LoadFile = 0 and ARS_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 41, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File,ARSLP_Smallimage from ActReceptSupplierListPhoto '+
                         'join ' + cWarehouse +' on ARSLP_FileName = FS_Name '+
                         ' where FS_Type = 2 AND ARSLP_FileName = ''' + FqMain.FieldByName('ARSLP_FileName').AsString+'''');

      FqShopFile.Open;
      cFileName := FARSLPFilesPath + '\' + FqMain.FieldByName('ARSLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FARSLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FARSLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('ARSLP_SmallImage').Value := FqShopFile.FieldByName('ARSLP_SmallImage').Value;
        FqMain.FieldByName('ARSLP_LoadFile').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
//    FqShop.SQl.Clear;
//    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 2 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 90');
//    FqShop.ExecSQL;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов актов несоответствия (поставщик)...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 41, FormStepResult(nCount))
    else SaveLog(12, 41, S);
  except
  end;
end;

function TSendDataExchange.LoadActReceptSupplEDIPhoto : Boolean;
  var cFileName, cWarehouse, S : string; nCount : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadActReceptSupplEDIPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к актам несоответствия товара EDI (поставщик)');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('select * from ActReceptSupplierEDIListPhoto' + #13#10 +
                 'where ARSLP_ID in (select ARSLP_ID from ActReceptSupplierEDI' + #13#10 +
                 '    join ActReceptSupplierEDIList on ARS_ID = ARSL_SDoc' + #13#10 +
                 '    join ActReceptSupplierEDIListPhoto on ARSL_ID = ARSLP_SDoc' + #13#10 +
                 '  where ARSLP_LoadFile = 0 and ARS_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 41, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File,ARSLP_Smallimage from ActReceptSupplierListPhoto '+
                         'join ' + cWarehouse +' on ARSLP_FileName = FS_Name '+
                         ' where FS_Type = 2 AND ARSLP_FileName = ''' + FqMain.FieldByName('ARSLP_FileName').AsString+'''');

      FqShopFile.Open;
      cFileName := FARSLPFilesPath + '\' + FqMain.FieldByName('ARSLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FARSLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FARSLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('ARSLP_SmallImage').Value := FqShopFile.FieldByName('ARSLP_SmallImage').Value;
        FqMain.FieldByName('ARSLP_LoadFile').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
//    FqShop.SQl.Clear;
//    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 2 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 90');
//    FqShop.ExecSQL;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов актов несоответствия EDI (поставщик)...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 41, FormStepResult(nCount))
    else SaveLog(12, 41, S);
  except
  end;
end;


function TSendDataExchange.LoadStoreCheckListPhotoPhoto : Boolean;
  var cFileName, cWarehouse, S : string; nCount : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadStoreCheckListPhotoPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к сторчекам');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('select * from StoreCheckListPhoto' + #13#10 +
                 'where SCLP_ID in (select SCLP_ID from StoreCheck' + #13#10 +
                 '    join StoreCheckList on SC_ID = SCL_SDoc' + #13#10 +
                 '    join StoreCheckListPhoto on SCL_ID = SCLP_SDoc' + #13#10 +
                 '  where SCLP_LoadFile = 0 and SC_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 41, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File,SCLP_SmallImage from StoreCheckListPhoto '+
                         'join ' + cWarehouse +' on SCLP_FileName = FS_Name '+
                         ' where SCLP_FileName = ''' + FqMain.FieldByName('SCLP_FileName').AsString+'''');

      FqShopFile.Open;
      cFileName := FSCLPFilesPath + '\' + FqMain.FieldByName('SCLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FSCLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('SCLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FSCLPFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('SCLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('SCLP_SmallImage').Value := FqShopFile.FieldByName('SCLP_SmallImage').Value;
        FqMain.FieldByName('SCLP_LoadFile').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    // удаление старых файлов
//    FqShop.SQl.Clear;
//    FqShop.SQL.Add('delete ' + cWarehouse + ' where FS_Type = 2 and DATEDIFF(DD,FS_DateInput,GETDATE()) > 90');
//    FqShop.ExecSQL;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов сторчеков...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 41, FormStepResult(nCount))
    else SaveLog(12, 41, S);
  except
  end;
end;

function TSendDataExchange.UnloadARTLP: Boolean;
var cFileName, cWarehouse, S : string; nCount, nSize : integer;
    nDate : TDateTime;
    sp : TADOStoredProc;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('UnloadARTLP') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов к актам приема товара');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(
    ' select * '+
    ' from ActReceptViewListPhoto '+
    ' where ARVLP_Loaded = 0');
  nCount := 0; S := '';
  try
    SaveLog(11, 32, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Text :=
        ' select * from ActReceptTovarListPhoto '+
        ' where ARTLP_ID = '+ IntToStr(FqShop.FieldByName('ARVLP_ID').AsInteger);
      FqMain.Open;
      if FqMain.RecordCount = 1 then
      begin
        FqShop.Edit;
        FqShop.FieldByName('ARVLP_SmallImage').Value := FqMain.FieldByName('ARTLP_SmallImage').Value;
        FqShop.FieldByName('ARVLP_Loaded').AsBoolean := true;
        FqShop.Post;

        cFileName := FARTLPFilesPath + FqShop.FieldByName('ARVLP_FileName').AsString;
        FqShopFile.Close;
        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
        FqShopFile.Open;
        FqShopFile.Insert;
        FqShopFile.FieldByName('FS_Type').AsInteger := 15;
        FqShopFile.FieldByName('FS_Name').AsString := FqShop.FieldByName('ARVLP_FileName').AsString;
        GetFileSizeDate(cFileName, nSize, nDate);
        FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
        FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
        {$IFDEF TRADE}
        MS := TMemoryStream.Create;
        try
          MS.Position := 0;
          sp := CreateProc('sp_GetFileFromSecure', False, 3);
          try
            sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
            sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
            try
              sp.Open;
              TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              MS.Position := 0;
              TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
            except on E:Exception do
              SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
            end;
          finally
            sp.Free;
          end;
        {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
        {$ENDIF}

          FqShopFile.Post;
          FqShopFile.Close;
        {$IFDEF TRADE}
        finally
          MS.Free;
        end;
        {$ENDIF}
        Inc(nCount);
      end;
      FqMain.Close;
      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов актов несоответствия на рассмотрение...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 32, FormStepResult(nCount))
    else SaveLog(12, 32, S);
  except
  end;
end;


function TSendDataExchange.UnloadARTPlaceLlistPhoto: Boolean;
var cFileName, cWarehouse, S : string; nCount, nSize : integer;
    nDate : TDateTime;
    sp : TADOStoredProc;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('UnloadARTPlaceLlistPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов к актам приема товара');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(
    ' select * '+
    ' from ActReceptPlacePhoto '+
    ' where ARPLP_Loaded = 0');
  nCount := 0; S := '';
  try
    SaveLog(11, 56, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Text :=
        ' select * from ActReceptTovarListPhoto '+
        ' where ARTLP_ID = '+ IntToStr(FqShop.FieldByName('ARPLP_ID').AsInteger);
      FqMain.Open;
      if FqMain.RecordCount = 1 then
      begin
        FqShop.Edit;
        FqShop.FieldByName('ARPLP_SmallImage').Value := FqMain.FieldByName('ARTLP_SmallImage').Value;
        FqShop.FieldByName('ARPLP_Loaded').AsBoolean := true;
        FqShop.Post;

        cFileName := FARTLPFilesPath + FqShop.FieldByName('ARPLP_FileName').AsString;
        FqShopFile.Close;
        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
        FqShopFile.Open;
        FqShopFile.Insert;
        FqShopFile.FieldByName('FS_Type').AsInteger := 56;
        FqShopFile.FieldByName('FS_Name').AsString := FqShop.FieldByName('ARPLP_FileName').AsString;
        GetFileSizeDate(cFileName, nSize, nDate);
        FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
        FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
        {$IFDEF TRADE}
        MS := TMemoryStream.Create;
        try
          MS.Position := 0;
          sp := CreateProc('sp_GetFileFromSecure', False, 3);
          try
            sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
            sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
            try
              sp.Open;
              TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              MS.Position := 0;
              TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
            except on E:Exception do
              SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
            end;
          finally
            sp.Free;
          end;

          FqShopFile.Post;
          FqShopFile.Close;
        finally
          if not FService and Assigned(MS) then
            MS.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
        FqShopFile.Post;
        FqShopFile.Close;
        {$ENDIF}

        Inc(nCount);
      end;
      FqMain.Close;
      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов актов несоответствия на рассмотрение...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 56, FormStepResult(nCount))
    else SaveLog(12, 56, S);
  except
  end;
end;


function TSendDataExchange.LoadBookComplaint: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadBookComplaint') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к книге жалоб');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select *' + #13#10 +
                 'from' + #13#10 +
                   'BookComplaintFile' + #13#10 +
                 'Where BCF_ID in (' + #13#10 +
                   'Select BCF_ID' + #13#10 +
                   'From' + #13#10 +
                     'BookComplaint' + #13#10 +
                     'Inner Join BookComplaintFile ON BCF_SDoc = BC_ID' + #13#10 +
                   'Where' + #13#10 +
                     'BCF_FileLoad = 0 AND' + #13#10 +
                     'BC_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 17, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from BookComplaintFile '+
                         'Inner join ' + cWarehouse +' ON BCF_File = FS_Name '+
                         'where BCF_File = ''' + FqMain.FieldByName('BCF_File').AsString+'''');
      FqShopFile.Open;
      cFileName := FBookComplaintFilesPath + FqMain.FieldByName('BCF_File').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FBookComplaintFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('BCF_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FBookComplaintFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('BCF_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('BCF_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к книге жало...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 17, FormStepResult(nCount))
    else SaveLog(12, 17, S);
  except
  end;
end;


function TSendDataExchange.LoadDocRROFiles: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadDocRROFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов отчетов РРО');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(
    ' select * ' +
    ' from DocRROFiles '+
    ' where DRF_SDoc in (select DR_ID from DocRRO where DR_Place = '+ IntToStr(FPlace) + ') ' +
    '   and DRF_Loaded = 0 ');

  nCount := 0; S := '';
  try
    SaveLog(11, 33, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add(
        ' select FS_File '+
        ' from DocRROFiles '+
        '   inner join ' + cWarehouse +' ON DRF_SecureFileName = FS_Name '+
        ' where DRF_ID = ' + IntToStr(FqMain.FieldByName('DRF_ShopID').AsInteger));
      FqShopFile.Open;
      cFileName := FDocRROFiles + FqMain.FieldByName('DRF_SecureFileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FDocRROFiles,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('DRF_SecureFileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FDocRROFiles,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('DRF_SecureFileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('DRF_Loaded').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к выкладкам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 33, FormStepResult(nCount))
    else SaveLog(12, 33, S);
  except
  end;
end;

function TSendDataExchange.LoadCounterfoilReturnFile: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadCounterfoilReturnFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов заявок на возврат ДС');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(
    ' select * ' +
    ' from CounterfoilReturnFile '+
  //  ' inner join CounterfoilReturnSign on CoRS_SDoc= CoRF_SDoc and CoRS_Level=2 and CoRS_IsSign=''N'' '+
    ' inner join CounterfoilReturn on CoR_Place = '+ IntToStr(FPlace) +
    ' and CoR_ID=CoRF_SDoc '+
    ' where CoRF_Loaded = 0 and CoR_UploadShop is not null '+
    '   and CoRF_CheckAccess in (0,60024) ');

  nCount := 0; S := '';
  try
    SaveLog(11, 34, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add(
        ' select FS_File '+
        ' from ' + cWarehouse +' where FS_Type=17 '+
        '  and FS_Name = ' + QuotedStr(FqMain.FieldByName('CoRF_Name').AsString));
      FqShopFile.Open;
      cFileName := FCounterfoilReturnFile + FqMain.FieldByName('CoRF_Name').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FCounterfoilReturnFile,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('CoRF_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FCounterfoilReturnFile,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('CoRF_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('CoRF_Loaded').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к заявкам на возврат ДС...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 34, FormStepResult(nCount))
    else SaveLog(12, 34, S);
  except
  end;
end;

function TSendDataExchange.LoadlayOutPhoto: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadlayOutPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов Выкладки');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select *' + #13#10 +
                 'from' + #13#10 +
                   'LayOutPhoto' + #13#10 +
                 'Where LOP_ID in (' + #13#10 +
                   'Select LOP_ID' + #13#10 +
                   'From' + #13#10 +
                     'LayOut' + #13#10 +
                     'Inner Join LayOutPhoto ON LOP_SDoc = LO_ID' + #13#10 +
                   'Where' + #13#10 +
                     'LOP_FileLoad <> 1 AND' + #13#10 +
                     'LO_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 17, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from LayOutPhoto '+
                         'Inner join ' + cWarehouse +' ON LOP_FileName = FS_Name '+
                         'where LOP_FileName = ''' + FqMain.FieldByName('Lop_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FLayOutPhotoPath + FqMain.FieldByName('LOP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FLayOutPhotoPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('LOP_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FLayOutPhotoPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('LOP_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('LOP_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к выкладкам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 17, FormStepResult(nCount))
    else SaveLog(12, 17, S);
  except
  end;
end;

function TSendDataExchange.LoadMAPMFiles: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadMAPMFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов-отчетов о поклейке\раздаче печатной продукции');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select * from MAPMFiles' + #13#10 +
                 'Where MAPMF_ID in (' + #13#10 +
                 '  Select MAPMF_ID From MarketingActionsPrintedMatter' + #13#10 +
                 '    Inner Join MAPMFiles ON MAPMF_SDoc = MAPM_ID' + #13#10 +
                 '  Where MAPMF_FileLoad = 0' + #13#10 +
                 '    AND MAPM_Place = '+IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 18, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from MAPMFiles '+
                         'Inner join ' + cWarehouse +' ON MAPMF_File = FS_Name '+
                         'where MAPMF_File = ''' + FqMain.FieldByName('MAPMF_File').AsString+'''');
      FqShopFile.Open;
      cFileName := FMAPMFilesPath + FqMain.FieldByName('MAPMF_File').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FMAPMFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MAPMF_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FMAPMFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MAPMF_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('MAPMF_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов-отчетов о поклейке\раздаче печатной продукции...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 18, FormStepResult(nCount))
    else SaveLog(12, 18, S);
  except
  end;
end;

function TSendDataExchange.SendPersonMoving : Boolean;
  var nCount : Integer; S : String;
begin
  Result:=True;
  if IsSkipAction('SendPersonMoving') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit
  else Result := False;
  nCount := 0;

  DoShowSendDataExchange('Перемещение сотрудников');
  try
    SaveLog(11, 19, '');
    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('declare @nSubdivision int, @dDate smalldatetime ' +
      'set @nSubdivision = ' + IntToStr(FSubdivision) +
      'set @dDate = ''2015/10/01'' ' +
      'select PS_ID, PS_Person, PS_Date, PS_DateEnd, PS_Staff from PersonStaff where ' +
      '  PS_IsTurn = ''Y'' and PS_Subdivision = @nSubdivision and ' +
      '  (PS_DateEnd >= @dDate or PS_DateEnd is Null) ' +
      'order by PS_ID');
    FqMain.Open;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select PM_ID, PM_Person, PM_Date, PM_DateEnd, PM_Staff ' +
      'from PersonMoving order by PM_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if not FqMain.Eof and ((FqMain.FieldByName('PS_ID').AsInteger < FqShop.FieldByName('PM_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(nCount);
          FconShop.Execute('insert PersonMoving (PM_ID, PM_Person, PM_Date, PM_DateEnd, PM_Staff) values (' +
            FqMain.FieldByName('PS_ID').AsString + ', ' +
            FqMain.FieldByName('PS_Person').AsString + ', ' +
            StrToQuery(FormatDateTime('YYYYMMDD', FqMain.FieldByName('PS_Date').AsDateTime)) + ', ' +
            IfStr(FqMain.FieldByName('PS_DateEnd').IsNull, 'Null',
              StrToQuery(FormatDateTime('YYYYMMDD', FqMain.FieldByName('PS_DateEnd').AsDateTime))) + ', ' +
            IntToSVar(FqMain.FieldByName('PS_Staff').AsInteger) + ')');
          FqMain.Next;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('PS_ID').AsInteger > FqShop.FieldByName('PM_ID').AsInteger) then
        begin
          FconShop.Execute('delete PersonMoving where PM_ID = ' + FqShop.FieldByName('PM_ID').AsString);
          FqShop.Next;
        end else if FqMain.FieldByName('PS_ID').AsInteger = FqShop.FieldByName('PM_ID').AsInteger then
        begin
          if (FqMain.FieldByName('PS_Person').AsInteger <> FqShop.FieldByName('PM_Person').AsInteger) or
            (FqMain.FieldByName('PS_Date').AsVariant <> FqShop.FieldByName('PM_Date').AsVariant) or
            (FqMain.FieldByName('PS_DateEnd').AsVariant <> FqShop.FieldByName('PM_DateEnd').AsVariant) or
            (FqMain.FieldByName('PS_Staff').AsInteger <> FqShop.FieldByName('PM_Staff').AsInteger) then
          begin
            Inc(nCount);
            FconShop.Execute('update PersonMoving set PM_Person = ' + IntToSVar(FqMain.FieldByName('PS_Person').AsInteger) +
              ', PM_Date = ' + StrToQuery(FormatDateTime('YYYYMMDD', FqMain.FieldByName('PS_Date').AsDateTime)) +
              ', PM_DateEnd = ' + IfStr(FqMain.FieldByName('PS_DateEnd').IsNull, 'Null',
                StrToQuery(FormatDateTime('YYYYMMDD', FqMain.FieldByName('PS_DateEnd').AsDateTime))) +
              ', PM_Staff = ' + IntToSVar(FqMain.FieldByName('PS_Staff').AsInteger) +
              ' where PM_ID = ' + FqShop.FieldByName('PM_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 19, FormStepResult(nCount))
    else SaveLog(12, 19, S);
  except
  end;

end;

function TSendDataExchange.LoadOfficeMemoFile : Boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    sParams, cFileName2 : string;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadOfficeMemoFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к служебкам');
  FqMain.Close; FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('declare @nSDoc int, @nSdocType int, @nID int ' +
    'set @nID = :ID ' +
    'set @nSDoc = :Sdoc ' +
    'set @nSdocType = :SdocType ' +
    'select OM_ID, OM_IdShop, OM_SdocType, ' +
    'OMF_ID, OMF_IdShop, OMF_Sdoc, OMF_SdocType, OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible from ' +
    '(select OM_ID, OM_IdShop, 0 as OM_SdocType from OfficeMemo where OM_PlaceShop = ' + IntToStr(FPlace) +
      ' and @nSdocType = 0 and OM_IdShop = @nSDoc ' +
    'union all ' +
    'select OML_ID, OML_IdShop, 1 from OfficeMemoList where OML_PlaceShop = ' + IntToStr(FPlace) +
      ' and @nSdocType = 1 and OML_IdShop = @nSDoc) as T1 ' +
    'left outer join OfficeMemoFile on OMF_Sdoc = OM_ID and OMF_SdocType = OM_SdocType and OMF_IdShop = @nID');

  FqShop.Close;
  FqShop.SQl.Clear;
  FqShop.SQl.Add('select OMF_ID, OMF_Sdoc, OMF_SdocType, OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible, ' +
    'FS_ID, FS_Size, FS_Date from OfficeMemoFile, ' + cWarehouse +
    ' where OMF_IdOffice is Null and OMF_File = FS_Name COLLATE DATABASE_DEFAULT and FS_Type = 1');
  nCount := 0; S := '';
  try
    SaveLog(11, 9, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);
      if FqMain.Active then FqMain.Close;
      FqMain.Parameters.ParamByName('ID').Value := FqShop.FieldByName('OMF_ID').AsVariant;
      FqMain.Parameters.ParamByName('Sdoc').Value := FqShop.FieldByName('OMF_Sdoc').AsVariant;
      FqMain.Parameters.ParamByName('SdocType').Value := FqShop.FieldByName('OMF_SdocType').AsVariant;
      FqMain.Open;
      FqMain.First;
      if FqMain.Eof then
      begin
        FqShop.Next;
        Continue;
      end;

      if FqMain.FieldByName('OMF_ID').IsNull then
      begin
       { FconMain.Execute('insert OfficeMemoFile (OMF_PlaceShop, OMF_IdShop, OMF_Sdoc, OMF_SdocType, OMF_File, OMF_Note, OMF_Visible, OMF_Loading) values (' +
          IntToStr(FPlace) + ', ' +
          FqShop.FieldByName('OMF_ID').AsString + ', ' + FqMain.FieldByName('OM_ID').AsString + ', ' +
          FqShop.FieldByName('OMF_SdocType').AsString + ', ' + '''Загрузка файла'', ' +
          StrToQuery(FqShop.FieldByName('OMF_Note').AsString) + ', ' +
          IfStr(FqShop.FieldByName('OMF_Visible').AsBoolean, '1', '0') + ', 1)');  }
        sParams := IntToStr(FPlace)+', '
                  +FqShop.FieldByName('OMF_ID').AsString+', '
                  +FqMain.FieldByName('OM_ID').AsString+', '
                  +FqShop.FieldByName('OMF_SdocType').AsString + ', '
                  +StrToQuery(FqShop.FieldByName('OMF_Note').AsString) + ', '
                  +IfStr(FqShop.FieldByName('OMF_Visible').AsBoolean, '1', '0') + ', '
                  +QuotedSTR(FIPAdresShop)+ ', '
                  +QuotedSTR(FPasswordShop)+ ', '
                  +QuotedSTR(FBDNameShop);
        FconMain.Execute('Exec OfficeMemoFile_InsertAndUpdate '+ sParams);
        FqMain.Close;
        FqMain.Open;
        FqMain.First;
        if FqMain.FieldByName('OMF_ID').IsNull then
        begin
          FqShop.Next;
          Continue;
        end;
      end;

      cFileName := 'OfficeMemo' + Format('%.10d', [FqMain.FieldByName('OMF_ID').AsInteger]) +
        ExtractFileExt(FqShop.FieldByName('OMF_File').AsString);

      if (FqMain.FieldByName('OMF_File').AsString <> cFileName) or
        (FqMain.FieldByName('OMF_Note').AsString <> FqShop.FieldByName('OMF_Note').AsString) or
        (FqMain.FieldByName('OMF_Visible').AsBoolean <> FqShop.FieldByName('OMF_Visible').AsBoolean) or
        (FqMain.FieldByName('OMF_DateVisible').AsDateTime < FqShop.FieldByName('OMF_DateVisible').AsDateTime) then
      begin
        FconMain.Execute('update OfficeMemoFile set OMF_Loading = 1, ' +
          'OMF_File = ''' +  cFileName + ''', ' +
          'OMF_Note = ' +  StrToQuery(FqShop.FieldByName('OMF_Note').AsString) + ', ' +
          'OMF_Visible = ' +  IfStr(FqShop.FieldByName('OMF_Visible').AsBoolean, '1', '0') +
          IfStr(FqMain.FieldByName('OMF_DateVisible').AsDateTime < FqShop.FieldByName('OMF_DateVisible').AsDateTime,
            ', OMF_DateVisible = ''' +  FormatDateTime('YYYYMMDD HH:NN:SS', FqShop.FieldByName('OMF_DateVisible').AsDateTime) + '''', '') +
          ' where OMF_ID = ' + FqMain.FieldByName('OMF_ID').AsString);
        FqMain.Close;
        FqMain.Open;
        FqMain.First;
      end;

      cFileName2 := cFileName;
      cFileName := FOMFilesPath + '\' + cFileName;
      if FileExists(cFileName) and (GetFileSize(cFileName) = FqShop.FieldByName('FS_Size').AsInteger) then
      begin
        FqShop.Next;
        Continue;
      end;

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);
      FqShopFile.Open;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FOMFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := cFileName2;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FOMFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := cFileName2;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов служебок...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 9, FormStepResult(nCount))
    else SaveLog(12, 9, S);
  except
  end;
end;

function TSendDataExchange.SendPersonPass : Boolean;
  var S : String; I, nCount : Integer;
begin
  Result:=True;
  if IsSkipAction('SendPersonPass') then Exit;
  if not FSalon then Exit else Result := False;
  nCount := 0;

  if not FconShop.Connected then Exit;
  DoShowSendDataExchange('Посещаемость сотрудников');
  try
    SaveLog(11, 10, '');
    I := 0; S := '';

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select (select MAX(PPa_DateTime) from PersonPass where PPa_DateUpdate is Null) as PPa_DateTime, ' +
      '(select MAX(PPa_DateUpdate) from PersonPass) as PPa_DateUpdate');
    FqShop.Open;

    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select * from PersonPass where PPa_DateTime > = ''20131001'' and '  +
      IfStr(not FqShop.FieldByName('PPa_DateTime').IsNull and not FqShop.FieldByName('PPa_DateUpdate').IsNull, '(', '') +
      IfStr(FqShop.FieldByName('PPa_DateTime').IsNull, '', 'PPa_DateTime >= ''' + FormatDateTime('YYYYMMDD', FqShop.FieldByName('PPa_DateTime').AsDateTime) + '''') +
      IfStr(not FqShop.FieldByName('PPa_DateTime').IsNull and not FqShop.FieldByName('PPa_DateUpdate').IsNull, ' or ', '') +
      IfStr(FqShop.FieldByName('PPa_DateUpdate').IsNull, '', 'PPa_DateUpdate >= ''' + FormatDateTime('YYYYMMDD', FqShop.FieldByName('PPa_DateUpdate').AsDateTime) + '''') +
      IfStr(not FqShop.FieldByName('PPa_DateTime').IsNull and not FqShop.FieldByName('PPa_DateUpdate').IsNull, ')', '') +
      IfStr(not FqShop.FieldByName('PPa_DateTime').IsNull or not FqShop.FieldByName('PPa_DateUpdate').IsNull, ' and ', '') +
      'PPa_Person in (select Pe_ID from Person ' +
      'where (select Pl_ID from Place inner join Depart on ' +
      'Dep_ID = Pl_Depart inner join Subdivision on Su_Depart = Dep_Id where Su_ID = Pe_Subdivision) = ' + IntToStr(FPlace) + ')');

    FqShop.Close; FqMain.Open;
    if FqMain.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof  do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        S := S + #13#10 + 'if not Exists(select * from PersonPass where PPa_Person = ' +
          FqMain.FieldByName('PPa_Person').AsString  + ' and Cast(PPa_DateTime as DATE) = ''' +
          FormatDateTime('YYYYMMDD', FqMain.FieldByName('PPa_DateTime').AsDateTime) + ''' and PPa_Type = ' +
          BoolToBit(FqMain.FieldByName('PPa_Type').AsBoolean) + ') ' +
          'insert PersonPass (PPa_Person, PPa_DateTime, PPa_Type, PPa_Note, PPa_DateUpdate, PPa_WhoUpdate, PPa_OverTime, PPa_OverTimeAdd) ' +
          'values (' + FqMain.FieldByName('PPa_Person').AsString + ',''' +
          FormatDateTime('YYYYMMDD HH:NN:SS', FqMain.FieldByName('PPa_DateTime').AsDateTime) + ''',' +
          BoolToBit(FqMain.FieldByName('PPa_Type').AsBoolean) + ',' +
          IfStr(FqMain.FieldByName('PPa_Note').IsNull, 'Null', '''' + FqMain.FieldByName('PPa_Note').AsString + '''') + ',' +
          IfStr(FqMain.FieldByName('PPa_DateUpdate').IsNull, 'Null', '''' +FormatDateTime('YYYYMMDD HH:NN:SS', FqMain.FieldByName('PPa_DateUpdate').AsDateTime) + '''') + ',' +
          IfStr(FqMain.FieldByName('PPa_WhoUpdate').IsNull, 'Null', FqMain.FieldByName('PPa_WhoUpdate').AsString) + ',' +
          BoolToBit(FqMain.FieldByName('PPa_OverTime').AsBoolean) + ',' +
          FqMain.FieldByName('PPa_OverTimeAdd').AsString + ') ' +
          'else update PersonPass set ' +
          'PPa_DateTime = ''' + FormatDateTime('YYYYMMDD HH:NN:SS', FqMain.FieldByName('PPa_DateTime').AsDateTime) + '''' +
          ', PPa_Note = ' + IfStr(FqMain.FieldByName('PPa_Note').IsNull, 'Null', '''' + FqMain.FieldByName('PPa_Note').AsString + '''') +
          ', PPa_DateUpdate = ' + IfStr(FqMain.FieldByName('PPa_DateUpdate').IsNull, 'Null', '''' +FormatDateTime('YYYYMMDD HH:NN:SS', FqMain.FieldByName('PPa_DateUpdate').AsDateTime) + '''') +
          ', PPa_WhoUpdate = ' + IfStr(FqMain.FieldByName('PPa_WhoUpdate').IsNull, 'Null', FqMain.FieldByName('PPa_WhoUpdate').AsString) +
          ', PPa_OverTime = ' +BoolToBit(FqMain.FieldByName('PPa_OverTime').AsBoolean) +
          ', PPa_OverTimeAdd = ' + FqMain.FieldByName('PPa_OverTimeAdd').AsString + ' where PPa_Person = ' +
          FqMain.FieldByName('PPa_Person').AsString  + ' and Cast(PPa_DateTime as DATE) = ''' +
          FormatDateTime('YYYYMMDD', FqMain.FieldByName('PPa_DateTime').AsDateTime) + ''' and PPa_Type = ' +
          BoolToBit(FqMain.FieldByName('PPa_Type').AsBoolean);
        Inc(I);
        FqMain.Next;

        if I >= 20 then
        begin
          FconShop.Execute(S);
          nCount := nCount + I; S := ''; I := 0;
        end;
        if Terminated then Break;
      end;
    end;

    FqMain.Close;
    FqMain.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

    nCount := nCount + I;
    if S <> '' then FconShop.Execute(S);
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 10, FormStepResult(nCount))
    else SaveLog(12, 10, S);
  except
  end;
end;

function TSendDataExchange.SendPlanogram: boolean;
  var S : string; nCount, I : integer;
      dDate: TDateTime;
begin
  Result := False; nCount := 0;
  if not FconShop.Connected then Exit;

  DoShowSendDataExchange('Отправка планограммы');
  try
    SaveLog(11, 26, '');
    I := 0; S := '';

    // дата последней выгрузки
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select top 1 LDE_Date from LogDataExchange ' +
                   'where LDE_SendName= 26 and LDE_Type=11 and LDE_Place=' + IntToStr(FPlace) +
                   'order by LDE_Date desc');
    FqMain.Open;
    if FQMain.RecordCount = 1 then
      dDate := FqMain.FieldByName('LDE_Date').AsDateTime
    else
      dDate := 0;

    // 1 часть
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select PGL_ID, PGL_TypeLegend, PGL_TypeEq, PGL_EqID, PGL_Number, PGL_Theme ' +
      ' from PlanogramList inner join Planogram on PG_ID = PGL_SDoc ' +
      ' where PG_Place = ' + IntToStr(FPlace) +
      ifvar(dDate=0,'',' and PG_DateUpdate >= :Date') +
      ' order by PGL_ID');
    if dDate > 0 then
       FqMain.Parameters.ParamByName('Date').Value := dDate;
    FqMain.Open;

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select PGL_ID, PGL_TypeLegend, PGL_TypeEq, PGL_EqID, PGL_Number, PGL_Theme ' +
      ' from PlanogramList order by PGL_ID');
    FqShop.Open;

    if FqMain.Active and FqShop.Active then
    begin
//      FconShop.Execute('Delete PlanogramList');
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof or not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if not FqMain.Eof and ((FqMain.FieldByName('PGL_ID').AsInteger < FqShop.FieldByName('PGL_ID').AsInteger) or FqShop.Eof) then
        begin
          Inc(I);
          if S = '' then
            S := 'Insert Into PlanogramList(PGL_ID, PGL_TypeLegend, PGL_TypeEq, PGL_EqID, PGL_Number, PGL_Theme)' +
                 'Select ' +
                 FqMain.FieldByName('PGL_ID').AsString + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_TypeLegend').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_TypeEq').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_EqID').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_Number').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_Theme').AsInteger)
          else
            S := S + ' union select ' +
                 FqMain.FieldByName('PGL_ID').AsString + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_TypeLegend').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_TypeEq').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_EqID').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_Number').AsInteger) + ',' +
                 IntToSVar(FqMain.FieldByName('PGL_Theme').AsInteger);
          FqMain.Next;

          if I >= 100 then
          begin
            FconShop.Execute(S);
            nCount := nCount + I; S := ''; I := 0;
          end;
        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('PGL_ID').AsInteger > FqShop.FieldByName('PGL_ID').AsInteger) then
        begin
          FconShop.Execute('delete ProgramList where PGL_ID = ' + FqShop.FieldByName('PGL_ID').AsString);
          FqShop.Next;
        end else if FqMain.FieldByName('PGL_ID').AsInteger = FqShop.FieldByName('PGL_ID').AsInteger then
        begin
          if (FqMain.FieldByName('PGL_TypeLegend').AsInteger <> FqShop.FieldByName('PGL_TypeLegend').AsInteger) or
            (FqMain.FieldByName('PGL_TypeEq').AsInteger <> FqShop.FieldByName('PGL_TypeEq').AsInteger) or
            (FqMain.FieldByName('PGL_EqID').AsInteger <> FqShop.FieldByName('PGL_EqID').AsInteger) or
            (FqMain.FieldByName('PGL_Number').AsInteger <> FqShop.FieldByName('PGL_Number').AsInteger) or
            (FqMain.FieldByName('PGL_Theme').AsInteger <> FqShop.FieldByName('PGL_Theme').AsInteger) then
          begin
            Inc(nCount);
            FconShop.Execute('update PersonMoving set PGL_TypeLegend = ' + IntToSVar(FqMain.FieldByName('PGL_TypeLegend').AsInteger) +
              ', PGL_TypeEq = ' + IntToSVar(FqMain.FieldByName('PGL_TypeEq').AsInteger) +
              ', PGL_EqID = ' + IntToSVar(FqMain.FieldByName('PGL_EqID').AsInteger) +
              ', PGL_Number = ' + IntToSVar(FqMain.FieldByName('PGL_Number').AsInteger) +
              ', PGL_Theme = ' + IntToSVar(FqMain.FieldByName('PGL_Theme').AsInteger) +
              ' where PGL_ID = ' + FqShop.FieldByName('PGL_ID').AsString);
          end;
          FqMain.Next; FqShop.Next;
        end;
        if Terminated then Break;
      end;
    end;

    nCount := nCount + I;
    if S <> '' then FconShop.Execute(S);

    // 2 часть
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select PG_Data from Planogram where PG_Place = ' + IntToStr(FPlace));
    FqMain.Open;
    if FqMain.Active and (FqMain.RecordCount = 1) then
    begin
      FqShop.SQl.Clear;
      FqShop.SQl.Add('select PG_Data from Planogram');
      FqShop.Open;
      if FqShop.RecordCount = 0 then
      begin
        FqShop.Insert;
        FqShop.FieldByName('PG_Data').AsBytes := FqMain.FieldByName('PG_Data').AsBytes;
        FqShop.Post;
      end
      else begin
        FqShop.Edit;
        FqShop.FieldByName('PG_Data').AsBytes := FqMain.FieldByName('PG_Data').AsBytes;
        FqShop.Post;
      end;
    end;

    // 3 часть
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select PP_ID,PP_NoPhoto from PlanogramPics');
    FqMain.Open;
    if FqMain.Active then
    begin
      while not FqMain.Eof do
      begin
        FqShop.SQl.Clear;
        FqShop.SQl.Add('select PP_ID,PP_NoPhoto from PlanogramPics where PP_ID='+FqMain.FieldByName('PP_ID').AsString);
        FqShop.Open;
        if FqShop.RecordCount = 0 then
        begin
          FqShop.Insert;
          FqShop.FieldByName('PP_ID').AsInteger := FqMain.FieldByName('PP_ID').AsInteger;
          FqShop.FieldByName('PP_NoPhoto').AsBytes := FqMain.FieldByName('PP_NoPhoto').AsBytes;
          FqShop.Post;
        end
        else begin
          FqShop.Edit;
          FqShop.FieldByName('PP_NoPhoto').AsBytes := FqMain.FieldByName('PP_NoPhoto').AsBytes;
          FqShop.Post;
        end;
        FqMain.Next;
      end;
    end;

    // 4 часть, планограмма плитки
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select TA_ID,TA_Sdoc,TA_Data,TA_Name,TA_Width,TA_Order ' +
      ' from TileArea' +
      ' inner join TileShelf on TS_ID = TA_SDoc' +
      ' inner join TileRack on TR_ID = TS_SDoc' +
      ' inner join PlanogramList on TR_ID = PGL_EqID and PGL_TypeEq=7' +
      ' inner join Planogram on PG_ID = PGL_SDoc ' +
      ' where PG_Place = ' + IntToStr(FPlace) +
      ifvar(dDate=0,'',' and TA_DateUpdateData >= :Date') +
      ' order by TA_ID');
    if dDate > 0 then
       FqMain.Parameters.ParamByName('Date').Value := dDate;
    FqMain.Open;
    while not FqMain.Eof do
    begin
      FqShop.SQl.Clear;
      FqShop.SQl.Add('select TA_ID,TA_Sdoc,TA_Data,TA_Name,TA_Width,TA_Order from TileArea where TA_ID='+FqMain.FieldByName('TA_ID').AsString);
      FqShop.Open;
      if FqShop.RecordCount = 0 then
      begin
        FqShop.Insert;
        FqShop.FieldByName('TA_ID').AsInteger := FqMain.FieldByName('TA_ID').AsInteger;
//        FqShop.FieldByName('TA_SDoc').AsInteger := FqMain.FieldByName('TA_SDoc').AsInteger;
        FqShop.FieldByName('TA_Name').AsString := FqMain.FieldByName('TA_Name').AsString;
        FqShop.FieldByName('TA_Width').AsInteger := FqMain.FieldByName('TA_Width').AsInteger;
        FqShop.FieldByName('TA_Order').Value := FqMain.FieldByName('TA_Order').Value;
        FqShop.FieldByName('TA_Data').AsBytes := FqMain.FieldByName('TA_Data').AsBytes;
        FqShop.Post;
      end
      else begin
        FqShop.Edit;
        FqShop.FieldByName('TA_Name').AsString := FqMain.FieldByName('TA_Name').AsString;
        FqShop.FieldByName('TA_Width').AsInteger := FqMain.FieldByName('TA_Width').AsInteger;
        FqShop.FieldByName('TA_Order').Value := FqMain.FieldByName('TA_Order').Value;
        FqShop.FieldByName('TA_Data').AsBytes := FqMain.FieldByName('TA_Data').AsBytes;
        FqShop.Post;
      end;
      FqMain.Next;
    end;

//    // 5 часть, товары с планограммы плитки
//    FqMain.Close;
//    FqMain.SQL.Clear;
//    FqMain.SQL.Add('select TT_ID,TT_SDoc,TT_Tovar,TT_Layer,TT_Order ' +
//      ' from TileTovar' +
//      ' inner join TileArea on TA_ID = TT_SDoc' +
//      ' inner join TileShelf on TS_ID = TA_SDoc' +
//      ' inner join TileRack on TR_ID = TS_SDoc' +
//      ' inner join PlanogramList on TR_ID = PGL_EqID and PGL_TypeEq=7' +
//      ' inner join Planogram on PG_ID = PGL_SDoc ' +
//      ' where PG_Place = ' + IntToStr(FPlace) +
//      ifvar(dDate=0,'',' and TA_DateUpdateData >= :Date') +
//      ' order by TT_ID');
//    if dDate > 0 then
//       FqMain.Parameters.ParamByName('Date').Value := dDate;
//    FqMain.Open;
//    FqShop.Close;
//    FqShop.SQL.Clear;
//    FqShop.SQL.Add('select TT_ID,TT_SDoc,TT_Tovar,TT_Layer,TT_Order from TileTovar order by TT_ID');
//    FqShop.Open;
//
//    if FqMain.Active and FqShop.Active then
//    begin
//      DoShowSendDataExchange('', FqMain.RecordCount);
//      while not FqMain.Eof or not FqShop.Eof do
//      begin
//        DoShowSendDataExchange('', 0, FqMain.RecNo);
//        if not FqMain.Eof and ((FqMain.FieldByName('TT_ID').AsInteger < FqShop.FieldByName('TT_ID').AsInteger) or FqShop.Eof) then
//        begin
//          Inc(nCount);
//          FconShop.Execute('insert TileTovar (TT_ID, TT_SDoc, TT_Tovar, TT_Layer, TT_Order) values (' +
//            FqMain.FieldByName('TT_ID').AsString + ', ' +
//            FqMain.FieldByName('TT_SDoc').AsString + ', ' +
//            FqMain.FieldByName('TT_Tovar').AsString + ', ' +
//            FqMain.FieldByName('TT_Layer').AsString + ', ' +
//            FqMain.FieldByName('TT_Order').AsString + ')');
//          FqMain.Next;
//        end else if FqMain.Eof or not FqShop.Eof and (FqMain.FieldByName('TT_ID').AsInteger > FqShop.FieldByName('TT_ID').AsInteger) then
//        begin
//          FconShop.Execute('delete TileTovar where TT_ID = ' + FqShop.FieldByName('TT_ID').AsString);
//          FqShop.Next;
//        end else if FqMain.FieldByName('TT_ID').AsInteger = FqShop.FieldByName('TT_ID').AsInteger then
//        begin
//          if (FqMain.FieldByName('TT_Layer').AsInteger <> FqShop.FieldByName('TT_Layer').AsInteger) or
//             (FqMain.FieldByName('TT_Order').AsInteger <> FqShop.FieldByName('TT_Order').AsInteger) then
//          begin
//            Inc(nCount);
//            FconShop.Execute('update TileTovar set TT_Layer = ' + FqMain.FieldByName('TT_Layer').AsString +
//              ', TT_Order = ' + FqMain.FieldByName('TT_Order').AsString +
//              ' where TT_ID = ' + FqShop.FieldByName('TT_ID').AsString);
//          end;
//          FqMain.Next; FqShop.Next;
//        end;
//        if Terminated then Break;
//      end;
//    end;

    FqMain.Close;
    FqMain.SQL.Clear;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 26, FormStepResult(nCount))
    else SaveLog(12, 26, S);
  except
  end;
end;

function TSendDataExchange.SendTovarPhoto : Boolean;
  var S, cWarehouse : string; nMaxID, nCount, nDel, I : integer;
begin
  Result:=True;
  if IsSkipAction('SendTovarPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehousePhoto + '.dbo.TovarPhoto';

  DoShowSendDataExchange('Отправка фотографий товаров');

  nCount := 0; nDel := 0;
  try
    SaveLog(11, 11, '');

    FqShop.Close;
    FqShop.SQl.Clear;
    FqShop.SQl.Add('select Max(TP_ID) as TP_ID from ' + cWarehouse);
    FqShop.Open;
    if not FqShop.Eof then nMaxID := FqShop.FieldByName('TP_ID').AsInteger
    else nMaxID := 0;
    FqShop.Close;
    FqShop.SQl.Clear;

    S := '';
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select SL_SDoc from SysLog where SL_Key = 127 and (SL_Date >= ' +
      '(select DateAdd(d, - 1, Max(LDE_Date))  from LogDataExchange where LDE_Type = 13 and LDE_SendName = 11 and LDE_Place = ' + IntToStr(FPlace) +
       ') or not Exists(select * from LogDataExchange where LDE_Type = 13 and LDE_SendName = 11 and LDE_Place = ' + IntToStr(FPlace) + '))');
    FqMain.Open;
    while not FqMain.Eof do
    begin
      S := S + IfStr(S = '', '', ',') + FqMain.FieldByName('SL_SDoc').AsString;
      FqMain.Next;
    end;
    FqMain.Close;
    FqMain.SQL.Clear;
    if S <> '' then
    begin
      FconShop.Execute('if Exists(select TP_ID from ' + cWarehouse + ' where TP_ID in (' + S + ')) ' +
        'delete ' + cWarehouse + ' where TP_ID in (' + S + ')', I);
      if I > 0 then Inc(nDel, I);
    end;

    S := '';
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select SL_SDoc from SysLog, Tovar where SL_Key = 136 and SL_TurnType = 0 and ' +
      'SL_SDoc = Tov_ID and Tov_Permision = ''N'' and SL_Date >= ' +
      'IsNull((select DateAdd(d, - 1, Max(LDE_Date))  from LogDataExchange where ' +
	    'LDE_Type = 13 and LDE_SendName = 11 and LDE_Place = ' + IntToStr(FPlace) + '), ''20100101'')');
    FqMain.Open;
    while not FqMain.Eof do
    begin
      S := S + IfStr(S = '', '', ',') + FqMain.FieldByName('SL_SDoc').AsString;
      FqMain.Next;
    end;
    FqMain.Close;
    FqMain.SQL.Clear;
    if S <> '' then
    begin
      FconShop.Execute('if Exists(select TP_ID from ' + cWarehouse + ' where TP_Tovar in (' + S + ')) ' +
        'delete ' + cWarehouse + ' where TP_Tovar in (' + S + ')', I);
      if I > 0 then Inc(nDel, I);
    end;

    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select TP_ID, TP_Tovar, TP_Thumbnail, TP_Photo from SysLog, Tovar, FileStorage.dbo.TovarPhoto ' +
      'where SL_Key = 136 and SL_TurnType = 1 and SL_SDoc = Tov_ID and Tov_Permision = ''Y'' and TP_Tovar = SL_SDoc and SL_Date >= ' +
      'IsNull((select DateAdd(d, - 1, Max(LDE_Date))  from LogDataExchange where ' +
      'LDE_Type = 13 and LDE_SendName = 11 and LDE_Place = ' + IntToStr(FPlace) + '), ''20100101'') ' +
      'union all ' +
      'select top 3000 TP_ID, TP_Tovar, TP_Thumbnail, TP_Photo ' +
      'from FileStorage.dbo.TovarPhoto ' + IfStr(nMaxID > 0, ' where TP_ID > ' + IntToStr(nMaxID), '') + ' order by TP_ID');
    FqMain.Open;

    if FqMain.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);
        if FqShop.Active then FqShop.Close;
        FqShop.SQl.Clear;
        FqShop.SQl.Add('select TP_ID, TP_Tovar, TP_Thumbnail, TP_Photo from ' + cWarehouse +
          ' where TP_ID = ' + FqMain.FieldByName('TP_ID').AsString);
        FqShop.Open;
        if FqShop.RecordCount = 0 then
        begin
          FqShop.Insert;
          FqShop.FieldByName('TP_ID').AsInteger := FqMain.FieldByName('TP_ID').AsInteger;
          FqShop.FieldByName('TP_Tovar').AsInteger := FqMain.FieldByName('TP_Tovar').AsInteger;
          FqShop.FieldByName('TP_Thumbnail').AsBytes := FqMain.FieldByName('TP_Thumbnail').AsBytes;
          FqShop.FieldByName('TP_Photo').AsBytes := FqMain.FieldByName('TP_Photo').AsBytes;
          FqShop.FieldByName('TP_Tovar').AsInteger := FqMain.FieldByName('TP_Tovar').AsInteger;
          FqShop.Post;
          Inc(nCount);
        end;
        FqMain.Next;
        if Terminated then Break;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 11, FormStepResult(nCount, 'Добавлено - %u фотографий', 'Новых нет',
      IfStr(nDel > 0, '. Удалено - ' + IntToStr(nDel) + ' фотографий',  '')))
    else SaveLog(12, 11, S);
  except
  end;
end;

function TSendDataExchange.SendGroupsFile : boolean;
const COUNT_READ = 10;
var
  S, cFileName, cWarehouse{, IDList} : string;
  nSize, nID, nCount : integer;
  nDate : TDateTime;
  I : Integer;
  sp : TADOStoredProc;
  MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('SendGroupsFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  nCount := 0;
  //IDList:='';
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов стандартов приемки товара');

  try
    SaveLog(11, 15, '');

    // Берем файлы магазина
//    if FqShop.Active then FqShop.Close;
//    FqShop.SQl.Clear;
//    FqShop.SQl.Add( ' declare @IDList varchar(max) = '''' '+
//                    ' select @IDList += cast(GF_IDOffice as varchar)+'','' ' +
//                    ' from GroupsFile  ' +
//                    ' SET @IDList = substring(@IDList,0,len(@IDList)) '+
//                    ' select @IDList as IDList');
//    FqShop.Open;
//    IDList:= FqShop.FieldByName('IDList').AsString;

    FqMain.Close; FqShop.Close;
    FqMain.SQL.Clear;
    // Список файлов в трейде
    FqMain.SQL.Add( ' select * '+
                    ' from GroupsFile '+
                    //ifvar(IDList='','',
                    //      ' where GF_ID in ('+IDList+') ')+
                    ' order by GF_ID');
    FqMain.Open;
    S := '';

    if FqMain.Active then
    begin
      DoShowSendDataExchange('', FqMain.RecordCount);
      while not FqMain.Eof do
      begin
        DoShowSendDataExchange('', 0, FqMain.RecNo);

        if S = '' then
          S := FqMain.FieldByName('GF_ID').AsString
        else
          S := S + ', ' + FqMain.FieldByName('GF_ID').AsString;

        cFileName := FGroupFilesPath + IfStr(FGroupFilesPath[Length(FGroupFilesPath)] = '\', '', '\') +
          FqMain.FieldByName('GF_File').AsString;
        if not GetFileExists(cFileName) then
        begin
          SaveLog(12, 15, 'Не найден файл: ' + cFileName);
          FqMain.Next;
          Continue;
        end;
        GetFileSizeDate(cFileName, nSize, nDate);

        // есть ли такой же файл на магазине
//        if FqShop.Active then FqShop.Close;
//        FqShop.SQl.Clear;
//        FqShop.SQl.Add('select * ' +
//          ' from GroupsFile where GF_IDOffice = :IDOffice ' +
//          ' order by GF_ID');
//        FqShop.Parameters.ParamByName('IDOffice').Value := FqMain.FieldByName('GF_ID').AsString;
//        FqShop.Open;
//
//        // Если подобная запись есть
//        if FqShop.RecordCount = 0 then



//        begin
//          if (FqShop.FieldByName('GF_Sdoc').AsInteger <> FqMain.FieldByName('GF_Sdoc').AsInteger) or
//            (FqShop.FieldByName('GF_File').AsInteger <> FqMain.FieldByName('GF_File').AsInteger) or
//            (FqShop.FieldByName('GF_Note').AsInteger <> FqMain.FieldByName('GF_Note').AsInteger) or
//            (FqShop.FieldByName('GF_Date').AsVariant <> FqMain.FieldByName('GF_Date').AsVariant) then
//          begin
//            nID := FqShop.FieldByName('OMF_SDoc').AsInteger;
//            if FqShop.Active then FqShop.Close;
//            FqShop.SQl.Clear;
//            FqShop.SQl.Add('select OMF_ID, OMF_IdOffice, OMF_Sdoc, OMF_SdocOffice, OMF_SdocType, ' +
//              'OMF_File, OMF_Note, OMF_Date, OMF_Visible, OMF_DateVisible ' +
//              'from OfficeMemoFile where OMF_ID = ' + IntToStr(nID));
//            FqShop.Open;
//            FqShop.Edit;
//            FqShop.FieldByName('OMF_IdOffice').AsInteger := FqMain.FieldByName('OMF_ID').AsInteger;
//            FqShop.FieldByName('OMF_SDoc').AsInteger := nSDoc;
//            FqShop.FieldByName('OMF_SdocOffice').AsInteger := FqMain.FieldByName('OMF_SDoc').AsInteger;
//            FqShop.FieldByName('OMF_SdocType').AsInteger := FqMain.FieldByName('OMF_SdocType').AsInteger;
//            FqShop.FieldByName('OMF_File').AsVariant := FqMain.FieldByName('OMF_File').AsVariant;
//            FqShop.FieldByName('OMF_Note').AsVariant := FqMain.FieldByName('OMF_Note').AsVariant;
//            FqShop.FieldByName('OMF_Date').AsVariant := FqMain.FieldByName('OMF_Date').AsVariant;
//            FqShop.FieldByName('OMF_Visible').AsVariant := FqMain.FieldByName('OMF_Visible').AsVariant;
//            FqShop.FieldByName('OMF_DateVisible').AsVariant := FqMain.FieldByName('OMF_DateVisible').AsVariant;
//            FqShop.Post;
//          end;
//        end else

        if FqShop.Active then FqShop.Close;
        FqShop.SQL.Clear;
        FqShop.SQl.Add('select * ' +
          ' from GroupsFile where GF_IDOffice = :IDOffice ' +
          ' order by GF_ID');
        FqShop.Parameters.ParamByName('IDOffice').Value := FqMain.FieldByName('GF_ID').AsString;
        FqShop.Open;

        if FqShop.RecordCount = 0 then
        begin
          FqShop.Close; FqShop.SQl.Clear;
          FqShop.SQl.Add('select * ' +
            ' from GroupsFile where GF_ID = 0');
          FqShop.Open;
          FqShop.Insert;
          FqShop.FieldByName('GF_IdOffice').AsInteger := FqMain.FieldByName('GF_ID').AsInteger;
          FqShop.FieldByName('GF_Sdoc').AsInteger := FqMain.FieldByName('GF_Sdoc').AsInteger;
          FqShop.FieldByName('GF_File').AsString := FqMain.FieldByName('GF_File').AsString;
          FqShop.FieldByName('GF_Note').AsString := FqMain.FieldByName('GF_Note').AsString;
          FqShop.FieldByName('GF_Date').Value := FqMain.FieldByName('GF_Date').Value;
          FqShop.Post;
        end
        else if (FqShop.FieldByName('GF_Sdoc').AsInteger <> FqMain.FieldByName('GF_Sdoc').AsInteger) or
                (FqShop.FieldByName('GF_File').AsString <> FqMain.FieldByName('GF_File').AsString) or
                (FqShop.FieldByName('GF_Note').AsString <> FqMain.FieldByName('GF_Note').AsString) or
                (FqShop.FieldByName('GF_Date').AsVariant <> FqMain.FieldByName('GF_Date').AsVariant) then
        begin
          FqShop.Edit;
          FqShop.FieldByName('GF_Sdoc').AsInteger := FqMain.FieldByName('GF_Sdoc').AsInteger;
          FqShop.FieldByName('GF_File').AsString := FqMain.FieldByName('GF_File').AsString;
          FqShop.FieldByName('GF_Note').AsString := FqMain.FieldByName('GF_Note').AsString;
          FqShop.FieldByName('GF_Date').Value := FqMain.FieldByName('GF_Date').Value;
          FqShop.Post;
        end;

        // Запись файла в WareHouse
        if FqShop.Active then FqShop.Close;
        FqShop.SQl.Clear;
        FqShop.SQl.Add(' select FS_ID, FS_Name, FS_Size, FS_Date from ' + cWarehouse +
                       ' where FS_Type = 4 and FS_Name = :FileName');
        FqShop.Parameters.ParamByName('FileName').Value := FqMain.FieldByName('GF_File').AsVariant;
        FqShop.Open;
        if FqShop.RecordCount > 0 then
        begin
          if (FqShop.FieldByName('FS_Size').AsInteger <> nSize) or
            (FqShop.FieldByName('FS_Date').AsDateTime <> nDate) then
          begin
            nID := FqShop.FieldByName('FS_ID').AsInteger;
            FqShop.SQl.Clear;
            FqShop.SQl.Add('select FS_Size, FS_Date, FS_File from ' + cWarehouse +
                           ' where FS_ID = ' + IntToStr(nID));
            FqShop.Open;
            FqShop.Edit;
            FqShop.FieldByName('FS_Size').AsInteger := nSize;
            FqShop.FieldByName('FS_Date').AsDateTime := nDate;
            // критическая секция для одного потока
//            csGroups.Enter;
//            try
//              TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
//            finally
//              csGroups.Leave;
//            end;
            ///////////////////////////////////////
            {$IFDEF TRADE}
            MS := TMemoryStream.Create;
            try
              MS.Position := 0;
              if not FService then
              begin
                sp := CreateProc('sp_GetFileFromSecure', False, 3);
                try
                  sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
                  sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
                  try
                    sp.Open;
                    TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                  except on E:Exception do
                    SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
                  end;
                finally
                  sp.Free;
                end;
              end;
            {$ENDIF}
              I := 1;
              while I <= COUNT_READ do
              begin
                try
                  {$IFDEF TRADE}
                    if MS.Size > 0 then
                    begin
                      MS.Position := 0;
                      TBlobField(FqShop.FieldByName('FS_File')).LoadFromStream(MS);
                    end;
                  {$ELSE}
                    TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
                  {$ENDIF}
                  I := COUNT_READ + 1;
                except
                  on E : Exception do
                  begin
                    if I <= COUNT_READ then
                      Inc(I)
                    else
                      raise Exception.Create(E.Message + ' ' + IntToStr(I));
                  end;
                end;
              end;
              FqShop.Post;
              Inc(nCount);
            {$IFDEF TRADE}
            finally
                MS.Free;
            end;
            {$ENDIF}
          end;

        end else
        begin
          FqShop.SQl.Clear;
          FqShop.SQl.Add(' select FS_Type, FS_Name, FS_Size, FS_Date, FS_File ' +
                         ' from ' + cWarehouse + ' where FS_ID = 0');
          FqShop.Open;
          FqShop.Insert;
          FqShop.FieldByName('FS_Type').AsInteger := 4;
          FqShop.FieldByName('FS_Name').AsString := FqMain.FieldByName('GF_File').AsVariant;
          FqShop.FieldByName('FS_Size').AsInteger := nSize;
          FqShop.FieldByName('FS_Date').AsDateTime := nDate;
          // критическая секция для одного потока
//          csGroups.Enter;
//          try
//            TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
//          finally
//            csGroups.Leave;
//          end;
          //////////////////////////////////
          {$IFDEF TRADE}
          MS := TMemoryStream.Create;
          try
            MS.Position := 0;
            sp := CreateProc('sp_GetFileFromSecure', False, 3);
            try
              sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
              sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
              try
                sp.Open;
                TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              except on E:Exception do
                SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
              end;
            finally
              sp.Free;
            end;
          {$ENDIF}
            I := 1;
            while I <= COUNT_READ do
            begin
              try
                {$IFDEF TRADE}
                  if MS.Size > 0 then
                  begin
                    MS.Position := 0;
                    TBlobField(FqShop.FieldByName('FS_File')).LoadFromStream(MS);
                  end;
                {$ELSE}
                  TBlobField(FqShop.FieldByName('FS_File')).LoadFromFile(cFileName);
                {$ENDIF}

                I := COUNT_READ + 1;
              except
                on E : Exception do
                begin
                  if I <= COUNT_READ then
                    Inc(I)
                  else
                    raise Exception.Create(E.Message + ' ' + IntToStr(I));
                end;
              end;
            end;
            FqShop.Post;
            Inc(nCount);
          {$IFDEF TRADE}
          finally
            MS.Free;
          end;
          {$ENDIF}
        end;

        FqMain.Next;
        if Terminated then Break;
      end;
      // Удаление лишних записей
      // Удалим все, если в основной БД не нашли файлов
      FqShop.SQl.Clear;
      if S<>'' then
        FqShop.SQl.Add(' delete GroupsFile where GF_IDOffice not in (' + S + ')')
      else
        FqShop.SQl.Add(' delete GroupsFile ');
      FqShop.ExecSQL;

    end;

    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 15, FormStepResult(nCount))
    else SaveLog(12, 15, S);
  except
  end;
end;

function TSendDataExchange.SendHelpFile : boolean;
  var S, cWarehouse, cFileName : string; nSize, nCount, nFID : integer;
      nDate : TDateTime;
      SearchRec: TSearchRec; FindResult: Integer; FileList : TStringList;
      sp : TADOStoredProc;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('SendHelpFile') then Exit;
  if (FSubdivision = 0) or (FWarehouse = '') then Exit
  else Result := False;
  nCount := 0; S := '';
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  FileList := TStringList.Create;
  try
    SaveLog(11, 14, '');
    DoShowSendDataExchange('Отправка файлов Help');
    FileList.Sorted := True;

    FindResult := FindFirst(FHelpFilesPath + '/*.*', faNormal, SearchRec);
    try
      while FindResult = 0 do
      begin
        FileList.Add(SearchRec.Name);
        FindResult := FindNext(SearchRec);
      end;
    finally
      FindClose(SearchRec);
    end;

    if FileList.Count = 0 then
    begin
      Result := True;
      Exit;
    end;

    try
      if FqShop.Active then FqShop.Close;
      FqShop.SQl.Clear;
      FqShop.SQl.Add('select FS_ID, FS_Name, FS_Size, FS_Date from ' + cWarehouse + ' where FS_Type = 3 order by FS_Name');
      FqShop.Open;

      nFID := 0;
      DoShowSendDataExchange('', Math.Max(FileList.Count, FqShop.RecordCount));
      while not (FqShop.Eof and (FileList.Count <= nFID))  do
      begin
        DoShowSendDataExchange('', 0, Math.Max(nFID + 1, FqShop.RecNo));

        if not FqShop.Eof and (AnsiUpperCase(FqShop.FieldByName('FS_Name').AsString) > AnsiUpperCase(FileList.Strings[nFID])) or
          FqShop.Eof and (FileList.Count > nFID) then
        begin
//          nSize := GetFileSize(FHelpFilesPath + '/' + FileList.Strings[nFID]);
//          nDate := GetFileDate(FHelpFilesPath + '/' + FileList.Strings[nFID]);
          cFileName := FHelpFilesPath + '/' + FileList.Strings[nFID];
          FqShopFile.SQl.Clear;
          FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
          FqShopFile.Open;
          FqShopFile.Insert;
          FqShopFile.FieldByName('FS_Type').AsInteger := 3;
          FqShopFile.FieldByName('FS_Name').AsString := FileList.Strings[nFID];

          GetFileSizeDate(FHelpFilesPath + '/' + FileList.Strings[nFID], nSize, nDate);
          FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
          FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
          {$IFDEF TRADE}
          MS := TMemoryStream.Create;
          try
            MS.Position := 0;
            sp := CreateProc('sp_GetFileFromSecure', False, 3);
            try
              sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
              sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
              try
                sp.Open;
                TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                MS.Position := 0;
                TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
              except on E:Exception do
                SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
              end;
            finally
              sp.Free;
            end;
            FqShopFile.Post;
            FqShopFile.Close;
          finally
            MS.Free;
          end;
          {ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
          FqShopFile.Post;
          FqShopFile.Close;
          {$ENDIF}
          Inc(nCount);

          Inc(nFID);
        end else if not FqShop.Eof and ((FileList.Count <= nFID) or
           (AnsiUpperCase(FqShop.FieldByName('FS_Name').AsString) < AnsiUpperCase(FileList.Strings[nFID]))) then
        begin
          FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);
          Inc(nCount);

          FqShop.Next;
        end else if not FqShop.Eof and (AnsiUpperCase(FqShop.FieldByName('FS_Name').AsString) = AnsiUpperCase(FileList.Strings[nFID])) then
        begin
          cFileName := FHelpFilesPath + '/' + FileList.Strings[nFID];
          GetFileSizeDate(cFileName, nSize, nDate);
          if (nSize <> FqShop.FieldByName('FS_Size').AsInteger) or
            (nDate <> FqShop.FieldByName('FS_Date').AsDateTime) then
          begin
            FqShopFile.SQl.Clear;
            FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = ' +
              FqShop.FieldByName('FS_ID').AsString);
            FqShopFile.Open;
            FqShopFile.Edit;
            FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
            FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
            {$IFDEF TRADE}
            MS := TMemoryStream.Create;
            try
              MS.Position := 0;
              sp := CreateProc('sp_GetFileFromSecure', False, 3);
              try
                sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
                sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
                try
                  sp.Open;
                  TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                  MS.Position := 0;
                  TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
                except on E:Exception do
                  SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
                end;
              finally
                sp.Free;
              end;
              FqShopFile.Post;
              FqShopFile.Close;
            finally
              MS.Free;
            end;
            {$ELSE}
            TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
            FqShopFile.Post;
            FqShopFile.Close;
            {$ENDIF}
            Inc(nCount);
          end;
          FqShop.Next;
          Inc(nFID);
        end else
        begin
          S := 'Ошибка сравнения файлов...';
          Exit;
        end;
      end;
      Result := True;
    except
      on E: EDatabaseError do S := E.Message;
      on E: Exception do S := E.Message;
      else S := ''
    end;
    FqMain.Close;
    FqMain.SQL.Clear;
    FqShopFile.Close;
    FqShopFile.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

  finally
    FileList.Free;
  end;

  try
    if Result then SaveLog(13, 14, FormStepResult(nCount))
    else SaveLog(12, 14, S);
  except
  end;
end;

function TSendDataExchange.SendPersonDeduct : Boolean;
  var nCount : Integer; S : string;
begin
  Result:=True;
  if IsSkipAction('SendPersonDeduct') then Exit;
  Result := False; nCount := 0; S := '';
  if not FconShop.Connected then Exit;

  DoShowSendDataExchange('Контроль удержаний');
  try
    SaveLog(11, 16, '');

    FqShop.Close;
    FqShop.SQL.Clear;
    FqShop.SQL.Add('select PD_ID, PD_Document, PD_SDoc, PD_Date, PD_DateExamin, PD_Person, PD_PersonName, PD_Subdivision, ' +
      'PD_SuName, PD_Depart, PD_Type, PD_Reason, PD_Note, PD_Currency, PD_Summa, PD_Exchange, PD_DocIn, ' +
      'PD_SPerson, PD_SPersonName, PD_Undertake, PD_UnderEcon, PD_Conclusion, PD_CurrFact, PD_SummaFact, ' +
      'PD_Schedule, PD_SummaDeduct, PD_DateUpdate, PD_WhoUpdate, PD_IsEcon, PD_DateEcon, PD_WhoEcon, ' +
      'PD_IsOVK, PD_DateOVK, PD_WhoOVK, PD_IsExecutor, PD_DateExecutor, PD_WhoExecutor, ' +
      'PD_IsAudit, PD_DateAudit, PD_WhoAudit, PD_IsDirector, PD_DateDirector, PD_WhoDirector, ' +
      'PD_IsOk, PD_DateOk, PD_WhoOk, PD_SendUnder from PersonDeduct ' +
      'where PD_IsOk = ''N'' order by PD_ID');

    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('select PD_ID, PD_Document, PD_SDoc, PD_Date, PD_DateExamin, PD_Person,  ' +
      '(select Pe_Name from VPerson where Pe_ID = PD_Person) as PD_PersonName, PD_Subdivision, ' +
      'Su_Name as PD_SuName, PD_Depart, PD_Type, PD_Reason, PD_Note, PD_Currency, PD_Summa, PD_Exchange, ' +
      'PD_SPerson, (select Pe_Name from VPerson where Pe_ID = PD_SPerson) as PD_SPersonName, DI_DocSource as PD_DocIn, ' +
      'PD_Undertake, PD_UnderEcon, PD_Conclusion, PD_CurrFact, PD_SummaFact, ' +
      'PD_Schedule, PD_SummaDeduct, PD_DateUpdate, ' +
      '(select Pe_Name from VPerson where Pe_ID = PD_WhoUpdate) as PD_WhoUpdate, ' +
      'PD_IsEcon, PD_DateEcon, (select Pe_Name from VPerson where Pe_ID = PD_WhoEcon) as PD_WhoEcon, ' +
      'PD_IsOVK, PD_DateOVK, (select Pe_Name from VPerson where Pe_ID = PD_WhoOVK) as PD_WhoOVK, ' +
      'PD_IsExecutor, PD_DateExecutor, (select Pe_Name from VPerson where Pe_ID = PD_WhoExecutor) as PD_WhoExecutor, ' +
      'PD_IsAudit, PD_DateAudit, (select Pe_Name from VPerson where Pe_ID = PD_WhoAudit) as PD_WhoAudit, ' +
      'PD_IsDirector, PD_DateDirector, (select Pe_Name from VPerson where Pe_ID = PD_WhoDirector) as PD_WhoDirector, ' +
      'PD_IsOk, PD_DateOk, (select Pe_Name from VPerson where Pe_ID = PD_WhoOk) as PD_WhoOk from ' +
      'PersonDeduct left outer join Subdivision on Su_ID = PD_Subdivision ' +
      'left outer join DocIn on DI_Document = PD_DocIn ' +
      'where PD_ID = :ID');

    FqShop.Open;
    if FqShop.Active then
    begin
      DoShowSendDataExchange('', FqShop.RecordCount);
      while not FqShop.Eof do
      begin
        DoShowSendDataExchange('', 0, FqShop.RecNo);

        FqMain.Close;
        FqMain.Parameters.ParamByName('ID').Value := FqShop.FieldByName('PD_ID').AsInteger;
        FqMain.Open;

        if FqMain.RecordCount = 1 then
        begin
          if (FqMain.FieldByName('PD_Document').AsVariant <> FqShop.FieldByName('PD_Document').AsVariant) or
             (FqMain.FieldByName('PD_SDoc').AsVariant <> FqShop.FieldByName('PD_SDoc').AsVariant) or
             (FqMain.FieldByName('PD_Date').AsVariant <> FqShop.FieldByName('PD_Date').AsVariant) or
             (FqMain.FieldByName('PD_DateExamin').AsVariant <> FqShop.FieldByName('PD_DateExamin').AsVariant) or
             (FqMain.FieldByName('PD_Person').AsVariant <> FqShop.FieldByName('PD_Person').AsVariant) or
             (FqMain.FieldByName('PD_PersonName').AsVariant <> FqShop.FieldByName('PD_PersonName').AsVariant) or
             (FqMain.FieldByName('PD_Subdivision').AsVariant <> FqShop.FieldByName('PD_Subdivision').AsVariant) or
             (FqMain.FieldByName('PD_SuName').AsVariant <> FqShop.FieldByName('PD_SuName').AsVariant) or
             (FqMain.FieldByName('PD_Depart').AsVariant <> FqShop.FieldByName('PD_Depart').AsVariant) or
             (FqMain.FieldByName('PD_Type').AsVariant <> FqShop.FieldByName('PD_Type').AsVariant) or
             (FqMain.FieldByName('PD_Reason').AsVariant <> FqShop.FieldByName('PD_Reason').AsVariant) or
             (FqMain.FieldByName('PD_Note').AsVariant <> FqShop.FieldByName('PD_Note').AsVariant) or
             (FqMain.FieldByName('PD_Currency').AsVariant <> FqShop.FieldByName('PD_Currency').AsVariant) or
             (FqMain.FieldByName('PD_Summa').AsVariant <> FqShop.FieldByName('PD_Summa').AsVariant) or
             (FqMain.FieldByName('PD_Exchange').AsVariant <> FqShop.FieldByName('PD_Exchange').AsVariant) or
             (FqMain.FieldByName('PD_SPerson').AsVariant <> FqShop.FieldByName('PD_SPerson').AsVariant) or
             (FqMain.FieldByName('PD_SPersonName').AsVariant <> FqShop.FieldByName('PD_SPersonName').AsVariant) or
             (FqMain.FieldByName('PD_Undertake').AsVariant <> FqShop.FieldByName('PD_Undertake').AsVariant) or
             (FqMain.FieldByName('PD_UnderEcon').AsVariant <> FqShop.FieldByName('PD_UnderEcon').AsVariant) or
             (FqMain.FieldByName('PD_Conclusion').AsVariant <> FqShop.FieldByName('PD_Conclusion').AsVariant) or
             (FqMain.FieldByName('PD_CurrFact').AsVariant <> FqShop.FieldByName('PD_CurrFact').AsVariant) or
             (FqMain.FieldByName('PD_SummaFact').AsVariant <> FqShop.FieldByName('PD_SummaFact').AsVariant) or
             (FqMain.FieldByName('PD_Schedule').AsVariant <> FqShop.FieldByName('PD_Schedule').AsVariant) or
             (FqMain.FieldByName('PD_SummaDeduct').AsVariant <> FqShop.FieldByName('PD_SummaDeduct').AsVariant) or
             (FqMain.FieldByName('PD_DateUpdate').AsVariant <> FqShop.FieldByName('PD_DateUpdate').AsVariant) or
             (FqMain.FieldByName('PD_WhoUpdate').AsVariant <> FqShop.FieldByName('PD_WhoUpdate').AsVariant) or
             (FqMain.FieldByName('PD_IsEcon').AsVariant <> FqShop.FieldByName('PD_IsEcon').AsVariant) or
             (FqMain.FieldByName('PD_DateEcon').AsVariant <> FqShop.FieldByName('PD_DateEcon').AsVariant) or
             (FqMain.FieldByName('PD_WhoEcon').AsVariant <> FqShop.FieldByName('PD_WhoEcon').AsVariant) or
             (FqMain.FieldByName('PD_IsOVK').AsVariant <> FqShop.FieldByName('PD_IsOVK').AsVariant) or
             (FqMain.FieldByName('PD_DateOVK').AsVariant <> FqShop.FieldByName('PD_DateOVK').AsVariant) or
             (FqMain.FieldByName('PD_WhoOVK').AsVariant <> FqShop.FieldByName('PD_WhoOVK').AsVariant) or
             (FqMain.FieldByName('PD_IsExecutor').AsVariant <> FqShop.FieldByName('PD_IsExecutor').AsVariant) or
             (FqMain.FieldByName('PD_DateExecutor').AsVariant <> FqShop.FieldByName('PD_DateExecutor').AsVariant) or
             (FqMain.FieldByName('PD_WhoExecutor').AsVariant <> FqShop.FieldByName('PD_WhoExecutor').AsVariant) or
             (FqMain.FieldByName('PD_IsAudit').AsVariant <> FqShop.FieldByName('PD_IsAudit').AsVariant) or
             (FqMain.FieldByName('PD_DateAudit').AsVariant <> FqShop.FieldByName('PD_DateAudit').AsVariant) or
             (FqMain.FieldByName('PD_WhoAudit').AsVariant <> FqShop.FieldByName('PD_WhoAudit').AsVariant) or
             (FqMain.FieldByName('PD_IsDirector').AsVariant <> FqShop.FieldByName('PD_IsDirector').AsVariant) or
             (FqMain.FieldByName('PD_DateDirector').AsVariant <> FqShop.FieldByName('PD_DateDirector').AsVariant) or
             (FqMain.FieldByName('PD_WhoDirector').AsVariant <> FqShop.FieldByName('PD_WhoDirector').AsVariant) or
             (FqMain.FieldByName('PD_IsOk').AsVariant <> FqShop.FieldByName('PD_IsOk').AsVariant) or
             (FqMain.FieldByName('PD_DateOk').AsVariant <> FqShop.FieldByName('PD_DateOk').AsVariant) or
             (FqMain.FieldByName('PD_WhoOk').AsVariant <> FqShop.FieldByName('PD_WhoOk').AsVariant) or
             not FqMain.FieldByName('PD_DocIn').IsNull and (FqMain.FieldByName('PD_DocIn').AsVariant <> FqShop.FieldByName('PD_DocIn').AsVariant) then
          begin
            FqShopFile.SQl.Clear;
            FqShopFile.SQl.Add('select * from PersonDeduct where PD_ID = ' + FqShop.FieldByName('PD_ID').AsString);
            FqShopFile.Open;
            FqShopFile.Edit;

            FqShopFile.FieldByName('PD_Document').AsVariant := FqMain.FieldByName('PD_Document').AsVariant;
            FqShopFile.FieldByName('PD_SDoc').AsVariant := FqMain.FieldByName('PD_SDoc').AsVariant;
            FqShopFile.FieldByName('PD_Date').AsVariant := FqMain.FieldByName('PD_Date').AsVariant;
            FqShopFile.FieldByName('PD_DateExamin').AsVariant := FqMain.FieldByName('PD_DateExamin').AsVariant;
            FqShopFile.FieldByName('PD_Person').AsVariant := FqMain.FieldByName('PD_Person').AsVariant;
            if not FqMain.FieldByName('PD_PersonName').IsNull then
              FqShopFile.FieldByName('PD_PersonName').AsVariant := FqMain.FieldByName('PD_PersonName').AsVariant;
            FqShopFile.FieldByName('PD_Subdivision').AsVariant := FqMain.FieldByName('PD_Subdivision').AsVariant;
            if not FqMain.FieldByName('PD_SuName').IsNull then
              FqShopFile.FieldByName('PD_SuName').AsVariant := FqMain.FieldByName('PD_SuName').AsVariant;
            FqShopFile.FieldByName('PD_Depart').AsVariant := FqMain.FieldByName('PD_Depart').AsVariant;
            FqShopFile.FieldByName('PD_Type').AsVariant := FqMain.FieldByName('PD_Type').AsVariant;
            FqShopFile.FieldByName('PD_Reason').AsVariant := FqMain.FieldByName('PD_Reason').AsVariant;
            FqShopFile.FieldByName('PD_Note').AsVariant := FqMain.FieldByName('PD_Note').AsVariant;
            FqShopFile.FieldByName('PD_Currency').AsVariant := FqMain.FieldByName('PD_Currency').AsVariant;
            FqShopFile.FieldByName('PD_Summa').AsVariant := FqMain.FieldByName('PD_Summa').AsVariant;
            FqShopFile.FieldByName('PD_Exchange').AsVariant := FqMain.FieldByName('PD_Exchange').AsVariant;
            FqShopFile.FieldByName('PD_SPerson').AsVariant := FqMain.FieldByName('PD_SPerson').AsVariant;
            if not FqMain.FieldByName('PD_SPersonName').IsNull then
              FqShopFile.FieldByName('PD_SPersonName').AsVariant := FqMain.FieldByName('PD_SPersonName').AsVariant;
            if not FqShopFile.FieldByName('PD_SendUnder').AsBoolean then
              FqShopFile.FieldByName('PD_Undertake').AsVariant := FqMain.FieldByName('PD_Undertake').AsVariant;
            FqShopFile.FieldByName('PD_UnderEcon').AsVariant := FqMain.FieldByName('PD_UnderEcon').AsVariant;
            FqShopFile.FieldByName('PD_Conclusion').AsVariant := FqMain.FieldByName('PD_Conclusion').AsVariant;
            FqShopFile.FieldByName('PD_CurrFact').AsVariant := FqMain.FieldByName('PD_CurrFact').AsVariant;
            FqShopFile.FieldByName('PD_SummaFact').AsVariant := FqMain.FieldByName('PD_SummaFact').AsVariant;
            FqShopFile.FieldByName('PD_Schedule').AsVariant := FqMain.FieldByName('PD_Schedule').AsVariant;
            FqShopFile.FieldByName('PD_SummaDeduct').AsVariant := FqMain.FieldByName('PD_SummaDeduct').AsVariant;
            FqShopFile.FieldByName('PD_DateUpdate').AsVariant := FqMain.FieldByName('PD_DateUpdate').AsVariant;
            if not FqMain.FieldByName('PD_WhoUpdate').IsNull then
              FqShopFile.FieldByName('PD_WhoUpdate').AsVariant := FqMain.FieldByName('PD_WhoUpdate').AsVariant;
            FqShopFile.FieldByName('PD_IsEcon').AsVariant := FqMain.FieldByName('PD_IsEcon').AsVariant;
            FqShopFile.FieldByName('PD_DateEcon').AsVariant := FqMain.FieldByName('PD_DateEcon').AsVariant;
            if not FqMain.FieldByName('PD_WhoEcon').IsNull then
              FqShopFile.FieldByName('PD_WhoEcon').AsVariant := FqMain.FieldByName('PD_WhoEcon').AsVariant;
            FqShopFile.FieldByName('PD_IsOVK').AsVariant := FqMain.FieldByName('PD_IsOVK').AsVariant;
            FqShopFile.FieldByName('PD_DateOVK').AsVariant := FqMain.FieldByName('PD_DateOVK').AsVariant;
            if not FqMain.FieldByName('PD_WhoOVK').IsNull then
              FqShopFile.FieldByName('PD_WhoOVK').AsVariant := FqMain.FieldByName('PD_WhoOVK').AsVariant;
            FqShopFile.FieldByName('PD_IsExecutor').AsVariant := FqMain.FieldByName('PD_IsExecutor').AsVariant;
            FqShopFile.FieldByName('PD_DateExecutor').AsVariant := FqMain.FieldByName('PD_DateExecutor').AsVariant;
            if not FqMain.FieldByName('PD_WhoExecutor').IsNull then
              FqShopFile.FieldByName('PD_WhoExecutor').AsVariant := FqMain.FieldByName('PD_WhoExecutor').AsVariant;
            FqShopFile.FieldByName('PD_IsAudit').AsVariant := FqMain.FieldByName('PD_IsAudit').AsVariant;
            FqShopFile.FieldByName('PD_DateAudit').AsVariant := FqMain.FieldByName('PD_DateAudit').AsVariant;
            if not FqMain.FieldByName('PD_WhoAudit').IsNull then
              FqShopFile.FieldByName('PD_WhoAudit').AsVariant := FqMain.FieldByName('PD_WhoAudit').AsVariant;
            FqShopFile.FieldByName('PD_IsDirector').AsVariant := FqMain.FieldByName('PD_IsDirector').AsVariant;
            FqShopFile.FieldByName('PD_DateDirector').AsVariant := FqMain.FieldByName('PD_DateDirector').AsVariant;
            if not FqMain.FieldByName('PD_WhoDirector').IsNull then
              FqShopFile.FieldByName('PD_WhoDirector').AsVariant := FqMain.FieldByName('PD_WhoDirector').AsVariant;
            FqShopFile.FieldByName('PD_IsOk').AsVariant := FqMain.FieldByName('PD_IsOk').AsVariant;
            FqShopFile.FieldByName('PD_DateOk').AsVariant := FqMain.FieldByName('PD_DateOk').AsVariant;
            if not FqMain.FieldByName('PD_WhoOk').IsNull then
              FqShopFile.FieldByName('PD_WhoOk').AsVariant := FqMain.FieldByName('PD_WhoOk').AsVariant;
            if not FqMain.FieldByName('PD_DocIn').IsNull then
              FqShopFile.FieldByName('PD_DocIn').AsVariant := FqMain.FieldByName('PD_DocIn').AsVariant;

            FqShopFile.Post;
            Inc(nCount);
          end;
        end else if FqMain.RecordCount = 0 then FconShop.Execute('delete PersonDeduct where PD_ID = ' +
          FqShop.FieldByName('PD_ID').AsString);


        if Terminated then Break;
        FqShop.Next;
      end;
    end;

    FqMain.Close;
    FqMain.SQL.Clear;
    FqShop.Close;
    FqShop.SQL.Clear;

    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := ''
  end;

  try
    if Result then SaveLog(13, 16, FormStepResult(nCount))
    else SaveLog(12, 16, S);
  except
  end;
end;

function TSendDataExchange.LoadApplContractFiles: boolean;
  var cFileName, cWarehouse, S : string; nCount : integer; bReload : Boolean;
      Q : TADOQuery;
      MS : TMemoryStream;
  const cPrefix : String = 'ACFiles';
begin
  Result:=True;
  if IsSkipAction('LoadApplContractFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов к заявкам на договора');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('Select AC_ID, AC_IDOffice, ACF_ID, ACF_Contract, ACF_Type, ' +
    'ACF_FileExt, ACF_Note, ACF_ShopUnload, ' +
    '(select Pe_IdBase from VPerson where PE_ID = ACF_WhoInput) as ACF_WhoInput, ACF_DateInput ' +
    'from ApplContract, ApplContractFiles where AC_ID = ACF_SDoc and ' +
    'AC_ShopUnload is not Null and ACF_IDOffice is null and ACF_ShopUnload = 0 ' +
    'order by AC_ID, ACF_ID');

  nCount := 0; S := '';
  try
    SaveLog(11, 21, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('Select AC_ID, ACF_ID, ACF_Contract, ACF_Type, ' +
        'ACF_FileExt, ACF_Note, AC_ShopUnload, ACF_FileLoad ' +
        'from ApplContract inner join ApplContractRevision on AC_ID = ACR_SDoc and ACR_Type = 1 and IsNull(ACR_ShopLoad, 0) > 0 ' +
        'left outer join ApplContractFiles on AC_ID = ACF_SDoc and ' +
        'ACF_Place = ' + IntToStr(FPlace) + ' and ACF_IDShop = ' + FqShop.FieldByName('ACF_ID').AsString +
        ' where AC_ID = ' + FqShop.FieldByName('AC_IDOffice').AsString);
      FqMain.Open;

      if not FqMain.FieldByName('AC_ShopUnload').IsNull then
      begin
        bReload := false;
        if FqMain.FieldByName('ACF_ID').IsNull then
        begin
          FconMain.Execute('insert ApplContractFiles (ACF_SDoc, ACF_Place, ACF_IDShop, ACF_Contract, ' +
            'ACF_Type, ACF_FileExt, ACF_Note, ACF_WhoInput, ACF_DateInput) values (' +
            FqMain.FieldByName('AC_ID').AsString + ',' + IntToSVar(FPlace) + ', ' +
            FqShop.FieldByName('ACF_ID').AsString + ',' + IfStr(FqShop.FieldByName('ACF_Contract').AsBoolean, '1', '0') + ',' +
            FqShop.FieldByName('ACF_Type').AsString + ',' + StrToQuery(FqShop.FieldByName('ACF_FileExt').AsString) + ',' +
            StrToQuery(FqShop.FieldByName('ACF_Note').AsString) + ',' +
            FqShop.FieldByName('ACF_WhoInput').AsString + ',' +
            StrToQuery(FormatDateTime('YYYY-MM-DD HH:NN:SS', FqShop.FieldByName('ACF_DateInput').AsDateTime)) + ')');
          FqMain.Close;
          FqMain.Open;
        end else if (FqShop.FieldByName('ACF_Contract').AsBoolean <> FqMain.FieldByName('ACF_Contract').AsBoolean) or
            (FqShop.FieldByName('ACF_Type').AsInteger <> FqMain.FieldByName('ACF_Type').AsInteger) or
            (FqShop.FieldByName('ACF_FileExt').AsString <> FqMain.FieldByName('ACF_FileExt').AsString) or
            (FqShop.FieldByName('ACF_Note').AsString <> FqMain.FieldByName('ACF_Note').AsString) then
        begin
          FconMain.Execute('update ApplContractFiles set ' +
            'ACF_Contract = ' + IfStr(FqShop.FieldByName('ACF_Contract').AsBoolean, '1', '0') +
            ',ACF_Type = ' + FqShop.FieldByName('ACF_Type').AsString +
            ',ACF_FileExt = ' + StrToQuery(FqShop.FieldByName('ACF_FileExt').AsString) +
            ',ACF_Note = ' + StrToQuery(FqShop.FieldByName('ACF_Note').AsString) +
            ' where ACF_ID = ' + FqMain.FieldByName('ACF_ID').AsString);
          bReload := True;
        end;

        if not FqMain.FieldByName('ACF_ID').IsNull and (
          not FqMain.FieldByName('ACF_FileLoad').AsBoolean or bReload) then
        begin
          FqShopFile.Close;
          FqShopFile.SQL.Clear;
          FqShopFile.SQL.Add('select FS_File from ' + cWarehouse +
            ' where FS_Type = 10 and FS_Name = ''' + cPrefix + Format('%.10d', [FqShop.FieldByName('ACF_ID').AsInteger]) +
              FqShop.FieldByName('ACF_FileExt').AsString + '''');
          FqShopFile.Open;

          if FqShopFile.RecordCount = 1 then
          begin
            cFileName := FACFilesPath + '\' + cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
              FqMain.FieldByName('ACF_FileExt').AsString;
            {$IFDEF TRADE}
            Q := CreateQuery(False);
            MS := TMemoryStream.Create;
            try
              TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
              MS.Position := 0;

              // Если файл уже есть, то его сперва надо удалить!
              if GetFileExists(cFileName) then
                // удалить файл!
              begin
                Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
                Q.Parameters.ParamByName('Folder').Value :=
                  StringReplace(FACFilesPath,'\\dom.loc\dfs\secure\','',[]);
                Q.Parameters.ParamByName('File').Value :=
                  cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
                  FqMain.FieldByName('ACF_FileExt').AsString;
                Q.Open;
              end;

              Q.Close;
              Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
              Q.Parameters.ParamByName('Folder').Value :=
                StringReplace(FACFilesPath,'\\dom.loc\dfs\secure\','',[]);
              Q.Parameters.ParamByName('File').Value :=
                  cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
                  FqMain.FieldByName('ACF_FileExt').AsString;
              Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
              Q.Open;
            finally
              MS.Free;
              Q.Close; Q.Free;
            end;
            {$ELSE}
            TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
            {$ENDIF}
            FconMain.Execute('update ApplContractFiles set ACF_FileLoad = 1 where ACF_ID = ' +
              FqMain.FieldByName('ACF_ID').AsString);
            Inc(nCount);
          end;
          FqShopFile.Close;
        end;

        FconShop.Execute('update ApplContractFiles set ACF_ShopUnload = 1 where ACF_ID = ' +
          FqShop.FieldByName('ACF_ID').AsString);
      end{ else if FqShop.FieldByName('ACF_ShopUnload').AsInteger = 0 then
      begin
        if not FqMain.FieldByName('ACF_ID').IsNull then
        begin
          cFileName := FACFilesPath + '\' + cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
            FqMain.FieldByName('ACF_FileExt').AsString;
          if FileExists(cFileName) then DeleteFile(cFileName);
          if not FileExists(cFileName) then FconMain.Execute('delete ApplContractFiles where ACF_ID = ' +
            FqMain.FieldByName('ACF_ID').AsString);
          FqMain.Close;
          FqMain.Open;
        end;

        if FqMain.FieldByName('ACF_ID').IsNull then
        begin
          FconShop.Execute('delete '+ cWarehouse + ' where FS_Type = 10 and FS_Name = ''' +
            cPrefix + Format('%.10d', [FqShop.FieldByName('ACF_ID').AsInteger]) +
            FqShop.FieldByName('ACF_FileExt').AsString + '''');
          FconShop.Execute('update ApplContractFiles set ACF_ShopUnload = Null where ACF_ID = ' +
            FqShop.FieldByName('ACF_ID').AsString);
          FconShop.Execute('delete ApplContractFiles where ACF_ID = ' +
            FqShop.FieldByName('ACF_ID').AsString);
        end;
      end};

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к заявкам на договора...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 21, FormStepResult(nCount))
    else SaveLog(12, 21, S);
  except
  end;
end;

function TSendDataExchange.SendApplContractFiles: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; bReload : Boolean;
      nDate : TDateTime;
      sp : TADOStoredProc;
      MS : TMemoryStream;
  const cPrefix : String = 'ACFiles';
begin
  Result:=True;
  if IsSkipAction('SendApplContractFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов к заявкам на договора');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select AC_ID, ACF_ID, ACF_Contract, ACF_Type, ' +
    'ACF_FileExt, ACF_Note, ACF_WhoInput, ACF_DateInput ' +
    'from ApplContract, ApplContractFiles where AC_ID = ACF_SDoc and ' +
    'AC_IsShopExport = 1 and AC_ShopUnload is not Null and ' +
    'ACF_IDShop is null and ACF_FileUnload = 0' +
    'order by AC_ID, ACF_ID');

  nCount := 0; S := '';
  try
    SaveLog(11, 22, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShop.Close;
      FqShop.SQL.Clear;
      FqShop.SQL.Add('Select AC_ID, AC_ShopLoad, ACF_ID, ACF_Contract, ACF_Type, ' +
        'ACF_FileExt, ACF_Note, ACF_ShopLoad ' +
        'from ApplContract left outer join ApplContractFiles on AC_ID = ACF_SDoc and ' +
        'ACF_IDOffice = ' + FqMain.FieldByName('ACF_ID').AsString +
        ' where AC_IDOffice = ' + FqMain.FieldByName('AC_ID').AsString);
      FqShop.Open;

      if not FqShop.FieldByName('AC_ID').IsNull and not FqShop.FieldByName('AC_ShopLoad').IsNull then
      begin
        bReload := false;
        if FqShop.FieldByName('ACF_ID').IsNull then
        begin
          FconShop.Execute('insert ApplContractFiles (ACF_SDoc, ACF_IDOffice, ACF_Contract, ' +
            'ACF_Type, ACF_FileExt, ACF_Note, ACF_WhoInput, ACF_DateInput) values (' +
            FqShop.FieldByName('AC_ID').AsString + ',' +
            FqMain.FieldByName('ACF_ID').AsString + ',' + IfStr(FqMain.FieldByName('ACF_Contract').AsBoolean, '1', '0') + ',' +
            FqMain.FieldByName('ACF_Type').AsString + ',' + StrToQuery(FqMain.FieldByName('ACF_FileExt').AsString) + ',' +
            StrToQuery(FqMain.FieldByName('ACF_Note').AsString) + ',' +
            FqMain.FieldByName('ACF_WhoInput').AsString + ',' +
            StrToQuery(FormatDateTime('YYYY-MM-DD HH:NN:SS', FqMain.FieldByName('ACF_DateInput').AsDateTime)) + ')');
          FqShop.Close;
          FqShop.Open;
        end else if (FqShop.FieldByName('ACF_Contract').AsBoolean <> FqMain.FieldByName('ACF_Contract').AsBoolean) or
            (FqShop.FieldByName('ACF_Type').AsInteger <> FqMain.FieldByName('ACF_Type').AsInteger) or
            (FqShop.FieldByName('ACF_FileExt').AsString <> FqMain.FieldByName('ACF_FileExt').AsString) or
            (FqShop.FieldByName('ACF_Note').AsString <> FqMain.FieldByName('ACF_Note').AsString) then
        begin
          FconShop.Execute('update ApplContractFiles set ' +
            'ACF_Contract = ' + IfStr(FqMain.FieldByName('ACF_Contract').AsBoolean, '1', '0') +
            ',ACF_Type = ' + FqMain.FieldByName('ACF_Type').AsString +
            ',ACF_FileExt = ' + StrToQuery(FqMain.FieldByName('ACF_FileExt').AsString) +
            ',ACF_Note = ' + StrToQuery(FqMain.FieldByName('ACF_Note').AsString) +
            ' where ACF_ID = ' + FqShop.FieldByName('ACF_ID').AsString);
          bReload := True;
        end;

        if not FqShop.FieldByName('ACF_ID').IsNull and
          (not FqShop.FieldByName('ACF_ShopLoad').AsBoolean or bReload) then
        begin

          cFileName := FACFilesPath + '\' + cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
            FqMain.FieldByName('ACF_FileExt').AsString;
          if not FileExists(cFileName) then
          begin
            SaveLog(12, 22, 'Не найден файл: ' + cFileName);
            FqMain.Next;
            Continue;
          end;

          GetFileSizeDate(cFileName, nSize, nDate);

          FqShopFile.Close;
          FqShopFile.SQL.Clear;
          FqShopFile.SQL.Add('select FS_Type, FS_Size, FS_Date, FS_Name, FS_File from ' + cWarehouse +
            ' where FS_Type = 10 and FS_Name = ''' + cPrefix + Format('%.10d', [FqShop.FieldByName('ACF_ID').AsInteger]) +
              FqShop.FieldByName('ACF_FileExt').AsString + '''');
          FqShopFile.Open;

          if FqShopFile.RecordCount = 1 then
          begin
            FqShopFile.Edit;
            FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
            FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
          end else
          begin
            FqShopFile.Insert;
            FqShopFile.FieldByName('FS_Type').AsInteger := 10;
            FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
            FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
            FqShopFile.FieldByName('FS_Name').AsString := cPrefix + Format('%.10d', [FqShop.FieldByName('ACF_ID').AsInteger]) +
              FqShop.FieldByName('ACF_FileExt').AsString;
          end;

          {$IFDEF TRADE}
          MS := TMemoryStream.Create;
          try
            MS.Position := 0;
            sp := CreateProc('sp_GetFileFromSecure', False, 3);
            try
              sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
              sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
              try
                sp.Open;
                TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
                MS.Position := 0;
                TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
              except on E:Exception do
                SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
              end;
            finally
              sp.Free;
            end;

            FqShopFile.Post;
            FqShopFile.Close;
            FconShop.Execute('update ApplContractFiles set ACF_ShopLoad = 1 ' +
              ' where ACF_ID = ' + FqShop.FieldByName('ACF_ID').AsString);
          finally
            MS.Free;
          end;
          {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
          FqShopFile.Post;
          FqShopFile.Close;
          FconShop.Execute('update ApplContractFiles set ACF_ShopLoad = 1 ' +
            ' where ACF_ID = ' + FqShop.FieldByName('ACF_ID').AsString);
          {$ENDIF}
          Inc(nCount);
        end;

        FconMain.Execute('update ApplContractFiles set ACF_FileUnload = 1 where ACF_ID = ' +
          FqMain.FieldByName('ACF_ID').AsString);
      end;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов к заявкам на договора...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 22, FormStepResult(nCount))
    else SaveLog(12, 22, S);
  except
  end;
end;

function TSendDataExchange.ReturnApplContractFiles: boolean;
  var cFileName, cWarehouse, S : string; nCount : integer;
  const cPrefix : String = 'ACFiles';
begin
  Result:=True;
  if IsSkipAction('ReturnApplContractFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Возврат файлов к заявкам на договора');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select AC_ID, ACF_ID, ACF_IDShop, ACF_FileExt ' +
    'from ApplContract ' +
    'inner join ApplContractRevision on AC_ID = ACR_SDoc and ACR_ShopLoad = 0 ' +
    'inner join ApplContractFiles on AC_ID = ACF_SDoc and ACF_Contract = 1 and ' +
    '  ACF_Type = ACR_Order and ACF_Place = ' + IntToStr(FPlace) +
    'where AC_IsShopExport = 1 and AC_ShopUnload is not Null ' +
    'order by AC_ID, ACF_ID');

  nCount := 0; S := '';
  try
    SaveLog(11, 23, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShop.Close;
      FqShop.SQL.Clear;
      FqShop.SQL.Add('Select AC_ID, ACF_ID, ACF_ShopUnload ' +
        'from ApplContract inner join ApplContractFiles on AC_ID = ACF_SDoc and ' +
        'ACF_ID = ' + FqMain.FieldByName('ACF_IDShop').AsString +
        ' where AC_IDOffice = ' + FqMain.FieldByName('AC_ID').AsString);
      FqShop.Open;

      if not FqShop.FieldByName('ACF_ID').IsNull then
      begin
        if FqShop.FieldByName('ACF_ShopUnload').AsBoolean then
          FconShop.Execute('update ApplContractFiles set ACF_ShopUnload = 0 where ACF_ID = ' +
            FqShop.FieldByName('ACF_ID').AsString);

        cFileName := FACFilesPath + '\' + cPrefix + Format('%.10d', [FqMain.FieldByName('ACF_ID').AsInteger]) +
          FqMain.FieldByName('ACF_FileExt').AsString;

        if FileExists(cFileName) then DeleteFile(cFileName);

        if not FileExists(cFileName) then
          FconMain.Execute('update ApplContractFiles set ACF_FileLoad = 0 where ACF_ID = ' +
            FqMain.FieldByName('ACF_ID').AsString + #13#10 +
            'delete ApplContractFiles where ACF_ID = ' + FqMain.FieldByName('ACF_ID').AsString);
        Inc(nCount);
      end;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка возврата файлов к заявкам на договора...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 23, FormStepResult(nCount))
    else SaveLog(12, 23, S);
  except
  end;
end;

function TSendDataExchange.LoadLayOutPhotoDoc: boolean;
var cFileName, cWarehouse, S : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadLayOutPhotoDoc') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов Выкладки');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select * from LayOutPhotoDoc' + #13#10 +
                 'Where LOPD_ShopLoad is Not Null and' + #13#10 +
                 'IsNull(LOPD_FileName, '''') = '''' and LOPD_SDoc in ' +
                 '(select Lo_ID from LayOut where LO_IsMerchandiser = 0 and LO_Place = ' +
                 IntToStr(FPlace)+')');

  nCount := 0; S := '';
  try
    SaveLog(11, 24, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select LOPD_FileName, LOPD_DateInput, dbo.GetIDBase(LOPD_WhoInput) as LOPD_WhoInput, ' +
        'LOPD_DateUpdate, dbo.GetIDBase(LOPD_WhoUpdate) as LOPD_WhoUpdate,' +
        ' LOPD_FileDate, dbo.GetIDBase(LOPD_WhoFile) as LOPD_WhoFile, ' +
        'FS_File from LayOutPhotoDoc '+
        'Inner join ' + cWarehouse + ' ON FS_Type = 11 and LOPD_FileName = FS_Name '+
        'where LOPD_ID = ' + FqMain.FieldByName('LOPD_IDShop').AsString);
      FqShopFile.Open;
      cFileName := FLayOutPhotoPathDoc + FqShopFile.FieldByName('LOPD_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FLayOutPhotoPathDoc,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('LOPD_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FLayOutPhotoPathDoc,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('LOPD_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('LOPD_FileName').AsString := FqShopFile.FieldByName('LOPD_FileName').AsString;
        FqMain.FieldByName('LOPD_DateInput').AsVariant := FqShopFile.FieldByName('LOPD_DateInput').AsVariant;
	      FqMain.FieldByName('LOPD_WhoInput').AsVariant := FqShopFile.FieldByName('LOPD_WhoInput').AsVariant;
        FqMain.FieldByName('LOPD_DateUpdate').AsVariant := FqShopFile.FieldByName('LOPD_DateUpdate').AsVariant;
        FqMain.FieldByName('LOPD_WhoUpdate').AsVariant := FqShopFile.FieldByName('LOPD_WhoUpdate').AsVariant;
        FqMain.FieldByName('LOPD_FileDate').AsVariant := FqShopFile.FieldByName('LOPD_FileDate').AsVariant;
        FqMain.FieldByName('LOPD_WhoFile').AsVariant := FqShopFile.FieldByName('LOPD_WhoFile').AsVariant;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к выкладкам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 24, FormStepResult(nCount))
    else SaveLog(12, 24, S);
  except
  end;
end;

function TSendDataExchange.SendLayOutPhotoDoc: boolean;
var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
    sp : TADOStoredProc;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('SendLayOutPhotoDoc') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка файлов Выкладки');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('Select * from LayOutPhotoDoc' + #13#10 +
                 'Where LOPD_ShopLoad is Not Null and' + #13#10 +
                 'IsNull(LOPD_FileName, '''') = ''''');

  nCount := 0; S := '';
  try
    SaveLog(11, 25, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('select LOPD_FileName, LOPD_DateInput, LOPD_WhoInput, ' +
        'LOPD_DateUpdate, LOPD_WhoUpdate, LOPD_FileDate, LOPD_WhoFile ' +
        'from LayOutPhotoDoc where LOPD_ID = ' +
        FqShop.FieldByName('LOPD_IDOffice').AsString);
      FqMain.Open;
      cFileName := FLayOutPhotoPathDoc + FqMain.FieldByName('LOPD_FileName').AsString;
      if FqMain.RecordCount = 1 then
      begin
        GetFileSizeDate(cFileName, nSize, nDate);

        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
        FqShopFile.Open;
        FqShopFile.Insert;
        FqShopFile.FieldByName('FS_Type').AsInteger := 11;
        FqShopFile.FieldByName('FS_Name').AsString := FqMain.FieldByName('LOPD_FileName').AsString;
        FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
        FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;
        {$IFDEF TRADE}
        MS := TMemoryStream.Create;
        try
          MS.Position := 0;
          sp := CreateProc('sp_GetFileFromSecure', False, 3);
          try
            sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
            sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
            try
              sp.Open;
              TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              MS.Position := 0;
              TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
            except on E:Exception do
              SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
            end;
          finally
            sp.Free;
          end;
        {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
        {$ENDIF}
          FqShopFile.Post;

          FqShop.Edit;
          FqShop.FieldByName('LOPD_FileName').AsString := FqMain.FieldByName('LOPD_FileName').AsString;
          FqShop.FieldByName('LOPD_DateInput').AsVariant := FqMain.FieldByName('LOPD_DateInput').AsVariant;
          FqShop.FieldByName('LOPD_WhoInput').AsVariant := FqMain.FieldByName('LOPD_WhoInput').AsVariant;
          FqShop.FieldByName('LOPD_DateUpdate').AsVariant := FqMain.FieldByName('LOPD_DateUpdate').AsVariant;
          FqShop.FieldByName('LOPD_WhoUpdate').AsVariant := FqMain.FieldByName('LOPD_WhoUpdate').AsVariant;
          FqShop.FieldByName('LOPD_FileDate').AsVariant := FqMain.FieldByName('LOPD_FileDate').AsVariant;
          FqShop.FieldByName('LOPD_WhoFile').AsVariant := FqMain.FieldByName('LOPD_WhoFile').AsVariant;
          FqShop.Post;
        {$IFDEF TRADE}
        finally
          MS.Free;
        end;
        {$ENDIF}
        Inc(nCount);
      end;
      FqMain.Close;

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов к выкладкам...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 25, FormStepResult(nCount))
    else SaveLog(12, 25, S);
  except
  end;
end;


function TSendDataExchange.SendInventCardPhoto: boolean;
  var cFileName, cWarehouse, S : string; nInvCount, nCount, nSize : integer; nDate : TDateTime;
begin
  Result:=True;
  if IsSkipAction('SendInventCardPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;

  DoShowSendDataExchange('Отправка файлов инвентарных карточек(новых)');
  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(' Select * from InventCardPhoto '+
                 ' inner join InventCard on inv_ID = ICP_SDoc');

  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('select ICP_ID,ICP_SDoc,ICP_Thumbnail,ICP_Photo,ICP_FileName,ICP_DateInput,ICP_WhoInput,ICP_DateUpdate,ICP_WhoUpdate ' +
                 ' from InventCardPhoto '+
                 ' inner join InventCard on inv_ID = ICP_SDoc'+
                 ' left join InventCardList on Inv_ID = IL_SDoc '+
                 ' inner join Maintool on Inv_MainTool = MT_ID'+
                 ' Where isnull(IL_Place,INV_Place) = ' + IntToStr(Fplace) +
                 ' and Inv_ISMove = ''Y'' '+
                 ' and MT_TypeMainTool  in (2,4,3) '+
                 ' group by ICP_ID,ICP_SDoc,ICP_Thumbnail,ICP_Photo,ICP_FileName,ICP_DateInput,ICP_WhoInput,ICP_DateUpdate,ICP_WhoUpdate');
  FqMain.Open;

  nCount := 0; S := '';
  try
    SaveLog(11, 50, '');
    DoShowSendDataExchange('', FqMain.RecordCount);
    FqShop.Open;

    if FqShop.IsEmpty then              //заполняем если таблица пуста
      begin
        FqMain.First;
        while not FqMain.Eof do
          begin
            FqShop.Insert;
            FqShop.FieldByName('ICP_ID').AsInteger := FqMain.FieldByName('ICP_ID').AsInteger;
            FqShop.FieldByName('ICP_SDoc').AsInteger := FqMain.FieldByName('ICP_SDoc').AsInteger;
            FqShop.FieldByName('ICP_Thumbnail').AsVariant := FqMain.FieldByName('ICP_Thumbnail').AsVariant;
            FqShop.FieldByName('ICP_Photo').AsVariant := FqMain.FieldByName('ICP_Photo').AsVariant;
            FqShop.FieldByName('ICP_FileName').AsString := FqMain.FieldByName('ICP_FileName').AsString;
            FqShop.FieldByName('ICP_DateInput').AsVariant := FqMain.FieldByName('ICP_DateInput').AsVariant;
            FqShop.FieldByName('ICP_WhoInput').AsInteger := FqMain.FieldByName('ICP_WhoInput').AsInteger;
            FqShop.FieldByName('ICP_DateUpdate').AsVariant := FqMain.FieldByName('ICP_DateUpdate').AsVariant;
            FqShop.FieldByName('ICP_WhoUpdate').AsVariant := FqMain.FieldByName('ICP_WhoUpdate').AsVariant;
            FqShop.Post;
            FqMain.Next;
            if Terminated then Break;
          end;
      end
    else
      begin
        FqMain.First;
        while not FqMain.Eof do
        begin
          DoShowSendDataExchange('', 0, FqShop.RecNo);

          FqShop.Close;
          FqShop.SQL.Clear;
          FqShop.SQL.Add(' select inv_ID ' +
                         ' from InventCard ' +
                         ' where inv_ID = :Id');
          FqShop.Parameters.ParamByName('Id').Value := FqMain.FieldByName('ICP_SDoc').AsInteger;
          FqShop.Open;
          nInvCount := FqShop.RecordCount;

          FqShop.Close;
          FqShop.SQL.Clear;
          FqShop.SQL.Add(' select ICP_ID,ICP_SDoc,ICP_Thumbnail,ICP_Photo,ICP_FileName,ICP_DateInput,ICP_WhoInput,ICP_DateUpdate,ICP_WhoUpdate ' +
                         ' from InventCardPhoto ' +
                         ' where ICP_ID = ' +
            FqMain.FieldByName('ICP_ID').AsString);
          FqShop.Open;
          if (FqShop.RecordCount = 0) and (nInvCount <> 0) then       //добавляем если есть новые  и есть запись в InventCard на ТТ
          begin
            FqShop.Insert;
            FqShop.FieldByName('ICP_ID').AsInteger := FqMain.FieldByName('ICP_ID').AsInteger;
            FqShop.FieldByName('ICP_SDoc').AsInteger := FqMain.FieldByName('ICP_SDoc').AsInteger;
            FqShop.FieldByName('ICP_Thumbnail').AsVariant := FqMain.FieldByName('ICP_Thumbnail').AsVariant;
            FqShop.FieldByName('ICP_Photo').AsVariant := FqMain.FieldByName('ICP_Photo').AsVariant;
            FqShop.FieldByName('ICP_FileName').AsString := FqMain.FieldByName('ICP_FileName').AsString;
            FqShop.FieldByName('ICP_DateInput').AsVariant := FqMain.FieldByName('ICP_DateInput').AsVariant;
            FqShop.FieldByName('ICP_WhoInput').AsInteger := FqMain.FieldByName('ICP_WhoInput').AsInteger;
            FqShop.FieldByName('ICP_DateUpdate').AsVariant := FqMain.FieldByName('ICP_DateUpdate').AsVariant;
            FqShop.FieldByName('ICP_WhoUpdate').AsVariant := FqMain.FieldByName('ICP_WhoUpdate').AsVariant;
            FqShop.Post;
            Inc(nCount);
          end;
          FqMain.Next;

          if Terminated then Break;
        end;
      end;

     FqMain.Close;
     FqMain.SQL.Clear;
     FqMain.SQL.Add(' Declare @IDs varchar(max) = '''' '+
                    ' Select @IDs += cast(ICP_ID as varchar(100)) + '','' '+
                    ' From InventCardPhoto '+
                    ' inner join InventCard on inv_ID = ICP_SDoc '+
                    ' left join InventCardList on Inv_ID = IL_SDoc '+
                    ' Where isnull(IL_Place,Inv_Place) = ' + IntToStr(Fplace) +
                    ' group by ICP_ID '+
                    ' if @IDs <> '''' '+
                    ' Set @IDs = SubString(@IDs,1,len(@IDs)-1) '+
                    ' Select iif(@IDs = '''',''0'',@IDs) as IDS ');
     FqMain.Open;

     if not FqMain.FieldByName('IDS').IsNull then                             //Удаление лишних файлов
        begin
          FconShop.Execute('delete InventCardPhoto where ICP_ID not In ( ' + FqMain.FieldByName('IDS').AsString+' )');
        end;


    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов к выкладкам...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqMain.Close;
  FqMain.SQL.Clear;

  try
    if Result then SaveLog(13, 50, FormStepResult(nCount))
    else SaveLog(12, 50, S);
  except
  end;
end;


function TSendDataExchange.SendPersonHappyFile: boolean;
  var cFileName, cWarehouse, S : string; nCount: integer;
begin
  Result:=True;
  if IsSkipAction('SendPersonHappyFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка фонов "Счастья"');

  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(' Select * from '+
                 ' PersonHappyFile '+
                 ' left join '+cWarehouse+' on FS_Name = PHF_Name collate Cyrillic_General_CI_AS and FS_Type = 49 '+
                 ' where FS_File is null ');

  nCount := 0; S := '';
  try
    SaveLog(11, 49, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('select PHF_Name, PHF_DateInput, PHF_WhoInput, PHF_FileContent ' +
        ' from PersonHappyFile '+
        ' where PHF_ID = ' +
        FqShop.FieldByName('PHF_ID').AsString);
      FqMain.Open;
//      cFileName := FPersonHappyFile +'\'+ FqMain.FieldByName('PHF_Name').AsString;

      if FqMain.RecordCount = 1 then
      begin
//        nSize := GetFileSize(cFileName);
//        nDate := GetFileDate(cFileName);
        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('select FS_Type, FS_Name, FS_Size, FS_Date, FS_File from ' + cWarehouse + ' where FS_ID = 0');
        FqShopFile.Open;
        FqShopFile.Insert;
        FqShopFile.FieldByName('FS_Type').AsInteger := 49;
        FqShopFile.FieldByName('FS_Name').AsString := FqMain.FieldByName('PHF_Name').AsString;
        FqShopFile.FieldByName('FS_Size').AsInteger := TBlobField(FqMain.FieldByName('PHF_FileContent')).Size; //nSize;
        FqShopFile.FieldByName('FS_Date').AsDateTime := FqMain.FieldByName('PHF_DateInput').AsDateTime; //nDate;
//        TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
        TBlobField(FqShopFile.FieldByName('FS_File')).assign(TBlobField(FqMain.FieldByName('PHF_FileContent')));
        FqShopFile.Post;

        FqShop.Edit;
        FqShop.FieldByName('PHF_Name').AsString := FqMain.FieldByName('PHF_Name').AsString;
        FqShop.FieldByName('PHF_DateInput').AsVariant := FqMain.FieldByName('PHF_DateInput').AsVariant;
        FqShop.FieldByName('PHF_WhoInput').AsVariant := FqMain.FieldByName('PHF_WhoInput').AsVariant;
        FqShop.Post;
      end;
      FqMain.Close;

      FqShop.Next;
      if Terminated then Break;
    end;


     FqMain.Close;
     FqMain.SQL.Clear;
     FqMain.SQL.Add(' Declare @IDs varchar(max) = '''' '+
                    ' Select @IDs += cast(PHF_ID as varchar(100)) + '','' '+
                    ' From PersonHappyFile '+
                    ' if @IDs <> '''' '+
                    ' Set @IDs = SubString(@IDs,1,len(@IDs)-1) '+
                    ' Select iif(@IDs = '''',''0'',@IDs) as IDS ');
     FqMain.Open;

     if not FqMain.FieldByName('IDS').IsNull then                             //Удаление лишних файлов
        begin
          FconShop.Execute('delete PersonHappyFile where PHF_ID not In ( ' + FqMain.FieldByName('IDS').AsString+' )');
        end;


    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов к выкладкам...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 49, FormStepResult(nCount))
    else SaveLog(12, 49, S);
  except
  end;
end;

// Отправка анкет (файлов) на мазагин с офиса
function TSendDataExchange.SendPersonFilesAnk: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
      sp : TADOStoredProc;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('SendPersonFilesAnk') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Отправка анкет сотрудников на магазин');

  FqMain.Close;
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('If EXISTS ( Select 1');
  FqShop.SQL.Add('            From sysobjects');
  FqShop.SQL.Add('            Where name = ''PersonFilesAnk'' AND type = ''U'')');
  FqShop.SQL.Add('begin');

  FqShop.SQL.Add('Select');
  FqShop.SQL.Add(' *');
  FqShop.SQL.Add('From PersonFilesAnk');
  FqShop.SQL.Add(' left join '+cWarehouse+' On FS_Name = PFA_SecureFileName collate Cyrillic_General_CI_AS and ');
  FqShop.SQL.Add('                             FS_Type = 52');
  FqShop.SQL.Add('Where FS_ID is null and');
  FqShop.SQL.Add('      PFA_Load is not null and');
  FqShop.SQL.Add('      PFA_UnLoad is null');

  FqShop.SQL.Add('end');
  FqShop.SQL.Add('else');
  FqShop.SQL.Add('Select 1 Where 1 = 0');

  nCount := 0;
  S := '';
  Try
    SaveLog(11, 52, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);

    While not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add('Select');
      FqMain.SQL.Add(' *');
      FqMain.SQL.Add('From PersonFilesAnk');
      FqMain.SQL.Add('Where PFA_SDoc = :Person and');
      FqMain.SQL.Add('      PFA_SecureFileName = :SecureFileName');
      FqMain.Parameters.ParamByName('Person').Value := FqShop.FieldByName('PFA_SDoc').AsInteger;
      FqMain.Parameters.ParamByName('SecureFileName').Value := FqShop.FieldByName('PFA_SecureFileName').AsString;
      FqMain.Open;

      cFileName := FPersonFilesAnkPath  + FqMain.FieldByName('PFA_SecureFileName').AsString;

      If FqMain.RecordCount = 1 then
      begin
        GetFileSizeDate(cFileName, nSize, nDate);

        FqShopFile.SQl.Clear;
        FqShopFile.SQl.Add('Select');
        FqShopFile.SQl.Add(' FS_Type, FS_Name, FS_Size, FS_Date, FS_File');
        FqShopFile.SQl.Add('From ' + cWarehouse);
        FqShopFile.SQl.Add('Where FS_ID = 0');
        FqShopFile.Open;

        FqShopFile.Insert;
        FqShopFile.FieldByName('FS_Type').AsInteger := 52;
        FqShopFile.FieldByName('FS_Name').AsString := FqMain.FieldByName('PFA_SecureFileName').AsString;
        FqShopFile.FieldByName('FS_Size').AsInteger := nSize;
        FqShopFile.FieldByName('FS_Date').AsDateTime := nDate;

        {$IFDEF TRADE}
        MS := TMemoryStream.Create;
        try
          MS.Position := 0;
          sp := CreateProc('sp_GetFileFromSecure', False, 3);
          try
            sp.Parameters.ParamByName('@FilePath').Value := ExtractFilePath(cFileName);
            sp.Parameters.ParamByName('@FileName').Value := ExtractFileName(cFileName);
            try
              sp.Open;
              TBlobField(sp.FieldByName('Content')).SaveToStream(MS);
              MS.Position := 0;
              TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromStream(MS);
            except on E:Exception do
              SMessage('Ошибка при вызове sp_GetFileFromSecure:~' + E.Message);
            end;
          finally
            sp.Free;
          end;
        {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).LoadFromFile(cFileName);
        {$ENDIF}
          FqShopFile.Post;

          FqShop.Edit;
          FqShop.FieldByName('PFA_DateInput').AsVariant := FqMain.FieldByName('PFA_DateInput').AsVariant;
          FqShop.FieldByName('PFA_WhoInput').AsVariant := FqMain.FieldByName('PFA_WhoInput').AsVariant;
          FqShop.Post;
        {$IFDEF TRADE}
        finally
          MS.Free;
        end;
        {$ENDIF}
        Inc(nCount);
      end;
      FqMain.Close;

      FqShop.Next;
      if Terminated then Break;
    end;

    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка отправки файлов анкет сотрудников на магазин ...';
  end;

  FqShop.Close;
  FqShop.SQL.Clear;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  Try
    if Result then SaveLog(13, 52, FormStepResult(nCount))
    else SaveLog(12, 52, S);
  except
  end;
end;



// Загрузка (файлов/картинок) для "Заявок на ремонт с ТТ" на офис с мазагина
function TSendDataExchange.LoadDemandRepairFiles: boolean;
var cFileName, cWarehouse, S : string; nCount, ManagerPersonID : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadDemandRepairFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов для "Заявок на ремонт из ТТ"');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;


  FqMain.SQL.Add('Declare @Place int = :Place');
  FqMain.SQL.Add('select DRF_ID, DRF_SecureFileName, DRF_FileLoad '+
                 'from DemandRepairFiles '+
                 'join DemandRepairAssets On DRF_SDoc = DRA_ID and DRF_LSDoc = DRA_ID_ON_SHOP '+
                 'where DRA_Place = @Place and DRF_FileLoad = 0');
  FqMain.Parameters.ParamByName('Place').Value := FPlace;



  nCount := 0;
  S := '';
  Try
    SaveLog(11, 53, 'DemandRepairFiles');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);

    While not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('If EXISTS ( Select 1');
      FqShopFile.SQL.Add('            From sysobjects');
      FqShopFile.SQL.Add('            Where name = ''DemandRepairFiles'' AND type = ''U'')');
      FqShopFile.SQL.Add('begin');

      FqShopFile.SQL.Add('Select ');
      FqShopFile.SQL.Add(' *');
      FqShopFile.SQL.Add('From DemandRepairFiles');
      FqShopFile.SQL.Add(' inner join ' + cWarehouse + ' On FS_Name = DRF_SecureFileName collate Cyrillic_General_CI_AS and');
      FqShopFile.SQL.Add('                                  FS_Type = 53'); //код 53 записан в  \GIT\shopaccount\SQL\TaWarehouse.sql
      FqShopFile.SQL.Add('Where DRF_SecureFileName = :SecureFileName');

      FqShopFile.SQL.Add('end');
      FqShopFile.SQL.Add('else');
      FqShopFile.SQL.Add('Select 1 Where 1 = 0');

      FqShopFile.Parameters.ParamByName('SecureFileName').Value := FqMain.FieldByName('DRF_SecureFileName').AsString;
      FqShopFile.Open;


      If FqShopFile.RecordCount = 1 then
      begin
        cFileName := FDemandRepairFilesPath + FqShopFile.FieldByName('DRF_SecureFileName').AsString;
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FDemandRepairFilesPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('DRF_SecureFileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FDemandRepairFilesPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('DRF_SecureFileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('DRF_FileLoad').AsBoolean := True;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов для "Заявок на ремонт из ТТ" ...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 53, FormStepResult(nCount))
    else SaveLog(12, 53, S);
  except
  end;
end;

//Забираем с ТТ. Заявки на ремонт
// Перенесено из стандартной почты
function TSendDataExchange.LoadDemandRepairAssets: boolean;
var
  cFileName, cWarehouse, S: string;
  nCount, ManagerPersonID: integer;
  nMail: integer;
  nSendName: integer;
begin
  Result:=True;
  if IsSkipAction('LoadDemandRepairAssets') then Exit;
  S := '';
  nSendName := 57;
  nCount := 0;
  DoShowSendDataExchange('Получение данных для "Заявок на ремонт"');
  FqShopFile.Close;
  try

    FqShopFile.SQL.Clear;
    FqShopFile.SQL.Add( 'IF EXISTS'+ #13#10 +
                        '      (SELECT 1'+ #13#10 +
                        '       FROM sysobjects'+ #13#10 +
                        '       WHERE name = ''DemandRepairAssets'' AND type = ''U'')'+ #13#10 +
                        '   BEGIN'+ #13#10 +
                        '      SELECT DRA_ID,'+ #13#10 +
                        '             DRA_ID_ON_SHOP,'+ #13#10 +
                        '             DRA_ID_ON_TRADE,'+ #13#10 +
                        '             DRA_Date,'+ #13#10 +
                        '             DRA_Place,'+ #13#10 +
                        '             DRA_ProblemText,'+ #13#10 +
                        '             DRA_ResolutionText,'+ #13#10 +
                        '             DRA_IsReady,'+ #13#10 +
                        '             DRA_IsCancel,'+ #13#10 +
                        '             DRA_IsAccept,'+ #13#10 +
                        '             DRA_IsEnd,'+ #13#10 +
                        '             DRA_TypeRemont,'+ #13#10 +
                        '             IsNull (p1.Pe_IDBase, DRA_WhoInput) AS DRA_WhoInput,'+ #13#10 +
                        '             DRA_DateInput,'+ #13#10 +
                        '             IsNull (p2.Pe_IDBase, DRA_WhoReady) AS DRA_WhoReady,'+ #13#10 +
                        '             DRA_DateReady,'+ #13#10 +
                        '             DRA_WhoCancel,'+ #13#10 +
                        '             DRA_DateCancel,'+ #13#10 +
                        '             DRA_WhoAccept,'+ #13#10 +
                        '             DRA_DateAccept,'+ #13#10 +
                        '             DRA_WhoEnd,'+ #13#10 +
                        '             DRA_DateEnd,'+ #13#10 +
                        '             IsNull (p3.Pe_IDBase, DRA_WhoExpert) AS DRA_WhoExpert,'+ #13#10 +
                        '             DRA_DateExpert,'+ #13#10 +
                        '             IsNull (p4.Pe_IDBase, DRA_WhoUpdate) AS DRA_WhoUpdate,'+ #13#10 +
                        '             DRA_DateUpdate,'+ #13#10 +
                        '             IsNull (p5.Pe_IDBase, DRA_WhoUpdate2) AS DRA_WhoUpdate2,'+ #13#10 +
                        '             DRA_DateUpdate2,'+ #13#10 +
                        '             DRA_ShopUnload,'+ #13#10 +
                        '             DRA_ForAcceptUnload,'+ #13#10 +
                        '             DRA_SHOP_DR_ID,'+ #13#10 +
                        '             DRA_TRADE_DR_ID,'+ #13#10 +
                        '             DRA_IsUstr,'+ #13#10 +
                        '             DRA_IsUstrNote,'+ #13#10 +
                        '             DRA_Shopload,'+ #13#10 +
                        '             DRA_ExecPlanStartDate,'+ #13#10 +
                        '             DRA_ExecPlanEndDate,'+ #13#10 +
                        '             DRA_ExecFactStartDate,'+ #13#10 +
                        '             DRA_ExecFactEndDate,'+ #13#10 +
                        '             DRA_OrderPlanStartDate,'+ #13#10 +
                        '             DRA_OrderPlanEndDate,'+ #13#10 +
                        '             DRA_TypeRepairAssets'+ #13#10 +
                        '      FROM DemandRepairAssets'+ #13#10 +
                        '           LEFT JOIN VPerson p1 ON p1.Pe_ID = DRA_WhoInput'+ #13#10 +
                        '           LEFT JOIN VPerson p2 ON p2.Pe_ID = DRA_WhoReady'+ #13#10 +
                        '           LEFT JOIN VPerson p3 ON p3.Pe_ID = DRA_WhoExpert'+ #13#10 +
                        '           LEFT JOIN VPerson p4 ON p4.Pe_ID = DRA_WhoUpdate'+ #13#10 +
                        '           LEFT JOIN VPerson p5 ON p5.Pe_ID = DRA_WhoUpdate2'+ #13#10 +
                        '      WHERE    (    DRA_IsReady = ''Y'''+ #13#10 +
                        '                AND DRA_IsEnd = ''N'''+ #13#10 +
                        '                AND DRA_ShopUnload IS NULL)'+ #13#10 +
                        '            OR (DRA_IsEnd = ''Y'' AND DRA_IsUstr > 0 AND DRA_ShopUnload IS NULL)'+ #13#10 +
                        '   END'+ #13#10 +
                        'ELSE'+ #13#10 +
                        '   SELECT 1'+ #13#10 +
                        '   WHERE 1 = 0');
    FqShopFile.Open;
    If FqShopFile.RecordCount <> 0 then
    begin
      SaveLog(11, nSendName, 'DemandRepairAssets');

      // Получаем номер загрузки из LogDataExchange для DRA_ShopUnload на ТТ и DRA_ShopLoad в трейде
      // Берём из только что вставленного лога процей выше через SaveLog
      // Может быть предыдушая (или 0 для первого запуска по ТТ)
      //  если запуск был вручную (не стал менять убирать проверку FService в nSendName, не зная для чего это)
      FqMain.Close;
      FqMain.SQL.Clear;
      FqMain.SQL.Add(' SELECT TOP 1 LDE_ID FROM LogDataExchange WHERE ');
      FqMain.SQL.Add(' LDE_Type = 11 AND LDE_SendName = ' + IntToStr(nSendName) + ' AND LDE_Place = ' +
         IntToStr(FPlace) + ' ORDER BY LDE_ID DESC');
      FqMain.Open;
      nMail := FqMain.FieldByName('LDE_ID').AsInteger;
      FqMain.Close;
      FqMain.SQL.Clear;

      FqShopFile.First;
      While not FqShopFile.Eof do
      begin
        FqMain.Close;
        FqMain.SQL.Clear;
        FqMain.SQL.Add('select * from DemandRepairAssets where ' + 'DRA_PLACE=' + IntToStr(FPlace) +
          ' and DRA_ID_ON_SHOP = ' + IntToStr(FqShopFile.FieldByName('DRA_ID').AsInteger));
        FqMain.Open;
        if FqMain.RecordCount = 0 then
        begin
          FqMain.Insert;
          FqMain.FieldByName('DRA_PLACE').AsInteger := FPlace;
          FqMain.FieldByName('DRA_ID_ON_SHOP').AsInteger :=
            IfVar(FqShopFile.FieldByName('DRA_ID').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_ID').AsInteger);
          FqMain.FieldByName('DRA_WhoInput').AsInteger :=
            IfVar(FqShopFile.FieldByName('DRA_WhoInput').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_WhoInput').AsInteger);
          FqMain.FieldByName('DRA_DateInput').AsDateTime :=
            IfVar(FqShopFile.FieldByName('DRA_DateInput').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_DateInput').AsDateTime);
        end
        else
        begin
          FqMain.Edit;
        end;
         FqMain.FieldByName('DRA_Date').Value :=
            IfVar(FqShopFile.FieldByName('DRA_Date').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_Date').AsDateTime);
          FqMain.FieldByName('DRA_IsReady').Value :=
            IfVar(FqShopFile.FieldByName('DRA_IsReady').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_IsReady').AsString);
          FqMain.FieldByName('DRA_WhoReady').Value :=
            IfVar(FqShopFile.FieldByName('DRA_WhoReady').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_WhoReady').AsInteger);
          FqMain.FieldByName('DRA_DateReady').Value :=
            IfVar(FqShopFile.FieldByName('DRA_DateReady').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_DateReady').AsDateTime);
          FqMain.FieldByName('DRA_ProblemText').Value :=
            IfVar(FqShopFile.FieldByName('DRA_ProblemText').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_ProblemText').AsString);
          FqMain.FieldByName('DRA_SHOP_DR_ID').Value :=
            IfVar(FqShopFile.FieldByName('DRA_SHOP_DR_ID').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_SHOP_DR_ID').AsInteger);
          FqMain.FieldByName('DRA_OrderPlanStartDate').Value :=
            IfVar(FqShopFile.FieldByName('DRA_OrderPlanStartDate').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_OrderPlanStartDate').AsDateTime);
          FqMain.FieldByName('DRA_OrderPlanEndDate').Value :=
            IfVar(FqShopFile.FieldByName('DRA_OrderPlanEndDate').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_OrderPlanEndDate').AsDateTime);
          FqMain.FieldByName('DRA_IsUstr').Value :=
            IfVar(FqShopFile.FieldByName('DRA_IsUstr').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_IsUstr').AsInteger);
          FqMain.FieldByName('DRA_IsUstrNote').Value :=
            IfVar(FqShopFile.FieldByName('DRA_IsUstrNote').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_IsUstrNote').AsString);
          FqMain.FieldByName('DRA_DateExpert').Value :=
            IfVar(FqShopFile.FieldByName('DRA_DateExpert').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_DateExpert').AsDateTime);
          FqMain.FieldByName('DRA_WhoExpert').Value :=
            IfVar(FqShopFile.FieldByName('DRA_WhoExpert').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_WhoExpert').AsInteger);
          FqMain.FieldByName('DRA_WhoUpdate').Value :=
            IfVar(FqShopFile.FieldByName('DRA_WhoUpdate').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_WhoUpdate').AsInteger);
          FqMain.FieldByName('DRA_WhoUpdate2').Value :=
            IfVar(FqShopFile.FieldByName('DRA_WhoUpdate2').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_WhoUpdate2').AsInteger);
          FqMain.FieldByName('DRA_DateUpdate').Value :=
            IfVar(FqShopFile.FieldByName('DRA_DateUpdate').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_DateUpdate').AsDateTime);
          FqMain.FieldByName('DRA_TypeRepairAssets').Value :=
            IfVar(FqShopFile.FieldByName('DRA_TypeRepairAssets').IsNull,
                  null,
                  FqShopFile.FieldByName('DRA_TypeRepairAssets').AsInteger);
          //Логируем порцию загрузки
          FqMain.FieldByName('DRA_Shopload').Value := nMail;
        FqMain.Post;
        FqShopFile.Edit;
        //Логируем порцию выгрузки
        FqShopFile.FieldByName('DRA_ShopUnload').AsInteger := nMail;
        FqShopFile.Post;
        FqShopFile.Next;
        Inc(nCount);
      end;
      Result := True;
    end;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение данных для "Заявок на ремонт" ...';
  end;
  try
    if Result and (S = '') then SaveLog(13, nSendName, FormStepResult(nCount))
    else SaveLog(12, nSendName, S);
  except
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;
end;

// Загрузка анкет (файлов) на офис с мазагина
function TSendDataExchange.LoadPersonFilesAnk: boolean;
var cFileName, cWarehouse, S : string; nCount, ManagerPersonID : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadPersonFilesAnk') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение анкет сотрудников');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;


  FqMain.SQL.Add('Declare @Place int = :Place');
  FqMain.SQL.Add('Select');
  FqMain.SQL.Add(' A.*');
  FqMain.SQL.Add('From PersonFilesAnk A');
  FqMain.SQL.Add(' inner join Person On PFA_SDoc = Pe_ID');
  FqMain.SQL.Add(' inner join Subdivision On Su_ID = Pe_Subdivision');
  FqMain.SQL.Add(' inner join Depart On Su_Depart = Dep_ID');
  FqMain.SQL.Add(' inner join Place On Dep_ID = Pl_Depart and Pl_Type = 2');
  FqMain.SQL.Add('Where PFA_FileLoad = 0 and');
  FqMain.SQL.Add('      PFA_ShopLoad is not null and');
//FqMain.SQL.Add('      PFA_ShopUnLoad is null and'); //<-- вот это условие под вопросом, так как оно дублирует посути PFA_FileLoad = 0, а присваивает его UnloadPersonFilesAnk
  FqMain.SQL.Add('  (   Pl_ID = @Place'+ //это условие тоже нужно дополнить так как появились анкеты с филий.
                 '   or Pl_ID in'+
                 '      (select Pm_place from vPlaceManager '+                      //2. смотрим на каких Place еще этот же менеджер по персоналу
                 '       where pm_person in (select pm_person from vPlaceManager '+ //1. смотрим кто менеджер по персоналу на этом FPlace
                 '                           inner join person on pe_id=pm_person '+
                 '                           inner join Subdivision on su_id=Pe_Subdivision or Pe_Depart=su_depart '+
                 '                           inner join depart on Pe_Depart=dep_id or dep_id=su_depart '+
                 '                           inner join place on Pl_Subdivision=su_id or Pl_Depart=dep_id '+
                 '                           where pl_id=pm_place and pm_place=@Place' + //4. отправка только на мх менеджера
                 '                           ) '+
                 '      ) '+
                 '  )');
  FqMain.Parameters.ParamByName('Place').Value := FPlace;



  nCount := 0;
  S := '';
  Try
    SaveLog(11, 51, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);

    While not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('If EXISTS ( Select 1');
      FqShopFile.SQL.Add('            From sysobjects');
      FqShopFile.SQL.Add('            Where name = ''PersonFilesAnk'' AND type = ''U'')');
      FqShopFile.SQL.Add('begin');

      FqShopFile.SQL.Add('Select ');
      FqShopFile.SQL.Add(' *');
      FqShopFile.SQL.Add('From PersonFilesAnk');
      FqShopFile.SQL.Add(' inner join ' + cWarehouse + ' On FS_Name = PFA_SecureFileName collate Cyrillic_General_CI_AS and');
      FqShopFile.SQL.Add('                                  FS_Type = 52');
      FqShopFile.SQL.Add('Where PFA_SecureFileName = :SecureFileName');

      FqShopFile.SQL.Add('end');
      FqShopFile.SQL.Add('else');
      FqShopFile.SQL.Add('Select 1 Where 1 = 0');

      FqShopFile.Parameters.ParamByName('SecureFileName').Value := FqMain.FieldByName('PFA_SecureFileName').AsString;
      FqShopFile.Open;

      If FqShopFile.RecordCount = 1 then
      begin
        cFileName := FPersonFilesAnkPath + FqShopFile.FieldByName('PFA_SecureFileName').AsString;
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FPersonFilesAnkPath,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('PFA_SecureFileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FPersonFilesAnkPath,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqShopFile.FieldByName('PFA_SecureFileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('PFA_FileLoad').AsBoolean := True;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к анкетам сотрудников с магазина ...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 51, FormStepResult(nCount))
    else SaveLog(12, 51, S);
  except
  end;
end;

function TSendDataExchange.TakeActDamageTovarListPhoto: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('TakeActDamageTovarListPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Приём фото товаров в актах повреждения');

  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(	' SELECT ADTLP.*  '+
                  '   FROM ActDamageTovarListPhoto ADTLP  '+
                  '        INNER JOIN ActDamageTovarList ON ADTL_ID = ADTLP_SDoc  '+
                  '        INNER JOIN ActDamageTovar ON ADT_ID = ADTL_Sdoc  '+
                  '   WHERE ADTLP_FileLoad = 0 AND ADT_Place = '+IntToStr(FPlace));
  nCount := 0; S := '';
  try
    SaveLog(11, 54, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File, ADTLP_SmallImage from ActDamageTovarListPhoto '+
                         'join ' + cWarehouse +' on ADTLP_FileName = FS_Name '+
                         ' where ADTLP_FileName = ''' + FqMain.FieldByName('ADTLP_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FActDamageTovarListPhoto + FqMain.FieldByName('ADTLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FActDamageTovarListPhoto,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ADTLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FActDamageTovarListPhoto,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ADTLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('ADTLP_SmallImage').Value := FqShopFile.FieldByName('ADTLP_SmallImage').Value;
        FqMain.FieldByName('ADTLP_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов фото товаров в актах повреждения...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 54, FormStepResult(nCount))
    else SaveLog(12, 54, S);
  except
  end;
end;

function TSendDataExchange.TakeActReceptSupplierFile: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('TakeActReceptSupplierFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Приём Файлов актов несоответствия');

  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(	'SELECT ARSF.*'+ #13#10 +
                  'FROM ActReceptSupplierFile ARSF'+ #13#10 +
                  '     INNER JOIN ActReceptSupplier ON ARS_ID = ARSF_SDoc'+ #13#10 +
                  'WHERE ARSF_FileLoad = 0 AND ARS_Place = '+IntToStr(FPlace));
  nCount := 0; S := '';
  try
    SaveLog(11, 54, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ActReceptSupplierFile '+
                         'join ' + cWarehouse +' on FS_Type = 55 and ARSF_FileName = FS_Name '+
                         ' where ARSF_FileName = ''' + FqMain.FieldByName('ARSF_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FActReceptSupplierFile + FqMain.FieldByName('ARSF_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FActReceptSupplierFile,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSF_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FActReceptSupplierFile,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSF_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('ARSF_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов фото товаров в актах повреждения...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 54, FormStepResult(nCount))
    else SaveLog(12, 54, S);
  except
  end;
end;

function TSendDataExchange.TakeActReceptSupplierEDIFile: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('TakeActReceptSupplierEDIFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Приём Файлов актов несоответствия EDI');

  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(	'SELECT ARSF.*'+ #13#10 +
                  'FROM ActReceptSupplierEDIFile ARSF'+ #13#10 +
                  '     INNER JOIN ActReceptSupplierEDI ON ARS_ID = ARSF_SDoc'+ #13#10 +
                  'WHERE ARSF_FileLoad = 0 AND ARS_Place = '+IntToStr(FPlace));
  nCount := 0; S := '';
  try
    SaveLog(11, 54, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ActReceptSupplierFile '+
                         'join ' + cWarehouse +' on FS_Type = 55 and ARSF_FileName = FS_Name '+
                         ' where ARSF_FileName = ''' + FqMain.FieldByName('ARSF_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FActReceptSupplierFile + FqMain.FieldByName('ARSF_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FActReceptSupplierFile,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSF_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FActReceptSupplierFile,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('ARSF_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('ARSF_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов фото товаров в актах повреждения EDI...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 54, FormStepResult(nCount))
    else SaveLog(12, 54, S);
  except
  end;
end;


function TSendDataExchange.TakeDocDemandReclamationPhoto: boolean;
  var cFileName, cWarehouse, S : string; nCount, nSize : integer; nDate : TDateTime;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('TakeDocDemandReclamationPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Приём фото товаров в актах повреждения');

  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(	' SELECT DDRLP.*  '+
                  '   FROM DocDemandReclamationListPhoto DDRLP  '+
                  '        INNER JOIN DocDemandReclamationList ON DDRL_Id = DDRLP_SDoc  '+
                  '        INNER JOIN DocDemandReclamation ON DDRL_Sdoc = DDR_Id  '+
                  '   WHERE DDRLP_FileLoad = 0 AND DDR_Place = '+IntToStr(FPlace));
  nCount := 0; S := '';
  try
    SaveLog(11, 55, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File, DDRLP_SmallImage from DocDemandReclamationListPhoto '+
                         'join ' + cWarehouse +' on DDRLP_FileName = FS_Name '+
                         ' where DDRLP_FileName = ''' + FqMain.FieldByName('DDRLP_FileName').AsString+'''');
      FqShopFile.Open;
      cFileName := FDocDemandReclamationTovarListPhoto + FqMain.FieldByName('DDRLP_FileName').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FDocDemandReclamationTovarListPhoto,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('DDRLP_FileName').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FDocDemandReclamationTovarListPhoto,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('DDRLP_FileName').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('DDRLP_SmallImage').Value := FqShopFile.FieldByName('DDRLP_SmallImage').Value;
        FqMain.FieldByName('DDRLP_FileLoad').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов фото товаров в актах повреждения...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 55, FormStepResult(nCount))
    else SaveLog(12, 55, S);
  except
  end;
end;


function TSendDataExchange.LoadPersonFiles: boolean;
var cFileName, cWarehouse, S, cFilterName : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadPersonFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов сотрудника');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Text:='Select * from PersonFiles ' +
                   'inner join Place on Pl_ID = ' + IntToStr(FPlace) +
                   '          and Pl_Supermarcet = 1 ' +
                   'Where PFS_ShopLoad = 0 and PFS_Office = 0 ';

  nCount := 0; S := '';
  try
    SaveLog(11, 24, 'PersonFiles');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    cFilterName:='';
    DoShowSendDataExchange('', 0, 1);
    while not FqMain.Eof do
    begin
     cFilterName:=cFilterName+QuotedStr(FqMain.FieldByName('PFS_SecureFileName').AsString);
     FqMain.Next;
     if not FqMain.Eof then cFilterName:=cFilterName+',';
     if Terminated then Break;
    end;
    if cFilterName<>'' then
    begin
      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select PFS_SecureFileName, FS_File from PersonFiles '+
        'Inner join ' + cWarehouse + ' ON FS_Type = 12 and PFS_SecureFileName = FS_Name collate Cyrillic_General_CI_AS '+
        'where PFS_IsSend = 0 and PFS_SecureFilename in ('+cFilterName+')');
      FqShopFile.Open;
      if FqShopFile.RecordCount > 0 then
      begin
        nCount:=1;
        while not FqShopFile.Eof do
        begin
          cFileName := FPersonFiles + FqShopFile.FieldByName('PFS_SecureFileName').AsString;
          {$IFDEF TRADE}
          Q := CreateQuery(False);
          MS := TMemoryStream.Create;
          try
            TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
            MS.Position := 0;

            // Если файл уже есть, то его сперва надо удалить!
            if GetFileExists(cFileName) then
              // удалить файл!
            begin
              Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
              Q.Parameters.ParamByName('Folder').Value :=
                StringReplace(FPersonFiles,'\\dom.loc\dfs\secure\','',[]);
              Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('PFS_SecureFileName').AsString;
              Q.Open;
            end;

            Q.Close;
            Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FPersonFiles,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('PFS_SecureFileName').AsString;
            Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
            Q.Open;
          finally
            MS.Free;
            Q.Close; Q.Free;
          end;
          {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
          {$ENDIF}
          FqMain.Locate('PFS_SecureFileName',FqShopFile.FieldByName('PFS_SecureFileName').AsString,[]);
          FqMain.Edit;
          FqMain.FieldByName('PFS_ShopLoad').AsBoolean:=True;
          FqMain.Post;
          FqShopFile.Next;
          inc(nCount);
        end;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов сотрудников...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 24, FormStepResult(nCount))
    else SaveLog(12, 24, S);
  except
  end;
end;

function TSendDataExchange.LoadMCRFiles: boolean;
var cFileName, cWarehouse, S, cFilterName : string; nCount : integer;
    Q : TADOQuery;
    MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadMCRFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение файлов мониторинга цен конкурентов');
  FqMain.Close;
  FqShop.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Text:='Select MCRF_FileName, MCRF_SFileName, MCRF_LoadFile from MonitoringCompetitorRoznFiles ' +
                   'inner join MonitoringCompetitorRozn on MCR_ID = MCRF_SDoc '+
                   'and MCR_Place = ' + IntToStr(FPlace) +
                   'Where MCRF_LoadFile = 0 ';
  nCount := 0; S := '';
  try
    SaveLog(11, 30, 'MCRFiles');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    cFilterName:='';
    DoShowSendDataExchange('', 0, 1);
    while not FqMain.Eof do
    begin
     cFilterName:=cFilterName+QuotedStr(FqMain.FieldByName('MCRF_FileName').AsString);
     FqMain.Next;
     if not FqMain.Eof then cFilterName:=cFilterName+',';
     if Terminated then Break;
    end;
    if cFilterName<>'' then
    begin
      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select MCRF_FileName, FS_File from MonitoringCompetitorRoznFiles '+
        'Inner join ' + cWarehouse + ' ON FS_Type = 14 and MCRF_FileName = FS_Name '+
        'where MCRF_Sent is not null and MCRF_FileName in ('+cFilterName+')');
      FqShopFile.Open;
      if FqShopFile.RecordCount > 0 then
      begin
        nCount:=1;
        while not FqShopFile.Eof do
        begin
          FqMain.Locate('MCRF_FileName',FqShopFile.FieldByName('MCRF_FileName').AsString,[]);
          cFileName := FMCRFiles + FqMain.FieldByName('MCRF_SFileName').AsString;
          {$IFDEF TRADE}
          Q := CreateQuery(False);
          MS := TMemoryStream.Create;
          try
            TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
            MS.Position := 0;

            // Если файл уже есть, то его сперва надо удалить!
            if GetFileExists(cFileName) then
              // удалить файл!
            begin
              Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
              Q.Parameters.ParamByName('Folder').Value :=
                StringReplace(FMCRFiles,'\\dom.loc\dfs\secure\','',[]);
              Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MCRF_SFileName').AsString;
              Q.Open;
            end;

            Q.Close;
            Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FMCRFiles,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MCRF_SFileName').AsString;
            Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
            Q.Open;
          finally
            MS.Free;
            Q.Close; Q.Free;
          end;
          {$ELSE}
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
          {$ENDIF}
          FqMain.Edit;
          FqMain.FieldByName('MCRF_LoadFile').AsBoolean:=True;
          FqMain.Post;
          FqShopFile.Next;
          inc(nCount);
        end;
      end;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов мониторинга цен конкурентов...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 30, FormStepResult(nCount))
    else SaveLog(12, 30, S);
  except
  end;
end;

function TSendDataExchange.DelLayoutPhotoDoc : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelLayoutPhotoDoc') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов Выкладки DOC');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select LOPD_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from LayoutPhotoDoc ' +
    'left outer join ' + cWarehouse + ' on FS_Type = 11 and FS_Name = LOPD_FileName ' +
    'where LOPD_DateInput < Cast(DateAdd(d, -14, GetDate()) as Date) ' +
    'order by LOPD_ID');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 27, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if not FqShop.FieldByName('FS_ID').IsNull then
        FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);

//    FconShop.Execute('delete LayoutPhotoDoc where LOPD_ID = ' + FqShop.FieldByName('LOPD_ID').AsString);
      Inc(nCount);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов Выкладки DOC...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 27, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 27, S);
  except
  end;
end;

function TSendDataExchange.DelDocInFile : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelDocInFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов Приходных документов');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select DIF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from DocIn ' +
    '  inner join DocInFile on DIF_SDoc = DI_ID '+
    '  join ' + cWarehouse + ' on FS_Type = 20 and FS_Name = DIF_Name ' +
    'where DI_DateMove < dateadd(month,-3,getdate()) and DI_IsMove = ''Y'' ');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 47, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if not FqShop.FieldByName('FS_ID').IsNull then
        FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);

    //  FconShop.Execute('delete DocInFile where DIF_ID = ' + FqShop.FieldByName('DIF_ID').AsString);
      Inc(nCount);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов Приходных документов...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 47, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 47, S);
  except
  end;
end;

function TSendDataExchange.DelLayoutPhoto : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelLayoutPhoto') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов Выкладки');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select LOP_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from LayoutPhoto ' +
    'left outer join ' + cWarehouse + ' on FS_Type = 9 and FS_Name = LOP_FileName ' +
    'where LOP_Date < Cast(DateAdd(m, -6, GetDate()) as Date) ' +
    'order by LOP_ID');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 37, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if not FqShop.FieldByName('FS_ID').IsNull then
        FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);

      FconShop.Execute('delete LayoutPhoto where LOP_ID = ' + FqShop.FieldByName('LOP_ID').AsString);
      Inc(nCount);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов Выкладки...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 37, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 37, S);
  except
  end;
end;

function TSendDataExchange.DelOfficeMemo : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelOfficeMemo') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление служебок по уволенным сотрудникам');
  FqMain.SQL.Clear;
  FqMain.SQL.Add('declare @nSubdivision int ' +
    'set @nSubdivision = ' + IntToStr(FSubdivision) +
    ' select T1.OM_ID, T1.OM_IdOffice from OPENROWSET(''SQLNCLI'', ''SERVER=' + FIPAdresShop +
    '  ;UID=sa;PWD=' + FPasswordShop + ';DATABASE=' + FBDNameShop + ''', ' +
    '  ''select OM_ID, OM_IdOffice from OfficeMemo'') as T1 ' +
    'left outer join (select distinct OM_ID from ( ' +
    '	select OM_ID from OfficeMemo where ' +
    '      OM_WhoInput in (select Pe_ID from Person where Pe_Subdivision = @nSubdivision) ' +
    '    union All ' +
    '	select OML_Sdoc from OfficeMemoList where ' +
    '      OML_WhoInput in (select Pe_ID from Person where Pe_Subdivision = @nSubdivision) ' +
    '    union All ' +
    '	select OML_Sdoc from OfficeMemoList where ' +
    '      OML_Whom in (select Pe_ID from Person where Pe_Subdivision = @nSubdivision) ' +
    '    union All ' +
    '	select OM_ID from OfficeMemo where ' +
    '      OM_WhoInput in (select PS_Person from PersonStaff where PS_Subdivision = @nSubdivision and ' +
    '	  PS_DateEnd >= DateAdd(m, -2, Cast(GetDate() as Date))) ' +
    '    union All ' +
    '	select OML_Sdoc from OfficeMemoList where ' +
    '      OML_WhoInput in (select PS_Person from PersonStaff where PS_Subdivision = @nSubdivision and ' +
    '	  PS_DateEnd >= DateAdd(m, -2, Cast(GetDate() as Date))) ' +
    '    union All ' +
    '	select OML_Sdoc from OfficeMemoList where ' +
    '      OML_Whom in (select PS_Person from PersonStaff where PS_Subdivision = @nSubdivision and ' +
    '	  PS_DateEnd >= DateAdd(m, -2, Cast(GetDate() as Date)))) as T1) as T2 on T1.OM_IdOffice = T2.OM_ID ' +
    'where T2.OM_ID is Null and T1.OM_IdOffice is not Null ' +
    'order by T1.OM_ID');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 28, '');
    FqMain.Open;
    DoShowSendDataExchange('', FqMain.RecordCount);
    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShop.SQL.Clear;
      FqShop.SQL.Add('select OMF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from OfficeMemoFile ' +
        'left outer join ' + cWarehouse + ' on FS_Type = 1 and FS_Name = OMF_File ' +
        'where OMF_SdocType = 0 and OMF_Sdoc =  ' + FqMain.FieldByName('OM_ID').AsString +
        ' union All ' +
        'select OMF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from OfficeMemoList ' +
        '  inner join OfficeMemoFile on OMF_SDoc = OML_ID and OMF_SdocType = 1 ' +
        '  left outer join Warehouse.dbo.FileStorage on FS_Type = 1 and FS_Name = OMF_File ' +
        '  where OML_SDoc = ' + FqMain.FieldByName('OM_ID').AsString +
        ' order by OMF_ID, FS_ID');
      FqShop.Open;
      while not FqShop.Eof do
      begin
        if not FqShop.FieldByName('FS_ID').IsNull then
        begin
          FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);
          Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);
        end;
        FconShop.Execute('delete OfficeMemoFile where OMF_ID = ' + FqShop.FieldByName('OMF_ID').AsString);
        FqShop.Next;
      end;
      FqShop.Close;

      FqShop.SQL.Clear;
      FqShop.SQL.Add('select OML_ID from OfficeMemoList ' +
        'where OML_SDoc = ' + FqMain.FieldByName('OM_ID').AsString +
        'order by OML_ID');
      FqShop.Open;
      while not FqShop.Eof do
      begin
        FconShop.Execute('delete OfficeMemoList where OML_ID = ' + FqShop.FieldByName('OML_ID').AsString);
        FqShop.Next;
      end;
      FqShop.Close;

      FconShop.Execute('delete OfficeMemo where OM_ID = ' + FqMain.FieldByName('OM_ID').AsString);
      Inc(nCount);
      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления служебок...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 28, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 28, S);
  except
  end;
end;

function TSendDataExchange.DelOfficeMemoFile : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelOfficeMemoFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов по старым служебкам');
  FqShop.SQL.Clear;
  FqShop.SQL.Add( ' Select OM_Id as T_OMID ' + #13#10 +
                  ' into #temp ' + #13#10 +
                  ' from OfficeMemo ' + #13#10 +
                  '   inner join OfficeMemoList on OM_Id = OML_Sdoc ' + #13#10 +
                  ' where OML_IsTurn = ''N'' ' + #13#10 +
                  ' group by OM_Id ' + #13#10 +
                  ' union all ' + #13#10 +
                  ' Select distinct OML_Sdoc ' + #13#10 +
                  ' from OfficeMemoList ' + #13#10 +
                  ' where OML_DateTurn >= DateAdd(month, -10, Cast(GetDate() as Date)) ' + #13#10 +
                  ' union all ' + #13#10 +
                  ' select OM_Id ' + #13#10 +
                  ' from OfficeMemo ' + #13#10 +
                  '   left outer join OfficeMemoList on OM_Id = OML_Sdoc ' + #13#10 +
                  ' where OML_Id is null ' + #13#10 +
                  ' Select OMF_Id  ' + #13#10 +
                  ' from (select OM_Id  ' + #13#10 +
                  '       from OfficeMemo ' + #13#10 +
                  '         left join #temp on T_OMID = OM_ID ' + #13#10 +
                  '       where T_OMID is null) OM ' + #13#10 +
                  '   inner join OfficeMemoFile on (OMF_SdocType = 0 and OMF_Sdoc = OM_ID) ' + #13#10 +
                  ' union all ' + #13#10 +
                  ' Select OMF_Id  ' + #13#10 +
                  ' from (select OM_Id  ' + #13#10 +
                  '       from OfficeMemo ' + #13#10 +
                  '         left join #temp on T_OMID = OM_ID ' + #13#10 +
                  '       where T_OMID is null) OM ' + #13#10 +
                  '   inner join OfficeMemoList on OM_Id = OML_Sdoc ' + #13#10 +
                  '   inner join OfficeMemoFile on (OMF_SdocType = 1 and OMF_Sdoc = OML_ID)  ' + #13#10 +
                  ' drop table #temp'
);

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 38, '');
    FqShop.Open;
    SaveLog(11, 38, 'Кол-во записей: '+IntToStr(FqShop.RecordCount));
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select OMF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from OfficeMemoFile ' +
        '  left outer join ' + cWarehouse + ' on FS_Type = 1 and FS_Name = OMF_File ' +
        '  where OMF_Id = ' + FqShop.FieldByName('OMF_Id').AsString);
      FqShopFile.Open;
      if not FqShopFile.IsEmpty then
      begin
        if not FqShopFile.FieldByName('FS_ID').IsNull then
        begin
          FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShopFile.FieldByName('FS_ID').AsString);
          Inc(nSize, FqShopFile.FieldByName('FS_Size').AsInteger);
        end;
        FconShop.Execute('delete OfficeMemoFile where OMF_ID = ' + FqShopFile.FieldByName('OMF_ID').AsString);
      end;
      FqShopFile.Close;

      Inc(nCount);
      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления служебок...';
  end;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 38, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 38, S);
  except
  end;
end;

function TSendDataExchange.DelOfficeMemoFileOld : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelOfficeMemoFileOld') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов из служебок старше 1.5 лет');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select FS_Id, DATALENGTH(FS_File) as FS_Size from ' + cWarehouse +
    ' where FS_Type = 1 and FS_DateInput < DATEADD(MONTH, -18, GetDate()) ' +
    'order by FS_Type');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 44, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      Inc(nCount);
      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов служебок...';
  end;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 44, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 44, S);
  except
  end;
end;

function TSendDataExchange.DelMCRFiles : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelMCRFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов Мониторинга цен конкурентов');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select MCRF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from MonitoringCompetitorRoznFiles ' +
    'left join MonitoringCompetitorRozn on MCR_ID=MCRF_SDoc '+
    'inner join ' + cWarehouse + ' on FS_Type = 14 and FS_Name = MCRF_FileName ' +
    'where (MCR_Signed=1 and MCRF_Sent is not null and datediff(day,MCR_DateSigned,GetDate())>14) ' + //22951_сз216084_Зосименко
    '   or (MCR_Signed=0 and datediff(day,case when MCR_DateInput<MCR_Date '+
    '                                          then MCR_Date '+
    '                                          else MCR_DateInput end, GetDate())>14) '+ //22951_сз216084_Зосименко
    'order by MCRF_ID');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 31, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if not FqShop.FieldByName('FS_ID').IsNull then
        FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);

      Inc(nCount);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов Мониторинга цен конкурентов...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 31, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 31, S);
  except
  end;
end;


//-----------------------------
function TSendDataExchange.DelDismissedEmployeeFile : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelDismissedEmployeeFile') then Exit;

  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов по уволенным сотрудникам');

  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('declare @CurrDate smalldatetime = getdate()');
  FqShop.SQL.Add('select count(FS_ID) as Qty, sum(FS_Size) as Mb  from warehouse.dbo.FileStorage');
  FqShop.SQL.Add('join PersonFiles on PFS_SecureFileName = FS_Name and FS_Type = 12 ');
  FqShop.SQL.Add('where PFS_LSDoc in');
  FqShop.SQL.Add('(select Pe_ID from (');
  FqShop.SQL.Add('select Pe_ID, row_number() over (partition by PS_Person order by PS_Date desc) as rn, PS_DateSigned from Person');
  FqShop.SQL.Add('join PersonStaff on PS_Person = pe_id');
  FqShop.SQL.Add('where PS_IsTurn = ''Y'' and Pe_Discharge is not null and Pe_Staff is null) tt');
  FqShop.SQL.Add('where rn = 1 and datediff(day, isnull(PS_DateSigned, @CurrDate), @CurrDate)>31)');
  FqShop.Open;
  nCount := FqShop.FieldByName('Qty').asInteger;
  nSize := FqShop.FieldByName('Mb').asInteger;
  FqShop.Close;
  S := '';

  try
    SaveLog(11, 39, '');
    SaveLog(13, 39, Format('К удалению - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]));
    if nCount>0
    then FconShop.Execute(
            'declare @CurrDate smalldatetime = getdate() '+
            'delete from '+cWarehouse+' where FS_ID in ( ' +
            'select FS_ID from '+cWarehouse+' ' +
            '	join PersonFiles on PFS_SecureFileName = FS_Name and FS_Type = 12 ' +
            '	where PFS_LSDoc in ' +
            '	(select Pe_ID from ( ' +
            'select Pe_ID, row_number() over (partition by PS_Person order by PS_Date desc) as rn, PS_DateSigned from Person ' +
            'join PersonStaff on PS_Person = pe_id ' +
            'where PS_IsTurn = ''Y'' and Pe_Discharge is not null and Pe_Staff is null) tt ' +
            'where rn = 1 and datediff(day, isnull(PS_DateSigned, @CurrDate), @CurrDate)>31) )'
        );

    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов по уволенным сотрудникам...';
  end;
  try
    if Result and (nCount>0)
    then SaveLog(13, 39, 'Удалено.');
    if S<>''
    then SaveLog(12, 39, S);
  except
  end;
end;

function TSendDataExchange.DelInventSheetFile : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelInventSheetFile') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов прикрепленных к инвентаризациям');

  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add('declare @CurrDate smalldatetime = DateAdd(day,-15,Cast(GetDate () as Date))');
  FqShop.SQL.Add('select count(FS_ID) as Qty, sum(FS_Size) as Mb  from warehouse.dbo.FileStorage');
  FqShop.SQL.Add('inner join InvShitFiles on FS_Name = ISF_Name and FS_Type = 18 ');
  FqShop.SQL.Add('where cast(FS_DateInput as Date) <@CurrDate');

  FqShop.Open;
  nCount := FqShop.FieldByName('Qty').asInteger;
  nSize := FqShop.FieldByName('Mb').asInteger;
  FqShop.Close;
  S := '';

  try
    SaveLog(11, 39, '');
    SaveLog(13, 39, Format('К удалению - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]));
    if nCount>0
    then FconShop.Execute(
            'declare @CurrDate smalldatetime = DateAdd(day,-15,Cast(GetDate () as Date)) '+
            'delete from '+cWarehouse+' where FS_ID in ( ' +
            'select FS_ID from '+cWarehouse+' ' +
            '	inner join InvShitFiles on FS_Name = ISF_Name and FS_Type = 18' +
            '	where cast(FS_DateInput as Date) <@CurrDate ) '
        );

    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов прикрепленных к инвентаризациям...';
  end;
  try
    if Result and (nCount>0)
    then SaveLog(13, 39, 'Удалено.');
    if S<>''
    then SaveLog(12, 39, S);
  except
  end;
end;


function TSendDataExchange.DelDocRROFiles : boolean;
  var cWarehouse, S : string; nCount, nSize : integer;
begin
  Result:=True;
  if IsSkipAction('DelDocRROFiles') then Exit;
  if FWarehouse = '' then Exit else Result := False;
  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Удаление файлов отчетов по РРО');
  FqShop.SQL.Clear;
  FqShop.SQL.Add('select DRF_ID, FS_ID, DATALENGTH(FS_File) as FS_Size from DocRROFiles ' +
    'inner join ' + cWarehouse + ' on FS_Type = 16 and FS_Name = DRF_SecureFileName ' +
    'where DRF_DateInput < Cast(DateAdd(m, -2, GetDate()) as Date) ' +
    'order by DRF_ID');

  nCount := 0; nSize := 0; S := '';
  try
    SaveLog(11, 43, '');
    FqShop.Open;
    DoShowSendDataExchange('', FqShop.RecordCount);
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if not FqShop.FieldByName('FS_ID').IsNull then
        FconShop.Execute('delete ' + cWarehouse + ' where FS_ID = ' + FqShop.FieldByName('FS_ID').AsString);

//      FconShop.Execute('delete DocRROFiles where DRF_ID = ' + FqShop.FieldByName('DRF_ID').AsString);
      Inc(nCount);
      Inc(nSize, FqShop.FieldByName('FS_Size').AsInteger);

      FqShop.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка удаления файлов отчетов по РРО...';
  end;
  FqShop.Close;
  FqShop.SQL.Clear;

  try
    if Result then SaveLog(13, 43, Format('Удалено - %u записей. %g mb.', [nCount, Round4(nSize / (1024 * 1024))]))
    else SaveLog(12, 43, S);
  except
  end;
end;

function TSendDataExchange.LoadShopPersonPass: boolean;
  var cFileName, cWarehouse,cFile, S : string; nCount, i : integer;
begin
  Result:=True;
  if IsSkipAction('LoadShopPersonPass') then Exit;
  Result := False;
  DoShowSendDataExchange('Сравнение посещаемости по сотрудникам');
  /////////////////////////////////
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('select PPa_ID, PPa_Person, PPa_DateTime, PPa_Type, ' +
    'PPa_OverTime, PPa_OverTimeAdd, cast(PPa_DateTime as Date) as PPa_Date ' +
    'from PersonPass ' +
    'where PPa_DateTime >= DateAdd(Day, -15, GetDate()) order by PPa_ID');

  FqShop.Close;
  FqShop.SQL.Clear;
  if not FSendSupplier then
    FqShop.SQL.Add('select PPa_ID, PPa_Person as PPa_Person, PPa_DateTime, PPa_Type, ' +
    'PPa_OverTime, PPa_OverTimeAdd, cast(PPa_DateTime as Date) as PPa_Date ' +
    'from PersonPass ' +
    'where PPa_DateTime >= DateAdd(Day, -10, GetDate()) and PPa_ShopUnload is not Null order by PPa_ID')
  else FqShop.SQL.Add('select PPa_ID, P1.Pe_IDBase as PPa_Person, PPa_DateTime, PPa_Type, ' +
    'PPa_OverTime, PPa_OverTimeAdd, cast(PPa_DateTime as Date) as PPa_Date ' +
    'from PersonPass inner join VPerson as P1 on PPa_Person = P1.Pe_ID and P1.Pe_IDBase <> 0 ' +
    'where PPa_DateTime >= DateAdd(Day, -10, GetDate()) and PPa_ShopUnload is not Null order by PPa_ID');

  try
     /////////////////////////////////
    FqShop.Open;
    FqMain.Open;
    /////////////////////////////////
    DoShowSendDataExchange('', 0, FqShop.RecordCount);
    nCount := 0; S := '';
    SaveLog(11, 45, '');
   // FqMain.Open;
    while not FqShop.Eof do
    begin
      DoShowSendDataExchange('', 0, FqShop.RecNo);

      if FqMain.Locate('PPa_Person;PPa_Type;PPa_Date', VarArrayOf([FqShop.FieldByName('PPa_Person').AsInteger,
        FqShop.FieldByName('PPa_Type').AsBoolean, FqShop.FieldByName('PPa_Date').AsDateTime]), []) then
      begin
        try
          if (FormatDateTime('YYYYMMDD HH:NN:SS', FqShop.FieldByName('PPa_DateTime').AsDateTime) <>
              FormatDateTime('YYYYMMDD HH:NN:SS', FqMain.FieldByName('PPa_DateTime').AsDateTime)) or
             (FqShop.FieldByName('PPa_OverTime').AsString <> FqMain.FieldByName('PPa_OverTime').AsString) or
             (FqShop.FieldByName('PPa_OverTimeAdd').AsString <> FqMain.FieldByName('PPa_OverTimeAdd').AsString) then
          begin
            FconMain.Execute('update PersonPass set PPa_DateTime = ' + QuotedStr(FormatDateTime('YYYYMMDD HH:MM:SS.ZZZ', FqShop.FieldByName('PPa_DateTime').AsDateTime)) +
                                                 ', PPa_OverTime = ' + BoolToBit(FqShop.FieldByName('PPa_OverTime').AsBoolean) +
                                                 ', PPa_OverTimeAdd = ' + FqShop.FieldByName('PPa_OverTimeAdd').AsString +
                             ' where PPa_Person = ' + FqShop.FieldByName('PPa_Person').AsString +
                             '   and PPa_Type = ' +  BoolToBit(FqShop.FieldByName('PPa_Type').AsBoolean) +
                             '   and PPa_Date = ' + QuotedStr(FormatDateTime('YYYYMMDD', FqShop.FieldByName('PPa_Date').AsDateTime)));
            Inc(nCount);
          end;

        except  on E: Exception do S := E.Message;
        end;

        if Terminated then Break;
      end else
        try
          FconMain.Execute('insert into PersonPass(PPa_Person, PPa_DateTime, PPa_Type, PPa_OverTime, PPa_OverTimeAdd) '+
                           ' Values('+ FqShop.FieldByName('PPa_Person').AsString + ','+
                                       QuotedStr(FormatDateTime('YYYYMMDD HH:MM:SS.ZZZ', FqShop.FieldByName('PPa_DateTime').AsDateTime)) + ','+
                                       BoolToBit(FqShop.FieldByName('PPa_Type').AsBoolean) + ','+
                                       BoolToBit(FqShop.FieldByName('PPa_OverTime').AsBoolean) + ','+
                                       FqShop.FieldByName('PPa_OverTimeAdd').AsString + ')');

          Inc(nCount);
        except  on E: Exception do S := E.Message;
        end;

      FqShop.Next;
   end;
   Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка сравнения посещаемости по сотрудникам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 45, FormStepResult(nCount))
    else SaveLog(12, 45, S);
  except
  end;
end;

function TSendDataExchange.LoadOfficeMemo: boolean;
var
  S: String;
  fTimeOut : Integer;
begin
  try
    Result:=True;
    if IsSkipAction('LoadOfficeMemo') then Exit;
    Result := False;

    DoShowSendDataExchange('Получение СЗ с магазина');
    fTimeOut := FqMain.CommandTimeout;
    FqMain.CommandTimeout:= 60*15;
    FqMain.Close;
    FqMain.SQL.Clear;
    FqMain.SQL.Add('exec LoadOfficeMemoShop :Place ');
    FqMain.Parameters.ParamByName('Place').Value:=FPlace;

    try
      SaveLog(11, 48, 'Получение СЗ с магазина');
      FqMain.Open;

      Result := True;
    except
      on E: EDatabaseError do S := E.Message;
      on E: Exception do S := E.Message;
      else S := 'Ошибка получение СЗ с магазина...';
    end;
    FqMain.Close;
    FqMain.SQL.Clear;

  finally
    FqMain.CommandTimeout := fTimeOut;

    if Result then
      SaveLog(13, 48, FormStepResult(1))
    else
      SaveLog(12, 48, S);
  end;
end;

function TSendDataExchange.LoadMeterLeaseActFiles: boolean;
  var cFileName, cWarehouse, cFile, S : string; nCount, i : integer;
      Q : TADOQuery;
      MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadMeterLeaseActFiles') then Exit;
  if FWarehouse = '' then
    Exit
  else
    Result := False;

  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Фото показаний счетчиков');
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add('Select MLF_ID, MLF_SDoc, MLF_Name, MLF_Loaded ' +
    ' from ArendaOffice.dbo.MeterLeaseActFiles ' +
    '  inner join ArendaOffice.dbo.MeterLeaseAction on MLA_ID = MLF_SDoc '+
    '  inner join ArendaOffice.dbo.VMeterLease on ML_ID = MLA_SDoc and ML_Place = '+IntToStr(FPlace)+
    ' where MLF_Loaded = 0 and MLF_ShopLoad is not Null ' +
    ' order by MLF_ID');

  nCount := 0; S := '';
  try
    SaveLog(11, 46, '');
    FqMain.Open;

    while not FqMain.Eof do
    begin
      DoShowSendDataExchange('', 0, FqMain.RecNo);

      FqShopFile.Close;
      FqShopFile.SQL.Clear;
      FqShopFile.SQL.Add('select FS_File from ' + cWarehouse +
                         ' where FS_Type = 21 and FS_Name = ''' +
                         FqMain.FieldByName('MLF_Name').AsString+'''');
      FqShopFile.Open;

      cFileName := FMeterLeaseActFiles + FqMain.FieldByName('MLF_Name').AsString;
      if FqShopFile.RecordCount = 1 then
      begin
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FMeterLeaseActFiles,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MLF_Name').AsString;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FMeterLeaseActFiles,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := FqMain.FieldByName('MLF_Name').AsString;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShopFile.FieldByName('FS_File')).SaveToFile(cFileName);
        {$ENDIF}
        FqMain.Edit;
        FqMain.FieldByName('MLF_Loaded').AsBoolean := true;
        FqMain.Post;
        Inc(nCount);
      end;
      FqShopFile.Close;

      FqMain.Next;
      if Terminated then Break;
    end;
    Result := True;
  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов к выкладкам...';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then SaveLog(13, 46, FormStepResult(nCount))
    else SaveLog(12, 46, S);
  except
  end;
end;

// Загрузка прикрепленных файлов к "Заявка под клиента" на офис с магазина
function TSendDataExchange.LoadDemandTovarFiles : Boolean;
var
  S               : String;
  cFileName       : String;
  cWarehouse      : String;
  i               : Integer;
  nCount          : Integer;
  cFile : String;
  FSecureFileName : String;
  Q : TADOQuery;
  MS : TMemoryStream;
begin
  Result:=True;
  if IsSkipAction('LoadDemandTovarFiles') then Exit;

  Result := False;

  if FWarehouse = '' then
  begin
    S := 'Нет или не прописана в конфигурации база Warehouse';
    Exit;
  end;

  cWarehouse := FWarehouse + '.dbo.FileStorage';

  DoShowSendDataExchange('Получение прикрепленных файлов к "Заявкам под клиента"');
//------------------------------------------------------------------------------
// Запрос на магазине
  FqShop.Close;
  FqShop.SQL.Clear;
  FqShop.SQL.Add(
        ' select DT_ID, DT_Document, DTF_Name, DTF_Note, DTF_IsUnload, DTF_WhoInput, DTF_DateInput, FS_File ' +
        ' from DemandTovarFiles ' +
        '   inner join ' + cWarehouse + ' on DTF_Name = FS_Name '+ // FS_Type = 53
        '   inner join DemandTovar on DT_ID = DTF_SDoc ' +
        ' where DTF_IsUnload = 0');
  FqShop.Open;

//------------------------------------------------------------------------------
// Запрос на основной. Нужен для формирования ссылок на файл
  FqMain.Close;
  FqMain.SQL.Clear;
  FqMain.SQL.Add(
    'declare @Document bigint, @Place int ' +
    ' set @Document = :Document ' +
    ' set @Place = :Place ' +
    ' select DT_ID ' +
    ' from DemandTovar ' +
    ' where DT_Document = @Document ' +
    '   and DT_Place = @Place '
    );

  DoShowSendDataExchange('', 0, FqShop.RecordCount);
  nCount := 0;
  S := '';
  try
    //SaveLog(11, 40, '');
    DoShowSendDataExchange('', FqShop.RecNo);
    while not FqShop.Eof do
    begin
      cFile := '';
      FqMain.Close;
      FqMain.Parameters.ParamByName('Document').Value := FqShop.FieldByName('DT_Document').AsString;
      FqMain.Parameters.ParamByName('Place').Value    := FPlace;
      FqMain.Open;
      if not FqMain.IsEmpty then
      begin
        cFile     := IntToStr(FPlace) + '_' + FqShop.FieldByName('DTF_Name').AsString;
        cFileName := FShopDocInFile + cFile;
        FSecureFileName := 'File_' + FqShop.FieldByName('DT_ID').AsString + '_' + FqShop.FieldByName('DTF_Name').AsString;
        // Сохраняем файл в хранилище
        {$IFDEF TRADE}
        Q := CreateQuery(False);
        MS := TMemoryStream.Create;
        try
          TBlobField(FqShopFile.FieldByName('FS_File')).SaveToStream(MS);
          MS.Position := 0;

          // Если файл уже есть, то его сперва надо удалить!
          if GetFileExists(cFileName) then
            // удалить файл!
          begin
            Q.SQL.Text := 'select dbo.FileDelete(:Folder,:File) as R ';
            Q.Parameters.ParamByName('Folder').Value :=
              StringReplace(FShopDocInFile,'\\dom.loc\dfs\secure\','',[]);
            Q.Parameters.ParamByName('File').Value := cFile;
            Q.Open;
          end;

          Q.Close;
          Q.SQL.Text := 'select dbo.FileSave(:Folder,:File,:Stream) as R ';
          Q.Parameters.ParamByName('Folder').Value :=
            StringReplace(FShopDocInFile,'\\dom.loc\dfs\secure\','',[]);
          Q.Parameters.ParamByName('File').Value := cFile;
          Q.Parameters.ParamByName('Stream').LoadFromStream(MS, ftBlob);
          Q.Open;
        finally
          MS.Free;
          Q.Close; Q.Free;
        end;
        {$ELSE}
        TBlobField(FqShop.FieldByName('FS_File')).SaveToFile( cFileName );
        {$ENDIF}
        S := '';
        try
          FconMain.Execute(
            'insert into DemandTovarFiles(DF_SDoc, DF_Note, DF_FileName,DF_SecureFileName,DF_Type,DF_DateInput,DF_WhoInput) '+ ' Values('+
            FqMain.FieldByName('DT_ID').AsString + ',' +
            QuotedStr(FqShop.FieldByName('DTF_Note').AsString) + ',' +
            QuotedStr(FSecureFileName) + ',' +
            QuotedStr(cFile) + ',' +
            '54'  + ',' +
            QuotedStr(FormatDateTime('yyyymmdd', FqShop.FieldByName('DTF_DateInput').AsDateTime)) + ',' +
            FqShop.FieldByName('DTF_WhoInput').AsString + ')'
            );

        except on E: Exception do
          begin
            S := E.Message;
            // SaveLog(12, 40, S)
          end;
        end;

        if S = '' then
        begin
          FqShop.Edit;
          FqShop.FieldByName('DTF_IsUnload').AsBoolean := True;
          FqShop.Post;
          Inc(nCount);
        end;
      end; // FqMain
      FqShop.Next;
    end; // while FqShop.Eof
    FqShop.Close;

    Result := True;

  except
    on E: EDatabaseError do S := E.Message;
    on E: Exception do S := E.Message;
    else S := 'Ошибка получение файлов прикрепленных к "Заявкам под клиента"';
  end;
  FqMain.Close;
  FqMain.SQL.Clear;
  FqShopFile.Close;
  FqShopFile.SQL.Clear;

  try
    if Result then
//      SaveLog(13, 40, FormStepResult(nCount))
    else
//       SaveLog(12, 40, S);
  except
  end;
end;

procedure TSendDataExchange.SendDataExchange;
begin
  try
    if not Connected then DoConnect;
    FOK := FconShop.Connected;

    // все что вв этом блоке, будет выполняться ТОЛЬКО в службе ShopDataExchangeFiles
    {$IFDEF SHOPDATAEXCHANGEFILES}
    if not Terminated and FOK  then LoadDocInFiles;
    {$ELSE}

    if not Terminated and FOK and (FPlace <> 105) then FOK := LoadApplContractFilesRetail;

    if not Terminated and FOK and (not FService or not FPlacePresence) then
    begin
      FOK := SendPresencePlace;
    end;
//
    if not Terminated and FOK and (FRegFilesPath <> '') and (FWarehouse <> '') and (FSubdivision <> 0) then
    begin
      FOK := SendReglament;
      if not Terminated and FOK then FOK := SendRegStaff;
      if not Terminated and FOK then FOK := SendRegFile;
      if not Terminated and FOK then FOK := SendReadMeReg;
      if not Terminated and FOK then FOK := LoadReadMeReg;
    end;

    if not Terminated and FOK then FOK := LoadOfficeMemo;
    if not Terminated and FOK then FOK := SendBegunokTurn;
    if not Terminated and FOK then FOK := SendPerson;
    if not Terminated and FOK then FOK := SendPersonFilial;
    if not Terminated and FOK then FOK := SendPersonJob;

    if not Terminated and FOK and FSalon and not FSupermarcet then FOK := SendPersonPass;

    if not Terminated and FOK and (FARTLPFilesPath <> '') and (FWarehouse <> '') then FOK := LoadARTLP;
    if not Terminated and FOK and (FARTLPFilesPath <> '') and (FWarehouse <> '') then FOK := UnloadARTLP;
    if not Terminated and FOK and (FARTLPFilesPath <> '') and (FWarehouse <> '') then FOK := UnloadARTPlaceLlistPhoto;

    if not Terminated and FOK and (FARSLPFilesPath <> '') and (FWarehouse <> '') then FOK := LoadActReceptSupplPhoto;
    if not Terminated and FOK and (FARSLPFilesPath <> '') and (FWarehouse <> '') then FOK := LoadActReceptSupplEDIPhoto;

    if not Terminated and FOK and (FSCLPFilesPath <> '') and (FWarehouse <> '') then FOK := LoadStoreCheckListPhotoPhoto;

    if not Terminated and FOK and (not FService or FPlacePresence) and (FWarehouse <> '') then
      FOK := SendHelpFile;

    if not Terminated and FOK and (not FService or FPlacePresence) and (FWarehouse <> '') then
      FOK := SendGroupsFile;

    if not Terminated and FOK and (not FService or not FPlacePresence) then FOK := SendPersonDeduct;

    if not Terminated and FOK and (FMAPMFilesPath <> '') and (FWarehouse <> '') then FOK := LoadMAPMFiles;

    if not Terminated and FOK and (FShopCollectionFilePath <> '') and (FWarehouse <> '') then FOK := LoadShopCollectionFile;

    if not Terminated and FOK and (FShopCollectionFilePath <> '') and (FWarehouse <> '') then FOK := LoadShopCollectionListFile;

    if not Terminated and not FSupermarcet and FOK then FOK := SendPersonMoving;

    if not Terminated and FOK and (FLayOutPhotoPath <> '') and (FWarehouse <> '') then FOK := LoadLayoutPhoto;
    if not Terminated and FOK and (FPersonHappyFile <> '') and (FWarehouse <> '')then FOK := SendPersonHappyFile;

    if not Terminated and FOK and (FOMFilesPath <> '') and (FWarehouse <> '') then
    begin
      if not Terminated and FOK then FOK := SendOfficeMemoFile;
      if not Terminated and FOK then FOK := LoadOfficeMemoFile;
    end;

    if not Terminated and FOK and (FACFilesPath <> '') and (FWarehouse <> '') and
      (FPlace = 105) then LoadApplContractFiles;

    if not Terminated and FOK and (FACFilesPath <> '') and (FWarehouse <> '') and
      (FPlace = 105) then SendApplContractFiles;

    if not Terminated and FOK and (FACFilesPath <> '') and (FWarehouse <> '') and
      (FPlace = 105) then ReturnApplContractFiles;

    if not Terminated and FOK and (FShopInvSheetFile <> '') and (FWarehouse <> '') then FOK := LoadShopInvShetFile;

    if not Terminated and FOK and (FBookComplaintFilesPath <> '') and (FWarehouse <> '') then FOK := LoadBookComplaint;

    if not Terminated and FOK and (FLayOutPhotoPathDoc <> '') and (FWarehouse <> '') and FSendSupplier then FOK := LoadLayOutPhotoDoc;
    if not Terminated and FOK and (FLayOutPhotoPathDoc <> '') and (FWarehouse <> '') and FSendSupplier then FOK := SendLayOutPhotoDoc;


    if not Terminated and FOK and (not FService or FPlacePresence) and (FWarehousePhoto <> '') then
      FOK := SendTovarPhoto;

    if not Terminated and FOK and FSupermarcet and (FPersonFiles <> '') and (FWarehouse <> '') then FOK := LoadPersonFiles;
    if not Terminated and FOK and (FMCRFiles <> '') and (FWarehouse <> '') then FOK := LoadMCRFiles;
    if not Terminated and FOK and (FCounterfoilReturnFile <> '') and (FWarehouse <> '') then FOK := LoadCounterfoilReturnFile;

    if not Terminated and FOk then FOk := LoadDocRROFiles;
    if not Terminated and FOK  then FOk := LoadMeterLeaseActFiles;

//    if not Terminated and FOK and (FShopInvSheetFile <> '') and (FWarehouse <> '') then FOK := LoadShopInvShetFile;

    if not Terminated and FOk and (HourOf(Now) > 12) and (DayOfWeek(Date) = 6) and not StepProcessing(35) then
      FOk := CompareTableClient(35, 'Client', 'Client',
        'Cl_DateInput,Cl_WhoInput,Cl_DateUpdate,Cl_WhoUpdate,Cl_Place,Cl_Reclamation', 'Cl_NoResident = 0');

    if not Terminated and FOk and (HourOf(Now) > 12) and (DayOfWeek(Date) = 7) and not StepProcessing(36) then
      FOk := CompareTable(36, 'Tovar',
        'Tov_WhoInput,Tov_DateUpdate,Tov_WhoUpdate,Tov_Saldo,Tov_PriceOut,Tov_Action,Tov_MinStock');
//
//     Не разремливать
//    if not Terminated and FOK then FOK := SendPlanogram;
    if not Terminated and FOK then FOK := SendInventCardPhoto;

    if not Terminated and FOK then DelLayoutPhoto;
    if not Terminated and FOK then DelDocInFile;
    if not Terminated and FOK and FSendSupplier then DelLayoutPhotoDoc;
    if not Terminated and FOK then DelMCRFiles;
    if not Terminated and FOK then DelOfficeMemo;
    if not Terminated and FOK then DelOfficeMemoFile;
    if not Terminated and FOK and FSupermarcet then DelDismissedEmployeeFile;
    if not Terminated and FOK then DelInventSheetFile;
    if not Terminated and FOK then DelDocRROFiles;
    if not Terminated and FOK then LoadShopInvShetPerson;
    if not Terminated and FOK then DelOfficeMemoFileOld;
    if not Terminated and FOK and not FSalon then LoadShopPersonPass;
    //if FPlace = 100 then if not Terminated and FOK  then LoadDocInFiles;
    if not Terminated and FOK  then LoadDocInFiles;
    if not Terminated and FOK and (FActDamageTovarListPhoto <> '') and (FWarehouse <> '')then FOK := TakeActDamageTovarListPhoto;
    if not Terminated and FOK and (FDocDemandReclamationTovarListPhoto <> '') and (FWarehouse <> '')
     then FOK := TakeDocDemandReclamationPhoto;
    if not Terminated and FOK and (FPersonFilesAnkPath <> '') and (FWarehouse <> '') then FOK := SendPersonFilesAnk;
    if not Terminated and FOK and (FPersonFilesAnkPath <> '') and (FWarehouse <> '') then FOK := LoadPersonFilesAnk;
    if not Terminated and FOK and (FDemandRepairFilesPath <> '') and (FWarehouse <> '') then FOK := LoadDemandRepairFiles;
    if not Terminated and FOK then FOK := LoadDemandTovarFiles;
    if not Terminated and FOK then FOK := TakeActReceptSupplierFile;
    if not Terminated and FOK then FOK := TakeActReceptSupplierEDIFile;
    if not Terminated and FOK then FOK := LoadDemandRepairAssets;
    {$ENDIF}
    DoShowSendDataExchange('Отправка закончена');
    FOK := FOK and FconShop.Connected;
  finally
    FqShopFile.Close;
    FqShop.Close;
    FconShop.Close;
    FqMain.Close;
    FconMain.Close;
    if Assigned(FEndSendDataExchange) then FEndSendDataExchange;
  end;
end;

procedure TSendDataExchange.Execute;
begin
  if not Terminated then SendDataExchange;
end;

end.
