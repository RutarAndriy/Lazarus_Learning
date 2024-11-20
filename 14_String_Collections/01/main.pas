unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    bSave: TButton;
    bRead: TButton;
    bClear: TButton;
    Memo1: TMemo;
    procedure bClearClick(Sender: TObject);
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
  Memo1.Lines.SaveToFile('MyText.txt');
end;

procedure TfMain.bReadClick(Sender: TObject);
begin
  if FileExists('MyText.txt') then
    Memo1.Lines.LoadFromFile('MyText.txt')
  else ShowMessage('Файлу MyText.txt не існує');
end;

procedure TfMain.bClearClick(Sender: TObject);
begin
  Memo1.Clear;
end;

end.

