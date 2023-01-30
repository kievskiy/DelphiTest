unit UserRightAccessShopEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  CustomForm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.Win.Registry, uCustomConfig,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxLabel, cxButtonEdit, cxTextEdit, cxContainer, cxSplitter, cxMemo, cxDBEdit,
  cxDBLabel, Vcl.ExtCtrls, TRexSyntaxMemo, Vcl.ComCtrls, Vcl.Buttons, ONumUtils,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  TRexCrypting,
  dxmdaset, Data.Win.ADODB, dxBarBuiltInMenu, System.ImageList, Vcl.ImgList,
  System.StrUtils,
  cxPC, Vcl.Menus, Vcl.Grids, Vcl.DBGrids, cxImageComboBox;

type
  TfmUserRightAccessShopEdit = class(TDataEditForm)
    Panel6: TPanel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    btnHelp: TBitBtn;
    FuckAllBtn: TBitBtn;
    FuckAllBtnNoDis: TBitBtn;
    Panel5: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Ur_id: TcxGridDBColumn;
    cxGrid1DBTableView1UR_Name: TcxGridDBColumn;
    cxGrid1DBTableView1Pe_Id: TcxGridDBColumn;
    cxGrid1DBTableView1Pe_FullName: TcxGridDBColumn;

    cxGrid1DBTableView2: TcxGridDBTableView;
    cxGrid1DBTableView2Column1: TcxGridDBColumn;
    cxGrid1DBTableView2Ur_id: TcxGridDBColumn;
    cxGrid1DBTableView2UR_Name: TcxGridDBColumn;
    cxGrid1DBTableView2Pe_Id: TcxGridDBColumn;
    cxGrid1DBTableView2Pe_FullName: TcxGridDBColumn;

    cxGrid1DBTableView3: TcxGridDBTableView;
    cxGrid1DBTableView3Column1: TcxGridDBColumn;
    cxGrid1DBTableView3Ur_id: TcxGridDBColumn;
    cxGrid1DBTableView3UR_Name: TcxGridDBColumn;
    cxGrid1DBTableView3Pe_Id: TcxGridDBColumn;
    cxGrid1DBTableView3Pe_FullName: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    pnl1: TPanel;
    Panel4: TPanel;
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Panel12: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBEdit7: TDBEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxGrid3: TcxGrid;
    cxGrid3DBTableView1: TcxGridDBTableView;
    cxGrid3DBTableView1Column1: TcxGridDBColumn;
    cxGrid3Level1: TcxGridLevel;
    Panel3: TPanel;
    Panel8: TPanel;
    DBEdit10: TDBEdit;
    cxDBLabel1: TcxDBLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxDBMemo2: TcxDBMemo;
    cxLabel3: TcxLabel;
    Panel9: TPanel;
    Splitter3: TSplitter;
    smSA: TSyntaxMemo;
    smSMSmall: TSyntaxMemo;
    smSMBig: TSyntaxMemo;
    fsSyntaxMemo4: TSyntaxMemo;
    fsSyntaxMemo5: TSyntaxMemo;
    cxSplitter1: TcxSplitter;
    dsUserRightAccess: TDataSource;
    qryUserRightAccessEdit: TADOQuery;
    qUser1: TADOQuery;
    dsUser1: TDataSource;
    cxPageControl1: TcxPageControl;
    ImageList1: TImageList;
    PageControl2: TPageControl;
    TSSA: TTabSheet;
    TSSMSmall: TTabSheet;
    TSSMBig: TTabSheet;

    MainMenu1: TMainMenu;
    mm_Copy: TMenuItem;
    mm_CopyTest2: TMenuItem;
    qUser2: TADOQuery;
    dsUser2: TDataSource;
    qUser3: TADOQuery;
    dsUser3: TDataSource;
    qPlace: TADOQuery;
    N1: TMenuItem;
    mm_ShopAdminListInfo: TMenuItem;
    cxGrid1DBTableView1Pe_IDBase: TcxGridDBColumn;
    pnl2: TPanel;
    lbUserAccessResult: TLabel;
    lbPlName: TLabel;
    sbSetPlace: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SyntaxMemo2: TSyntaxMemo;
    qCheckAccessShopText: TADOQuery;
    TabSheet4: TTabSheet;
    qUnloadLog: TADOQuery;
    dsUnloadLog: TDataSource;
    Panel7: TPanel;
    mm_CopyURASInCurrentShop: TBitBtn;
    BitBtn1: TBitBtn;
    Panel10: TPanel;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    cxGridDBTableView1Column4: TcxGridDBColumn;
    cxGridDBTableView1Column5: TcxGridDBColumn;
    cxGridDBTableView1Column7: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxSplitter2: TcxSplitter;
    Panel11: TPanel;
    cxDBMemo3: TcxDBMemo;
    Panel13: TPanel;
    qPing: TADOQuery;
    cxGrid1DBTableView2GR_Name: TcxGridDBColumn;
    cxGrid1DBTableView1GR_Name: TcxGridDBColumn;
    cxGrid1DBTableView3GR_Name: TcxGridDBColumn;

    procedure FormShow(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure smSMBigChange(Sender: TObject);
    procedure smSMSmallChange(Sender: TObject);
    procedure smSAChange(Sender: TObject);
    procedure sbSetPlaceClick(Sender: TObject);
    procedure mm_ShopAdminListInfoClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FuckAllBtnClick(Sender: TObject);
    procedure mm_CopyClick(Sender: TObject);
    procedure dsUser1DataChange(Sender: TObject; Field: TField);
    procedure mm_CopyURASInCurrentShopClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FServer, FTesterServer, FBase: string;
    Shop_Type: Integer;
    pcActivePage: Integer;
    FPerson: Integer;
    // 1 - SmShop Big
    // 2 - SmShop Small
    // 3 - ShopAccount
    Pl_Id, Pl_Type: array [1 .. 3] of Integer;
    ConnectionString: array [1 .. 3] of String;

    FPlSA: Integer;
    FDataSource, TestConnectionString: String;
    nIsProgtest: Boolean;
    function CheckEditEx(const AOk: Boolean): Boolean; override;
    function _GetWhoUpdate(): Integer;
    function SetPl_IdDeff(AShop_Type: Integer): Boolean;
    function Ping(AData_Source: String): Boolean;
    procedure SetConnectionAttributeForShop_Type(AShop_Type: Integer);
    procedure SetlbUserAccessResultCaption;
  public
    { Public declarations }
    // Проверка доступа на ТТ при создании скрипта
    function CheckAccessForTTText(nPages: Integer; nConnectionString: String;
      nText: string; nLogin: Integer = 0; nPerson: Integer = 0;
      nPersonLocal: Integer = 0): Boolean;
  end;

procedure EditUserRightAccessForTT(nID: Integer);

implementation

{$R *.dfm}

uses DataModule, Person, DictChoice, ListBoxGrid, MessageGrid,
  UserRightAccessShopList;

procedure EditUserRightAccessForTT(nID: Integer);
var
  fmUserRightAccessShopEdit: TfmUserRightAccessShopEdit;
Begin
  fmUserRightAccessShopEdit := TfmUserRightAccessShopEdit.Create
    (Screen.ActiveForm);
  try
    fmUserRightAccessShopEdit.ID := nID;
    fmUserRightAccessShopEdit.Show;
  Except
    fmUserRightAccessShopEdit.Free;
  end;
End;

function TfmUserRightAccessShopEdit.Ping(AData_Source: String): Boolean;
var
  q: TADOQuery;
begin
  Result := False;
  qPing.Close;
  qPing.Parameters.ParamByName('Data_Source').Value := AData_Source;
  qPing.Open;
  Result := qPing.FieldByName('Res').AsBoolean;
end;

function TfmUserRightAccessShopEdit.SetPl_IdDeff(AShop_Type: Integer): Boolean;
var
  q: TADOQuery;
begin

  Result := False;

  SetConnectionAttributeForShop_Type(0);
  Result := False;
  if qPlace.RecordCount = 0 then
  begin
    SMessage('Нет ни одной ТТ на чём можно тренироваться~' + IfVar(IsTestServer,
      'Попросите взрослого дядю приподтянь копию магазина/супера на тестовой базе',
      ''));
    exit;
  end;

  // Пытаемся запихнуть первый магаз
  qPlace.Locate('Shop_Type', 3, [loCaseInsensitive]);
  if qPlace.FieldByName('Shop_Type').AsInteger <> 3 then
  begin
    // Без магаза вообще тяжко...
    SMessage('Нет ни одного магазина на чём можно проверить');
    exit;
  end
  else
    Pl_Id[3] := qPlace.FieldByName('Pl_Id').AsInteger;
  // Пытаемся запихнуть первый большой супер
  qPlace.Locate('Shop_Type', 1, [loCaseInsensitive]);
  if qPlace.FieldByName('Shop_Type').AsInteger = 1 then
    Pl_Id[1] := qPlace.FieldByName('Pl_Id').AsInteger;

  // Пытаемся запихнуть первый малый супер
  qPlace.Locate('Shop_Type', 2, [loCaseInsensitive]);
  if qPlace.FieldByName('Shop_Type').AsInteger = 2 then
    Pl_Id[2] := qPlace.FieldByName('Pl_Id').AsInteger;
  if (Pl_Id[1] = 0) and (Pl_Id[2] = 0) then
  begin
    // суперов тоже нет
    SMessage('Нет ни одного супермаркета(ни большого ни малого) на чём можно проверить');
    exit;
  end;
  if (Pl_Id[1] = 0) then
  begin
    Pl_Id[1] := Pl_Id[2];
    Pl_Type[1] := 2;
    SMessageI(
      'Нет ни одного большого супермаркета на чём можно проверить...~Будем проверять на малом');
  end;
  if (Pl_Id[2] = 0) then
  begin
    Pl_Id[2] := Pl_Id[1];
    Pl_Type[2] := 1;
    SMessageI(
      'Нет ни одного малого супермаркета на чём можно проверить...~Будем проверять на большом');
  end;
  SetConnectionAttributeForShop_Type(1);
  Result := true;

end;

function TfmUserRightAccessShopEdit.CheckAccessForTTText(nPages: Integer;
  nConnectionString: String; nText: string; nLogin: Integer = 0;
  nPerson: Integer = 0; nPersonLocal: Integer = 0): Boolean;

begin

  try
    qCheckAccessShopText.Close;
    qCheckAccessShopText.ConnectionString := nConnectionString;
    qCheckAccessShopText.Parameters.ParamByName('Login').Value := nLogin;
    qCheckAccessShopText.Parameters.ParamByName('Person').Value := nPerson;
    qCheckAccessShopText.Parameters.ParamByName('PersonLocal').Value :=
      nPersonLocal;
    qCheckAccessShopText.Parameters.ParamByName('SQL').Value := nText;
    qCheckAccessShopText.Open;
  except
    on E: exception do
      SMessage('Ошибка скрипта для ТТ с типом ' + PageControl2.Pages[nPages].Caption +
        ':~' + E.Message);
  end;
  Result := qCheckAccessShopText.FieldByName('Res').AsBoolean;

end;

procedure TfmUserRightAccessShopEdit.smSAChange(Sender: TObject);
begin
  qryUserRightAccessEdit.Edit;
  qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').AsString :=
    smSA.Lines.Text;
end;

procedure TfmUserRightAccessShopEdit.smSMBigChange(Sender: TObject);
begin
  qryUserRightAccessEdit.Edit;
  qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').AsString :=
    smSMBig.Lines.Text;
end;

procedure TfmUserRightAccessShopEdit.smSMSmallChange(Sender: TObject);
begin
  qryUserRightAccessEdit.Edit;
  qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').AsString :=
    smSMSmall.Lines.Text;
end;

procedure TfmUserRightAccessShopEdit.SpeedButton3Click(Sender: TObject);
var
  msg, URA_Script: String;
begin
  case pcActivePage of
    1:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMBig').AsString;
        msg := '~  -' + TSSMSmall.Caption + '~  -' + TSSA.Caption;
      end;
    2:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMSmall').AsString;
        msg := '~  -' + TSSMBig.Caption + '~  -' + TSSA.Caption;
      end;
    3:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSA').AsString;
        msg := '~  -' + TSSMBig.Caption + '~  -' + TSSMSmall.Caption;
      end;
  end;
  if URA_Script = '' then
    exit;
  msg := 'Вы действительно хотите скопировать активный скрипт с типом ТТ ' +
    PageControl2.ActivePage.Caption + ' на следующие типы ТТ?' + msg +
    '~Данное действие нельзя будет отменить';
  if SMesDlg(msg) <> mrOk then
    exit;
  case pcActivePage of
    1:
      begin
        smSMSmall.Lines.Text := URA_Script;
        smSA.Lines.Text := URA_Script;
        smSMSmallChange(self);
        smSAChange(self);
      end;
    2:
      begin
        smSMBig.Lines.Text := URA_Script;
        smSA.Lines.Text := URA_Script;
        smSMBigChange(self);
        smSAChange(self);
      end;
    3:
      begin
        smSMBig.Lines.Text := URA_Script;
        smSMSmall.Lines.Text := URA_Script;
        smSMBigChange(self);
        smSMSmallChange(self);
      end;
  end;
end;

function TfmUserRightAccessShopEdit._GetWhoUpdate(): Integer;
begin
  Result := 0;
  if not ChoiceDict('URPerson', true, '',
    'Укажите для логирования, какой сотрудник вносит изменения') then
    exit;
  Result := DictID('URPerson');
end;

procedure TfmUserRightAccessShopEdit.BitBtn1Click(Sender: TObject);
var
  q: TADOStoredProc;
begin
  q := CreateProc('pr_CopyURASForCurrentURAS');
  q.ExecuteOptions := [eoExecuteNoRecords];
  try
    q.Parameters.ParamByName('@SAPl_Id').Value := FPlSA;
    q.Parameters.ParamByName('@Data_Source').Value := FDataSource;
    q.Parameters.ParamByName('@Id').Value := ID;
    try
      q.ExecProc;
      qUnloadLog.Close;
      qUnloadLog.Open;
    except
      on E: exception do
        SMessage('Ошибка копирования данных:~' + E.Message);
    end;
  finally
    q.Close;
    q.Free;
  end;

end;

procedure TfmUserRightAccessShopEdit.btnHelpClick(Sender: TObject);
var
  URA_Script: String;
  Ur_id: Integer;
  Person: Integer;
  PersonLocal: Integer;
begin
  if Pl_Id[pcActivePage] = 0 then
    sbSetPlaceClick(self);
  if Pl_Id[pcActivePage] = 0 then
    exit;
  case pcActivePage of
    1:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMBig').AsString;
        Ur_id := qUser1.FieldByName('Ur_id').AsInteger;
        Person := qUser1.FieldByName('Pe_IDBase').AsInteger;
        PersonLocal := qUser1.FieldByName('Pe_id').AsInteger;
      end;
    2:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMSmall').AsString;
        Ur_id := qUser2.FieldByName('Ur_id').AsInteger;
        Person := qUser2.FieldByName('Pe_id').AsInteger;
        PersonLocal := qUser2.FieldByName('Pe_id').AsInteger;
      end;
    3:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSA').AsString;
        Ur_id := qUser3.FieldByName('Ur_id').AsInteger;
        Person := qUser3.FieldByName('Pe_id').AsInteger;
        PersonLocal := qUser3.FieldByName('Pe_id').AsInteger;
      end;
  end;
  if URA_Script = '' then
    exit;

  try
    if CheckAccessForTTText(pcActivePage, ConnectionString[pcActivePage],
      URA_Script, Ur_id, Person, PersonLocal) then
    begin
      PageControl2.ActivePage.Tag := 1;
    end
    else
    begin
      PageControl2.ActivePage.Tag := 0;
    end;
  except
    on E: exception do
    begin
      PageControl2.ActivePage.Tag := 2;
      SMessage('Ошибка ' + #13#10 + E.Message);
    end;
  end;
  SetlbUserAccessResultCaption;
end;

function TfmUserRightAccessShopEdit.CheckEditEx(const AOk: Boolean): Boolean;
var
  N: Integer;
  Script_1, Script_2, Script_3: String;
  function _StringReplace(const S: string): string;
  begin
    Result := StringReplace(S, ' ', '', [rfReplaceAll, rfIgnoreCase]);
    Result := Trim(Result);
  end;

Begin
  Result := true;
  if not(qryUserRightAccessEdit.State in [dsInsert, dsEdit]) then
    exit;
  CancelButton.SetFocus;
  if (ModalResult <> mrOk) and (qryUserRightAccessEdit.State = dsInsert) and
    (qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').AsString = '') and
    (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').AsString = '') and
    (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').AsString = '')
  then
  begin
    qryUserRightAccessEdit.Cancel;
    Result := true;
    exit;
  end;

  if AOk then
    N := SCMesDlg('В данные были внесены изменения. Сохранять ?...')
  else
    N := mrYes;
  case N of
    mrYes:
      begin
        if qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').IsNull or
          (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig')
          .AsString = '#$D#$A') then
          qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').Value := ' ';

        if qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').IsNull or
          (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall')
          .AsString = '#$D#$A') then
          qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').Value := ' ';

        if qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').IsNull or
          (qryUserRightAccessEdit.FieldByName('URAS_ScriptSA')
          .AsString = '#$D#$A') then
          qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').Value := ' ';

        Script_1 := _StringReplace(qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMBig').AsString);
        Script_2 := _StringReplace(qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMSmall').AsString);
        Script_3 := _StringReplace(qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSA').AsString);
        FPerson := _GetWhoUpdate;
        if FPerson = 0 then
        begin
          Result := False;
          exit;
        end;
        if qryUserRightAccessEdit.FieldByName('URAS_Code').IsNull then
        Begin
          SMessage('Укажите код');
          Result := False;
          SetFocused(DBEdit1);
        End
        else if qryUserRightAccessEdit.FieldByName('URAS_Name').AsString = ''
        then
        Begin
          SMessage('Укажите описание');
          Result := False;
          SetFocused(DBEdit2);
        End
        else if (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig')
          .AsString = '') and (Script_1 <> '') then
        Begin
          SMessage('Укажите скирипт для большого супермаркета');
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 0;
          PageControl2Change(self);
          SetFocused(smSMBig);
        End
        else if (qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall')
          .AsString = '') and (Script_2 <> '') then
        Begin
          SMessage('Укажите скирипт для малого супермаркета');
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 1;
          PageControl2Change(self);
          SetFocused(smSMSmall);
        End
        else if (qryUserRightAccessEdit.FieldByName('URAS_ScriptSA')
          .AsString = '') and (Script_3 <> '') then
        Begin
          SMessage('Укажите скирипт для мазазина');
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 2;
          PageControl2Change(self);
          SetFocused(smSA);
        End
        else if (Pl_Id[1] = 0) and (Script_1 <> '') then
        begin
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 0;
          PageControl2Change(self);
          SMessage('Необходимо выбрать код магазина с типом ' +
            PageControl2.ActivePage.Caption +
            '~на котором мы сможем проверить скрипт');
          sbSetPlaceClick(self);
        end
        else if (Pl_Id[2] = 0) and (Script_2 <> '') then
        begin
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 1;
          PageControl2Change(self);
          SMessage('Необходимо выбрать код магазина с типом ' +
            PageControl2.ActivePage.Caption +
            '~на котором мы сможем проверить скрипт');
          sbSetPlaceClick(self);
        end
        else if (Pl_Id[3] = 0) and (Script_3 <> '') then
        begin
          Result := False;
          PageControl1.TabIndex := 0;
          PageControl2.TabIndex := 2;
          PageControl2Change(self);
          SMessage('Необходимо выбрать код магазина с типом ' +
            PageControl2.ActivePage.Caption +
            '~на котором мы сможем проверить скрипт');
          sbSetPlaceClick(self);
        end
        else
          try

            if Script_1 <> '' then
              CheckAccessForTTText(0, ConnectionString[1],
                qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').AsString,
                qUser1.FieldByName('Ur_id').Value);

            if Script_2 <> '' then
              CheckAccessForTTText(1, ConnectionString[2],
                qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall')
                .AsString, qUser2.FieldByName('Ur_id').Value);

            if Script_3 <> '' then
              CheckAccessForTTText(2, ConnectionString[3],
                qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').AsString,
                qUser3.FieldByName('Ur_id').Value);

            try
              qryUserRightAccessEdit.FieldByName('URAS_WhoUpdate').AsInteger
                := FPerson;

              qryUserRightAccessEdit.Post;
              ID := qryUserRightAccessEdit.FieldByName('URAS_ID').AsInteger;
              ResetData(self);
            Except
              Result := False;
            end;
          except
//            SMessage('Ошибка исполнения скрипта:~');
            Result := False;
//            SetFocused(smSMBig);
          end;
      end;
    mrNo:
      Result := true;
    mrCancel:
      Result := False;
  end;
end;

procedure TfmUserRightAccessShopEdit.dsUser1DataChange(Sender: TObject;
  Field: TField);
begin
  PageControl2.ActivePage.Tag := -1;
  SetlbUserAccessResultCaption;
end;

Procedure TfmUserRightAccessShopEdit.SetConnectionAttributeForShop_Type
  (AShop_Type: Integer);
var
  i: Integer;
  Procedure SetConnectionAttribute(Const AShop_Type: Integer);

  begin
    lbPlName.Caption :=
      '<- Нажми на кнопку чтобы выбрать ТТ для проверки скрипта';
    qPlace.Close;
    qPlace.Parameters.ParamByName('SAPl_Id').Value := FPlSA;
    qPlace.Parameters.ParamByName('Data_Source').Value := FDataSource;
    qPlace.Parameters.ParamByName('Pl_Type').Value := Pl_Type[AShop_Type];
    qPlace.Open;
    sbSetPlace.Visible := (qPlace.RecordCount > 0);

    if not sbSetPlace.Visible then
      SMessage('Нет ни одной ТТ с типом ' + PageControl2.ActivePage.Caption +
        ' на чём можно тренироваться..~' + IfVar(IsTestServer,
        'Попросите взрослого дядю приподтянь копию магазина/супера на тестовой базе',
        ''));

    qPlace.Locate('pl_Id', Pl_Id[AShop_Type], [loCaseInsensitive]);

    ConnectionString[AShop_Type] :=
      qPlace.FieldByName('PlConnectionString').AsString;

    case AShop_Type of
      1:
        begin
          cxGrid1Level1.GridView := cxGrid1DBTableView1;
        end;
      2:
        begin
          cxGrid1Level1.GridView := cxGrid1DBTableView2;
        end;
      3:
        begin
          cxGrid1Level1.GridView := cxGrid1DBTableView3;
        end;
    end;

    if Pl_Id[AShop_Type] = 0 then
      exit;
    lbPlName.Caption := qPlace.FieldByName('pl_Id').AsString + ' - ' +
      qPlace.FieldByName('pl_Name').AsString;

    try
      case AShop_Type of
        1:
          begin
            if qUser1.ConnectionString = ConnectionString[AShop_Type] then
              exit;
            qUser1.Close;
            qUser1.ConnectionString := ConnectionString[AShop_Type];
            qUser1.Open;
          end;
        2:
          begin
            if qUser2.ConnectionString = ConnectionString[AShop_Type] then
              exit;
            qUser2.Close;
            qUser2.ConnectionString := ConnectionString[AShop_Type];
            qUser2.Open;
          end;
        3:
          begin
            if qUser3.ConnectionString = ConnectionString[AShop_Type] then
              exit;
            qUser3.Close;
            qUser3.ConnectionString := ConnectionString[AShop_Type];
            qUser3.Open;
          end;
      end;
    except
      on E: exception do
      begin
        SMessage('Ошибка для ' + qPlace.FieldByName('pl_Id').AsString + ' - ' +
          qPlace.FieldByName('pl_Name').AsString + #13#10 + 'ConnectionString' +
          #13#10 + ConnectionString[AShop_Type] + #13#10 + E.Message);
      end;
    end;
  end;

Begin
  case AShop_Type of
    0:
      begin
        SetConnectionAttribute(1);
        SetConnectionAttribute(2);
        SetConnectionAttribute(3);
      end;
    1, 2, 3:
      begin
        SetConnectionAttribute(AShop_Type);
      end;
  end;
End;

procedure TfmUserRightAccessShopEdit.SetlbUserAccessResultCaption;
begin
  case PageControl2.ActivePage.Tag of
    - 1:
      begin
        lbUserAccessResult.Caption := '?';
        lbUserAccessResult.Font.Color := clBlack;
      end;
    0:
      begin
        lbUserAccessResult.Caption := 'Доступ запрещен';
        lbUserAccessResult.Font.Color := clRed;
      end;
    1:
      begin
        lbUserAccessResult.Caption := 'Доступ разрешен';
        lbUserAccessResult.Font.Color := clLime;
      end;
    2:
      begin
        lbUserAccessResult.Caption := 'Ошибка исполнения';
        lbUserAccessResult.Font.Color := clBlue;
      end;
  end;
end;

procedure TfmUserRightAccessShopEdit.FormShow(Sender: TObject);
var
  rr: String;
begin
  PageControl1.TabIndex := 0;
  PageControl2.TabIndex := 0;

  Shop_Type := 1;
  TabSheet3.TabVisible := False;
  Color := clBtnFace;
  FTesterServer := 'SQL-T2.dom.loc\MSSQL2016';
  SetButtons([sOkCancel]);
  AutoClose := true;
  BaseEdit := 'UserRightAccessShopList';

  qUser2.SQL := qUser1.SQL;
  qUser3.SQL := qUser1.SQL;

  qUser1.Parameters.ParamByName('SQL').Value := '';
  qUser1.Parameters.ParamByName('hideDis').Value := 0;

  qUser2.Parameters.ParamByName('SQL').Value := '';
  qUser2.Parameters.ParamByName('hideDis').Value := 0;

  qUser3.Parameters.ParamByName('SQL').Value := '';
  qUser3.Parameters.ParamByName('hideDis').Value := 0;

  Pl_Id[1] := 0;
  Pl_Id[2] := 0;
  Pl_Id[3] := 0;

  Pl_Type[1] := 1;
  Pl_Type[2] := 2;
  Pl_Type[3] := 3;

  FPlSA := 0;
  If not SetURASDeff(qryUserRightAccessEdit, FPlSA, FDataSource) then
    exit;

  // If not SetPl_IdDeff Then
  // Close;

  qryUserRightAccessEdit.Parameters.ParamByName('ID').Value := ID;
  qryUserRightAccessEdit.Open;

  qUnloadLog.Close;
  qUnloadLog.Parameters.ParamByName('SAPl_Id').Value := FPlSA;
  qUnloadLog.Parameters.ParamByName('Data_Source').Value := FDataSource;
  qUnloadLog.Parameters.ParamByName('Pl_Type').Value := 0;
  qUnloadLog.Parameters.ParamByName('SDoc').Value := ID;
  qUnloadLog.Open;

  PageControl2Change(self);
  // SetConnectionAttributeForShop_Type(pcActivePage);

  // if ID <> 0 then
  // QRefresh;
  nIsProgtest := False;

  if IsTestServer then
  begin
    mm_Copy.Visible :=
      Exists('SELECT 1 FROM sys.Servers where [name] = ''onenew''');
    mm_CopyTest2.Visible := mm_Copy.Visible;

    mm_Copy.Caption := mm_Copy.Caption + ' на One';
    FServer := 'eltro';

  end
  else
  begin
    nIsProgtest := true;
    FServer := Config.TestServer;
    mm_Copy.Caption := mm_Copy.Caption + ' на Progtest';
  end;

  smSMBig.Lines.Text := IfVar(ID <> 0,
    qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').AsString, '');
  smSMSmall.Lines.Text := IfVar(ID <> 0,
    qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').AsString, '');
  smSA.Lines.Text := IfVar(ID <> 0, qryUserRightAccessEdit.FieldByName
    ('URAS_ScriptSA').AsString, '');
  SetFocused(DBEdit1);
  // InitFindReplace(DataModule1.Connection, 'U', 'sql');

  // Размер шрифта по-умолчанию
  smSMBig.Font.Size := 13;
  smSMSmall.Font.Size := 13;
  smSA.Font.Size := 13;
  if Config.ProjIntName = 'Trade' then
    FBase := 'Electro';
end;

procedure TfmUserRightAccessShopEdit.FuckAllBtnClick(Sender: TObject);
var
  QText, URA_Script: String;
  hideDis: Integer;

  function ReplaceScript(QT, SReplace, SSource: string): String;
  var
    i, L: Integer;
    SHead: String;
  begin
    L := Length(SReplace);
    i := Pos(uppercase(SReplace), uppercase(QT));
    if i > 0 then
    begin
      while i > 0 do
      begin
        if (Pos(QT[i + L], ' (),.' + #10 + #13) > 0) and
          ((i = 1) or (Pos(QT[i - 1], ' (),.' + #10 + #13) > 0)) then
        begin
          if i > 1 then
            SHead := Copy(QT, 1, i - 1)
          else
            SHead := '';
          QT := SHead + SSource + Copy(QT, i + L, Length(QT) - i - L + 1);
          i := Pos(uppercase(SReplace), uppercase(QT));
        end
        else
          i := PosEx(uppercase(SReplace), uppercase(QT), i + 1);
      end;
    end;
    Result := QT;
  end;

  procedure RefreshQuery(q: TADOQuery; nhideDis: Integer);
  begin
    q.Close;
    q.Parameters.ParamByName('SQL').Value := QText;
    q.Parameters.ParamByName('hideDis').Value := nhideDis;
    q.Open;
  end;

begin
  if Pl_Id[pcActivePage] = 0 then
    sbSetPlaceClick(self);
  if Pl_Id[pcActivePage] = 0 then
    exit;
  case pcActivePage of
    1:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMBig').AsString;
      end;
    2:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSMSmall').AsString;
      end;
    3:
      begin
        URA_Script := qryUserRightAccessEdit.FieldByName
          ('URAS_ScriptSA').AsString;
      end;
  end;
  if URA_Script = '' then
    exit;

  QText := URA_Script;
  QText := ReplaceScript(QText, 'UserReally where',
    'UserReallyAll where Ur_Id=@Login and');
  QText := ReplaceScript(QText, 'UserReally ',
    'UserReallyAll where Ur_Id=@Login ');

  if (Sender as TBitBtn).Name = 'FuckAllBtnNoDis' then
    hideDis := 1
  else
    hideDis := 0;
  case pcActivePage of
    1:
      begin
        RefreshQuery(qUser1, hideDis);
      end;
    2:
      begin
        RefreshQuery(qUser2, hideDis);
      end;
    3:
      begin
        RefreshQuery(qUser3, hideDis);
      end;
  end;

end;

procedure TfmUserRightAccessShopEdit.PageControl2Change(Sender: TObject);
begin
  pcActivePage := PageControl2.TabIndex + 1;
  SetConnectionAttributeForShop_Type(pcActivePage);
  SetlbUserAccessResultCaption;
end;

procedure TfmUserRightAccessShopEdit.sbSetPlaceClick(Sender: TObject);
Var
  i: Integer;
  cStr: String;
  Pl_Id_Temp: Integer;
begin
  if (qPlace.RecordCount > 0) then
  begin
    qPlace.First;
    cStr := 'Код|Название';
    while not qPlace.Eof do
    begin
      cStr := cStr + ',' + qPlace.FieldByName('pl_Id').AsString + '|' +
        StringReplace(qPlace.FieldByName('Pl_Name').AsString, ',', ' ',
        [rfReplaceAll, rfIgnoreCase]);
      qPlace.Next;
    end;
    if not ViewListBoxGrid('Выбор подразделения для ТТ с типом ' +
      PageControl2.ActivePage.Caption, cStr, i) then
      exit;
    Pl_Id_Temp := TokenInt(Token(cStr, ',', i + 1), '|', 1);

    qPlace.Locate('pl_Id', Pl_Id_Temp, [loCaseInsensitive]);
    if not Ping(qPlace.FieldByName('Data_Source').AsString) then
    begin
      SMessage('Адрес ' + qPlace.FieldByName('Data_Source').AsString +
        ' не пингуется...~' +
        'Необходимо выбрать другую ТТ для проверки скрипта');
      exit;
    end;
    Pl_Id[pcActivePage] := Pl_Id_Temp;
    SetConnectionAttributeForShop_Type(pcActivePage);
  end;
end;

procedure TfmUserRightAccessShopEdit.mm_CopyClick(Sender: TObject);
var
  q: TADOQuery;
  i: Integer;
  sp: TADOStoredProc;
  S: string;
begin
  if qryUserRightAccessEdit.FieldByName('URAS_Id').IsNull then
  begin
    SMessage('Перед копированием необходимо заполнить и сохранить данные');
    exit;
  end;
  if not CheckEditEx(true) then
    exit;

  FPerson := _GetWhoUpdate;
  if FPerson = 0 then
    exit;
  try
    q := TADOQuery.Create(nil);
    if (Sender as TMenuItem).Tag = 1 then
    begin
      q.ConnectionString :=
        'Provider=SQLOLEDB.1;Password=1111;Persist Security Info=True;User ID=sa;'
        + 'Initial Catalog=' + FBase + ';Data Source=' + FTesterServer;
    end
    else
    begin
      if nIsProgtest then
        q.ConnectionString :=
          'Provider=SQLOLEDB.1;Password=1111;Persist Security Info=True;User ID=sa;'
          + 'Initial Catalog=' + FBase + ';Data Source=' + FServer
      else
      begin
        sp := CreateProc('GetSAPasswordOneNew');
        try
          sp.Parameters.ParamByName('@cPassword').Value := '';
          try
            sp.ExecProc;
            S := sp.Parameters.ParamByName('@cPassword').Value;
          except
            on E: exception do
              SMessage('Ошибка доступа: ' + E.Message);
          end;
        finally
          sp.Free;
        end;

        S := Trim(UnCryptingPassword(S));
        q.ConnectionString := 'Provider=SQLOLEDB.1;Password=' + S +
          ';Persist Security Info=False;User ID=sa;' + 'Initial Catalog=' +
          FBase + ';Data Source=' + Config.OneNewIP;
      end;
    end;

    q.CommandTimeout := 180;
    q.SQL.Clear;
    q.SQL.Add(

      'DECLARE' + #13#10 + //
      '   @URAS_Code            INT = :Code,' + #13#10 + //
      '   @URAS_Name            VARCHAR (255) = :Name,' + #13#10 + //
      '   @URAS_MessError       VARCHAR (255) = :MessError,' + #13#10 + //
      '   @URAS_ScriptSMBig     VARCHAR (max) = :ScriptSMBig,' + #13#10 + //
      '   @URAS_ScriptSMSmall   VARCHAR (max) = :ScriptSMSmall,' + #13#10 + //
      '   @URAS_ScriptSA        VARCHAR (max) = :ScriptSA,' + #13#10 + //
      '   @URAS_IsDel           BIT = :IsDel,' + #13#10 + //
      '   @URAS_WhoUpdate       INT = :Person,' + #13#10 + //
      '   @Mess                 VARCHAR (1000)= ''''''''' + #13#10 + //
      'IF @Mess = ''''''''' + #13#10 + //
      '   SET @Mess = NULL' + #13#10 + //
      '   BEGIN TRAN' + #13#10 + //
      '   BEGIN TRY' + #13#10 + //
      '    IF EXISTS' + #13#10 + //
      '          (SELECT *' + #13#10 + //
      '           FROM UserRightAccessShop' + #13#10 + //
      '           WHERE URAS_Code = @URAS_Code)' + #13#10 + //
      '       UPDATE UserRightAccessShop' + #13#10 + //
      '       SET URAS_IsDel = 1' + #13#10 + //
      '       WHERE URAS_Code = @URAS_Code' + #13#10 + //
      '     INSERT INTO UserRightAccessShop (URAS_Code,' + #13#10 + //
      '                                      URAS_Name,' + #13#10 + //
      '                                      URAS_MessError,' + #13#10 + //
      '                                      URAS_ScriptSMBig,' + #13#10 + //
      '                                      URAS_ScriptSMSmall,' + #13#10 + //
      '                                      URAS_ScriptSA,' + #13#10 + //
      '                                      URAS_IsDel,' + #13#10 + //
      '                                      URAS_WhoUpdate)' + #13#10 + //
      '     VALUES (@URAS_Code,' + #13#10 + //
      '             @URAS_Name,' + #13#10 + //
      '             @URAS_MessError,' + #13#10 + //
      '             @URAS_ScriptSMBig,' + #13#10 + //
      '             @URAS_ScriptSMSmall,' + #13#10 + //
      '             @URAS_ScriptSA,' + #13#10 + //
      '             @URAS_IsDel,' + #13#10 + //
      '             @URAS_WhoUpdate)' + #13#10 + //
      '   END TRY' + #13#10 + //
      '   BEGIN CATCH' + #13#10 + //
      '     SET @Mess = Error_message()' + #13#10 + //
      '     IF @@TRANCOUNT > 0 ROLLBACK TRAN' + #13#10 + //
      '   END CATCH' + #13#10 + //

      '   IF @@TRANCOUNT > 0 COMMIT TRAN' + #13#10 + //
      '   if @mess <> ''''''''' + #13#10 + //
      '       RAISERROR(@mess, 16, 10)');
    q.Parameters.ParamByName('Code').Value := qryUserRightAccessEdit.FieldByName
      ('URAS_Code').Value;
    q.Parameters.ParamByName('Name').Value := qryUserRightAccessEdit.FieldByName
      ('URAS_Name').Value;
    q.Parameters.ParamByName('MessError').Value :=
      qryUserRightAccessEdit.FieldByName('URAS_MessError').AsString;
    q.Parameters.ParamByName('ScriptSMBig').Value :=
      qryUserRightAccessEdit.FieldByName('URAS_ScriptSMBig').AsString;
    q.Parameters.ParamByName('ScriptSMSmall').Value :=
      qryUserRightAccessEdit.FieldByName('URAS_ScriptSMSmall').AsString;
    q.Parameters.ParamByName('ScriptSA').Value :=
      qryUserRightAccessEdit.FieldByName('URAS_ScriptSA').AsString;
    q.Parameters.ParamByName('IsDel').Value :=
      qryUserRightAccessEdit.FieldByName('URAS_IsDel').AsBoolean;
    q.Parameters.ParamByName('Person').Value := FPerson;
    q.ExecSQL;
    SMessageI('Загрузка прошла успешно');
  except
    on E: exception do
    begin
      SMessage('Загрузка потерпела неудачу.~' + E.Message);
      exit;
    end;
  end;

end;

procedure TfmUserRightAccessShopEdit.mm_CopyURASInCurrentShopClick
  (Sender: TObject);
var
  q: TADOStoredProc;
begin
  q := CreateProc('pr_CopyURASInCurrentShop');
  q.ExecuteOptions := [eoExecuteNoRecords];
  try
    q.Parameters.ParamByName('@URAS_ID').Value := ID;
    q.Parameters.ParamByName('@URAUL_Pl_Id').Value :=
      qUnloadLog.FieldByName('Pl_Id').AsInteger;
    q.Parameters.ParamByName('@Server').Value :=
      qUnloadLog.FieldByName('Data_Source').AsString;
    q.Parameters.ParamByName('@Pwd').Value :=
      qUnloadLog.FieldByName('PWD').AsString;
    q.Parameters.ParamByName('@Database').Value :=
      qUnloadLog.FieldByName('BDName').AsString;
    try
      q.ExecProc;
      qUnloadLog.Close;
      qUnloadLog.Open;
    except
      on E: exception do
        SMessage('Ошибка копирования данных:~' + E.Message);
    end;
  finally
    q.Close;
    q.Free;
  end;
end;

procedure TfmUserRightAccessShopEdit.mm_ShopAdminListInfoClick(Sender: TObject);
var
  q: TADOQuery;
begin
  if Pl_Id[pcActivePage] = 0 then
  begin
    SMessage('Вначале необходимо выбрать ТТ');
    exit;
  end;

  try
    q := TADOQuery.Create(nil);
    q.ConnectionString := ConnectionString[pcActivePage];
    q.SQL.Clear;
    q.SQL.Add('SELECT SAL_ID, SAL_Name, SAL_MainRoles FROM ShopAdminList');
    q.Open;
    SMessageGrid('Должности на ТТ ' + lbPlName.Caption, q, '', False, False, 1,
      '', '70,140,200', False, False);
  finally
    q.Free;
  end;
end;

end.
