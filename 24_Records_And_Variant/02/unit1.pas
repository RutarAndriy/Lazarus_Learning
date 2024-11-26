unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  v1, v2, v3: Variant;
begin
  v1:= '5'; // присвоїли символ
  v2:= '10'; // тепер строку
  v3:= 20; // ціле число
  v1:= v1 + v2 + v3; // тепер усе додали
  ShowMessage(IntToStr(v1));
end;

end.

