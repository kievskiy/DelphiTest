unit RouteCostList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCalendar, cxLabel, cxCurrencyEdit, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, Data.Win.ADODB, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, Vcl.ComCtrls, Vcl.Menus, DataModule, CustomForm, ComObj,JSON;

type
  TfRouteCostList = class(TDataListForm)
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    cxTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dsDocList: TDataSource;
    qDocList: TADOQuery;
    cxTableView1Column1: TcxGridDBColumn;
    cxTableView1Column2: TcxGridDBColumn;
    cxTableView1Column3: TcxGridDBColumn;
    cxTableView1Column4: TcxGridDBColumn;
    RefreshItem: TMenuItem;
    cxTableView1Column5: TcxGridDBColumn;
    mm_Filter: TMenuItem;
    mm_FilterDate: TMenuItem;
    mm_FilterPlace: TMenuItem;
    mm_FilterAll: TMenuItem;
    mm_LoadFromExcel: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure EditRecord(Sender: TObject); override;
    procedure InsertRecord(Sender: TObject); override;
    procedure DeleteRecord(Sender: TObject); override;
    procedure RefreshItemClick(Sender: TObject);
    procedure qDocListAfterScroll(DataSet: TDataSet);
    procedure mm_FilterDateClick(Sender: TObject);
    procedure mm_FilterPlaceClick(Sender: TObject);
    procedure mm_FilterAllClick(Sender: TObject);
    procedure mm_LoadFromExcelClick(Sender: TObject);
  private
    { Private declarations }
    FFilter: integer;
    FDateStart: TDateTime;
    FDateFinal: TDateTime;
    FPlace: string;
  public
    { Public declarations }
    procedure QRefresh(nID : Integer = 0); override;
  end;

procedure ViewRouteCostList;

implementation

{$R *.dfm}

uses RouteCostEdit, DblCalendar, mChD, RepWindow;

procedure TfRouteCostList.FormShow(Sender: TObject);
begin
  FFilter:=0;
  FDateStart:=Config.DateStart;
  FDateFinal:=Config.DateFinal;
  FPlace:='';

  StatusBar1.Font.Size := cxGrid1.Font.Size;
  StatusBar1.Panels.Items[0].Width := cxTableView1Column1.Width;
  QRefresh();
end;

procedure TfRouteCostList.QRefresh(nID : Integer = 0);
begin
  qDocList.AfterScroll := nil;

  if (nID = 0) and (qDocList.Active) then
    nID := qDocList.FieldByName('RC_ID').AsInteger;

  qDocList.Close;

  qDocList.Parameters.ParamByName('Filter').Value:=FFilter;
  qDocList.Parameters.ParamByName('Date1').Value:=FDateStart;
  qDocList.Parameters.ParamByName('Date2').Value:=FDateFinal;
  qDocList.Parameters.ParamByName('Place').Value:=FPlace;
  qDocList.Open;

  if nID <> 0 then
    qDocList.Locate('RC_ID', nID, [loCaseInsensitive]);

  qDocList.AfterScroll := qDocListAfterScroll;
end;

procedure TfRouteCostList.qDocListAfterScroll(DataSet: TDataSet);
begin
  StatusBar1.Panels.Items[0].Text := IntToStr(qDocList.RecNo) + ':' + IntToStr(qDocList.RecordCount);
end;

procedure TfRouteCostList.RefreshItemClick(Sender: TObject);
begin
  QRefresh();
end;

procedure TfRouteCostList.InsertRecord;
begin
  if not CheckAccess(90016, False) then
  begin
    SMessageI('У Вас нет права добавления этих данных!');
    Exit;
  end;

  EditRouteCost( 0 );
  QRefresh();
end;

procedure TfRouteCostList.mm_FilterAllClick(Sender: TObject);
begin
  FFilter:=0;
  FPlace:='';
  QRefresh();
end;

procedure TfRouteCostList.mm_FilterDateClick(Sender: TObject);
begin
  if not SDR then  Exit;
  FFilter:=1;
  FDateStart:=Config.DateStart;
  FDateFinal:=Config.DateFinal;
  QRefresh();
end;

procedure TfRouteCostList.mm_FilterPlaceClick(Sender: TObject);
var XML:TResultParams;
begin
  XML:=mChD.SelectParams(['D=Place|F=Pl_Type=2|MS=True|AZ=True|']);
  if not Assigned(XML) then Exit ;

  try
    FPlace:=XML.DictIDs('Place');
  finally
    XML.Destroy;
  end;
  QRefresh();
end;

procedure TfRouteCostList.mm_LoadFromExcelClick(Sender: TObject);
const
  xlCellTypeLastCell = $0000000B;
var XLApp, Sheet: OLEVariant;
    RangeMatrix: Variant;
    fRepWindow: TfRepWindow;
    x,y, j:integer;
    P1: integer;
    P2, P3: TDateTime;
    P5: double;
    sp: TADOStoredProc;
    msg, s: string;
    JSONArray: TJSONArray;
    JSONObject: TJSONObject;
begin
  if not OpenDialog1.Execute then Exit;
  XLApp := CreateOleObject('Excel.Application');
  try
    XLApp.Visible := False;
    XLApp.DisplayAlerts := false;
    XLApp.Workbooks.Open(OpenDialog1.FileName);
    Sheet := XLApp.Workbooks[ExtractFileName(OpenDialog1.FileName)].WorkSheets[1];
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    x := XLApp.ActiveCell.Row;
    y := XLApp.ActiveCell.Column;
    msg:='';
