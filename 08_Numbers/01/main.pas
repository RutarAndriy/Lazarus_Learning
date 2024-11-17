unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, MaskEdit, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ME1: TMaskEdit;
    ME2: TMaskEdit;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Button1Click(Sender: TObject);
var
  s: String; // для формування звіту
  rist: Real; // для отримання росту
  vaga: Byte; // для отримання ваги
  imt: Real; // для розрахунку ІМТ
begin
  // Спочатку перетворити ріст із строки у дробове число:
  rist:= StrToFloat(ME1.Text);
  // Тепер вага:
  vaga:= StrToInt(ME2.Text);
  // Тепер розрахуємо ІМТ:
  imt:= vaga / (rist * rist);
  // В залежності від результату формуємо строку звіту:
  s:= 'Ваш ІМТ = ' + FormatFloat('#.##', imt) + #13;
  if imt < 19 then
    s:= s + 'У вас дефіцит ваги!'
  else if (imt >= 19) and (imt <= 25) then
    s:= s + 'У вас нормальна вага!'
  else if (imt >= 25) and (imt <= 30) then
    s:= s + 'У вас надлишкова вага!'
  else if (imt >= 30) and (imt <= 40) then
    s:= s + 'У вас ожиріння!'
  else if (imt >= 40) then
    s:= s + 'Жах! У вас сильне ожиріння!'
  else
    s:= s + 'Що-небуть пішло не так, результат не вдалося розрахувати!';
  // Виводимо результат на екран
  ShowMessage(s);
end;

end.

