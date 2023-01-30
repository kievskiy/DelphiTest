unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  NewThread = class(TThread)
  private
    X1, Y1, X2, Y2, Color: Integer;
    { Private declarations }
  protected
    procedure Execute; override;
    procedure Paint;
  end;

var
  Form1: TForm1;
  cl: NewThread;

implementation

{$R *.dfm}


procedure NewThread.Execute;
begin
  Randomize;
  repeat
    X2 := Random(Form1.Width);
    Y2 := Random(Form1.Height);
    Color := Random($FFFFFF);
    Synchronize(Paint);
    X1 := X2;
    Y1 := Y2;
  until Terminated;

end;

procedure NewThread.Paint;
begin
  with Form1.Canvas do
  begin
    Pen.Color := Color;
    MoveTo(X1, Y1);
    LineTo(X2, Y2);
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  cl := NewThread.Create(False);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  cl.Free;
end;

end.
