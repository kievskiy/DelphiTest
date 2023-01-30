unit uShopCommunication;

interface

uses Windows, Classes, StdCtrls, ComCtrls, SysUtils, DB, ADODB, Variants,
  IdMessage, IdPOP3, IdSMTP, IdReplyPOP3, IdAttachment, IdAttachmentFile,
  ActiveX, IdFTPCommon, IdGlobal, IdFTP, DateUtils, XMLIntf, XMLDoc;

const MAIL_VERSION = 1;

type

  TTypeCommunication = (cNone, cBaseUnload, cBaseLoad, cBaseForward, cBaseReceive,
    cShopUnload, cShopLoad, cShopForward, cShopReceive);

  TTypeMail = (tmCheck, tmLookInside, tmLoad, tmUnLoad, tmReturnDoc, tmForward);


  TLoadedIDList = class(TStringList)
  protected
    function CompareStrings(const S1, S2: string): Integer; override;
  public
    function AddID(const S: string; const ID : integer): Integer; overload;
    function AddID(const S: string; const ID : string): Integer; overload;
    function ExistIDList(const S: string): Boolean;
    function GetIDList(const S: string): String;
    function Find(const S: string; var Index: Integer): Boolean; override;
  end;

  TCustomCommunication  = class(TThread)
  private

  protected
    FOk : boolean;
    FWorks : boolean;
    FNoFile : boolean;
    FNewVer : boolean;
    FProjTerminate : boolean;
    FTestServer : boolean;
    FTestServerName : string;

    FTypeCommunication : TTypeCommunication;
    FPlace : Integer;
    FTypeDoc : integer;
    FRemainder : Boolean;
    FService : Boolean;
    FAllDoc : Boolean;
    FIDDoc : integer;
    FSIDDoc : string;
    FNumForward : integer;

    FIDLoad : integer;
    FIDLoadDoc2 : integer; // для выгрузки одновременно двух разных документов
    FIDJob : integer;

    FConnectionString : String;
    FUserName : String;
    FUserPassword : String;
    FSAPassword : String;

    FIPAdrecShop : String;
    FBDNameShop : String;
    FSAPasswordShop : String;

    FUploadFile : boolean;
    FDirectSendingFile : boolean;

    FTheMailer : String;

    FExchangeData : Integer;

    FHost : string;
    FSMTPUsername : String;
    FPOPUsername : String;
    FPOPPassword : String;

    FFTPHost : String;
    FFTPPort : Integer;
    FFTPUserName : String;
    FFTPPassword : String;
    FWarehouseMailFile : String;

    FTextFile : TextFile;
    FFileName : String;
    FFileSize : Integer;
    FTransferZip : Boolean;
    FFileAddType : integer;
    FNXMLZip: String;

    FXMLInfo : String;
    FXMLFileTransfer : String;
    FXMLFileTransferSize : Integer;
    FXMLFileName : String;
    FXMLFileSize : Integer;
    FXMLFileAdd : String;
    FXMLFileAddSize : Integer;

    FFileDir : String;
    FXLSDir : String;
    FXLSFile : String;

    FNumber : Integer;
    FDateStartDoc : Variant;
    FDatePeriod : Variant;
    FDateCurr : TDateTime;
    FIDHist : Integer;
    FNote: string;
    FInformation: string;
    FConfirmationType : Integer;
    FConfirmationText: string;

    FSMShop : Boolean;
    FSupermarcet : Boolean;
    FSalon : Boolean;
    FSelfService : Boolean;
    FPlacePrice : Integer;
    FPlaceCur : Integer;
    FSubdivision : Integer;
    FNationalCur : Integer;
    FPerson : Integer;
    FDateStart : Variant;
    FCadreSmall : Boolean;
    FOperLoad : Integer;
    FGrDocOper : Integer;
    FGrDocClient : Integer;
    FGrDocClientRRO : Integer;
    FDateNalogStart : Variant;
    FIsOcupate : Boolean;

    FLog : String;
    FError : String;

    FLoadedIDList : TLoadedIDList;
    FconAdmin: TADOConnection;
    FqAdmin: TADOQuery;
    FqListAdmin: TADOQuery;
    FconUser: TADOConnection;
    FqUser: TADOQuery;
    FconShop: TADOConnection;
    FqShop: TADOQuery;

    FParamLoad : Boolean;
    FCountOpen : Integer;

    FTypeMail : TTypeMail;
    FNameOfStep : String;
    FMax : Integer;
    FPosition : Integer;
    FShopMain : integer;

    FShowNameOfStep : TThreadProcedure;
    FEndCommunication : TThreadProcedure;
    FConfirmation : TThreadProcedure;

    function ExecuteAdmin(const CommandText: WideString) : Boolean;
    function QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Variant) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Integer) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Int64) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Currency) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : String) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : Variant) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : Currency) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : Integer) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : Int64) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : String) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : Boolean) : Boolean; overload;
    function QGetFieldAdmin(const ASQL, AField : String; var AValue : TDateTime) : Boolean; overload;

    function DictPrefix(const ADict : String) : String;
    function GetDictName(const ADict : String; const AID : Variant) : String;
    function GetBasePersonID(Pe_ID : Integer) : Integer;
    function GetShopPersonID(Pe_ID : Integer) : Integer;

    function QGetFieldAllAdmin(const ASQL, AField, AParams, ASeparator : String; AValues: OleVariant; var AValue : String) : Boolean; overload;
    function QGetFieldAllAdmin(const ASQL, AField, ASeparator : String; var AValue : String) : Boolean; overload;

    function ExistsAdmin(const ASQL, AParams : String; AValues: OleVariant) : Boolean; overload;
    function ExistsAdmin(const ASQL : String) : Boolean; overload;
    function ExistsAdmin(const ATable, AWhere, AParams : WideString; AValues: OleVariant) : Boolean; overload;
    function ExistsAdmin(const ATable, AWhere : WideString) : Boolean; overload;
    function TableExistsAdmin(const ATable: String) : Boolean;
    function ViewExistsAdmin(const ATable: String) : Boolean;
    function FieldExistsAdmin(const ATable, AField: String) : Boolean;

    function UnloadTable(ATable, AName, AIDField, AFields : string;
      AFieldUpdate : string = ''; AWhere : string = ''; AIDLoad : string = ''; AShopLoad : string = '';
      AAddID : boolean = False) : boolean;
    function LoadTable : boolean;

    function UnloadDelTable(AKey : integer; ATable, AName, AIDField : string;
      AWhere : string = ''; AIDLoad : string = ''; AShopLoad : string = '')  : Boolean;
    function LoadDelTable : Boolean;

    function UnloadDelDict(const AKey : Integer; const ANameDict : string) : Boolean;
    function UnloadSysLog(AKey : integer; AName, ATitle : string; AWhere : string = '') : Boolean;

    function QUpdateAdmin(const ASQL, AField : String; AValues: OleVariant) : Boolean;
    function QInsertAdmin(const ASQL, AField : String; AValues: OleVariant) : Boolean; overload;
    function QInsertAdmin(const ASQL, AField : String; AValues: OleVariant; var AID : Integer) : Boolean; overload;

    function ExecuteUser(const CommandText: WideString) : Boolean;
    function QUpdateUser(const ASQL, AField : String; AValues: OleVariant) : Boolean;
    function QInsertUser(const ASQL, AField : String; AValues: OleVariant) : Boolean; overload;
    function QInsertUser(const ASQL, AField : String; AValues: OleVariant; var AID : Integer) : Boolean; overload;

    function SetSQLLoad(const ASQL : string; const AParamLoad : boolean = False) : boolean;
    function PosSQLLoad(AID : Integer) : boolean;
    function FindRecord(AFieldName : String; AID : Integer) : boolean;
    function DocToAnal(ADocument : Int64) : Integer;
    function GetUnloadDir(APath : string = '') : string;

    function GetConnected : boolean;
    function GetSubject : String;
    function GetFileInfo : String;
    function GetFileName : String;
    function GetFileTransfer : String;
    function GetFileZIP : String;
    function GetFileAdd : String;
    function GetError : String;
    function GetTypeMailName : String;
    function GetNameOfStep : String;

    procedure ShowStep(ANameOfStep : string; AMax : integer = 0; APos : integer = 0);
    function AddError(const AProc, AMessage : String; const AText : string; const AField : string;
      const AParam : string; const AValues: OleVariant) : boolean; overload;
    function AddError(const AProc, AMessage : String) : boolean; overload;
    procedure AddNote(const ANote : String);
    procedure AddInformation(const AInformation : String);
    procedure AddXLSFile(const AFile : String);

    function AddID(const S: string; const ID : integer): Integer; overload;
    function AddID(const S, ID: string): Integer; overload;
    function GetID(const S: string): String;
    function ParsingInfo : boolean;
    function GetNumberFile(const AFileName : string; var ANumber : Integer) : boolean;
    function LoadPop3File : Boolean;
    function GetFTPDir : string;
    function ChangeDirFTP(AIdFTP : TIdFTP; ADir : String; ACreate : Boolean = true) : Boolean;
    function ConnectFTPServer(var AError : string) : TIdFTP;
    function LoadFTPFile : Boolean;

    function DoConnect : Boolean;
    function DoGetParam : Boolean;
    function DoCreateFile : Boolean;
    function DoReceivingFile : Boolean;
    function DoPrepareSendingFile : Boolean;
    function DoCheckingFile : Boolean;
    function DoSendFile : Boolean;
    function SendSMTPFile : Boolean;
    function SendMailToFile : Boolean;
    function SendFTPFile : Boolean;

    function SendWarehouseMailFile : Boolean;
    function ReceivingWarehouseMailFile : Boolean;
    function LoadWarehouseMailFile : Boolean;

    function DoCompletion : Boolean;
    function DoCancel : Boolean;
    procedure DoExecute;
    procedure Execute; override;

     // получение строкового значения для тестового сервера (каталог на FTP-сервере)
     function TestServerName: string;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    function ExistID(const S: string): Boolean;

    procedure SetParam(const ATypeCommunication : TTypeCommunication; const APlace : Integer;
      const AConnectionString, AUserName, AUserPassword, AFileDir, AXLSDir : String);
    procedure Communication; Virtual;
    procedure AfterCommunication; Virtual;
    procedure RollbackCommunication; Virtual;
    function StartCommunication : boolean;

    function DoConnectPublic: boolean;
    function ConnectFTPServerPublic(var AError : string) : TIdFTP;
    function ChangeDirFTPPublic(AIdFTP : TIdFTP) : Boolean;

    property Place : Integer read FPlace;
    property Connected : boolean read GetConnected;
    property Ok : boolean read FOk;
    property Works : boolean read FWorks;
    property NoFile : boolean read FNoFile;

    property FileNameWE : String read FFileName;
    property FileInfo : String read GetFileInfo;
    property FileName : String read GetFileName;
    property FileTransfer : String read GetFileTransfer;
    property FileZIP : String read GetFileZIP;
    property FileAddType : integer read FFileAddType write FFileAddType;
    property FileAdd : String read GetFileAdd;
    property UploadFile : boolean read FUploadFile write FUploadFile;
    property DirectSendingFile : boolean read FDirectSendingFile write FDirectSendingFile;
    property TheMailer : String read FTheMailer write FTheMailer;
    property Log : String read FLog;
    property Error : String read GetError;
    property Note : String read FNote;
    property Information : String read FInformation;
    property XLSFile : String read FXLSFile;
    property TypeMail : TTypeMail read FTypeMail write FTypeMail;
    property TypeMailName : String read GetTypeMailName;
    property NameOfStep : String read GetNameOfStep;
    property Max : Integer read FMax;
    property Position : Integer read FPosition;
    property MaxPosition : Integer read FMax;
    property ConfirmationType : Integer read FConfirmationType;
    property ConfirmationText: string read FConfirmationText;
    property Terminated;
    property ProjTerminate : boolean read FProjTerminate;
    property TypeDoc : Integer read FTypeDoc write FTypeDoc;
    property Service : Boolean read FService write FService;
    property Remainder : Boolean read FRemainder write FRemainder;
    property AllDoc : Boolean read FAllDoc write FAllDoc;
    property IDDoc : Integer read FIDDoc write FIDDoc;
    property SIDDoc : String read FSIDDoc write FSIDDoc;
    property NumForward : Integer read FNumForward write FNumForward;
    property IDJob : integer read FIDJob write FIDJob;
    property Number : Integer read FNumber;
    property DatePeriod : Variant read FDatePeriod write FDatePeriod;
    property Subdivision : Integer read FSubdivision;
    property ShopMain : Integer read FShopMain;

    property OnShowNameOfStep : TThreadProcedure read FShowNameOfStep write FShowNameOfStep;
    property OnEndCommunication : TThreadProcedure read FEndCommunication write FEndCommunication;
    property OnConfirmation : TThreadProcedure read FConfirmation write FConfirmation;
  end;

const
  C_DocDemandForceReturn = 'DocDemandForceReturn';
  C_DocDemandForceReturn_Title = 'Возврат заявок на товар с ТТ';


implementation

uses ONumUtils, TRexCrypting, ZLibExGZ;

const
  ListExt = 'INF,GZM,MUL,VER,FIL,GZX,XML';
  ExtInfo = '.INF';
  ExtFile = '.MUL';
  ExtZIP = '.GZM';
  XMLZIP = '.GZX';
  ListAdd = '.VER,.FIL,.XML';

//     TLoadedIDList

function TLoadedIDList.CompareStrings(const S1, S2: string): Integer;
  var c1, c2 : string;
begin
  if Pos(',', S1) > 0 then c1 := Copy(S1, 1, Pos(',', S1) - 1)
  else c1 := S1;
  if Pos(',', S2) > 0 then c2 := Copy(S2, 1, Pos(',', S2) - 1)
  else c2 := S2;
  Result := inherited CompareStrings(c1, c2);
end;

function TLoadedIDList.AddID(const S: string; const ID : integer): Integer;
  var I : Integer; Str : string;
begin
  if Find(StringReplace(S, ',', '',[rfReplaceAll]), I) then
  begin
    Str := Strings[I];
    Delete(I);
    Str := Str + ',' + IntToStr(ID);
    Add(Str);
  end else Add(StringReplace(S, ',', '',[rfReplaceAll]) + ',' + IntToStr(ID));
  Find(StringReplace(S, ',', '',[rfReplaceAll]), I);
  Result := I;
end;

function TLoadedIDList.AddID(const S: string; const ID : string): Integer;
  var I : Integer; Str : string;
begin
  if Find(StringReplace(S, ',', '',[rfReplaceAll]), I) then
  begin
    Str := Strings[I];
    Delete(I);
    Str := Str + ',' + ID;
    Add(Str);
  end else Add(StringReplace(S, ',', '',[rfReplaceAll]) + ',' + ID);
  Find(StringReplace(S, ',', '',[rfReplaceAll]), I);
  Result := I;
end;

function TLoadedIDList.ExistIDList(const S: string): Boolean;
  var I : Integer;
begin
  Result := Find(StringReplace(S, ',', '',[rfReplaceAll]), I);
end;

function TLoadedIDList.GetIDList(const S: string): String;
  var I : Integer;
begin
  if Find(StringReplace(S, ',', '',[rfReplaceAll]), I) then
    Result := Copy(Strings[I], Pos(',', Strings[I]) + 1, Length(Strings[I]))
  else Result := '';
end;

function TLoadedIDList.Find(const S: string; var Index: Integer): Boolean;
begin
  if not Sorted then
  begin
    Index := IndexOf(StringReplace(S, ',', '',[rfReplaceAll]));
    Result := Index >= 0;
  end else Result := inherited Find(S, Index);
end;

//   TCustomCommunication

