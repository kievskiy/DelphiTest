unit UserRightAccessShopList;

interface

{$INCLUDE definitions.inc}
{$IFDEF TRADE}
{$DEFINE USE_URALOG}
{$ENDIF}
{$IFDEF DOORS}
{$DEFINE USE_URALOG}
{$ENDIF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  CustomForm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, ONumUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxButtonEdit, Vcl.Menus, System.Actions, Vcl.ActnList, Data.Win.ADODB,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxImageComboBox;

type
  TfmUserRightAccessShopList = class(TDataListForm)
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1URAS_Code: TcxGridDBColumn;
    cxGrid1DBTableView1URAS_Name: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    qryUserRightAccess: TADOQuery;
    dsUserRightAccess: TDataSource;
    mm1: TMainMenu;
    mm_Filter: TMenuItem;
    N7: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    mm_Log: TMenuItem;
    mm_Job: TMenuItem;
    mmFAll: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    cxGrid1DBTableView1_Success: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure mm_LogClick(Sender: TObject);

    procedure EditRecord(Sender: TObject); override;
    procedure InsertRecord(Sender: TObject); override;
    procedure DeleteRecord(Sender: TObject); override;
    procedure mm_JobClick(Sender: TObject);
    procedure mmFAllClick(Sender: TObject);

  private
    { Private declarations }
    FPlSA, FFilterActive: Integer;
    FDataSource: String;
  public
    { Public declarations }
    procedure QRefresh(nID: Integer = 0); override;
  end;

procedure UserRightAccessShopListOpen;

Function SetURASDeff(qry: TADOQuery; var APlSA: Integer;
  var ADataSource: String): Boolean;

implementation

{$R *.dfm}

uses DataModule, UserRightAccessShopEdit, UserRightAccessShopLog;

procedure UserRightAccessShopListOpen;
var
  fmUserRightAccessShopList: TfmUserRightAccessShopList;
Begin
  if (Config.Person <> 117) and (Config.Person <> 25036) and
    (Config.Person <> 29636) then
    Exit;
  fmUserRightAccessShopList := TfmUserRightAccessShopList.Create
    (Screen.ActiveForm);
  try
    fmUserRightAccessShopList.Show;
  Except
    fmUserRightAccessShopList.Free;
  end;
End;

procedure TfmUserRightAccessShopList.EditRecord(Sender: TObject);
begin
  EditUserRightAccessForTT(qryUserRightAccess.FieldByName('URAS_ID').AsInteger);
end;

procedure TfmUserRightAccessShopList.InsertRecord(Sender: TObject);
begin
  EditUserRightAccessForTT(0);
end;

procedure TfmUserRightAccessShopList.mmFAllClick(Sender: TObject);
begin
  FFilterActive := (Sender as TMenuItem).Tag;
  QRefresh;
end;

procedure TfmUserRightAccessShopList.DeleteRecord(Sender: TObject);
begin
  if qryUserRightAccess.IsEmpty then
    Exit;
  if qryUserRightAccess.FieldByName('URAS_IsDel').AsBoolean then
  begin
    SMessage('Запись уже удалена');
    Exit;
  end;

  if SMesDlg('Удаление записи приведёт к удаления на всех ТТ.~Удалить запись ' +
    qryUserRightAccess.FieldByName('URAS_Code').AsString + '?') <> mrOk then
    Exit;
  Execute('UPDATE UserRightAccessShop SET URAS_IsDel = 1 Where URAS_ID = ' +
    qryUserRightAccess.FieldByName('URAS_ID').AsString);
  SendMessage(ActiveControl.Handle, WM_KEYDOWN, VK_UP, 0);
  QRefresh;
end;

Function SetURASDeff(qry: TADOQuery; var APlSA: Integer;
  var ADataSource: String): Boolean;
var
  q: TADOQuery;
  TestConnectionString: String;
begin
  Result := False;
  APlSA := 0;
  if IsTestServer then
  begin
    if Exists('SELECT 1 FROM sys.databases WHERE [name] = ''ShopAccount''') then
    begin
      // Ищем Id TT
      // Для этого лезим в конфиг на db ShopAccount на тестовом
      try
        q := TADOQuery.Create(nil);
        TestConnectionString := qry.Connection.ConnectionString;
        ADataSource :=
          Token(Token(Copy(TestConnectionString, Pos('Data Source',
          TestConnectionString), Length(TestConnectionString) -
          Pos('Data Source', ADataSource) + 1), '=', 2), ';', 1);
        q.ConnectionString :=
          'Provider=SQLOLEDB.1;Password=1111;Persist Security Info=True;User ID=sa;'
          + 'Initial Catalog=master;Data Source=' + ADataSource;
        q.SQL.Clear;
        q.SQL.Add('Select Con_ShopPlace from Shops.ShopAccount.dbo.Config');
        q.Open;
        APlSA := q.FieldByName('Con_ShopPlace').AsInteger;
        q.Close;

        q.SQL.Clear;
        q.SQL.Add('SELECT data_source FROM sys.Servers WHERE name = ''SHOPS''');
        q.Open;
        ADataSource := q.FieldByName('data_source').AsString;

      finally
        q.Free;
      end;
    end;
  end;
  Result := True;
end;

procedure TfmUserRightAccessShopList.actAddExecute(Sender: TObject);
begin
  InsertRecord(Self);
end;

procedure TfmUserRightAccessShopList.actDelExecute(Sender: TObject);
begin
  DeleteRecord(Self);
end;

procedure TfmUserRightAccessShopList.actEditExecute(Sender: TObject);
begin
  EditRecord(Self);
end;

procedure TfmUserRightAccessShopList.actRefreshExecute(Sender: TObject);
begin
  QRefresh;
end;

procedure TfmUserRightAccessShopList.FormShow(Sender: TObject);
begin
  If not SetURASDeff(qryUserRightAccess, FPlSA, FDataSource) then
    Exit;
  FFilterActive := 0;
  QRefresh;
end;

procedure TfmUserRightAccessShopList.mm_JobClick(Sender: TObject);
var
  q: TADOStoredProc;
begin

  q := CreateProc('Job_CopyURASInShop');
  q.CommandTimeout := 360;
  q.ExecuteOptions := [eoExecuteNoRecords];
  try
    q.Parameters.ParamByName('@SAPl_Id').value := FPlSA;
    q.Parameters.ParamByName('@Data_Source').value := FDataSource;
    try
      q.ExecProc;
      SMessage('Всё ушло');
    except
      on E: exception do
        SMessage('Ошибка копирования данных:~' + E.Message);
    end;
  finally
    q.Close;
    q.Free;
  end;
end;

procedure TfmUserRightAccessShopList.mm_LogClick(Sender: TObject);
begin
{$IFDEF USE_URALOG}
  ViewUserRightAccessShopLog;
{$ENDIF}
end;

procedure TfmUserRightAccessShopList.QRefresh(nID: Integer = 0);
begin
  if qryUserRightAccess.Active and (nID = 0) then
    nID := qryUserRightAccess.FieldByName('URAS_ID').AsInteger;
  qryUserRightAccess.Close;
  qryUserRightAccess.Parameters.ParamByName('_SAPl_Id').value := FPlSA;
  qryUserRightAccess.Parameters.ParamByName('_Data_Source').value :=
    FDataSource;
  qryUserRightAccess.Parameters.ParamByName('_IsActive').value := FFilterActive;
  qryUserRightAccess.Open;
  if nID <> 0 then
    qryUserRightAccess.Locate('URAS_ID', nID, [loCaseInsensitive]);
end;

{
  initialization

  AddDict('URRForTTType', 'URRForTTType', 'Типы доступов ТТ,Тип доступов ТТ,Типов доступов ТТ',
  'SELECT 1 AS URRFTT_Id, ''Супермаркет большой'' AS URRFTT_Name ' +
  ' UNION SELECT 2 AS URRFTT_Id, ''Супермаркет малый'' AS URRFTT_Name ' +
  ' UNION SELECT 3 AS URRFTT_Id, ''Магазин'' AS URRFTT_Name', nil);
}
end.
