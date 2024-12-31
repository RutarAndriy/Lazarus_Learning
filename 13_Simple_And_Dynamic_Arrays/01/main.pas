unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin;

type

  { TfMain }

  TfMain = class(TForm)
    btnCalc: TButton;
    seTemp: TSpinEdit;
    stLabel: TStaticText;
    procedure btnCalcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  atemp: array[1..2, -100..200] of Real; // глобальний двовимірний масив

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
var
  i: SmallInt; // лічильник для циклу
begin
  for i:= -100 to 200 do begin
    atemp[1, i]:= i * 9/5 + 32; // Фаренгейти
    atemp[2, i]:= i + 273.15;   // Кельвіни
  end;
end;

procedure TfMain.btnCalcClick(Sender: TObject);
begin
  ShowMessage(seTemp.Text + '° Цельсія буде дорівнювати: ' + #13 +
              FloatToStr(atemp[1, seTemp.Value]) + '° Фаренгейта' + #13 +
              FloatToStr(atemp[2, seTemp.Value]) + '° Кельвіна');
end;

end.

