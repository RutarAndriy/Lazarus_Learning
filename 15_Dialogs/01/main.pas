unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs;

type

  { TfMain }

  TfMain = class(TForm)
    bDate: TButton;
    bCalc: TButton;
    bSave: TButton;
    bRead: TButton;
    bClear: TButton;
    bColor: TButton;
    bFont: TButton;
    CalcD: TCalculatorDialog;
    DD: TCalendarDialog;
    CD: TColorDialog;
    FD: TFontDialog;
    Memo1: TMemo;
    OD: TOpenDialog;
    SD: TSaveDialog;
    procedure bCalcClick(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure bColorClick(Sender: TObject);
    procedure bDateClick(Sender: TObject);
    procedure bFontClick(Sender: TObject);
    procedure bReadClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bSaveClick(Sender: TObject);
begin
  if SD.Execute then Memo1.Lines.SaveToFile(SD.FileName);
end;

procedure TfMain.bReadClick(Sender: TObject);
begin
  if OD.Execute then Memo1.Lines.LoadFromFile(OD.FileName);
end;

procedure TfMain.bClearClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TfMain.bCalcClick(Sender: TObject);
begin
  if CalcD.Execute then Memo1.Lines.Add(FloatToStr(CalcD.Value));
end;

procedure TfMain.bColorClick(Sender: TObject);
begin
  if CD.Execute then Memo1.Font.Color:= CD.Color;
end;

procedure TfMain.bDateClick(Sender: TObject);
begin
  if DD.Execute then Memo1.Lines.Add(DateToStr(DD.Date));
end;

procedure TfMain.bFontClick(Sender: TObject);
var
  c: TColor;
begin
  if FD.Execute then begin
    c:= Memo1.Font.Color;
    Memo1.Font:= FD.Font;
    Memo1.Font.Color:= c;
  end;
end;

end.

