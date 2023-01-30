unit CriterionsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, Data.Win.ADODB, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,CustomForm, CriterionsEdit,
  cxCheckBox, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cxLabel;

type
  TfCriterionsList = class(TDataListForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dsCriterion: TDataSource;
    qCriterion: TADOQuery;
    cCR_ID: TcxGridDBColumn;
    cCr_Name: TcxGridDBColumn;
    cCr_NameAnalitik: TcxGridDBColumn;
    cCr_IsMulti: TcxGridDBColumn;
    pChoice: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mm_RepCritUsing: TMenuItem;
    mm_CriterionSteps: TMenuItem;
    N2: TMenuItem;
    mm_LoadFromExcel: TMenuItem;
    OpenDialog1: TOpenDialog;
    c_QtyCriterionSteps: TcxGridDBColumn;
    mm_PrintPattern: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure InsertRecord(Sender: TObject); override;  // Вставить запись
    procedure EditRecord(Sender: TObject); override;    // Редактировать  запись
    procedure DeleteRecord(Sender: TObject); override;
    procedure mSelClick(Sender: TObject);
    procedure mm_RepCritUsingClick(Sender: TObject);
    procedure mm_CriterionStepsClick(Sender: TObject);
    procedure mm_LoadFromExcelClick(Sender: TObject);
    procedure mm_PrintPatternClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
    ID:Integer;
    mSel,Delim:TmenuItem;
  public
    { Public declarations }
    procedure QRefresh(nID : Integer = 0); override; // Обновить данные
  end;

//var
  //fCriterionsList: TfCriterionsList;
  procedure ViewCriterionsList;  // Открытие окна
  function  selectCriterionsList(pID:integer):integer;  // Открытие окна (Выбор)

implementation
uses ComObj, CriterionList, JSON, RepWindow,uExcelExport, CriterionsUnion, CriterionsManyToOne;
{$R *.dfm}


function  selectCriterionsList(pID:integer):integer;  // Открытие окна (Выбор)
var
  fCriterionsList : TfCriterionsList;
begin
  if not DataModule1.Connection.Connected then Exit;
  fCriterionsList := TfCriterionsList.Create(Screen.ActiveForm);
  try
    try
      fCriterionsList.pChoice.Visible:=True;
      fCriterionsList.cxGrid1DBTableView1.OnDblClick:=fCriterionsList.mSelClick;

      fCriterionsList.mSel := TMenuItem.Create(nil);
      fCriterionsList.mSel.Name := 'mSel';
      fCriterionsList.mSel.Caption := 'Выбрать';
      fCriterionsList.mSel.ImageIndex := 21;
      fCriterionsList.mSel.OnClick := fCriterionsList.mSelClick;

      fCriterionsList.Delim := TMenuItem.Create(nil);
      fCriterionsList.Delim.Name := 'mDelim';
      fCriterionsList.Delim.Caption := '-';

      fCriterionsList.FQPopupMenu.Items.Insert(0, fCriterionsList.Delim);
      fCriterionsList.FQPopupMenu.Items.Insert(0, fCriterionsList.mSel);


      fCriterionsList.ID := pID;
      if fCriterionsList.ShowModal = mrOk then
        Result:=fCriterionsList.qCriterion.FieldByName('Cr_ID').AsInteger
      else
        Result:=-1;
    finally

      fCriterionsList.Free;
    end;
  except
    fCriterionsList.Free;
  end;
end;

procedure ViewCriterionsList;  // Открытие окна
var
  fCriterionsList : TfCriterionsList;
begin
  if not DataModule1.Connection.Connected then Exit;
  fCriterionsList := TfCriterionsList.Create(Screen.ActiveForm);
  try
    fCriterionsList.ID := 0;
    fCriterionsList.Show;
  except
    fCriterionsList.Free;
  end;
end;

{ TfCriterionsList }

procedure TfCriterionsList.DeleteRecord(Sender: TObject); // Удалить  запись
begin
  if qCriterion.RecordCount = 0 then Exit;

  if SMesDlg('Удалить критерий ' + qCriterion.FieldByName('Cr_ID').AsString +
    ' ?') <> mrOk then Exit;
  if Execute('Delete Criterion Where Cr_ID = ' + qCriterion.FieldByName('Cr_ID').AsString) then
    SendMessage(ActiveControl.Handle, WM_SYSKEYDOWN, VK_UP, 0);

  ResetData(Self);
end;

procedure TfCriterionsList.EditRecord(Sender: TObject);  // Редактировать  запись
begin
  if not qCriterion.Active then Exit;
  if qCriterion.RecordCount = 0 then InsertRecord(Sender)
  else EditCriterions(qCriterion.FieldByName('Cr_ID').AsInteger);
end;

procedure TfCriterionsList.FormShow(Sender: TObject);
begin
   QRefresh(ID);
end;

procedure TfCriterionsList.InsertRecord(Sender: TObject);  // Вставить  запись
begin
  if not qCriterion.Active then Exit;
  EditCriterions(0);
end;

procedure TfCriterionsList.mm_CriterionStepsClick(Sender: TObject);
begin
  CriterionStepsList(qCriterion.FieldByName('Cr_ID').AsInteger);
end;

procedure TfCriterionsList.mm_LoadFromExcelClick(Sender: TObject);
const
  xlCellTypeLastCell = $0000000B;
var
  XLApp, Sheet: OLEVariant;
  RangeMatrix: Variant;
  x, y, J:integer;
  msg:String;
  jA:TJsonArray;//uses JSON
  jO:TJsonObject;
  sp:TAdoStoredProc;

  procedure addPair(param: String; value : Variant; paramType : integer = 0);
  var s:string;
  begin
    if paramType = 0 then begin// string
      s:= VarToStr(value).Trim;
      if (s.IsEmpty) or (s='null')
      then JO.AddPair(param, TJSONNull.Create)//если строка пуста то запишем null
      else JO.AddPair(param, s);
    end
    else if paramType = 1 then  // date
      JO.AddPair(param, FormatDateTime( 'yyyy-MM-dd', value))
    else if paramType = 2 then  // number
      JO.AddPair(param, TJSONNumber.Create(value))
    else if paramType = 3 then  // boolean
      JO.AddPair(param, TJSONBool.Create(value))
    else if paramType = 4 then  // null
      JO.AddPair(param, TJSONNull.Create)
  end;

var
  P1 : Integer;
  P2 : String;
  P3 : String;
begin//Загрузка значений меры
// Права
  if not CheckAccess(230003,true) then Exit;
  if not OpenDialog1.Execute then exit;
  XLApp := CreateOleObject('Excel.Application');//uses ComObj
  sp:= CreateProc('pr_CriterionSteps_LoadFromExcel');
  jA:=TJsonArray.create;
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
    if (x<2) or (y<4) then
    begin
      msg:='Файл "'+OpenDialog1.FileName+'" содержит некорректные данные, и не может быть загружен.'
        +'~~Необходимая структура файла:'
        +'~1 строка не используется и нужна для оглавления колонок '
        +'~Кол-во столбиков:4'
        +'~1 : Код критерия(обязателен к заполнению)'
        +'~2 : Название критерия (не обязателен к заполнению)'
        +'~3 : Мера рус (обязателен к заполнению)'
        +'~4 : Мера укр (обязателен к заполнению)'
;   end
    Else
    Begin
      RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
      {fRepWindow := TfRepWindow.Create(Screen.ActiveForm);
        fRepWindow.Panel1.Caption:= 'Загрузка с Excel...';
        fRepWindow.dxfProgressBar1.Min := 1;
        fRepWindow.dxfProgressBar1.Max := X;
        fRepWindow.dxfProgressBar1.Step := 1;
        fRepWindow.dxfProgressBar1.Visible := true;//fRepWindow.Show;
        fRepWindow.Repaint;}

        for J := 2 to X do
        Begin
          //fRepWindow.dxfProgressBar1.Position := J;//fRepWindow.Position := J;
          //fRepWindow.Repaint;

          if not TryStrToInt(VarToStr(RangeMatrix[J,1]),P1) then
          begin
            msg:=msg+'Строка '+IntToStr(J)+' колонка 1 содержит некоректные/неполные данные'+#13;
            Continue;
          end;
          P2 := VarToStr(RangeMatrix[J,3]);
          P3 := VarToStr(RangeMatrix[J,4]);
          jO:=TJsonObject.Create;
          addpair('P1',P1,2);
          addpair('P2',P2,0);
          addpair('P3',P3,0);
          jA.AddElement(jO);
        end;
        sp.Parameters.Refresh;
        sp.Parameters.ParamByName('@data').Value:=jA.ToString;
        sp.Parameters.ParamByName('@data').size:=8000;//если не указать то выдает ошибку
        sp.Parameters.ParamByName('@rez').value:='';
        sp.Parameters.ParamByName('@rez').size:=8000;//если не указать то выдает ошибку
        try
            sp.ExecProc;
            msg:=msg+sp.Parameters.ParamByName('@rez').Value;
        except on E: Exception do
            msg:=msg+ E.Message;
        end;
    end;
  finally
   RangeMatrix := Unassigned;
   if not VarIsEmpty(XLApp) then
   begin
     XLApp.Quit;
     XLApp.DisplayAlerts := true;
     XLAPP := Unassigned;
     Sheet := Unassigned;
   end;
   FreeAndNil(ja);
   sp.free;
   if msg <> '' then SMessage(msg)
   else SMessageI('Данные загружены успешно.');
   QRefresh;
  end;

end;

procedure TfCriterionsList.mm_PrintPatternClick(Sender: TObject);
var
  F1 : TextFile;
  fRepWindow : TfRepWindow;
  cFile : string;
begin
  cFile := NamingFile('PatternEnterCriteria');
  try
    AssignFile(F1,Config.UserPath+cFile);
    Rewrite(F1);
  except
     SMessage('Файл уже открыт! Закройте его или переименуйте!');Exit;
  end;
  CloseFile(F1);
  fRepWindow := TfRepWindow.Create(Nil); fRepWindow.Show; fRepWindow.Repaint;
  with TExcelExport.Create do
  try
    FileName := Config.UserPath + cFile;
    PageOrientation := true;
    LeftMargin := 0.7;
    RightMargin := 0.5;
    TopMargin := 1;
    BottomMargin := 0.5;
    Open;
    SetColumns(0,32*100); WriteCell(23,-1,0,'Код критерия');
    SetColumns(1,32*255); WriteCell(23,-1,1,'Название критерия');
    SetColumns(2,32*255); WriteCell(23,-1,2,'Мера рус.');
    SetColumns(3,32*255); WriteCell(23,-1,3,'Мера укр.');
  finally
    Close; Free;
    fRepWindow.Close; fRepWindow.Free;
  end;
  OpenExcelFile(cFile);

end;

procedure TfCriterionsList.mm_RepCritUsingClick(Sender: TObject);
var
  q: TADOStoredProc;
begin
  q := createproc('prReportCriterionUsing');
  try
    q.Open;
    PrintToExcelFile(q, ['Отчет по применению критериев'], 'prReportCriterionUsing');
  finally
    q.Free;
  end;

end;

procedure TfCriterionsList.mSelClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfCriterionsList.N3Click(Sender: TObject);
begin
  EditCriterionsUnion;
end;

procedure TfCriterionsList.N4Click(Sender: TObject);
begin
  EditCriterionsManyToOne;
end;

procedure TfCriterionsList.QRefresh(nID: Integer);   // Обновить данные
begin
  inherited;
  if (nID = 0) and qCriterion.Active then nID := qCriterion.FieldByName('Cr_ID').AsInteger;
  qCriterion.Close;
  qCriterion.Open;
  if nID <> 0 then qCriterion.Locate('Cr_ID', nID, [loCaseInsensitive]);

end;

end.
