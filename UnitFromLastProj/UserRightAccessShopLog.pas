unit UserRightAccessShopLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomForm, DataModule, uCustomConfig, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxContainer,
  ONumUtils, Data.Win.ADODB, cxSplitter, TRexSyntaxMemo, Vcl.ExtCtrls, cxTextEdit, cxMemo, cxDBEdit,
  cxLabel, cxDBLabel, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxImageComboBox,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList;

type
  TfUserRightAccessShopLog = class(TDataListForm)
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
    cxSplitter1: TcxSplitter;
    dsUserRightAccessShopLog: TDataSource;
    qryUserRightAccessShopLog: TADOQuery;
    qryUserRightAccessList: TADOQuery;
    dsUserRightAccessList: TDataSource;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumnURA_Code: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBColumnIsDel: TcxGridDBColumn;
    PageControl1: TPageControl;
    TSSMBig: TTabSheet;
    TSSMSmall: TTabSheet;
    TSSA: TTabSheet;
    Panel2: TPanel;
    Splitter2: TSplitter;
    fsSyntaxMemo6: TSyntaxMemo;
    fsSyntaxMemo5: TSyntaxMemo;
    Panel9: TPanel;
    Splitter3: TSplitter;
    fsSyntaxMemo2: TSyntaxMemo;
    fsSyntaxMemo1: TSyntaxMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    fsSyntaxMemo4: TSyntaxMemo;
    fsSyntaxMemo3: TSyntaxMemo;
    ImageList1: TImageList;
    procedure FormShow(Sender: TObject);
    procedure dsUserRightAccessShopLogDataChange(Sender: TObject; Field: TField);
    procedure dsUserRightAccessListDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ViewUserRightAccessShopLog();

implementation

{$R *.dfm}

procedure ViewUserRightAccessShopLog();
var
  fUserRightAccessShopLog: TfUserRightAccessShopLog;
Begin
  fUserRightAccessShopLog := TfUserRightAccessShopLog.Create(Screen.ActiveForm);
  try
    fUserRightAccessShopLog.Show;
  Except
    fUserRightAccessShopLog.Free;
  end;
End;

procedure TfUserRightAccessShopLog.dsUserRightAccessListDataChange(Sender: TObject; Field: TField);
begin
  if qryUserRightAccessList.RecordCount <> 0 then
  begin
    qryUserRightAccessShopLog.Connection := qryUserRightAccessList.Connection;
    qryUserRightAccessShopLog.Close;
    qryUserRightAccessShopLog.Parameters.ParamByName('Code').Value :=
      qryUserRightAccessList.FieldByName('URA_Code').AsString;
    qryUserRightAccessShopLog.Open;
  end;
end;

procedure TfUserRightAccessShopLog.dsUserRightAccessShopLogDataChange(Sender: TObject;
  Field: TField);
var
  ChangeBig, ChangeSmall, ChangeSA: boolean;
begin
  ChangeBig := not(qryUserRightAccessShopLog.FieldByName('URASL_ScriptSMBig_Old')
    .AsString = qryUserRightAccessShopLog.FieldByName('URASL_ScriptSMBig_New').AsString);
  ChangeSmall := not(qryUserRightAccessShopLog.FieldByName('URASL_ScriptSMSmall_Old')
    .AsString = qryUserRightAccessShopLog.FieldByName('URASL_ScriptSMSmall_New').AsString);
  ChangeSA := not(qryUserRightAccessShopLog.FieldByName('URASL_ScriptSA_Old')
    .AsString = qryUserRightAccessShopLog.FieldByName('URASL_ScriptSA_New').AsString);

  TSSMBig.Caption := IfVar(ChangeBig, 'Супер большой(+)', 'Супер большой');
  TSSMSmall.Caption := IfVar(ChangeSmall, 'Супер малый(+)', 'Супер малый');
  TSSA.Caption := IfVar(ChangeSA, 'Магазин(+)', 'Магазин');

  fsSyntaxMemo1.Lines.Text := qryUserRightAccessShopLog.FieldByName
    ('URASL_ScriptSMBig_Old').AsString;
  fsSyntaxMemo2.Lines.Text := qryUserRightAccessShopLog.FieldByName
    ('URASL_ScriptSMBig_New').AsString;

  fsSyntaxMemo3.Lines.Text := qryUserRightAccessShopLog.FieldByName
    ('URASL_ScriptSMSmall_Old').AsString;
  fsSyntaxMemo4.Lines.Text := qryUserRightAccessShopLog.FieldByName
    ('URASL_ScriptSMSmall_New').AsString;

  fsSyntaxMemo5.Lines.Text := qryUserRightAccessShopLog.FieldByName('URASL_ScriptSA_Old').AsString;
  fsSyntaxMemo6.Lines.Text := qryUserRightAccessShopLog.FieldByName('URASL_ScriptSA_New').AsString;
end;

procedure TfUserRightAccessShopLog.FormShow(Sender: TObject);
begin
  Color := clBtnFace;
  if Config.IsBranch then
  begin
    qryUserRightAccessList.Connection := DataModule1.Branch;
  end
  else
  begin
    qryUserRightAccessList.Connection := DataModule1.Connection;
  end;

  qryUserRightAccessList.Open;

  if qryUserRightAccessList.RecordCount <> 0 then
    // begin
    //
    // qryUserRightAccessShopLog.Parameters.ParamByName('Code').Value := qryUserRightAccessList.FieldByName('URA_Code').AsString;
    // qryUserRightAccessShopLog.Open;
    // end;

    // Размер шрифта по-умолчанию
    fsSyntaxMemo1.Font.Size := 13;
  fsSyntaxMemo2.Font.Size := 13;

  fsSyntaxMemo3.Font.Size := 13;
  fsSyntaxMemo4.Font.Size := 13;

  fsSyntaxMemo5.Font.Size := 13;
  fsSyntaxMemo6.Font.Size := 13;
end;

end.