constructor TCustomCommunication.Create;
begin
  inherited Create(True);

  FOk := False;
  FWorks := True;
  FNoFile := False;
  FNewVer := False;
  FTestServer := False;

  FTypeCommunication := cNone;
  FPlace := 0;
  FTypeDoc := 0;
  FRemainder := False;
  FService := False;
  FAllDoc := True;
  FIDDoc := 0;
  FSIDDoc := '';
  FNumForward := 0;
  FIDLoad := 0;
  FIDLoadDoc2:= 0;

  FConnectionString := '';
  FUserName := '';
  FUserPassword := '';
  FSAPassword := '';

  FIPAdrecShop := '';
  FBDNameShop := '';
  FSAPasswordShop := '';

  FUploadFile := False;
  FDirectSendingFile := False;
  FTheMailer := '';

  FExchangeData := 0;
  FHost := 'mail';
  FSMTPUsername := '';
  FPOPUsername := '';
  FPOPPassword := '';

  FFTPHost := '';
  FFTPPort := 0;
  FFTPUserName := '';
  FFTPPassword := '';
  FWarehouseMailFile := '';

  FNumber := 0;
  FDateStartDoc := Null;
  FDatePeriod := Null;
  FDateCurr := Now;
  FIDHist := 0;
  FNote := '';
  FInformation := '';

  FSMShop := False;
  FSupermarcet := False;
  FSelfService := False;
  FSalon := False;
  FPlacePrice := 0;
  FSubdivision := 0;
  FPerson := 0;
  FDateStart := Null;
  FCadreSmall := True;
  FOperLoad := 0;
  FGrDocOper := 0;
  FGrDocClient := 0;
  FGrDocClientRRO := 0;
  FDateNalogStart := Null;

  FFileName := '';
  FFileSize := 0;
  FTransferZip := False;
  FileAddType := 0;

  FXMLInfo := '';
  FXMLFileTransfer := '';
  FXMLFileTransferSize := 0;
  FXMLFileName := '';
  FXMLFileSize := 0;
  FXMLFileAdd := '';
  FXMLFileAddSize := 0;

  FFileDir := '';
  FXLSDir := '';
  FXLSFile := '';

  FLog := '';
  FError := '';

  FTypeMail := tmCheck;
  FNameOfStep := '';
  FMax := 0;
  FPosition := 0;

  FLoadedIDList := TLoadedIDList.Create;
  FLoadedIDList.Sorted := True;

  FconAdmin := TADOConnection.Create(Nil);
  FconAdmin.LoginPrompt := False;
  FqAdmin := TADOQuery.Create(Nil);
  FqAdmin.Connection := FconAdmin;
  FqAdmin.CommandTimeout := 180;
  FqListAdmin := TADOQuery.Create(Nil);
  FqListAdmin.Connection := FconAdmin;
  FqListAdmin.CommandTimeout := 180;

  FconUser := TADOConnection.Create(Nil);
  FconUser.LoginPrompt := False;
  FqUser := TADOQuery.Create(Nil);
  FqUser.Connection := FconUser;
  FqUser.CommandTimeout := 180;
  FParamLoad := False;
  FCountOpen := 2000;

  FconShop := TADOConnection.Create(Nil);
  FconShop.LoginPrompt := False;
  FqShop := TADOQuery.Create(Nil);
  FqShop.Connection := FconShop;
  FqShop.CommandTimeout := 180;


  FShowNameOfStep := Nil;
  FEndCommunication := Nil;
  FConfirmation := Nil;

end;

destructor TCustomCommunication.Destroy;
begin
  FqListAdmin.Free;
  FqAdmin.Free;
  if FconAdmin.Connected then FconAdmin.Close;
  FconAdmin.Free;
  FqUser.Free;
  if FconUser.Connected then FconUser.Close;
  FconUser.Free;
  if FconShop.Connected then FconShop.Close;
  FconShop.Free;
  FLoadedIDList.Free;
  inherited Destroy;
end;

function TCustomCommunication.GetConnected : boolean;
begin
  Result := FconAdmin.Connected and FconUser.Connected;
end;

function TCustomCommunication.GetSubject : String;
begin
  if FService then Result := ReplChar(FNote, '~', ' ') + ' ' +
    IfStr(FTypeCommunication in [cBaseUnload, cBaseForward], 'на магазин', 'с магазина')
  else Result := IfStr(FTypeCommunication in [cBaseForward, cShopForward], 'Повторная отправка файла ' + FileName,
    'Данные') + IfStr(FTypeCommunication in [cBaseUnload, cBaseForward], ' для  магазина', ' от  магазина');
  Result := Result + ' ' + IntToStr(FPlace) + ' - ' +
    GetDictName(IfStr(FTypeCommunication in [cBaseUnload, cBaseForward], 'Place', 'NonShop'), FPlace);
end;

function TCustomCommunication.GetFileInfo : String;
begin
  Result := FFileName + ExtInfo;
end;

function TCustomCommunication.GetFileName : String;
begin
  Result := FFileName + ExtFile;
end;

function TCustomCommunication.GetFileTransfer : String;
begin
  if FTransferZip then Result := FFileName + ExtZIP
  else Result := FFileName + ExtFile;
end;

function TCustomCommunication.GetFileZIP : String;
begin
  Result := FFileName + ExtZIP;
end;

function TCustomCommunication.GetFileAdd : String;
var S:String;
begin
  S:='';
  if FTypeCommunication in [cBaseLoad,cShopLoad] then S:=FXMLFileAdd
  else
    begin
    if FFileAddType=3 then
    begin
      if FTypeCommunication = cBaseUnLoad then S := 'KHEOS'
      else if FTypeCommunication = cShopUnLoad then S:='KHEOM';
      S:=S + IntToHex(FPlace,4) + IntToHex(FNumber,4)
    end
    else if FFileAddType > 0 then S := FFileName;
    if (S<>'') then S:=S + Token(ListAdd, ',', FFileAddType);
  end;
  Result := S;
end;

function TCustomCommunication.GetError : String;
begin
  Result := 'Компьютер : ' + ComputerName +
    ' IP : ' + GetLocalPs + #13#10#13#10 + FError;
end;

function TCustomCommunication.GetTypeMailName : String;
begin
  case FTypeMail of
    tmLoad : Result := 'Загрузка почты';
    tmUnLoad : Result := 'Отправка почты';
    tmReturnDoc : Result := 'Возврат документа';
    tmForward : Result := 'Пересылка файла';
    else Result := '';
  end;
end;

function TCustomCommunication.GetNameOfStep : String;
begin
  Result := FNameOfStep;
  if FMax > 1 then Result := Result + '. Количество записей ' + IntToStr(FMax);
end;

function TCustomCommunication.ExecuteAdmin(const CommandText: WideString) : Boolean;
  var cError : String;
      TimeOut: Integer;
begin
  Result := False;
  if not FconAdmin.Connected then Exit;
  try
    try
      FqAdmin.Close;
      TimeOut:=FqAdmin.CommandTimeout;
      if Pos('UNLOADXMLFIX',uppercase(CommandText))>0 then FqAdmin.CommandTimeout := 600;
      FqAdmin.SQL.Clear;
      FqAdmin.SQL.Text := CommandText;
      FqAdmin.ExecSQL;
      Result := True;
      FqAdmin.CommandTimeout:=TimeOut;
    except
      on E: EDatabaseError do cError := E.Message;
      on E: Exception do cError := E.Message;
      else cError := '';
    end;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    if not Result then AddError('ExecuteAdmin', cError, CommandText, '', '', Null);
  end;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Variant) : Boolean;
  var L, I : integer;
begin
  Result := False;
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
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
        for I := 0 to L - 1 do FqAdmin.Parameters.ParamByName(
          Trim(Token(AParams, ',', I + 1))).Value := VarArrayGet(AValues, I);
      end else
      begin
        for I := 0 to L - 1 do FqAdmin.Parameters.Items[I + 1].Value :=
          VarArrayGet(AValues, I);
      end;
    end;
    try
      FqAdmin.Open;
      if FqAdmin.Active then
      begin
        if FqAdmin.RecordCount = 1 then
        begin
          if AField = '' then AValue := FqAdmin.Fields[0].AsVariant
          else AValue := FqAdmin.FieldByName(AField).AsVariant;
          Result := True;
        end;
        FqAdmin.Close;
      end;
    except
      on E: EDatabaseError do AddError('QGetFieldAdmin', E.Message, ASQL, AField, AParams, AValues);
      on E: Exception do AddError('QGetFieldAdmin', E.Message, ASQL, AField, AParams, AValues);
      else AddError('QGetFieldAdmin', '', ASQL, AField, AParams, AValues);
    end;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
  end;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Integer) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, AParams, AValues, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Int64) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, AParams, AValues, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : Currency) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, AParams, AValues, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField, AParams : String; AValues: OleVariant; var AValue : String) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, AParams, AValues, Value);
  if Result then if Value = Null then AValue := '' else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : Variant) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, '', Null, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : Currency) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : Integer) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : Int64) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := 0 else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : String) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := '' else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : Boolean) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := False else AValue := Value;
end;

function TCustomCommunication.QGetFieldAdmin(const ASQL, AField : String; var AValue : TDateTime) : Boolean;
  var Value : Variant;
begin
  Value := AValue;
  Result := QGetFieldAdmin(ASQL, AField, Value);
  if Result then if Value = Null then AValue := Date else AValue := Value;
end;

function TCustomCommunication.DictPrefix(const ADict : String) : String;
begin
  if QGetFieldAdmin('select top 1 Name from syscolumns where id = (select id from sysobjects where name = ''' +
    ADict + ''' AND (type = ''U'' or type = ''V''))', 'Name', Result)  then
  begin
    Result := Token(Result, '_', 1)
  end else Result := '';
end;

function TCustomCommunication.GetDictName(const ADict : String; const AID : Variant) : String;
  var Value : Variant; bRasult : boolean;
begin
  Result := '';
  if AID = Null then Exit;
  Value := '';
  bRasult := QGetFieldAdmin('select ' + DictPrefix(ADict) + '_Name from ' + ADict + ' where ' + DictPrefix(ADict) + '_ID = ' + IntToStr(AID), '', Value);
  if bRasult and (Value <> Null) then Result := Value;
end;

function TCustomCommunication.GetBasePersonID(Pe_ID : Integer) : Integer;
Begin
  if FSMShop then QGetFieldAdmin('select Pe_IDBase from VPerson where Pe_ID = ' +
    IntToStr(Pe_ID), 'Pe_IDBase', Pe_ID);
  Result := Pe_ID;
End;

function TCustomCommunication.GetShopPersonID(Pe_ID : Integer) : Integer;
Begin
  if FSMShop then
  begin
    if not QGetFieldAdmin('select Pe_ID from VPerson where Pe_IDBase = ' + IntToStr(Pe_ID), 'Pe_ID', Pe_ID) then
      Pe_ID := 0;
  end;
  Result := Pe_ID;
End;

function TCustomCommunication.QGetFieldAllAdmin(const ASQL, AField, AParams, ASeparator : String; AValues: OleVariant; var AValue : String) : Boolean;
  var S : String; L, I : integer;
begin
  Result := True; AValue := '';
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
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
        for I := 0 to L - 1 do FqAdmin.Parameters.ParamByName(
          Trim(Token(AParams, ',', I + 1))).Value := VarArrayGet(AValues, I);
      end else
      begin
        for I := 0 to L - 1 do FqAdmin.Parameters.Items[I + 1].Value :=
          VarArrayGet(AValues, I);
      end;
    end;
    try
      FqAdmin.Open;
      if FqAdmin.Active and (FqAdmin.RecordCount > 0) then
      begin
        while not FqAdmin.Eof do
        begin
          if AField = '' then S := FqAdmin.Fields[0].AsString
          else S := FqAdmin.FieldByName(AField).AsString;
          if AValue <> '' then AValue := AValue + ASeparator + S
          else AValue := S;
          FqAdmin.Next;
        end;
      end else Result := False;
    except
      on E: EDatabaseError do AddError('QGetFieldAllAdmin', E.Message, ASQL, AField, AParams, AValues);
      on E: Exception do AddError('QGetFieldAllAdmin', E.Message, ASQL, AField, AParams, AValues);
      else AddError('QGetFieldAllAdmin', '', ASQL, AField, AParams, AValues);
    end;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
  end;
end;

function TCustomCommunication.QGetFieldAllAdmin(const ASQL, AField, ASeparator : String; var AValue : String) : Boolean;
begin
  Result := QGetFieldAllAdmin(ASQL, AField, '', ASeparator, Null, AValue);
end;

function TCustomCommunication.ExistsAdmin(const ASQL, AParams : String; AValues: OleVariant) : Boolean;
  var L, I : integer;
begin
  Result := False;
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
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
        for I := 0 to L - 1 do FqAdmin.Parameters.ParamByName(
          Trim(Token(AParams, ',', I + 1))).Value := VarArrayGet(AValues, I);
      end else
      begin
        for I := 0 to L - 1 do FqAdmin.Parameters.Items[I + 1].Value :=
          VarArrayGet(AValues, I);
      end;
    end;
    try
      FqAdmin.Open;
      if FqAdmin.Active then
      begin
        if FqAdmin.RecordCount > 0 then Result := True;
        FqAdmin.Close;
      end;
    except
      on E: EDatabaseError do AddError('ExistsAdmin', E.Message, ASQL, '', AParams, AValues);
      on E: Exception do AddError('ExistsAdmin', E.Message, ASQL, '', AParams, AValues);
      else AddError('ExistsAdmin', '', ASQL, '', AParams, AValues);
    end;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
  end;
end;

function TCustomCommunication.ExistsAdmin(const ASQL : String) : Boolean;
begin
  Result := ExistsAdmin(ASQL, '', Null);
end;

function TCustomCommunication.ExistsAdmin(const ATable, AWhere, AParams : WideString; AValues: OleVariant) : Boolean;
begin
  Result := ExistsAdmin('select top 1 * from ' + ATable + IfStr(AWhere <> '', ' where ' + AWhere, ''), AParams, AValues);
end;

function TCustomCommunication.ExistsAdmin(const ATable, AWhere : WideString) : Boolean;
begin
  Result := ExistsAdmin('select top 1 * from ' + ATable + IfStr(AWhere <> '', ' where ' + AWhere, ''), '', Null);
end;

function TCustomCommunication.TableExistsAdmin(const ATable: String) : Boolean;
begin
  Result := ExistsAdmin('select id from sysobjects where name = ''' +  ATable + ''' AND type = ''U''');
end;

function TCustomCommunication.TestServerName: string;
var qProc: TADOStoredProc;
    cError: String;
begin
  Result := '';
  try
    try
      // будет обьявлена на магазинах и в Трейде!
      qProc := TADOStoredProc.Create(nil);
      qProc.Connection := FconUser;
      qProc.ProcedureName := 'sp_TestServerName';
      qProc.Parameters.Refresh;
      qProc.Parameters.ParamByName('@Mode').Value := 1;
      qProc.Open;
      Result := qProc.FieldByName('_Res').AsString;
    except
      on E: EDatabaseError do cError := '~' + E.Message;
      on E: Exception do cError := '~' + E.Message;
      else cError := '~Ошибка подключения';
      AddError('DoConnect', cError);
    end;
  finally
    qProc.Close; qProc.Free;
  end;
end;

function TCustomCommunication.ViewExistsAdmin(const ATable: String) : Boolean;
begin
  Result := ExistsAdmin('select id from sysobjects where name = ''' +  ATable + ''' AND type = ''V''');
end;

function TCustomCommunication.FieldExistsAdmin(const ATable, AField: String) : Boolean;
  var nID : Integer;
