unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    SE1: TSpinEdit;
    StaticText1: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  atemp: array[1..2, -100..200] of Real; // Наш глобальний масив

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
var
  i: SmallInt; // Лічильник для циклу
begin
  for i:= -100 to 200 do begin
    atemp[1, i]:= i * 9/5 + 32; // Фаренгейти
    atemp[2, i]:= i + 273.15;   // Кельвіни
  end;
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  ShowMessage(SE1.Text + '° Цельсія буде дорівнювати: ' + #13 +
              FloatToStr(atemp[1, SE1.Value]) + '° Фаренгейта' + #13 +
              FloatToStr(atemp[2, SE1.Value]) + '° Кельвіна');
end;

end.

