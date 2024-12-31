unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    lblClock: TLabel;
    tmrUpdate: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure tmrUpdateTimer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.tmrUpdateTimer(Sender: TObject);
var
  i: Byte; // для отримання випадкового числа
begin
  // Спочатку змінюємо текст напису:
  lblClock.Caption:= TimeToStr(Now);
  // Отримуємо випадковий напрямок:
  i:= Random(4);
  // Тепер в залежності від напрямку рухаємо текст:
  case i of
    0: lblClock.Left:= lblClock.Left + 50; // вправо
    1: lblClock.Left:= lblClock.Left - 50; // вліво
    2: lblClock.Top:= lblClock.Top + 50;   // вверх
    3: lblClock.Top:= lblClock.Top - 50;   // вниз
  end;
  // Тепер перевіримо, чи не вийшов напис за межі форми?
  // Якщо вийшла - повертаємо її назад
  // Якщо вийшла вліво:
  if lblClock.Left < 0 then lblClock.Left:= 0;
    // Якщо вийшла вверх:
  if lblClock.Top < 0 then lblClock.Top:= 0;
    // Якщо вийшла вправо:
  if (lblClock.Left + lblClock.Width) > fMain.Width then
      lblClock.Left:= fMain.Width - lblClock.Width;
    // Якщо вийшла вниз:
  if (lblClock.Top + lblClock.Height) > fMain.Height then
      lblClock.Top:= fMain.Height - lblClock.Height;
end;

procedure TfMain.FormKeyPress(Sender: TObject; var Key: char);
begin
  // Якщо натиснули Esc - виходимо:
  if Key = #27 then Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  // Задаємо початковий текст для напису:
  lblClock.Caption:= TimeToStr(Now);
  // Задаємо початкове положення напису по центрі екрану:
  lblClock.Left:= Trunc(fMain.Width/2 - lblClock.Width/2);
  lblClock.Top:= Trunc(Height/2 - lblClock.Height/2);
end;

end.