begin
  Result := TableExistsAdmin(ATable) or ViewExistsAdmin(ATable);
  if Result and QGetFieldAdmin('select id from sysobjects where name = ''' +  ATable +
    ''' AND (type = ''U'' or type = ''V'')', 'id', nID)  then
  begin
    Result := ExistsAdmin('select id from syscolumns where id =  ' + IntToStr(nID) + ' and name = ''' +  AField + '''');
  end else Result := False;
end;

 {   Выгрузка одной таблицы...

        Обязательные данные
     ATable - Имя выгружаемой таблицы
     AName - Название таблицы
     AIDField - Ключевое поле в таблице (должно быть в перечне выгружаемых полей)
     AFields - Перечень выгружаемых полей

        Дополнительные данные
     AFieldUpdate - Поле для отсечение по периоду выгрузки
     AWhere - Условие отбора
     AIDLoad - Ключевое поле ID на получателе
     AShopLoad - Ключевое поле Place на получателе
 }

function TCustomCommunication.UnloadTable(ATable, AName, AIDField, AFields : string;
  AFieldUpdate : string = ''; AWhere : string = ''; AIDLoad : string = ''; AShopLoad : string = '';
  AAddID : boolean = False) : boolean;
  var M, MS, MB, cList, cListStr, cListBlob : string; I, j : integer;
begin
  Result := True;
  if not TableExistsAdmin(ATable) then Exit;
  ShowStep(AName);
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  try

    if (ATable = '') or (AName = '') or (AIDField = '') and (AFields = '') then
    begin
      Result := AddError('UnloadTable_' + ATable, 'Не определены: ' +
        IfStr(ATable = '', '~Имя выгружаемой таблицы', '') +
        IfStr(AName = '', '~Название таблицы', '') +
        IfStr(AIDField = '~Ключевое поле в таблице', '', '') +
        IfStr(AFields = '~Перечень выгружаемых полей', '', ''));
      Exit;
    end;

    try

      FqListAdmin.SQL.Add('select ' + AFields + ' from ' + ATable);
      if AWhere <> '' then FqListAdmin.SQL.Add('where ' + AWhere);

      if (FDatePeriod <> Null) and (AFieldUpdate <> '') then
        FqListAdmin.SQL.Add(IfStr(AWhere = '', 'where ', 'and ') + AFieldUpdate + ' >= :Date');
      FqListAdmin.SQL.Add('order by ' + AIDField);
      if (FDatePeriod <> Null) and (AFieldUpdate <> '') then
        FqListAdmin.Parameters.ParamByName('Date').Value := FDatePeriod;

      FqListAdmin.Open;

      if not Assigned(FqListAdmin.FindField(AIDField)) then
      begin
        Result := AddError('UnloadTable_' + ATable, 'Нет ключевого поля ' + AIDField +
          ' в перечне выгружаемых полей...');
        Exit;
      end;

      if not (FqListAdmin.FieldByName(AIDField).DataType in
        [ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint]) then
      begin
        Result := AddError('UnloadTable_' + ATable, 'Ключевое поле ' + AIDField +
          ' должно быть целым числом...');
        Exit;
      end;

      if FqListAdmin.Active and (FqListAdmin.RecordCount > 0) then
      begin
        ShowStep('', FqListAdmin.RecordCount);
        Writeln(FTextFile, 'UnloadTable');
        M := ''; MS := ''; MB := '';
        for I := 0 to FqListAdmin.FieldCount - 1 do
          case FqListAdmin.Fields[I].DataType of
            ftString, ftFixedChar, ftWideString, ftMemo :
              MS := MS + IfStr(MS = '', '', ',') + FqListAdmin.Fields[I].FieldName;
            ftBlob : MB := MB + IfStr(MB = '', '', ',') + FqListAdmin.Fields[I].FieldName;
            else M := M + IfStr(M = '', '', ',') + FqListAdmin.Fields[I].FieldName +
              ';' + IntToHex(FqListAdmin.Fields[I].DataSize, 4);
          end;

        Writeln(FTextFile, CodeStr(ATable) + CodeStr(AName) + CodeStr(AIDField) +
          CodeStr(M) + CodeStr(MS) + CodeStr(MB) + CodeStr(AIDLoad) + CodeStr(AShopLoad) +
          CodeStr(IfStr(AAddID, 'T', 'F')));
        Writeln(FTextFile, IntToHex(FqListAdmin.RecordCount, 8));
        while not FqListAdmin.Eof and Result do
        begin
          ShowStep('', 0, FqListAdmin.RecNo);

          cList := ''; cListStr := ''; cListBlob := '';

          for I := 0 to FqListAdmin.FieldCount - 1 do
            case FqListAdmin.Fields[I].DataType of
              ftString, ftFixedChar, ftWideString, ftMemo :
                cListStr := cListStr + CodeText(FqListAdmin.Fields[I].AsString);
              ftBlob : cListBlob := cListBlob + CodeStr(ImageToQuery(FqListAdmin.Fields[I].AsBytes));
              else for J := FqListAdmin.Fields[I].DataSize - 1 downto 0 do
                if FqListAdmin.Fields[I].IsNull
                then cList := cList + 'NN'
                else cList := cList + IntToHex(FqListAdmin.Fields[I].AsBytes[J], 2);
            end;

          if M <> '' then Writeln(FTextFile, cList);
          if MS <> '' then Writeln(FTextFile, cListStr);
          if MB <> '' then Writeln(FTextFile, cListBlob);

          if AAddID then AddID(ATable, FqListAdmin.FieldByName(AIDField).AsString);

          if Terminated then Result := False;
          FqListAdmin.Next;
        end;
      end;
    except
      on E: EDatabaseError do Result := AddError('UnloadTable_' + ATable, E.Message);
      on E: Exception do Result := AddError('UnloadTable_' + ATable, E.Message);
      else Result := AddError('UnloadTable_' + ATable, '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;


function TCustomCommunication.LoadTable : boolean;
  var cLine : String; nID : Int64; nCount, nIDStart, nIDSize : Integer;
      cTable, cName, cIDField, cIDLoad, cShopField,
      M, MS, MB : string; I, J, L, nMPos : integer; B : TBytes;
      bAddID, nNull : boolean;
begin
  Result := True;
  Readln(FTextFile, cLine);

  cTable := IsNull(DecodeStr(cLine, 1), '');
  cName := IsNull(DecodeStr(cLine, 2), '');
  cIDField := IsNull(DecodeStr(cLine, 3), '');
  M := IsNull(DecodeStr(cLine, 4), '');
  MS := IsNull(DecodeStr(cLine, 5), '');
  MB := IsNull(DecodeStr(cLine, 6), '');
  cIDLoad := IsNull(DecodeStr(cLine, 7), cIDField);
  cShopField := IsNull(DecodeStr(cLine, 8), '');
  bAddID := DecodeStr(cLine, 9) = 'T';

  nIDStart := 1; nIDSize := 0;
  for I := 1 to CountToken(M, ',') do
  begin
    if Token(Token(M, ',', I), ';', 1) = cIDField then
    begin
      nIDSize := TokenInt(Token(M, ',', I), ';', 2) * 2;
      Break;
    end;
    nIDStart := nIDStart + TokenInt(Token(M, ',', I), ';', 2) * 2;
  end;

  Readln(FTextFile, cLine);
  nCount := HexToInt(cLine);
  try
    ShowStep(cName, nCount);
    for L := 1 to nCount do
    begin
      ShowStep('', 0, L);
      Readln(FTextFile, cLine);
      nID := HexToInt(Copy(cLine, nIDStart, nIDSize));
      try
        try
          FqAdmin.Close;
          FqAdmin.SQL.Clear;
          FqAdmin.SQL.Text := 'select * from ' + cTable + ' where ' +
            cIDLoad + ' = ' + IntToStr(nID) +
            IfStr(cShopField <> '', ' and ' + cShopField + ' = ' + IntToStr(FPlace), '');
          FqAdmin.Open;
          if FqAdmin.RecordCount = 0 then
          begin
            FqAdmin.Insert;
            FqAdmin.FieldByName(cIDLoad).AsLargeInt := nID;
            if cShopField <> '' then FqAdmin.FieldByName(cShopField).AsInteger := FPlace;
          end else FqAdmin.Edit;

          nMPos := 1;
          for I := 1 to CountToken(M, ',') do
          begin
            if Token(Token(M, ',', I), ';', 1) <> cIDField then
            begin
              nNull:= False;
              SetLength(B, TokenInt(Token(M, ',', I), ';', 2));
              for J := TokenInt(Token(M, ',', I), ';', 2) - 1 downto 0 do
              begin
                if Copy(cLine, nMPos, 2) = 'NN'
                then nNull:= True
                else B[J] := HexToInt(Copy(cLine, nMPos, 2));
                Inc(nMPos, 2);
              end;
              if nNull
              then FqAdmin.FieldByName(Token(Token(M, ',', I), ';', 1)).AsVariant := Null
              else FqAdmin.FieldByName(Token(Token(M, ',', I), ';', 1)).AsVariant :=
                ByteToVar(FqAdmin.FieldByName(Token(Token(M, ',', I), ';', 1)).DataType, B);
              SetLength(B, 0)
            end else nMPos := nMPos + TokenInt(Token(M, ',', I), ';', 2) * 2;
          end;

          if MS <> '' then
          begin
            Readln(FTextFile, cLine);
            for I := 1 to CountToken(MS, ',') do
            FqAdmin.FieldByName(Token(MS, ',', I)).AsString :=
              DecodeText(cLine, I);
          end;

          FqAdmin.Post;

          if bAddID then AddID(cTable, FqAdmin.Fields.Fields[0].AsString);
        except
          on E: EDatabaseError do Result := AddError('LoadTable_' + cTable, E.Message);
          on E: Exception do Result := AddError('LoadTable_' + cTable, E.Message);
          else Result := AddError('LoadTable_' + cTable, '');
        end;
      finally
        FqAdmin.Close;
        FqAdmin.SQL.Clear;
      end;

      if not Result then Break;
      if Terminated then Result := False;
    end;
    FqListAdmin.Close;
  except
    on E: EDatabaseError do Result := AddError('LoadTable_' + cTable, E.Message);
    on E: Exception do Result := AddError('LoadTable_' + cTable, E.Message);
    else Result := AddError('LoadTable_' + cTable, '');
  end
end;

{   Выгрузка удалений из SysLog одной таблицы...

        Обязательные данные
     AKey - Ключевое поле в SysLog
     ATable - Имя выгружаемой таблицы
     AName - Название таблицы
     AIDField - Ключевое поле в таблице (должно быть в перечне выгружаемых полей)


        Дополнительные данные
     AWhere - Условие отбора
     AIDLoad - Ключевое поле ID на получателе
     AShopLoad - Ключевое поле Place на получателе
 }


function TCustomCommunication.UnloadDelTable(AKey : integer; ATable, AName, AIDField : string;
  AWhere : string = ''; AIDLoad : string = ''; AShopLoad : string = '') : Boolean;
begin
  Result := True;
  ShowStep('Удаление. ' + AName);
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select * from SysLog where SL_Key = ' + IntToStr(AKey));
  if AWhere <> '' then FqListAdmin.SQL.Add('and ' + AWhere);
  if FDatePeriod <> Null then
  begin
    FqListAdmin.SQL.Add('and SL_Date >= :Date');
    FqListAdmin.Parameters.ParamByName('Date').Value := FDatePeriod;
  end;
  try

    if (AKey = 0) or (ATable = '') or (AName = '') or (AIDField = '') then
    begin
      Result := AddError('UnloadTable_' + ATable, 'Не определены: ' +
        IfStr(AKey = 0, '~Ключевое поле в SysLog', '') +
        IfStr(ATable = '', '~Имя выгружаемой таблицы', '') +
        IfStr(AName = '', '~Название таблицы', '') +
        IfStr(AIDField = '~Ключевое поле в таблице', '', ''));
      Exit;
    end;

    if not FieldExistsAdmin(ATable, AIDField) then
    begin
      Result := AddError('UnloadDelTable_' + ATable, 'Нет ключевого поля ' + AIDField +
        ' в перечне выгружаемых полей...');
      Exit;
    end;

    try
      FqListAdmin.Open;
      if FqListAdmin.Active and (FqListAdmin.RecordCount > 0) then
      begin
        ShowStep('', FqListAdmin.RecordCount);
        Writeln(FTextFile, 'DelTable');
        Writeln(FTextFile, CodeStr(ATable) + CodeStr(AName) + CodeStr(AIDField) +
          CodeStr(AIDLoad) + CodeStr(AShopLoad));
        Writeln(FTextFile, IntToHex(FqListAdmin.RecordCount, 8));
        while not FqListAdmin.Eof and Result do
        begin
          ShowStep('', 0, FqListAdmin.RecNo);
          if not ExistsAdmin(ATable, AIDField + ' = ' + FqListAdmin.FieldByName('SL_SDoc').AsString) then
            Writeln(FTextFile, IntToHex(FqListAdmin.FieldByName('SL_SDoc').AsInteger, 8))
          else Writeln(FTextFile, '00000000');
          if Terminated then Result := False;
          FqListAdmin.Next;
        end;
      end;
    except
      on E: EDatabaseError do Result := AddError('UnloadDelTable_' + ATable, E.Message);
      on E: Exception do Result := AddError('UnloadDelTable_' + ATable, E.Message);
      else Result := AddError('UnloadDelTable_' + ATable, '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TCustomCommunication.LoadDelTable : Boolean;
  var cLine, cTable, cName, cIDField, cIDLoad, cShopField : string;
      nCount, I : Integer;
begin
  Result := True;
  Readln(FTextFile, cLine);

  cTable := IsNull(DecodeStr(cLine, 1), '');
  cName := IsNull(DecodeStr(cLine, 2), '');
  cIDField := IsNull(DecodeStr(cLine, 3), '');
  cIDLoad := IsNull(DecodeStr(cLine, 7), cIDField);
  cShopField := IsNull(DecodeStr(cLine, 8), '');

  Readln(FTextFile, cLine);
  nCount := HexToInt(cLine);
  try
    ShowStep('Удаление; ' + cName, nCount);
    for I := 1 to nCount do
    begin
      ShowStep('', 0, I);
      Readln(FTextFile, cLine);
      if (Copy(cLine, 1, 8) <> '00000000') and ExistsAdmin(cTable,
        cIDLoad + ' = ' + IntToStr(HexToInt(Copy(cLine, 1, 8)))) then
      begin
        if ExistsAdmin('sysforeignkeys', 'rkeyid = (select id from sysobjects where name = ' +
          StrToQuery(cTable) + ' and type = ''U'')') then
          Result := ExecuteAdmin('insert DelDict (DD_Name, DD_DictID) values (' +
          StrToQuery(cTable) + ',' + IntToStr(HexToInt(Copy(cLine, 1, 8))) + ')')
        else Result := ExecuteAdmin('delete ' + cTable + ' where ' +
          cIDLoad + ' = ' + IntToStr(HexToInt(Copy(cLine, 1, 8))));
      end;
      if Terminated then Result := False;
      if not Result then Break;
    end;
  except
    on E: EDatabaseError do Result := AddError('LoadDelTable_' + cTable, E.Message);
    on E: Exception do Result := AddError('LoadDelTable_' + cTable, E.Message);
    else Result := AddError('LoadDelTable_' + cTable, '');
  end
end;

function TCustomCommunication.QUpdateAdmin(const ASQL, AField : String; AValues: OleVariant) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := '';
  if AField = '' then Exit;
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
    FqAdmin.Open;
    if FqAdmin.Active then
    begin
      if FqAdmin.RecordCount = 1 then
      begin
        FqAdmin.Edit;
        L := CountToken(AField, ',');
        for I := 0 to L - 1 do FqAdmin.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqAdmin.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then  FqAdmin.Cancel;
      end;
      FqAdmin.Close;
    end else Result := False;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    if not Result then AddError('QUpdateAdmin', cError, ASQL, AField, '', AValues);
  end;
end;


function TCustomCommunication.UnloadDelDict(const AKey : Integer; const ANameDict : string) : Boolean;
begin
  Result := True;
  ShowStep('Удаленные в справочнике '+ ANameDict);
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select SL_SDoc from SysLog where SL_Key = ' + IntToStr(AKey));
  if FDatePeriod <> Null then
  begin
    FqListAdmin.SQL.Add('and SL_Date >= :Date');
    FqListAdmin.Parameters.ParamByName('Date').Value := FDatePeriod;
  end;
  FqListAdmin.SQL.Add('order by SL_SDoc');
  try
    try
      FqListAdmin.Open;
      if FqListAdmin.Active and (FqListAdmin.RecordCount > 0) then
      begin
        ShowStep('', FqListAdmin.RecordCount);
        Writeln(FTextFile, 'Del' + ANameDict);
        Writeln(FTextFile, IntToHex(FqListAdmin.RecordCount, 8));
        while not FqListAdmin.Eof and Result do
        begin
          ShowStep('', 0, FqListAdmin.RecNo);
          if not ExistsAdmin(ANameDict, DictPrefix(ANameDict) + '_ID = ' + FqListAdmin.FieldByName('SL_SDoc').AsString) then
            Writeln(FTextFile, IntToHex(FqListAdmin.FieldByName('SL_SDoc').AsInteger, 8))
          else Writeln(FTextFile, '00000000');
          if Terminated then Result := False;
          FqListAdmin.Next;
        end;
      end;
    except
      on E: EDatabaseError do Result := AddError('UnloadDelDict', E.Message);
      on E: Exception do Result := AddError('UnloadDelDict', E.Message);
      else Result := AddError('UnloadDelDict', '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

{   Выгрузка данных из SysLog...

        Обязательные данные
     AKey - Ключевое поле в SysLog
     AName - Имя блока в файле выгрузки
     ATitle - Название блока

        Дополнительные данные
     AWhere - Условие отбора
 }


function TCustomCommunication.UnloadSysLog(AKey : integer; AName, ATitle : string; AWhere : string = '') : Boolean;
begin
  Result := True;
  ShowStep(ATitle);
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Add('select distinct SL_SDoc from SysLog where SL_Key = ' + IntToStr(AKey));
  if AWhere <> '' then FqListAdmin.SQL.Add('and ' + AWhere);
  if FDatePeriod <> Null then
  begin
    FqListAdmin.SQL.Add('and SL_Date >= :Date');
    FqListAdmin.Parameters.ParamByName('Date').Value := FDatePeriod;
  end;
  FqListAdmin.SQL.Add('order by SL_SDoc');
  try
    try
      FqListAdmin.Open;
      if FqListAdmin.Active and (FqListAdmin.RecordCount > 0) then
      begin
        ShowStep('', FqListAdmin.RecordCount);
        Writeln(FTextFile, AName);
        Writeln(FTextFile, IntToHex(FqListAdmin.RecordCount, 8));
        while not FqListAdmin.Eof and Result do
        begin
          ShowStep('', 0, FqListAdmin.RecNo);
          Writeln(FTextFile, IntToHex(FqListAdmin.FieldByName('SL_SDoc').AsInteger, 8));
          if Terminated then Result := False;
          FqListAdmin.Next;
        end;
      end;
    except
      on E: EDatabaseError do Result := AddError('UnloadSysLog_' + ATitle, E.Message);
      on E: Exception do Result := AddError('UnloadSysLog_' + ATitle, E.Message);
      else Result := AddError('UnloadSysLog_' + ATitle, '');
    end
  finally
    FqListAdmin.Close;
    FqListAdmin.SQL.Clear;
  end;
end;

function TCustomCommunication.QInsertAdmin(const ASQL, AField : String; AValues: OleVariant) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := '';
  if AField = '' then Exit;
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
    FqAdmin.Open;
    if FqAdmin.Active then
    begin
      if FqAdmin.RecordCount = 0 then
      begin
        FqAdmin.Insert;
        L := CountToken(AField, ',');
        for I := 0 to L - 1 do FqAdmin.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqAdmin.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then  FqAdmin.Cancel;
      end else Result := False;
      FqAdmin.Close;
    end else Result := False;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    if not Result then AddError('QInsertAdmin', cError, ASQL, AField, '', AValues);
  end;
end;

function TCustomCommunication.QInsertAdmin(const ASQL, AField : String; AValues: OleVariant; var AID : Integer) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := ''; AID := 0;
  if AField = '' then Exit;
  if not FconAdmin.Connected then Exit;
  try
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := ASQL;
    FqAdmin.Open;
    if FqAdmin.Active then
    begin
      if FqAdmin.RecordCount = 0 then
      begin
        FqAdmin.Insert;
        L := CountToken(AField, ',');
        for I := 0 to L - 2 do FqAdmin.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqAdmin.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then  FqAdmin.Cancel;
        if Result then AID := FqAdmin.FieldByName(Trim(Token(AField, ',', L))).Value;
      end else Result := False;
      FqAdmin.Close;
    end else Result := False;
  finally
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    if not Result then AddError('QInsertAdmin', cError, ASQL, AField, '', AValues);
  end;
end;

function TCustomCommunication.ExecuteUser(const CommandText: WideString) : Boolean;
  var cError : String;
begin
  Result := False;
  if not FconUser.Connected then Exit;
  try
    try
      FqUser.Close;
      FqUser.SQL.Clear;
      FqUser.SQL.Text := CommandText;
      FqUser.ExecSQL;
      Result := True;
    except
      on E: EDatabaseError do cError := E.Message;
      on E: Exception do cError := E.Message;
      else cError := '';
    end;
  finally
    FqUser.Close;
    FqUser.SQL.Clear;
    if not Result then AddError('ExecuteUser', cError, CommandText, '', '', Null);
  end;
end;

function TCustomCommunication.QUpdateUser(const ASQL, AField : String; AValues: OleVariant) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := '';
  if AField = '' then Exit;
  if not FconUser.Connected then Exit;
  try
    FqUser.Close;
    FqUser.SQL.Clear;
    FqUser.SQL.Text := ASQL;
    FqUser.Open;
    if FqUser.Active then
    begin
      if FqUser.RecordCount = 1 then
      begin
        FqUser.Edit;
        L := CountToken(AField, ',');
        for I := 0 to L - 1 do FqUser.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqUser.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then FqUser.Cancel;
      end;
      FqUser.Close;
    end else Result := False;
  finally
    FqUser.Close;
    FqUser.SQL.Clear;
    if not Result then AddError('QUpdateUser', cError, ASQL, AField, '', AValues);
  end;
end;

function TCustomCommunication.QInsertUser(const ASQL, AField : String; AValues: OleVariant) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := '';
  if AField = '' then Exit;
  if not FconUser.Connected then Exit;
  try
    FqUser.Close;
    FqUser.SQL.Clear;
    FqUser.SQL.Text := ASQL;
    FqUser.Open;
    if FqUser.Active then
    begin
      if FqUser.RecordCount = 0 then
      begin
        FqUser.Insert;
        L := CountToken(AField, ',');
        for I := 0 to L - 1 do FqUser.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqUser.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then  FqUser.Cancel;
      end else Result := False;
      FqUser.Close;
    end else Result := False;
  finally
    FqUser.Close;
    FqUser.SQL.Clear;
    if not Result then AddError('QInsertUser', cError, ASQL, AField, '', AValues);
  end;
end;

function TCustomCommunication.QInsertUser(const ASQL, AField : String; AValues: OleVariant; var AID : Integer) : Boolean;
  var I, L : Integer; cError : String;
begin
  Result := False; cError := ''; AID := 0;
  if AField = '' then Exit;
  if not FconUser.Connected then Exit;
  try
    FqUser.Close;
    FqUser.SQL.Clear;
    FqUser.SQL.Text := ASQL;
    FqUser.Open;
    if FqUser.Active then
    begin
      if FqUser.RecordCount = 0 then
      begin
        FqUser.Insert;
        L := CountToken(AField, ',');
        for I := 0 to L - 2 do FqUser.FieldByName(
          Trim(Token(AField, ',', I + 1))).Value := VarArrayGet(AValues, I);
        try
          FqUser.Post;
          Result := True;
        except
          on E: EDatabaseError do cError := E.Message;
          on E: Exception do cError := E.Message;
          else cError := '';
        end;
        if not Result then  FqUser.Cancel;
        if Result then
          AID := FqUser.FieldByName(TokenTrim(AField, ',', L)).Value;
      end else Result := False;
      FqUser.Close;
    end else Result := False;
  finally
    FqUser.Close;
    FqUser.SQL.Clear;
    if not Result then AddError('QInsertUser', cError, ASQL, AField, '', AValues);
  end;
end;

function TCustomCommunication.SetSQLLoad(const ASQL : string; const AParamLoad : boolean = False) : boolean;
begin
  FParamLoad := AParamLoad;
  FqListAdmin.Close;
  FqListAdmin.SQL.Clear;
  FqListAdmin.SQL.Text := ASQL;
  if FParamLoad then
  begin
    FqListAdmin.Parameters.Items[0].Value := 0;
    FqListAdmin.Parameters.Items[1].Value := FCountOpen;
  end;
  FqListAdmin.Open;
  Result := FqListAdmin.Active;
end;

function TCustomCommunication.PosSQLLoad(AID : Integer) : boolean;
begin
  if FParamLoad and ((FqListAdmin.Parameters.Items[1].Value < AID) or (FqListAdmin.Parameters.Items[0].Value > AID)) then
  begin
    FqListAdmin.Close;
    FqListAdmin.Parameters.Items[0].Value := AID;
    FqListAdmin.Parameters.Items[1].Value := AID + FCountOpen;
    FqListAdmin.Open;
  end;
  Result := FqListAdmin.Locate(FqListAdmin.Fields.Fields[0].FieldName, AID, []);
end;

function TCustomCommunication.FindRecord(AFieldName : String; AID : Integer) : boolean;
begin
  if AFieldName = '' then Result := FqListAdmin.Locate(FqListAdmin.Fields[0].FieldName, AID, [])
  else Result := FqListAdmin.Locate(AFieldName, AID, [])
end;

// возвращает аналитику из номера документа
function TCustomCommunication.DocToAnal(ADocument : Int64) : Integer;
  var S : String;
begin
  if ADocument < 10000000 then Result := 0
  else if ADocument < 1100000000 then
  begin
    S := Format('%10d',[ADocument]);
    Result := StrToInt(Copy(S, 4, 2));
  end else if ADocument < 100000000000 then
  begin
    S := Format('%12d',[ADocument]);
    Result := StrToInt(Copy(S, 5, 3));
  end else
  begin
    S := Format('%13d',[ADocument]);
    Result := StrToInt(Copy(S, 5, 3));
  end;
end;

function TCustomCommunication.GetUnloadDir(APath : string = '') : string;
begin
  Result := FFileDir;
  if Result[Length(Result)] <> '\' then Result := Result + '\';
  if APath <> '' then Result := Result + APath;
  if Result[Length(Result)] <> '\' then Result := Result + '\';
  if not ForceDirectories(Result) then Result := '';
end;

procedure TCustomCommunication.SetParam(const ATypeCommunication : TTypeCommunication; const APlace : Integer;
  const AConnectionString, AUserName, AUserPassword, AFileDir, AXLSDir : String);
begin
  FTypeCommunication := ATypeCommunication;
  FPlace := APlace;
  FConnectionString := AConnectionString;
  FUserName := AUserName;
  FUserPassword := AUserPassword;
  FFileDir := AFileDir;
  FXLSDir := AXLSDir;
end;

procedure TCustomCommunication.ShowStep(ANameOfStep : string; AMax : integer = 0; APos : integer = 0);
  var nPos : integer;
begin
  try
    if ANameOfStep = '' then ANameOfStep := FNameOfStep;
    if (FNameOfStep = ANameOfStep) and (AMax = 0) then AMax := FMax;

    if AMax >= 1 then
    begin
      nPos := APos * 100 div AMax;
      if nPos = 0 then nPos := 1;
    end else nPos := 0;

    if Assigned(FShowNameOfStep) then
    begin
      if (FNameOfStep <> ANameOfStep) or (FMax <> AMax) or (FPosition <> nPos) then
      begin
        FMax := AMax;
        FPosition := nPos;
        if FNameOfStep <> ANameOfStep then
        begin
          FNameOfStep := ANameOfStep;
          FLog := FLog + '~' + ANameOfStep;
        end;
        Synchronize(FShowNameOfStep);
      end;
    end else
    begin
      FMax := AMax;
      FPosition := nPos;
      FNameOfStep := ANameOfStep;
    end;
  except
    on E: Exception do AddError('ShowStep', E.Message)
    else AddError('ShowStep', '');
  end;
end;

function TCustomCommunication.AddError(const AProc, AMessage : String; const AText : string; const AField : string;
  const AParam : string; const AValues: OleVariant) : boolean;
  var I : Integer;

  function StrDel0(AStr : string) : string;
    var I : integer;
  begin
    Result := '';
    for I := 1 to Length(AStr) do
      if AStr[I] = #0 then Result := Result + 'пустая строка'
      else Result := Result + AStr[I];
  end;

begin
  Result := False;
  FLog := FLog + '~' + StrDel0(AMessage);
  if FError <> '' then FError := FError + #13#10;
  if StrDel0(AMessage) <> '' then FError := FError + StrDel0(AMessage) + #13#10#13#10
  else FError := FError + 'Неизвестная ошибка!' + #13#10#13#10;
  if AProc <> '' then FError := FError + 'Процедура : ' + AProc + #13#10;
  if AText <> '' then FError := FError + 'Текст : ' + AText + #13#10;
  if AField <> '' then FError := FError + 'Поля : ' + AField + #13#10;
  if AParam <> '' then FError := FError + 'Параметры : ' + AParam + #13#10;
  if not VarIsNull(AValues) then
  begin
    FError := FError + 'Данные :'+ #13#10;
    for I := 0 to VarArrayHighBound(AValues, 1) do
    try
      if AParam <> '' then
      begin
        if Token(AParam, ',', I + 1) <> '' then
          FError := FError + Token(AParam, ',', I + 1) + ' = '
      end else if AField <> '' then
        if Token(AField, ',', I + 1) <> '' then
          FError := FError + Token(AField, ',', I + 1) + ' = ';

      case VarType(VarArrayGet(AValues, I)) of
        varEmpty : FError := FError + 'Отсутствует' + #13#10;
        varNull : FError := FError + 'Null' + #13#10;
        varSmallint, varInteger, varShortInt, varByte, varWord, varLongWord, varInt64:
          FError := FError + IntToStr(VarArrayGet(AValues, I)) + #13#10;
        varSingle, varDouble, varCurrency, 273:
          FError := FError + FloatToStr(VarArrayGet(AValues, I)) + #13#10;
        varDate : FError := FError + DateTimeToStr(VarArrayGet(AValues, I)) + #13#10;
        varBoolean : FError := FError + BoolToStr(VarArrayGet(AValues, I), True) + #13#10;
      else FError := FError + VarArrayGet(AValues, I) + #13#10;
      end;
    except
      FError := FError + 'Ошибка преобразования' + #13#10;
    end;
  end;
end;

function TCustomCommunication.AddError(const AProc, AMessage : String) : boolean;
begin
  Result := AddError(AProc, AMessage, '', '', '', Null);
end;

procedure TCustomCommunication.AddNote(const ANote : String);
begin
  if FNote = '' then FNote := ANote
  else FNote := FNote + '~' + ANote;
  FLog := FLog + '~' + ANote;
end;

procedure TCustomCommunication.AddInformation(const AInformation : String);
begin
  if FInformation = '' then FInformation := AInformation
  else FInformation := FInformation + '~' + AInformation;
end;

procedure TCustomCommunication.AddXLSFile(const AFile : String);
begin
  if FXLSFile = '' then FXLSFile := AFile
  else FXLSFile := FXLSFile + ';' + AFile;
end;

function TCustomCommunication.AddID(const S: string; const ID : integer): Integer;
begin
  Result := FLoadedIDList.AddID(S, ID)
end;

function TCustomCommunication.AddID(const S, ID: string): Integer;
begin
  Result := FLoadedIDList.AddID(S, ID)
end;

function TCustomCommunication.ExistID(const S: string): Boolean;
begin
  Result := FLoadedIDList.ExistIDList(S);
end;

function TCustomCommunication.GetID(const S: string): String;
begin
  Result := FLoadedIDList.GetIDList(S);
end;

procedure TCustomCommunication.Execute;
begin
  if not Terminated then DoExecute;
end;

function TCustomCommunication.ParsingInfo : boolean;
  var FInfoXML : TXMLDocument; FRoot, N : IXMLNode;
      I : Integer; cError : string;
begin
  Result := False; cError := '';
  try
    if not FileExists(FFileDir + FileInfo) then
    begin
      cError := 'Файл ' + FileInfo + ' не найден...';
      Exit;
    end;
    try
      FInfoXML := TXMLDocument.Create(FconAdmin);
      FInfoXML.LoadFromFile(FFileDir + FileInfo);
      FInfoXML.Active;
      FRoot := FInfoXML.DocumentElement;
      FNXMLZip:='';
      if Assigned(FRoot) then for I := 0 to FRoot.ChildNodes.Count-1 do
      Begin
        N := FRoot.ChildNodes.Get(I);
        if N.Attributes['NAME'] = 'Info' then
        begin   // Только информация по пакету
          FXMLInfo := N.Attributes['INFO'];
        end else if N.Attributes['NAME'] = 'FileTransfer' then
        begin   // Передаваемый файл
          FXMLFileTransfer := N.Attributes['FILE'];     // Имя файла
          FXMLFileTransferSize := N.Attributes['SIZE']; // Размер файла
          FTransferZip := N.Attributes['ZIP'];          // Признак упакованый/не упакованый
        end else if N.Attributes['NAME'] = 'FileName' then
        begin   // Файл передаваемых данных
          FXMLFileName := N.Attributes['FILE'];     // Имя файла
          FXMLFileSize := N.Attributes['SIZE'];     // Размер файла
        end else if N.Attributes['NAME'] = 'FileGZX' then
        begin   // Передаваемый файл
          FNXMLZip := N.Attributes['FILE'];     // Имя файла
//          FXMLFileAdd := N.Attributes['SIZE']; // Размер файла
        end else if N.Attributes['NAME'] = 'FileAdd' then
        begin   // Дополнительный файл
          FXMLFileAdd := N.Attributes['FILE'];          // Имя дополнительного файла
          FXMLFileAddSize := N.Attributes['SIZE'];      // Размер дополнительного файла
        end;
      end;
      FInfoXML.Active := False;
      FInfoXML.Free;
    except
      on E: Exception do cError := E.Message;
      else cError := 'Ошибка обработки файла Info...'
    end;

    if (cError = '') and ((FXMLInfo = '') or (FXMLFileTransfer = '') or
      (FXMLFileTransferSize = 0)) then
      cError := 'Ошибка содержания файла Info...';

    Result := cError = '';
  finally
    if not Result then
    begin
      AddError('ParsingInfo', cError);
    end;
  end;
end;

function TCustomCommunication.GetNumberFile(const AFileName : string; var ANumber : Integer) : boolean;
begin
  Result := False;
  if not CheckToken(ListExt, Token(UpperCase(AFileName), '.', 2), ',') then Exit;
  try
    ANumber := HexToInt(Token(Token(AFileName, '.', 1), '_', 2));
    Result := True;
  except
    on E: Exception do AddError('GetNumberFile', E.Message)
    else AddError('GetNumberFile', '');
  end;
end;

function TCustomCommunication.LoadPop3File : boolean;
  var  pop: TIdPOP3; m: TIdMessage; mc, i, j, nNumber: integer; b : boolean; s : string;
begin
  Result := False; b := False;
  pop:=TIdPOP3.Create(nil);
  pop.Host:= FHost;
  pop.Username:= FPOPUsername;
  pop.Password:= FPOPPassword;

  try
    try
      try
        pop.Connect;
      except
        on E: Exception do AddError('LoadPop3File', E.Message)
        else AddError('LoadPop3File', '');
      end;

      if not pop.Connected then Exit;

      mc := 0; j := 0;
      if (pop.SendCmd('STAT', '') = ST_OK) then
      begin
        s := pop.LastCmdResult.Text[0];
        if Length(s) > 0 then mc := StrToInt(Copy(s, 1, Pos(' ', S) - 1));
      end;

//      mc:=pop.CheckMessages;
      ShowStep('Поиск файла ' + FFileName + ' в почте...', mc);

      while mc > 0 do
      begin
        Inc(j);
        ShowStep('', 0, j);

        m:=TIdMessage.Create(pop);
        try
          try
            pop.Retrieve(mc,m);
          except
            on E: Exception do AddError('LoadPop3File', E.Message)
            else AddError('LoadPop3File', '');
            Exit;
          end;

          for i:=0 to m.MessageParts.Count-1 do
            with m.MessageParts do
              if items[i] is TIdAttachment then
                with TIdAttachment(items[i]) do
                  try
                    if not GetNumberFile(FileName, nNumber) then Continue;
                    if nNumber = FNumber then
                    begin
                      ShowStep('Получение файла ' + FileName, 0);
                      SaveToFile(FFileDir + FileName);
                      b := True;
                    end else if (nNumber + 20) < FNumber then b := True;
                  except
                    on E: Exception do AddError('LoadPop3File', E.Message)
                    else AddError('LoadPop3File', '');
                  end;
        finally
          m.Free;
        end;
        Dec(mc);
        if Terminated or b then Break;
      end;
      Result := True;
    finally
      pop.Free;
    end;
  except
    on E: Exception do AddError('LoadPop3File', E.Message)
    else AddError('LoadPop3File', '');
  end;
end;

function TCustomCommunication.GetFTPDir : string;
begin
  if FTypeCommunication in [cShopUnload, cBaseLoad, cShopForward] then
    Result := 'Shop/'
  else Result := 'Office/';
  Result := Result + IntToStr(FPlace) + '/';
  if FTestServer then Result := FTestServerName + '/' + Result;
end;

function TCustomCommunication.ChangeDirFTPPublic(AIdFTP : TIdFTP) : Boolean;
begin
  Result:= ChangeDirFTP(AIdFTP, GetFTPDir, true);
end;


function TCustomCommunication.ChangeDirFTP(AIdFTP : TIdFTP; ADir : String; ACreate : Boolean = true) : Boolean;
  var S:string;
Begin
  Result := false;
  if ADir[length(ADir)]<>'/' then ADir:=ADir+'/';
  AIdFTP.ChangeDir('/');

  while ADir <> '' do
  Begin
    S:=Copy(ADir,1,pos('/',ADir)-1);
    try
      AIdFTP.ChangeDir(S);
    except
      if ACreate then
      try
        AIdFTP.MakeDir(S);
        AIdFTP.ChangeDir(S);
      Except
        exit;
      end else Exit;
    end;
    Delete(ADir,1,pos('/',ADir));
  End;
  Result:=True;
End;

function TCustomCommunication.ConnectFTPServerPublic(var AError : string) : TIdFTP;
begin
  Result:= ConnectFTPServer(AError);
end;


function TCustomCommunication.ConnectFTPServer(var AError : string) : TIdFTP;
  var I : Integer; S : string;
begin
  AError := '';
  Result := Tidftp.Create(nil);
  Result.Passive := True;
  Result.TransferType := ftBinary;
  Result.UseExtensionDataPort := True;

  Result.Port := FFTPPort;
  Result.Username := FFTPUserName;
  Result.Password := FFTPPassword;

  for I := 1 to CountToken(FFTPHost, ',') do
  begin
    if not Assigned(FShowNameOfStep) or Ping(PAnsiChar(AnsiString(Token(FFTPHost, ',', I))), S) then
    try
      Result.Host := Token(FFTPHost, ',', I);
      Result.Connect;
    except
      on E: Exception do AError := AError + #13#10 + E.Message
    end;
    if Result.Connected then Break;
  end;

  if not Result.Connected then AError := 'Ошибка подключения к FTP серверу.' + AError
  else AError := '';
end;

function TCustomCommunication.LoadFTPFile : boolean;
  var idftp: TIdFTP; cError : string;
begin
  Result := False;
  idftp := ConnectFTPServer(cError);
  try
    if not idftp.Connected then Exit;

    try
      if not ChangeDirFTP(IdFTP, GetFTPDir, False) then Exit;
      if idftp.Size(FileInfo) > 0 then
      begin
        idftp.Get(FileInfo, FFileDir + FileInfo, True);
        if not ParsingInfo then Exit;
        idftp.Get(FileTransfer, FFileDir + FileTransfer, True);
        if FileAdd <> '' then
        begin
          if FNXMLZip<>'' then
          begin
            idftp.Get(FNXMLZip, FFileDir + FNXMLZip, True);
          end
          else idftp.Get(FileAdd, FFileDir + FileAdd, True);
        end;
      end;
      Result := True;
    except
      on E: Exception do cError := E.Message;
    end;
  finally
    idftp.Free;
    if not Result then AddError('LoadFTPFile', 'Ошибка получения файла ' + FileTransfer + ' через FTP сервер ~~' + cError);
  end;
end;

function TCustomCommunication.DoConnectPublic : Boolean;
begin
  Result:= DoConnect;
end;

function TCustomCommunication.DoConnect : Boolean;
  var cError : String;
      qProc : TADOStoredProc;
begin
  Result := False; cError := '';
  try
      // Проверка переменных
    ShowStep('Начало обработки...');
    if (FTypeCommunication = cNone) or (FConnectionString = '') or
      (FUserName = '') or (FUserPassword = '') then
    begin
      cError := 'Не заполнены параметры подключения...';
      Exit;
    end;

      // Подключение к БД пользователем
    ShowStep('Соединение к основной БД пользователем');
    FconUser.ConnectionString := FConnectionString;
    try
      FconUser.Open(FUserName, FUserPassword);
      FconUser.Execute('Set Transaction Isolation Level Read Uncommitted');
    except
      on E: EDatabaseError do cError := E.Message;
      on E: Exception do cError := E.Message;
      else cError := 'Ошибка подключения'
    end;

    if FconUser.Connected then
    begin

      FSAPassword := '';
      qProc := TADOStoredProc.Create(nil);
      qProc.Connection := FconUser;
      qProc.ProcedureName := 'GetSAPassword';
      try
        qProc.Parameters.Refresh;
        qProc.Parameters.ParamByName('@cPassword').Value := Null;
        qProc.ExecProc;
        FSAPassword := UnCryptingPassword(qProc.Parameters.ParamByName('@cPassword').Value);
      except
        on E: EDatabaseError do cError := E.Message;
        on E: Exception do cError := E.Message;
        else cError := ''
      end;
      qProc.Free;
    end else Exit;

    if FSAPassword = '' then
    begin
      if cError = '' then cError := 'Ошибка получения пароля администратора...';
      Exit;
    end;

      // Подключение к БД администратором
    ShowStep('Подключение к основной БД администратором');
    FconAdmin.ConnectionString := FConnectionString;
    try
      FconAdmin.Open('SA', FSAPassword);
      FconAdmin.Execute('Set Transaction Isolation Level Read Uncommitted');
    except
      on E: EDatabaseError do cError := '~' + E.Message;
      on E: Exception do cError := '~' + E.Message;
      else cError := '~Ошибка подключения';
    end;

    if FconAdmin.Connected then
    begin
      ShowStep('Тип сервера');
      if ExistsAdmin('select * from master.sys.extended_properties where name = ''type''') then
      begin
        if ExistsAdmin('select * from master.sys.extended_properties where name = ''type'' and ' +
          'convert(varchar, value) = ''test''') then FTestServer := true;
      end;
    end;

      // Данные о магазине (офис)
    if not Terminated and (FTypeCommunication in [cBaseUnload, cBaseLoad, cBaseForward, cBaseReceive]) and FconAdmin.Connected then
    begin

      ShowStep('Базовые параметры');
      FqAdmin.SQL.Clear;
      FqAdmin.SQL.Add('select Con_FTPHost, Con_FTPPort, Con_FTPUserName, Con_FTPPassword, ' +
        ' Con_NationalCurr, Con_WarehouseMailFile from Config');
      try
        FqAdmin.Open;
        if FqAdmin.RecordCount = 1 then
        begin
          FFTPHost := Trim(FqAdmin.FieldByName('Con_FTPHost').AsString);
          FFTPPort := FqAdmin.FieldByName('Con_FTPPort').AsInteger;
          FFTPUserName := Trim(FqAdmin.FieldByName('Con_FTPUserName').AsString);
          FFTPPassword := UnCryptingPassword(FqAdmin.FieldByName('Con_FTPPassword').AsString);
          FNationalCur := FqAdmin.FieldByName('Con_NationalCurr').AsInteger;
          FWarehouseMailFile := Trim(FqAdmin.FieldByName('Con_WarehouseMailFile').AsString);
        end;
      except
        on E: EDatabaseError do cError := E.Message;
        on E: Exception do cError := E.Message;
        else cError := 'Ошибка получение базовых параметров...'
      end;
      if FqAdmin.Active then FqAdmin.Close;

      ShowStep('Данные о магазине');
      FqAdmin.SQL.Clear;
      FqAdmin.SQL.Add('select Pl_ID, Pl_Name, Pl_Supermarcet, Pl_Salon, Pl_SendSupplier, Pl_PlacePrice, Pl_Person,');
      FqAdmin.SQL.Add('Pl_StartShopDoc, Pl_Mail, Pl_MailLogin, Pl_MailPass, Pl_ExchangeData, Pl_IPAdrec, Pl_BDName, Pl_Password,');
      FqAdmin.SQL.Add('(select top 1 Su_ID from Subdivision where Su_TimeBoard = 1 and Su_Depart = Pl_Depart) as Pl_Subdivision,');
      FqAdmin.SQL.Add('IsNull(PPr_Currency,' + IntToStr(FNationalCur) + ') as PPr_Currency,pl_isocupate');
      FqAdmin.SQL.Add('from Place left outer join PlacePrice on PPr_ID = Pl_PlacePrice where Pl_ID = ' + IntTostr(FPlace));
      FqAdmin.SQL.Add('order by Pl_ID');

      try
        FqAdmin.Open;
        if FqAdmin.RecordCount = 1 then
        begin
          FSupermarcet := FqAdmin.FieldByName('Pl_Supermarcet').AsBoolean;
          FSalon := FqAdmin.FieldByName('Pl_Salon').AsBoolean;
          FSelfService := FqAdmin.FieldByName('Pl_SendSupplier').AsBoolean;
          FPlacePrice := FqAdmin.FieldByName('Pl_PlacePrice').AsInteger;
          FPlaceCur := FqAdmin.FieldByName('PPr_Currency').AsInteger;
          FSubdivision := FqAdmin.FieldByName('Pl_Subdivision').AsInteger;
          FPerson := FqAdmin.FieldByName('Pl_Person').AsInteger;
          FDateStart := FqAdmin.FieldByName('Pl_StartShopDoc').AsVariant;
          FExchangeData := FqAdmin.FieldByName('Pl_ExchangeData').AsInteger;
          FSMTPUsername := Trim(FqAdmin.FieldByName('Pl_Mail').AsString);
          FPOPUsername := Trim(FqAdmin.FieldByName('Pl_MailLogin').AsString);
          FPOPPassword := UnCryptingPassword(FqAdmin.FieldByName('Pl_MailPass').AsString);
          FIPAdrecShop := Trim(FqAdmin.FieldByName('Pl_IPAdrec').AsString);
          FBDNameShop := Trim(FqAdmin.FieldByName('Pl_BDName').AsString);
          FSAPasswordShop := UnCryptingPassword(FqAdmin.FieldByName('Pl_Password').AsString);
          FIsOcupate := FqAdmin.FieldByName('pl_isocupate').AsBoolean;
        end;
      except
        on E: EDatabaseError do cError := E.Message;
        on E: Exception do cError := E.Message;
        else cError := 'Ошибка открытия справочника магазинов...'
      end;

      if FqAdmin.Active and (cError = '') then
      begin
        if FqAdmin.RecordCount <> 1 then cError := 'Ошибка получения данных о магазине...'
        else if FPerson = 0 then cError := 'Ошибка получения администратора магазина...'
        else if FSubdivision = 0 then cError := 'Ошибка получения подразделения магазина...';
      end else FconAdmin.Close;
      if FqAdmin.Active then FqAdmin.Close;
    end;

      // Данные о магазине (магазин)
    if not Terminated and (FTypeCommunication in [cShopUnload, cShopLoad, cShopForward, cShopReceive]) and FconAdmin.Connected then
    begin
      ShowStep('Данные о магазине');
      if not QGetFieldAdmin('SELECT UR_Person FROM UserRight WHERE LTrim(UR_Name) = ''' + FUserName + '''',
        'UR_Person', FPerson) then Exit;
      if FieldExistsAdmin('Config', 'Con_CadreSmall') then
      begin
        FSMShop := True;
        if not QGetFieldAdmin('SELECT Con_CadreSmall FROM Config', 'Con_CadreSmall', FCadreSmall) then Exit;
      end else FCadreSmall := True;

      FqAdmin.SQL.Clear;
      FqAdmin.SQL.Add('select Con_MailHost, Con_BuhMailLogin, Con_BuhMailPass, Con_MainMail, ' +
        'Con_ClientMain, Con_OperLoad, Con_GrDocOper, Con_GrDocClient, Con_GrDocClientRRO, Con_DateMailStart, ' +
        'Con_ExchangeData, Con_FTPHost, Con_FTPPort, Con_FTPUserName, Con_FTPPassword, ' +
        'Con_DateNalogStart, Con_NationalCurr, Con_ShopMain, Con_WarehouseMailFile from Config');

      try
        FqAdmin.Open;
        if FqAdmin.RecordCount = 1 then
        begin
          FExchangeData := FqAdmin.FieldByName('Con_ExchangeData').AsInteger;
          if Trim(FqAdmin.FieldByName('Con_MailHost').AsString) <> '' then
            FHost := Trim(FqAdmin.FieldByName('Con_MailHost').AsString);
          FSMTPUsername := Trim(FqAdmin.FieldByName('Con_MainMail').AsString);
          FPOPUsername := Trim(FqAdmin.FieldByName('Con_BuhMailLogin').AsString);
          FPOPPassword := UnCryptingPassword(FqAdmin.FieldByName('Con_BuhMailPass').AsString);
          FFTPHost := Trim(FqAdmin.FieldByName('Con_FTPHost').AsString);
          FFTPPort := FqAdmin.FieldByName('Con_FTPPort').AsInteger;
          FFTPUserName := Trim(FqAdmin.FieldByName('Con_FTPUserName').AsString);
          FFTPPassword := UnCryptingPassword(FqAdmin.FieldByName('Con_FTPPassword').AsString);
          FOperLoad := FqAdmin.FieldByName('Con_OperLoad').AsInteger;
          FGrDocOper := FqAdmin.FieldByName('Con_GrDocOper').AsInteger;
          FGrDocClient := FqAdmin.FieldByName('Con_GrDocClient').AsInteger;
          FGrDocClientRRO := FqAdmin.FieldByName('Con_GrDocClientRRO').AsInteger;
          FDateStart := FqAdmin.FieldByName('Con_DateMailStart').AsDateTime;
          FDateNalogStart := FqAdmin.FieldByName('Con_DateNalogStart').AsDateTime;
          FNationalCur := FqAdmin.FieldByName('Con_NationalCurr').AsInteger;
          FPlaceCur := FqAdmin.FieldByName('Con_NationalCurr').AsInteger;
          FShopMain := FqAdmin.FieldByName('Con_ShopMain').AsInteger;
          FWarehouseMailFile := Trim(FqAdmin.FieldByName('Con_WarehouseMailFile').AsString);
        end;
      except
        on E: EDatabaseError do cError := E.Message;
        on E: Exception do cError := E.Message;
        else cError := 'Ошибка получение данных о магазине...'
      end;

      if FqAdmin.Active and (cError = '') then
      begin
        if FqAdmin.RecordCount <> 1 then cError := 'Ошибка получение данных о магазине...'
        else if FOperLoad = 0 then cError :='Не определена операция загрузки приходов.'
        else if (FTypeCommunication = cShopUnload) and (FGrDocOper = 0) then cError :='Не определена операция для группировки расходов для выгрузки.'
        else if (FTypeCommunication = cShopUnload) and (FGrDocClient = 0) then cError :='Не определен покупатель для группировки расходов для выгрузки.'
        else if (FTypeCommunication = cShopUnload) and (FGrDocClientRRO = 0) then cError :='Не определен покупатель для группировки расходов по РРО для выгрузки.'
        else if FDateStart = Null then cError :='Не определена дата выгрузки документов в конфигурации.';
      end else FconAdmin.Close;
      if FqAdmin.Active then FqAdmin.Close;
    end;
  finally
    if FconUser.Connected and not FconAdmin.Connected then FconAdmin.Close;
    if cError <> '' then AddError('DoConnect', cError)
    else Result := Connected;
  end;
end;

function TCustomCommunication.DoGetParam : Boolean;
  var cError, S : String; nSize : integer;
begin
  Result := False; cError := '';
  ShowStep('Получение параметров');
  try
    if Terminated then Exit;

    if not QGetFieldAdmin('select GETDATE() as Date', 'Date', FDateCurr) then FDateCurr := Now;
    if FTypeCommunication in [cBaseUnload, cBaseLoad] then
    begin
      if not QGetFieldAdmin('select Pl_StartShopDoc from Place where Pl_ID = ' + IntToStr(FPlace),
        'Pl_StartShopDoc', FDateStartDoc) then Exit;

      if (FTypeCommunication = cBaseLoad) then
      begin

        if FDateStartDoc = Null then
        begin
          cError := 'Не предусмотрена загрузка документов...';
          Exit;
        end;

        if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0') and
           not ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) +
           ' and HL_Size = 0 and HL_Date > DateAdd(n, - 5, GetDate())') then
           ExecuteAdmin('delete HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0');

        if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0') then
        begin
          cError := 'Кто-то производит загрузку данных с магазина.'#13#10'Повторите загрузку через 5 минут...';
          Exit;
        end;

        if ExistsAdmin('select * from HistLoad where HL_Date > GetDate() and HL_Place = :Place',
          'Place', VarArrayOf([FPlace])) then
        begin
          cError := 'Дата загрузки меньше даты последней загрузки.';
          Exit;
        end;

        if ExistsAdmin('select HL_Number from HistLoad where HL_Place = ' + IntToStr(FPlace)) then
        begin
          if not QGetFieldAdmin('select Max(HL_Number) + 1 as HL_Number from HistLoad where HL_Place = ' + IntToStr(FPlace),
            'HL_Number', FNumber) then Exit;
        end else FNumber := 1;

        FFileName := 'E' + IntToStr(FPlace) + '_' + IntToHex(FNumber, 4);
      end else
      begin

        if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') and
           not ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) +
           ' and HU_Size = 0 and HU_Date > DateAdd(n, - 5, GetDate())') then
           ExecuteAdmin('delete HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0');

        if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') then
        begin
          cError := 'Кто-то производит выгрузку данных на магазин.'#13#10'Повторите выгрузку через 5 минут...';
          Exit;
        end;

        if ExistsAdmin('select * from HistUnload where HU_Date > :Date and HU_Place = :Place',
          'Date,Place', VarArrayOf([Now, FPlace])) then
        begin
          cError := 'Дата выгрузки меньше даты последней выгрузки.';
          Exit;
        end;

        if ExistsAdmin('select HU_Number from HistUnLoad where HU_Place = ' + IntToStr(FPlace)) then
        begin
          if not QGetFieldAdmin('select Max(HU_Number) + 1 as HU_Number from HistUnload where HU_Place = ' + IntToStr(FPlace),
            'HU_Number', FNumber) then Exit;
        end else FNumber := 1;

        if ExistsAdmin('select HU_Date as HU_Date from HistUnload where HU_Place = ' +
          IntToStr(FPlace) + ' and HU_DatePeriod is not Null') then
          if not QGetFieldAdmin('select Max(HU_Date) as HU_Date from HistUnload where HU_Place = ' +
          IntToStr(FPlace) + ' and HU_DatePeriod is not Null', 'HU_Date',
          FDatePeriod) then FDatePeriod := Null;

        if FDatePeriod <> Null then FDatePeriod := IncMinute(FDatePeriod, - 4);

        if (FDatePeriod = Null) and (UpperCase(FUserName) <> 'SA') then
        begin
          cError := 'Первые отправка выполняется администратором.';
          Exit;
        end;
        if FService then FDatePeriod := Null;

        FFileName := 'S' + IntToStr(FPlace) + '_' + IntToHex(FNumber, 4);
      end
    end else if FTypeCommunication in [cShopUnload, cShopLoad] then
    begin

      if (FTypeCommunication = cShopLoad) then
      begin

        if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0') and
           not ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) +
           ' and HL_Size = 0 and HL_Date > DateAdd(n, - 5, GetDate())') then
           ExecuteAdmin('delete HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0');

        if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0') then
        begin
          cError := 'Кто-то производит загрузку данных с офиса.'#13#10'Повторите загрузку через 5 минут...';
          Exit;
        end;

        if ExistsAdmin('select * from HistLoad where HL_Date > GetDate() and HL_Place = :Place',
          'Place', VarArrayOf([FPlace])) then
        begin
          cError := 'Дата загрузки меньше даты последней загрузки.';
          Exit;
        end;

        if ExistsAdmin('select HL_Number from HistLoad where HL_Place = ' + IntToStr(FPlace)) then
        begin
        if not QGetFieldAdmin('select Max(HL_Number) + 1 as HL_Number from HistLoad where HL_Place = ' + IntToStr(FPlace),
          'HL_Number', FNumber) then Exit;
        end else FNumber := 1;

        FFileName := 'S' + IntToStr(FPlace) + '_' + IntToHex(FNumber, 4);
      end else
      begin

        if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') and
           not ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) +
           ' and HU_Size = 0 and HU_Date > DateAdd(n, - 5, GetDate())') then
           ExecuteAdmin('delete HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0');

        if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') then
        begin
          cError := 'Кто-то производит выгрузку данных на офис.'#13#10'Повторите выгрузку через 5 минут...';
          Exit;
        end;

        if ExistsAdmin('select * from HistUnload where HU_Date > :Date and HU_Place = :Place',
          'Date,Place', VarArrayOf([Now, FPlace])) then
        begin
          cError := 'Дата выгрузки меньше даты последней выгрузки.';
          Exit;
        end;

        if ExistsAdmin('select HU_Number from HistUnLoad where HU_Place = ' + IntToStr(FPlace)) then
        begin
          if not QGetFieldAdmin('select Max(HU_Number) + 1 as HU_Number from HistUnload where HU_Place = ' + IntToStr(FPlace),
            'HU_Number', FNumber) then Exit;
        end else FNumber := 1;

        if FTypeDoc = 2 then
        begin
          if FieldExistsAdmin('InvSheet','IS_ShopUnload') then
          Begin
            if not QGetFieldAllAdmin('select IS_ID from InvSheet where IS_ShopUnload is Null and ' +
              'IS_DateDSigned >= :Date and IS_Date >= ''20130901'' and IS_IsMove = ''Y'' order by IS_ID',
              'IS_ID', 'Date', ',', VarArrayOf([FDateStart]), S) then S := '';
            if S <> '' then FLoadedIDList.Add('InvSheet,' + S);
          end;
          if not QGetFieldAllAdmin('select ISP_ID from InvSheetPlan where ISP_ShopUnload is Null and ' +
            'ISP_Date >= :Date and ISP_IsMove = ''Y'' order by ISP_ID',
            'ISP_ID', 'Date', ',', VarArrayOf([FDateStart]), S) then S := '';
          if S <> '' then FLoadedIDList.Add('InvSheetPlan,' + S);
          if not QGetFieldAllAdmin('select ISA_ID from InvSheetAct where ISA_ShopUnload is Null and ' +
            'ISA_Date >= :Date and ISA_IsSigned = ''Y'' order by ISA_ID',
            'ISA_ID', 'Date', ',', VarArrayOf([FDateStart]), S) then S := '';
          if S <> '' then FLoadedIDList.Add('InvSheetPlan,' + S);
        end;

        FFileName := 'E' + IntToStr(FPlace) + '_' + IntToHex(FNumber, 4);
      end
    end else if FTypeCommunication in [cBaseForward, cShopForward] then
    begin

      if not ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Number = ' +
        IntToStr(FNumForward)) then
      begin
        cError := 'Не найдена выгрузка с номером - ' + IntToStr(FNumForward);
        Exit;
      end;

      FFileName := IfStr(FTypeCommunication in [cBaseForward], 'S', 'E') + IntToStr(FPlace) + '_' + IntToHex(FNumForward, 4);

      if not FileExists(FFileDir + FileName) then
      begin
        if not FileExists(FFileDir + FileInfo) then ReceivingWarehouseMailFile;

        if not FileExists(FFileDir + FileInfo) then
        begin
          cError := 'Файл ' + FileInfo + ' не найден...';
          Exit;
        end;

          // Разбор INI файла
        if not ParsingInfo then Exit;

          // Проверка загружаемого файла
        if not FileExists(FFileDir + FileTransfer) then
        begin
          cError := 'Файл ' + FileTransfer + ' не загружен...~Повторите загрузку файлов...';
          Exit;
        end;

        if FTransferZip then
        begin
          ShowStep('Распаковка файла ' + FFileDir + FileTransfer);
          if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
          try
            GZDecompressFile(FFileDir + FileTransfer, FFileDir);
          except
            cError := 'Ошибка распаковки файла ' + FileZip + #13#10'Файл удален.' + #13#10 +
              'Повторите загрузку файлов....';
            Exit;
          end;
        end;
      end;

      if not FileExists(FFileDir + FileName) then
      begin
        cError := 'Файл ' + FileName + ' не найден...';
        Exit;
      end;

      if not QGetFieldAdmin('select HU_ID from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Number = ' +
        IntToStr(FNumForward), 'HU_ID', FIDHist) then
      begin
        cError := 'Ошибка получения ID выгрузки с номером - ' + IntToStr(FNumForward);
        Exit;
      end;

      if not QGetFieldAdmin('select HU_Size from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Number = ' +
        IntToStr(FNumForward), 'HU_Size', nSize) then
      begin
        cError := 'Ошибка получения ID выгрузки с номером - ' + IntToStr(FNumForward);
        Exit;
      end;


      if nSize <> ONumUtils.GetFileSize(FFileDir + FileName) then
      begin
        cError := 'Размер файла ' + FileName + ' отличается от автоматически сформированного...';
        Exit;
      end;

      if Assigned(FConfirmation) then
      begin
        FConfirmationType := 1;
        FConfirmationText := '';
        Synchronize(FConfirmation);
        Suspended := True;
      end;
      if Terminated then Exit;

      AddNote('Повторная отправка файла ' + FileName + '.');
    end else if FTypeCommunication in [cBaseReceive, cShopReceive] then
    begin
      if not ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Number = ' +
        IntToStr(FNumForward)) then
      begin
        cError := 'Не найдена выгрузка с номером - ' + IntToStr(FNumForward);
        Exit;
      end;

      FFileName := IfStr(FTypeCommunication in [cBaseReceive], 'S', 'E') + IntToStr(FPlace) + '_' + IntToHex(FNumForward, 4);

      if not QGetFieldAdmin('select HU_ID from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Number = ' +
        IntToStr(FNumForward), 'HU_ID', FIDHist) then
      begin
        cError := 'Ошибка получения ID выгрузки с номером - ' + IntToStr(FNumForward);
        Exit;
      end;

      if Terminated then Exit;

      AddNote('Получение отправленных файлов.');
    end else
    begin
      cError := 'Неизвестный вид действия...';
      Exit;
    end;
    Result := True;
  finally
    if not Result then AddError('DoGetParam', cError);
  end;
end;

function TCustomCommunication.DoCreateFile : Boolean;
  var cError : String;
begin
  Result := False; cError := '';
  ShowStep('Подготовка выгрузки...');
  try

    if Assigned(FConfirmation) then
    begin
      FConfirmationType := 1;
      FConfirmationText := '';
      Synchronize(FConfirmation);
      Suspended := True;
    end;

    if Terminated then Exit;

    if (FTypeCommunication = cBaseUnload) then
    begin

      if (FDatePeriod <> Null) and (IncMinute(FDatePeriod, 8) >= Now) then
      begin
        cError := 'Повторная отправка данных на магазин возможна только через 4 минуты после предыдущей.';
        Exit;
      end;

      if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') then
      begin
        cError := 'Кто-то производит выгрузку данных на магазин.'#13#10'Повторите выгрузку через 5 минут...';
        Exit;
      end;

      if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) +
        ' and HU_Number = ' +  IntToStr(FNumber)) then
      begin
        cError := 'Кто-то уже выгрузил данные на магазин.'#13#10'Повторите загрузку через 5 минут...';
        Exit;
      end;

      if not QInsertUser('select * from HistUnload where HU_ID = 0',
        'HU_Place,HU_Number,HU_Date,HU_File,HU_Size,HU_ID', VarArrayOf([
        FPlace, FNumber, FDateCurr, '', 0]), FIDHist) then
      begin
        cError := 'Ошибка начала выгрузки.'#13#10'Повторите выгрузку...';
        Exit;
      end;

      if not ForceDirectories(FFileDir) then
      begin
        cError := 'Ошибка создания папки ' + FFileDir;
        Exit;
      end;

      {$I-}
      AssignFile(FTextFile, FFileDir + FileName);
      Rewrite(FTextFile);
      {$I+}
      if IOResult <> 0 then
      begin
        cError := 'Ошибка создания файла ' + FFileDir + FileName;
        Exit;
      end;
      if not FService then AddNote('Выгрузка справочников.');
      if FRemainder then AddNote('Остатков по складам.');
      Writeln(FTextFile, 'KHEOS' + IntToHex(FPlace,4) + IntToHex(FNumber,4));
    end else
    begin

      if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) + ' and HU_Size = 0') then
      begin
        cError := 'Кто-то производит выгрузку данных на офис.'#13#10'Повторите выгрузку через 5 минут...';
        Exit;
      end;

      if ExistsAdmin('select * from HistUnload where HU_Place = ' + IntToStr(FPlace) +
        ' and HU_Number = ' +  IntToStr(FNumber)) then
      begin
        cError := 'Кто-то уже выгрузил данные на офис.'#13#10'Повторите загрузку через 5 минут...';
        Exit;
      end;

      if not QInsertUser('select * from HistUnload where HU_ID = 0',
        'HU_Place,HU_Number,HU_Date,HU_File,HU_Size,HU_ID', VarArrayOf([
        FPlace, FNumber, FDateCurr, '', 0]), FIDHist) then
      begin
        cError := 'Ошибка начала выгрузки.'#13#10'Повторите выгрузку...';
        Exit;
      end;

      if not ForceDirectories(FFileDir) then
      begin
        cError := 'Ошибка создания папки ' + FFileDir;
        Exit;
      end;

      {$I-}
      AssignFile(FTextFile, FFileDir + FileName);
      Rewrite(FTextFile);
      {$I+}
      if IOResult <> 0 then
      begin
        cError := 'Ошибка создания файла ' + FFileDir + FileName;
        Exit;
      end;
      if not FService then AddNote('Выгружено.');
      Writeln(FTextFile, 'KHEOM' + IntToHex(FPlace,4) + IntToHex(FNumber,4));
    end;

    Result := True;
  finally
    if not Result then AddError('DoCreateFile', cError);
  end;
end;

function TCustomCommunication.DoReceivingFile : Boolean;
  var cError : String; bDelFile : boolean;
begin
  Result := False; cError := ''; bDelFile := True;
  ShowStep('Получение файла...');
  try

    if not ForceDirectories(FFileDir) then
    begin
      cError := 'Ошибка создания папки ' + FFileDir;
      Exit;
    end;

    if FUploadFile and (FTypeCommunication in [cBaseReceive, cShopReceive]) and
      (FWarehouseMailFile <> '') and not FileExists(FFileDir + FileInfo) then
      ReceivingWarehouseMailFile;

    if FUploadFile and not FileExists(FFileDir + FileInfo) then
    begin
      if (FExchangeData = 0) and (FPOPUsername <> '') and (FPOPPassword <> '') then
      begin
        if Assigned(FConfirmation) then
        begin
          FConfirmationType := 0;
          FConfirmationText := '';
          Synchronize(FConfirmation);
          Suspended := True;
        end;

        if Terminated then Exit;
        if FUploadFile then if not LoadPop3File then Exit;
      end;

      if (FExchangeData = 1) and (FFTPHost <> '') and (FFTPPort <> 0) and (FFTPUserName <> '') and (FFTPPassword <> '') then
      begin
        if Assigned(FConfirmation) then
        begin
          FConfirmationType := 0;
          FConfirmationText := '';
          Synchronize(FConfirmation);
          Suspended := True;
        end;

        if Terminated then Exit;
        if FUploadFile then if not LoadFTPFile then Exit;
        if FUploadFile and (FTypeCommunication in [cBaseLoad]) and (FWarehouseMailFile <> '') and
          not FileExists(FFileDir + FileInfo) then LoadWarehouseMailFile;
      end;
    end;

    if FileExists(FFileDir + FileInfo) then
    begin
        // Разбор INI файла
      if not ParsingInfo then Exit;

        // Проверка загружаемого файла
      if not FileExists(FFileDir + FileTransfer) then
      begin
        cError := 'Файл ' + FileTransfer + ' не загружен...~Повторите загрузку файлов...';
        Exit;
      end;

      if (FXMLFileAdd <> '') and (FNXMLZip<>'') then
      begin
        ShowStep('Распаковка файла ' + FFileDir + FNXMLZip);
        if FileExists(FFileDir + FXMLFileAdd) then DeleteFile(FFileDir + FXMLFileAdd);
        try
          GZDecompressFile(FFileDir + FNXMLZip, FFileDir);
        except
          cError := 'Ошибка распаковки файла ' + FNXMLZip + #13#10'Файл удален.' + #13#10 +
            'Повторите загрузку файлов....';
          Exit;
        end;
      end;

      if (FXMLFileAdd <> '') and not FileExists(FFileDir + FXMLFileAdd) then
      begin
        cError := 'Файл ' + FXMLFileAdd + ' не загружен...~Повторите загрузку файлов...';
        Exit;
      end;

      if ONumUtils.GetFileSize(FFileDir + FileTransfer) <> FXMLFileTransferSize then
      begin
        cError := 'Размер полученого файла ' + FileTransfer + ' отличается от отправленного...~~Файлы удалены...~Повторите загрузку файлов...';
        Exit;
      end;

//      if (FXMLFileAdd <> '') and (ONumUtils.GetFileSize(FFileDir + FXMLFileAdd) <> FXMLFileAddSize) then
//      begin
//        cError := 'Размер полученого файла ' + FXMLFileAdd + ' отличается от отправленного...~~Файлы удалены...~Повторите загрузку файлов...';
//        Exit;
//      end;

      if FTransferZip then
      begin
        ShowStep('Распаковка файла ' + FFileDir + FileTransfer);
        if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
        try
          GZDecompressFile(FFileDir + FileTransfer, FFileDir);
        except
          cError := 'Ошибка распаковки файла ' + FileZip + #13#10'Файл удален.' + #13#10 +
            'Повторите загрузку файлов....';
          Exit;
        end;
      end;

        // Проверка файла данных
      if FileExists(FFileDir + FileName) and (ONumUtils.GetFileSize(FFileDir + FileName) <> FXMLFileSize) then
      begin
        cError := 'Размер файла данных ' + FileTransfer + ' отличается от отправленного...~~Файл удален...~Повторите загрузку файлов...';
        Exit;
      end;
    end else if FileExists(FFileDir + FileZip) then
    begin
      ShowStep('Распаковка файла ' + FFileDir + FileZip);
      if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
      try
        GZDecompressFile(FFileDir + FileZip, FFileDir);
      except
        if FileExists(FFileDir + FileZip) then DeleteFile(FFileDir + FileZip);
        cError := 'Ошибка распаковки файла ' + FileZip + #13#10'Файл удален.' + #13#10 +
          'Повторите загрузку файлов....';
        Exit;
      end;
    end;

    bDelFile := False;
    if FileExists(FFileDir + FileName) and (FTypeCommunication in [cBaseReceive, cShopReceive]) then
    begin
      if FTransferZip and FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
       AddNote('Файлы: ' + FileInfo + ', ' + FileTransfer + IfStr(FileAdd = '', '', ', ' + FileAdd) +
         '~~Находятся в папке: ' + FFileDir + '~');
    end else if FileExists(FFileDir + FileName) and ((FExchangeData = 0) or
      (FExchangeData = 1) and FileExists(FFileDir + FileInfo)) then
    begin

      if Assigned(FConfirmation) then
      begin
        FConfirmationType := 1;
        FConfirmationText := '';
        Synchronize(FConfirmation);
        Suspended := True;
      end;

      if Terminated then Exit;

      if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) + ' and HL_Size = 0') then
      begin
        cError := 'Кто-то производит загрузку данных.'#13#10'Повторите загрузку через 5 минут...';
        Exit;
      end;

      if ExistsAdmin('select * from HistLoad where HL_Place = ' + IntToStr(FPlace) +
        ' and HL_Number = ' +  IntToStr(FNumber)) then
      begin
        cError := 'Кто-то уже загрузил данные.'#13#10'Повторите загрузку через 5 минут...';
        Exit;
      end;

      if not QInsertUser('select * from HistLoad where HL_ID = 0',
        'HL_Place,HL_Number,HL_Date,HL_DatePeriod,HL_File,HL_Size,HL_ID',
        VarArrayOf([FPlace, FNumber, Now, Null, '', 0]), FIDHist) then Exit;

      FFileSize := ONumUtils.GetFileSize(FFileDir + FileName);

      {$I-}
      AssignFile(FTextFile, FFileDir + FileName);
      Reset(FTextFile);
      {$I+}
      if IOResult <> 0 then
      begin
        cError := 'Ошибка открытия файла ' + FFileDir + FileName;
        Exit;
      end;
      AddNote('Загружено');
    end else
    begin
      FNoFile := True;
      AddNote('Файл ' + FFileDir + FileName + '~Не найден.');
    end;

    Result := True;
  finally
    if not Result then
    begin
      AddError('DoReceivingFile', cError);
      if bDelFile then
      begin
        if FileExists(FFileDir + FNXMLZip) then DeleteFile(FFileDir + FNXMLZip);
        if FileExists(FFileDir + FileAdd) then DeleteFile(FFileDir + FileAdd);
        if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
        if FileExists(FFileDir + FileTransfer) then DeleteFile(FFileDir + FileTransfer);
        if FileExists(FFileDir + FileInfo) then DeleteFile(FFileDir + FileInfo);
      end;
    end;
  end;
end;

function TCustomCommunication.DoPrepareSendingFile : Boolean;
  var cError : String; FInfoXML : TXMLDocument; FRoot, N : IXMLNode;
      XMLFileSize: Integer;
begin
  Result := FOk; cError := '';
  ShowStep('Подготовка отправки файла...');
  try
    if not FOk then Exit;

    FFileSize := ONumUtils.GetFileSize(FFileDir + FileName);
    FNoFile:=(FFileSize<27);

//    if (FFileSize<27) and (FFileAddType<>3) then
//    begin
//      FNoFile := True;
//      AddNote('Нет данных для выгрузки...');
//      if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
//      Exit;
//    end;

    if (FFileAddType <> 0) and not FileExists(FFileDir + FileAdd) then
    begin
      Result := False;
      cError := 'Дополнительный файл ' + FileAdd + ' не найден ...';
      Exit;
    end;

    try
      if (FFileSize > 250) or (FTypeCommunication = cShopUnload) and not FDirectSendingFile then
      begin
        ShowStep('Архивирование данных');
        GZCompressFile(FFileDir + FileName, FFileDir + FileZIP);
        if FileExists(FFileDir + FileZIP) then FTransferZip := True;
      end;

      if (FFileAddType>0) then XMLFileSize := ONumUtils.GetFileSize(FFileDir + FileAdd);

      if (FFileAddType=3) then
      begin
        if (XMLFileSize>30) then
        begin
          FNoFile:=False;
          ShowStep('Архивирование XML');
          FNXMLZip:=FileZIP;
          FNXMLZip[length(FNXMLZip)]:='X';
          GZCompressFile(FFileDir + FileAdd, FFileDir + FNXMLZip);
        end else FFileAddType:=0;

        if FileExists(FFileDir + FileAdd) then DeleteFile(FFileDir + FileAdd);
      end;

      if FNoFile then
      begin
        AddNote('Нет данных для выгрузки...');
        if FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
        Exit;
      end;

    except on E:Exception do
      begin
        Result := False;
        cError := 'Ошибка архивирования файлов выгрузи: ' + E.Message;
        Exit;
      end;
    end;
 
      // Создаем и сохраняем файл Info
    ShowStep('Создаем и сохраняем файл Info');
    try
      FInfoXML := TXMLDocument.Create(FconAdmin);
      FInfoXML.Active := true;
      FInfoXML.Version := '1.0';
      FInfoXML.Encoding := 'windows-1251';
      FRoot := FInfoXML.AddChild('Communication');
      N := FRoot.AddChild('ITEMS');
      N.Attributes['NAME'] := 'Info';
      N.Attributes['INFO'] := GetSubject;
      N := FRoot.AddChild('ITEMS');
      N.Attributes['NAME'] := 'FileTransfer';
      N.Attributes['FILE'] := FileTransfer;
      N.Attributes['SIZE'] := ONumUtils.GetFileSize(FFileDir + FileTransfer);
      N.Attributes['ZIP'] := FTransferZip;
      N := FRoot.AddChild('ITEMS');
      N.Attributes['NAME'] := 'FileName';
      N.Attributes['FILE'] := FileName;
      N.Attributes['SIZE'] := ONumUtils.GetFileSize(FFileDir + FileName);
      if FFileAddType=3 then
      begin
        N := FRoot.AddChild('ITEMS');
        N.Attributes['NAME'] := 'FileGZX';
        N.Attributes['FILE'] := FNXMLZip;
        N.Attributes['SIZE'] := ONumUtils.GetFileSize(FFileDir + FNXMLZip);
      end;
      if FFileAddType > 0 then
      begin
        N := FRoot.AddChild('ITEMS');
        N.Attributes['NAME'] := 'FileAdd';
        N.Attributes['FILE'] := FileAdd;
        N.Attributes['SIZE'] := FFileSize;
      end;
      FInfoXML.SaveToFile(FFileDir + FileInfo);
      FInfoXML.Active := False;
      FInfoXML.Free;
    except
      on E: Exception do cError := E.Message;
      else cError := 'Ошибка сохранения файла Info...'
    end;

    Result := cError = '';
  finally
    if not Result then
    begin
      if cError <> '' then AddError('DoPrepareSendingFile', cError);
      if (FTypeCommunication in [cBaseUnload, cShopUnload]) and
        FileExists(FFileDir + FileName) then DeleteFile(FFileDir + FileName);
      if (FFileAddType > 0) and FileExists(FFileDir + FileAdd) then DeleteFile(FFileDir + FileAdd);
      if FileExists(FFileDir + FileZIP) then DeleteFile(FFileDir + FileZip);
      if FileExists(FFileDir + FileInfo) then DeleteFile(FFileDir + FileInfo);
    end;
  end;
end;

function TCustomCommunication.DoCheckingFile : Boolean;
  var cError, cLine : String;
      nCount : integer;
begin
  Result := False; cError := '';
  if (FNumber > 65535) then
    nCount := 5
  else
    nCount := 4;
  ShowStep('Проверка файла...');
  try
    if FTypeCommunication = cBaseLoad then
    begin
      Readln(FTextFile, cLine);
      while cLine<>'' do
      begin
      if Copy(cLine, 1, 5) <> 'KHEOM' then
      begin
        cError := 'Ошибка формата файла ' + FFileDir + FileName;
        Exit;
      end else if Copy(cLine, 6, 4) <> IntToHex(FPlace, 4) then
      begin
        cError := 'Файл ' + FFileDir + FileName + '~~не предназначен для вашего магазина.';
        Exit;
      end else if Copy(cLine, 10, nCount) <> IntToHex(FNumber, 4) then
      begin
        if Copy(cLine, 10, nCount) < IntToHex(FNumber, 4) then
          cError := 'Попытка повторной закачки файла~~' + FFileDir + FileName;
        if Copy(cLine, 10, nCount) > IntToHex(FNumber, 4) then
          cError := 'Ошибка последовательности закачки файлов~~' + FFileDir + FileName;
        Exit;
        end;
        if (cLine<>FXMLFileAdd) and (FNXMLZip<>'') then cLine:=FXMLFileAdd
                                                   else cLine:='';
      end;
    end else if FTypeCommunication = cShopLoad then
    begin
      Readln(FTextFile, cLine);
      while cLine<>'' do
      begin
      if Copy(cLine, 1, 5) <> 'KHEOS' then
      begin
        cError := 'Ошибка формата файла ' + FFileDir + FileName;
        Exit;
      end else if Copy(cLine, 6, 4) <> IntToHex(FPlace, 4) then
      begin
        cError := 'Файл ' + FFileDir + FileName + '~~не предназначен для вашего магазина.';
        Exit;
      end else if Copy(cLine, 10, nCount) <> IntToHex(FNumber, 4) then
      begin
        if Copy(cLine, 10, nCount) < IntToHex(FNumber, 4) then
          cError := 'Попытка повторной закачки файла~~' + FFileDir + FileName;
        if Copy(cLine, 10, nCount) > IntToHex(FNumber, 4) then
          cError := 'Ошибка последовательности закачки файлов~~' + FFileDir + FileName;
        end;
        if (cLine<>FXMLFileAdd) and (FNXMLZip<>'') then cLine:=FXMLFileAdd
                                                   else cLine:='';

      end;
    end else Exit;

    Result := True;
  finally
    if not Result then
    begin
      {$I-}
      CloseFile(FTextFile);
      {$I+}
      AddError('DoCheckingFile', cError);
    end;
  end;
end;

function TCustomCommunication.SendSMTPFile : Boolean;
  var IdSMTP: TIdSMTP; Msg: TIdMessage;
begin
  Result := False;
  IdSMTP := TIdSMTP.Create(Nil);
  try
    try
      IdSMTP.Host := FHost;
      IdSMTP.Connect;
    except on E: Exception do
      begin
        AddInformation('Ошибка подключения к почтовому серверу~~'+E.Message);
        exit;
      end;
    end;

    Msg := TIdMessage.Create(nil);
    try
      try
        Msg.Recipients.EMailAddresses := FSMTPUsername;
        Msg.Subject := GetSubject;
        TIdAttachmentFile.Create(Msg.MessageParts, FFileDir + FileInfo);
        TIdAttachmentFile.Create(Msg.MessageParts, FFileDir + FileTransfer);
        if FFileAddType = 3 then
          TIdAttachmentFile.Create(Msg.MessageParts, FFileDir + FNXMLZip)
        else if FFileAddType > 0 then
          TIdAttachmentFile.Create(Msg.MessageParts, FFileDir + FileAdd);

        IdSMTP.Send(Msg);
      except on E: Exception do
        begin
          AddInformation('Ошибка отправки письма с файлом ' + FileTransfer +
            IfStr(FFileAddType > 0, ', ' + FileAdd, '') +
            ' на ' + QuotedStr(FSMTPUsername) + '~~' +E.Message);
          exit;
        end;
      end;
      Result := True;
    finally
      Msg.Free;
    end;

    Result := True;
  finally
    idsmtp.Disconnect;
    IdSMTP.Free;
  end;
end;

function TCustomCommunication.SendMailToFile : Boolean;
  var struct1:_Startupinfo; struct2:_Process_Information; S : string;
      FNAdd: String;
begin
  if Pos(AnsiUpperCase('thunderbird.exe'), AnsiUpperCase(FTheMailer)) = 0 then
  begin
    if FFileAddType = 3 then FNAdd := FNXMLZip else FileAdd;
    if (Pos('/MAIL', FTheMailer) > 0) or (Pos('/mail', FTheMailer) > 0) then
      S := 'TO=' + FSMTPUsername
    else S := '/MAILTO=' + FSMTPUsername;
    S := S + ';S="' + GetSubject + '"';
    S := S + ';A="' + FFileDir + FileInfo + '"';
    S := S + ';A="' + FFileDir + FileTransfer + '"';
    if FFileAddType > 0 then
      S := S + ';A="' + FFileDir + FNAdd + '"';
    S := S + ';SEND';
  end else
  begin
    S := '-compose to="' + FSMTPUsername +
      '",subject="' + GetSubject + '",body="' + GetSubject + '"' +
      ',attachment=file:///' + FFileDir + FileInfo +
      ',attachment=file:///' + FFileDir + FileTransfer +
      IfStr(FFileAddType > 0,',attachment=file:///' + FFileDir + FNAdd, '');
  end;
  FillChar(struct1, SizeOf(struct1), 0);
  struct1.cb := SizeOf(struct1);
  Result := CreateProcess(nil, PChar(FTheMailer + ' ' + S),
    nil, nil, False, 0, nil, PChar(FFileDir), struct1, struct2);
  CloseHandle(struct2.hThread);
  CloseHandle(struct2.hProcess);
end;

function TCustomCommunication.SendFTPFile : Boolean;
  var IdFTP : TIdFTP; cError : string;
begin
  Result := False;
  IdFTP := ConnectFTPServer(cError);
  try
    if not IdFTP.Connected then Exit;

    try
      if not ChangeDirFTP(IdFTP, GetFTPDir) then Exit;
      if FFileAddType=3 then
        idftp.Put(FFileDir + FNXMLZip, FNXMLZip, False)
      else if FFileAddType > 0 then
        idftp.Put(FFileDir + FileAdd, FileAdd, False);
      idftp.Put(FFileDir + FileTransfer, FileTransfer, False);
      idftp.Put(FFileDir + FileInfo, FileInfo, False);
      Result := True;
    except
      on E: Exception do  cError := E.Message;
      else cError := 'Ошибка обработки';
    end;
  finally
    idftp.Free;
    if not Result then AddInformation('Ошибка отправки файла ' + FileTransfer +
      IfStr(FFileAddType > 0, ', ' + FileAdd, '') + ' через FTP сервер ~~' + cError);
  end;
end;

function TCustomCommunication.SendWarehouseMailFile : Boolean;
var
  cErrMsg: string;
  cDataFileName: string;
  cFileAddName: string;
begin
  Result := True;
  if not FconAdmin.Connected then Exit;

  if not (FTypeCommunication in [cBaseUnload, cBaseLoad, cShopUnload, cShopLoad]) then Exit;

  try
      // Удаляем старые файлы
    if ExistsAdmin('select * from ' + FWarehouseMailFile +
      '.dbo.ShopMailFile where SMF_Date < DateAdd(m, -1, Cast(GetDate() as Date))') then
      ExecuteAdmin('delete ' + FWarehouseMailFile +
      '.dbo.ShopMailFile where SMF_Date < DateAdd(m, -1, Cast(GetDate() as Date))');

      // Добавляем текущий файл
    if FTransferZip
    then cDataFileName:= FileZIP
    else cDataFileName:= FileTransfer;

    if FFileAddType = 3
    then cFileAddName:= FNXMLZip
    else if FFileAddType > 0
    then cFileAddName:= FileAdd
    else cFileAddName:= '';

    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := 'select * from ' + FWarehouseMailFile + '.dbo.ShopMailFile where SMF_Type = ' +
      IfStr(FTypeCommunication in [cBaseUnload, cBaseLoad], '0', '1') +
      ' and SMF_Place = ' + IntToStr(FPlace) + ' and SMF_Number = ' + IntToStr(FNumber);
    FqAdmin.Open;
    if FqAdmin.RecordCount = 0 then FqAdmin.Insert else FqAdmin.Edit;
    FqAdmin.FieldByName('SMF_Type').AsBoolean := IfVar(FTypeCommunication in [cBaseUnload, cBaseLoad], False, True);
    FqAdmin.FieldByName('SMF_Place').AsInteger := FPlace;
    FqAdmin.FieldByName('SMF_Number').AsInteger := FNumber;
    FqAdmin.FieldByName('SMF_NameINF').AsString := FileInfo;
    TBlobField(FqAdmin.FieldByName('SMF_INF')).LoadFromFile(FFileDir + FileInfo);
    FqAdmin.FieldByName('SMF_NameMUL').AsString := cDataFileName;
    TBlobField(FqAdmin.FieldByName('SMF_MUL')).LoadFromFile(FFileDir + cDataFileName);
    if cFileAddName <> ''
    then begin
      FqAdmin.FieldByName('SMF_NameGZX').AsString := cFileAddName;
      TBlobField(FqAdmin.FieldByName('SMF_GZX')).LoadFromFile(FFileDir + cFileAddName);
    end;
    FqAdmin.Post;
  except
    on e: Exception do begin
      cErrMsg:= e.message;
      AddNote('Выгрузка ' + inttostr(FNumber) + ' Ошибка записи в WarehouseMailFile: ' + cErrMsg);
      AddNote('Выгрузка ' + inttostr(FNumber) + ' Сохранение в ShopMailFileErrorLog.');
      try
        FqAdmin.Close;
        FqAdmin.SQL.Clear;
        FqAdmin.SQL.Text:= 'select * from ShopMailFileErrorLog where SFL_ID = 0';
        FqAdmin.Open;
        FqAdmin.Append;
        FqAdmin.FieldByName('SFL_Type').AsBoolean := IfVar(FTypeCommunication in [cBaseUnload, cBaseLoad], False, True);
        FqAdmin.FieldByName('SFL_Number').AsInteger := FNumber;
        FqAdmin.FieldByName('SFL_Error').AsString := cErrMsg;
        FqAdmin.FieldByName('SFL_NameINF').AsString := FileInfo;
        TBlobField(FqAdmin.FieldByName('SFL_INF')).LoadFromFile(FFileDir + FileInfo);
        FqAdmin.FieldByName('SFL_NameMUL').AsString := cDataFileName;
        TBlobField(FqAdmin.FieldByName('SFL_MUL')).LoadFromFile(FFileDir + cDataFileName);
        if cFileAddName <> ''
        then begin
          FqAdmin.FieldByName('SFL_NameGZX').AsString := cFileAddName;
          TBlobField(FqAdmin.FieldByName('SFL_GZX')).LoadFromFile(FFileDir + cFileAddName);
        end;

        FqAdmin.Post;
      except
        on e: Exception do
          AddNote('Выгрузка ' + inttostr(FNumber) + ' Ошибка записи в ShopMailFileErrorLog: ' + e.message);
      end;
    end;
  end;
  FqAdmin.Close;
  FqAdmin.SQL.Clear;
end;

function TCustomCommunication.ReceivingWarehouseMailFile : Boolean;
begin
  Result := True;
  if not FconAdmin.Connected then Exit;

  if not (FTypeCommunication in [cBaseReceive, cBaseForward, cShopReceive, cShopForward]) then Exit;

  try

      // Получаем файл с WarehouseMailFile
    FqAdmin.Close;
    FqAdmin.SQL.Clear;
    FqAdmin.SQL.Text := 'select * from ' + FWarehouseMailFile + '.dbo.ShopMailFile where SMF_Type = ' +
      IfStr(FTypeCommunication in [cBaseReceive], '0', '1') +
      ' and SMF_Place = ' + IntToStr(FPlace) + ' and SMF_Number = ' + IntToStr(FNumForward);
    FqAdmin.Open;
    if FqAdmin.RecordCount = 1 then
    begin
      TBlobField(FqAdmin.FieldByName('SMF_INF')).SaveToFile(FFileDir + FqAdmin.FieldByName('SMF_NameINF').AsString);
      TBlobField(FqAdmin.FieldByName('SMF_MUL')).SaveToFile(FFileDir + FqAdmin.FieldByName('SMF_NameMUL').AsString);
      if FqAdmin.FieldByName('SMF_NameGZX').AsString <> ''
      then TBlobField(FqAdmin.FieldByName('SMF_GZX')).SaveToFile(FFileDir + FqAdmin.FieldByName('SMF_NameGZX').AsString);
    end
    else if FqAdmin.RecordCount = 0
    then begin
      FqAdmin.Close;
      FqAdmin.SQL.Clear;
      FqAdmin.SQL.Text:= 'select * from ShopMailFileErrorLog where SFL_Type = ' + IfStr(FTypeCommunication in [cBaseReceive], '0', '1')
         + ' and SFL_Number = ' + IntToStr(FNumForward);
      FqAdmin.Open;
      if FqAdmin.RecordCount = 1 then
      begin
        TBlobField(FqAdmin.FieldByName('SFL_INF')).SaveToFile(FFileDir + FqAdmin.FieldByName('SFL_NameINF').AsString);
        TBlobField(FqAdmin.FieldByName('SFL_MUL')).SaveToFile(FFileDir + FqAdmin.FieldByName('SFL_NameMUL').AsString);
        if FqAdmin.FieldByName('SFL_NameGZX').AsString <> ''
        then TBlobField(FqAdmin.FieldByName('SFL_GZX')).SaveToFile(FFileDir + FqAdmin.FieldByName('SFL_NameGZX').AsString);
      end;
    end;
  except
  end;
  FqAdmin.Close;
  FqAdmin.SQL.Clear;
end;

function TCustomCommunication.LoadWarehouseMailFile : Boolean;
  var S : string;
begin
  Result := True;
  if not FconAdmin.Connected then Exit;

  if not (FTypeCommunication in [cBaseLoad]) then Exit;
  if (FIPAdrecShop = '') or (FBDNameShop = '') or (FSAPasswordShop = '') then Exit;

  if not Ping(PAnsiChar(AnsiString(FIPAdrecShop)), S) then Exit;


  try
    try

        // Подключение к БД магазина
      ShowStep('Подключение к БД магазина');
      FconShop.ConnectionString := FConnectionString;
      FconShop.Properties.Item['Data Source'].Value := FIPAdrecShop;
      FconShop.Properties.Item['Initial Catalog'].Value := FBDNameShop;
      FconShop.Open('SA', FSAPasswordShop);
      FconShop.Execute('Set Transaction Isolation Level Read Uncommitted');

        // Пповеряем наличие WarehouseMailFile в магазине
      FqShop.Close;
      FqShop.SQL.Clear;
      FqShop.SQL.Text := 'select Con_WarehouseMailFile from Config';
      FqShop.Open;
      if FqShop.RecordCount = 1 then
        S := Trim(FqShop.FieldByName('Con_WarehouseMailFile').AsString)
      else Exit;
      if S = '' then Exit;

        // Получаем файл с WarehouseMailFile магазина
      ShowStep('Получение файла из базы магазина');
      FqShop.Close;
      FqShop.SQL.Clear;
      FqShop.SQL.Text := 'select * from ' + S + '.dbo.ShopMailFile where SMF_Type = 1 and SMF_Place = ' +
        IntToStr(FPlace) + ' and SMF_Number = ' + IntToStr(FNumber);
      FqShop.Open;
      if FqShop.RecordCount = 1 then
      begin
        TBlobField(FqShop.FieldByName('SMF_INF')).SaveToFile(FFileDir + FqShop.FieldByName('SMF_NameINF').AsString);
        TBlobField(FqShop.FieldByName('SMF_MUL')).SaveToFile(FFileDir + FqShop.FieldByName('SMF_NameMUL').AsString);
      end;
    except
    end;
  finally
    FqShop.Close;
    FqShop.SQL.Clear;
    FconShop.Close;
  end;
end;

function TCustomCommunication.DoSendFile : Boolean;
begin
  Result := False;
  ShowStep('Отправка файла...');

  if FWarehouseMailFile <> '' then SendWarehouseMailFile;

  if (FExchangeData = 0) and (FDirectSendingFile or (FTheMailer <> '')) and (FSMTPUsername <> '') then
  begin

    if FDirectSendingFile then Result := SendSMTPFile
    else Result := SendMailToFile;
  end;

  if (FExchangeData = 1) and (FFTPHost <> '') and (FFTPPort <> 0) and (FFTPUserName <> '') and
    (FFTPPassword <> '') then Result := SendFTPFile;

  if Result and FieldExistsAdmin('HistUnload', 'HU_SendDone') then
    QUpdateUser('select HU_SendDone from HistUnload where HU_ID = ' + IntToStr(FIDHist),'HU_SendDone',VarArrayOf([true]));
end;

function TCustomCommunication.DoCompletion : Boolean;
begin
  try
    try
      if not FNoFile and FOk then
      begin
        case FTypeCommunication of
          cBaseUnload : begin
                          FOk := QUpdateAdmin('select * from HistUnload where HU_ID = ' + IntToStr(FIDHist),
                            'HU_Place,HU_Number,HU_Date,HU_DatePeriod,HU_File,HU_Size,HU_Note', VarArrayOf([
                            FPlace, FNumber, FDateCurr, FDatePeriod, FileName, FFileSize, FNote]));
                          if FOk then
                          begin
                            if DoSendFile then AddNote('~Файл - ' + FileName + '~отправлен на магазин')
                            else AddNote('~Файл - ' + FileName + '~отправьте на магазин');
                            QInsertUser('select * from HistMailSending where HMS_ID = 0',
                              'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                              VarArrayOf([Now,FPlace,FTypeDoc, FNumber, 0, IntToVar(FIDJob), FNote,
                              IfVar(Assigned(FShowNameOfStep), True, False)]));
                          end;
                        end;
          cBaseLoad : begin
                        FOk := QUpdateAdmin('select * from HistLoad where HL_ID = ' + IntToStr(FIDHist),
                          'HL_Place,HL_Number,HL_Date,HL_DatePeriod,HL_File,HL_Size,HL_Note', VarArrayOf([
                          FPlace, FNumber, FDateCurr, FDatePeriod, FileName, FFileSize, FNote]));
                        if FOk then
                        begin
                          QInsertUser('select * from HistLoadLog where HLL_ID = 0',
                            'HLL_Date,HLL_Place,HLL_Time,HLL_FailName,HLL_Status,HLL_Note,HLL_Fail,HLL_Mode',
                            VarArrayOf([StrToDate(FormatDateTime('dd/mm/yyyy', Now)),FPlace,Now,FileName,
                            'ОК', 'Загрузка была успешно завершена.~~' + FNote,
                            IfVar(Assigned(FShowNameOfStep), Null, StrToVar(XLSFile)),
                            IfStr(Assigned(FShowNameOfStep), 'Manual', 'Auto')]));
                        end;
                      end;
          cBaseForward : if FOk then
                        begin
                          FOk := DoSendFile;
                          if FOk then
                          begin
                            AddNote('~Файл - ' + FileName + '~отправлен на магазин');
                            QInsertUser('select * from HistMailSending where HMS_ID = 0',
                              'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Forward,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                              VarArrayOf([Now,FPlace,FTypeDoc, FNumForward, True, 0, IntToVar(FIDJob), FNote,
                              IfVar(Assigned(FShowNameOfStep), True, False)]));
                          end else AddError('DoCompletion', '~Ошибка пересылки файла - ' + FileName);
                        end;
          cShopUnload : begin
                          FOk := QUpdateAdmin('select * from HistUnload where HU_ID = ' + IntToStr(FIDHist),
                            'HU_Place,HU_Number,HU_Date,HU_DatePeriod,HU_File,HU_Size,HU_Note', VarArrayOf([
                            FPlace, FNumber, FDateCurr, FDatePeriod, FileName, FFileSize, FNote]));
                          if FOk then
                          begin
                            if DoSendFile then AddNote('~Файл - ' + FileName + '~отправлен на офис')
                            else AddNote('~Файл - ' + FileName + '~отправьте на офис');
                          end;
                        end;
          cShopLoad : FOk := QUpdateAdmin('select * from HistLoad where HL_ID = ' + IntToStr(FIDHist),
                        'HL_Place,HL_Number,HL_Date,HL_DatePeriod,HL_File,HL_Size,HL_Note', VarArrayOf([
                        FPlace, FNumber, FDateCurr, FDatePeriod, FileName, FFileSize, FNote]));
          cShopForward : if FOk then
                        begin
                          if DoSendFile then AddNote('~Файл - ' + FileName + '~отправлен на офис')
                          else AddNote('~Файл - ' + FileName + '~отправьте на офис');
                        end;
        end;
      end;
    except
    end;
  finally
    Result := True;
  end;
end;

function TCustomCommunication.DoCancel : Boolean;
begin
  Result := True;
  try
    try
      if FNoFile or not FOk then
      begin
        if Terminated then AddNote('Прервано...');
        case FTypeCommunication of
          cBaseUnload : begin
                          if FIDHist <> 0 then ExecuteAdmin('delete HistUnLoad where HU_ID = ' + IntToStr(FIDHist));
                          if not Assigned(FShowNameOfStep) then
                          begin
                            if FNoFile then QInsertUser('select * from HistMailSending where HMS_ID = 0',
                              'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                              VarArrayOf([Now,FPlace,FTypeDoc,Null,1, IntToVar(FIDJob), FNote, False]))
                            else QInsertUser('select * from HistMailSending where HMS_ID = 0',
                              'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                              VarArrayOf([Now,FPlace,FTypeDoc,Null,2, IntToVar(FIDJob), Error, False]));
                          end;
                        end;
          cShopUnload : if FIDHist <> 0 then ExecuteAdmin('delete HistUnLoad where HU_ID = ' + IntToStr(FIDHist));
          cBaseLoad : begin
                        if (FIDHist <> 0) then
                          ExecuteAdmin('delete HistLoad where HL_ID = ' + IntToStr(FIDHist));
                        if not Assigned(FShowNameOfStep) then
                        begin
                          if FNoFile then QInsertUser('select * from HistLoadLog where HLL_ID = 0',
                            'HLL_Date,HLL_Place,HLL_Time,HLL_FailName,HLL_Status,HLL_Note,HLL_Fail,HLL_Mode',
                            VarArrayOf([StrToDate(FormatDateTime('dd/mm/yyyy', Now)), FPlace, Now, FileName,
                            'Стоп!', FNote, Null, 'Auto']))
                          else QInsertUser('select * from HistLoadLog where HLL_ID = 0',
                           'HLL_Date,HLL_Place,HLL_Time,HLL_FailName,HLL_Status,HLL_Note,HLL_Fail,HLL_Mode',
                           VarArrayOf([StrToDate(FormatDateTime('dd/mm/yyyy', Now)), FPlace, Now, FileName,
                           'Неудачно!', Error, Null, 'Auto']));
                        end;
                      end;
          cShopLoad : if FIDHist <> 0 then ExecuteAdmin('delete HistLoad where HL_ID = ' + IntToStr(FIDHist));
          cBaseForward : if not Assigned(FShowNameOfStep) then
                         begin
                           if FNoFile then QInsertUser('select * from HistMailSending where HMS_ID = 0',
                             'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Forward,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                             VarArrayOf([Now,FPlace,FTypeDoc,FNumForward, True,1, IntToVar(FIDJob), FNote, False]))
                           else QInsertUser('select * from HistMailSending where HMS_ID = 0',
                             'HMS_Date,HMS_Place,HMS_Unloaded,HMS_Number,HMS_Forward,HMS_Status,HMS_IDJob,HMS_Note,HMS_Mode',
                             VarArrayOf([Now,FPlace,FTypeDoc,FNumForward, True,2, IntToVar(FIDJob), Error, False]));
                         end;
        end;
      end;
    except
    end;
  finally
    if FconUser.Connected  then FconUser.Close;
    if FconAdmin.Connected then FconAdmin.Close;
    FWorks := False;
    if Assigned(FEndCommunication) then FEndCommunication;
  end;

end;

procedure TCustomCommunication.DoExecute;
begin
  if FLoadedIDList.Count > 0 then FLoadedIDList.Clear;

  CoInitialize(nil);
  FOk := DoConnect;
  CoUninitialize;
  FTestServerName := TestServerName;
  if not Terminated and FOk then FOk := DoGetParam;
  if FTypeCommunication in [cBaseLoad, cShopLoad, cBaseReceive, cShopReceive] then
  begin
    if not Terminated and FOk then FOk := DoReceivingFile;
  end else if FTypeCommunication in [cBaseUnload, cShopUnload] then
  begin
    if not Terminated and FOk then FOk := DoCreateFile;
  end;
  if (not FOk or FNoFile) and DoCancel then Exit;

  try
    if not Terminated and FOk and (FTypeCommunication in [cBaseLoad, cShopLoad]) then FOk := DoCheckingFile;
    if not FOk then Exit;
    if not (FTypeCommunication in [cBaseForward, cShopForward, cBaseReceive, cShopReceive]) then
    begin
      Communication;
      if FOk and (FTypeCommunication in [cBaseUnload, cShopUnload]) and (Flush(FTextFile) <> 0) then
      begin
        AddError('DoExecute', 'Ошибка записи в файл');
        FOk := False;
      end;
      {$I-}
      CloseFile(FTextFile);
      {$I+}
      if (FTypeCommunication in [cBaseUnload, cShopUnload]) and (IOResult <> 0) then
      begin
        AddError('DoExecute', 'Ошибка закрытия файла');
        FOk := False;
      end;
      AfterCommunication;
    end;
    if FTypeCommunication in [cBaseUnload, cShopUnload, cBaseForward, cShopForward] then FOk := DoPrepareSendingFile;
    if FOk then DoCompletion;
  finally
    if not FOk then RollbackCommunication;
    DoCancel;
  end;
end;

procedure TCustomCommunication.Communication;
begin
  FOk := False;
  AddError('Communication', 'Не описан метод обработки...');
end;

procedure TCustomCommunication.AfterCommunication;
begin
  if FLoadedIDList.Count = 0 then Exit;
  FOk := False;
  AddError('AfterCommunication', 'Не описан метод постобработки...');
end;

procedure TCustomCommunication.RollbackCommunication;
begin
  if FLoadedIDList.Count = 0 then Exit;
  FOk := False;
  AddError('RollbackCommunication', 'Не описан метод отката обработки...');
end;

function TCustomCommunication.StartCommunication : boolean;
begin
  try
    DoExecute;
  finally
    Result := FOk;
  end;
end;

end.
