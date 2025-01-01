unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  Numbers;

type

  { TfMain }

  TfMain = class(TForm)
    btnClose: TBitBtn;
    edtSignInt: TEdit;
    edtUnsignInt: TEdit;
    edtReal: TEdit;
    lblSignInt: TLabel;
    lblUnsignInt: TLabel;
    lblReal: TLabel;
    procedure edtSignIntKeyPress(Sender: TObject; var Key: char);
    procedure edtUnsignIntKeyPress(Sender: TObject; var Key: char);
    procedure edtRealKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.edtSignIntKeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в ціле число із знаком:
  key:= TrueIntKeys(key, edtSignInt.Text, True);
end;

procedure TfMain.edtUnsignIntKeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в ціле число без знаку:
  key:= TrueIntKeys(key, edtUnsignInt.Text, False);
end;

procedure TfMain.edtRealKeyPress(Sender: TObject; var Key: char);
begin
  // Перевірка правильності вводимого символу в дробове число:
  key:= TrueFloatKeys(key, edtReal.Text);
end;

end.

