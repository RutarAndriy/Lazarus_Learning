unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs;

type

  { TfMain }

  TfMain = class(TForm)
    btnDate: TButton;
    btnCalc: TButton;
    btnSave: TButton;
    btnRead: TButton;
    btnClear: TButton;
    btnColor: TButton;
    btnFont: TButton;
    calcDlg: TCalculatorDialog;
    clndDlg: TCalendarDialog;
    clrDlg: TColorDialog;
    fntDlg: TFontDialog;
    memNotepad: TMemo;
    opnDlg: TOpenDialog;
    savDlg: TSaveDialog;
    procedure btnCalcClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
    procedure btnDateClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Збереження тексту в файл:
procedure TfMain.btnSaveClick(Sender: TObject);
begin
  if savDlg.Execute then memNotepad.Lines.SaveToFile(savDlg.FileName);
end;

// Зчитування тексту з файлу:
procedure TfMain.btnReadClick(Sender: TObject);
begin
  if opnDlg.Execute then memNotepad.Lines.LoadFromFile(opnDlg.FileName);
end;

// Очищення тексту:
procedure TfMain.btnClearClick(Sender: TObject);
begin
  memNotepad.Clear;
end;

// Додавання порахованого значення:
procedure TfMain.btnCalcClick(Sender: TObject);
begin
  if calcDlg.Execute then memNotepad.Lines.Add(FloatToStr(calcDlg.Value));
end;

// Задання кольору тексту:
procedure TfMain.btnColorClick(Sender: TObject);
begin
  if clrDlg.Execute then memNotepad.Font.Color:= clrDlg.Color;
end;

// Додавання дати до тексту:
procedure TfMain.btnDateClick(Sender: TObject);
begin
  if clndDlg.Execute then memNotepad.Lines.Add(DateToStr(clndDlg.Date));
end;

// Задання шрифту тексту:
procedure TfMain.btnFontClick(Sender: TObject);
var
  c: TColor;
begin
  if fntDlg.Execute then begin
    c:= memNotepad.Font.Color;
    memNotepad.Font:= fntDlg.Font;
    memNotepad.Font.Color:= c;
  end;
end;

end.

