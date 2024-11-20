unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Numbers;

type

  { TfMain }

  TfMain = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в ціле число із знаком:
  key:= TrueIntKeys(key, Edit1.Text, True);
end;

procedure TfMain.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в ціле число без знаку:
  key:= TrueIntKeys(key, Edit2.Text, False);
end;

procedure TfMain.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в дробове число:
  key:= TrueFloatKeys(key, Edit3.Text);
end;

end.