// Количество столбиков их название и ошибка по неправильному формату
    if (x<2) or (y<>5) then
    begin
      msg:='Файл "'+OpenDialog1.FileName+'" содержит некорректные данные, и не может быть загружен.' +
        '~Необходимая структура файла:' +
        '~Первая строка - шапка. Данные со второй строки.' +
        '~Кол-во столбиков:5' +
        '~1 : Код магазина(обязателен к заполнению)'+
        '~2 : Дата начала (обязателен к заполнению) Формат: ДД/ММ/ГГ'+
        '~3 : Дата окончания(обязателен к заполнению) Формат: ДД/ММ/ГГ'+
        '~4 : Название магазина(можно оставить пустым)'+
        '~5 : Стоимость(обязателен к заполнению)';
    end
    Else
    Begin
      RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
      fRepWindow := TfRepWindow.Create(Screen.ActiveForm);
      try
        fRepWindow.Text := 'Загрузка с Excel...';
        fRepWindow.Count := X;
        fRepWindow.Show;
        fRepWindow.Repaint;

        Formatsettings.ShortDateFormat := 'dd/mm/yyyy';
        JSONArray  := TJSONArray.Create; //собираем json
        for J := 2 to X do
        Begin
          fRepWindow.Position := J;

          if not TryStrToInt(VarToStr(RangeMatrix[J,1]),P1) then
          begin
            msg:=msg+'Строка '+IntToStr(J)+' колонка 1 содержит некоректные/неполные данные'+#13;
            Continue;
          end;

          try
           P2:= StrToDate(RangeMatrix[J,2]);
          except
            begin
              msg:=msg+'Строка '+IntToStr(J)+' колонка 2 содержит некоректные/неполные данные. Правильный формат: ДД/ММ/ГГ'+#13;
              Continue;
            end;
          end;

          try
           P3:= StrToDate(RangeMatrix[J,3]);
          except
            begin
              msg:=msg+'Строка '+IntToStr(J)+' колонка 3 содержит некоректные/неполные данные. Правильный формат: ДД/ММ/ГГ'+#13;
              Continue;
            end;
          end;

          if not TryStrToFloat(VarToStr(RangeMatrix[J,5]),P5) then
          begin
            msg:=msg+'Строка '+IntToStr(J)+' колонка 5 содержит некоректные/неполные данные'+#13;
            Continue;
          end;

          JSONObject := TJSONObject.Create;
          JSONObject.AddPair('Pl_Id', TJSONNumber.Create(P1));
          JSONObject.AddPair('DateFrom', TJSONString.Create(FormatDateTime('yyyy/mm/dd',P2)));
          JSONObject.AddPair('DateTo', TJSONString.Create(FormatDateTime('yyyy/mm/dd',p3)));
          JSONObject.AddPair('Summa', TJSONNumber.Create(P5));

          JSONArray.AddElement(JSONObject);
         End;

        S:=JSONArray.ToString();
        sp:= TADOStoredProc(nil);
        try
         sp:=CreateProc('prInsertRouteCostList');
         sp.Parameters.ParamByName('@json').Value:=S;
         try
           sp.ExecProc;
         except
           on E: Exception do msg:=E.Message;
         end;
        finally
          sp.Free;
        end;
      finally
        fRepWindow.Close;
        fRepWindow.Free;
      end;
    End;

  finally
    RangeMatrix := Unassigned;
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.Quit;
      XLApp.DisplayAlerts := true;
      XLAPP := Unassigned;
      Sheet := Unassigned;
    end;
    if msg = ''
      then SMessage('Загрузка прошла успешно')
      else SMessage(msg);
    QRefresh;
  end;
end;

procedure TfRouteCostList.EditRecord;
begin
  EditRouteCost( qDocList.FieldByName('RC_ID').AsInteger );
  QRefresh();
end;

procedure TfRouteCostList.DeleteRecord;
var
  SP : TADOStoredProc;
begin
  if not CheckAccess(90016, False) then
  begin
    SMessageI('У Вас нет права удаления этих данных!');
    Exit;
  end;

  if qDocList.RecordCount = 0 then
  begin
    SMessageW('Нет записей для удаления...~~Вас кто-то опередил и все удалил...');
    Exit;
  end;

  if SMesDlg('Удалить запись ?') <> mrOk then Exit;

  SP := CreateProc('RouteCost_Delete_Delphi');
  SP.Parameters.Refresh;
  SP.Parameters.ParamByName('@ID').Value := qDocList.FieldByName('RC_ID').AsInteger;
  SP.ExecProc;
  SP.Close;
  FreeAndNil(SP);

  QRefresh();
end;

procedure ViewRouteCostList;
var
  fRouteCostList : TfRouteCostList;
begin
  if not DataModule1.Connection.Connected then Exit;

  if not CheckAccess(90016, False) and
     not CheckAccess(90017, False) then
  begin
    SMessageI('У Вас нет права просмотра этих документов!');
    Exit;
  end;

  fRouteCostList := TfRouteCostList.Create( Application.MainForm );
  try
    fRouteCostList.Show;
  except
    fRouteCostList.Free;
  end;
end;

end.
