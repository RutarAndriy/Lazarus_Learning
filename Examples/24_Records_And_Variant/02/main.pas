unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnTest: TButton;
    procedure btnTestClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnTestClick(Sender: TObject);
var
  v1, v2, v3: Variant;
begin
  v1:= '5';                  // присвоїли символ
  v2:= '10';                 // присвоїли строку
  v3:= 20;                   // присвоїди ціле число
  v1:= v1 + v2 + v3;         // тепер все додаємо
  ShowMessage(IntToStr(v1)); // виводимо результат
end;

end.

