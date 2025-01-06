unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnSave: TButton;
    btnRead: TButton;
    btnClear: TButton;
    memNotepad: TMemo;
    procedure btnClearClick(Sender: TObject);
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

// Зберігаємо текст у файл MyText.txt:
procedure TfMain.btnSaveClick(Sender: TObject);
begin
  memNotepad.Lines.SaveToFile('MyText.txt');
end;

// Зчитуємо текст із файлу MyText.txt:
procedure TfMain.btnReadClick(Sender: TObject);
begin
  if FileExists('MyText.txt') then
    memNotepad.Lines.LoadFromFile('MyText.txt')
  else ShowMessage('Файлу MyText.txt не існує');
end;

// Очищуємо введений текст:
procedure TfMain.btnClearClick(Sender: TObject);
begin
  memNotepad.Clear;
end;

end.

