unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    lClock: TLabel;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Timer1Timer(Sender: TObject);
var
  i: Byte; // для отримання випадкового числа
begin
  // Спочатку змінюємо текст напису:
  lClock.Caption:= TimeToStr(Now);
  // Отримуємо випадковий напрямок:
  i:= Random(4);
  // Тепер в залежності від напрямку рухаємо текст:
  case i of
    0: lClock.Left:= lClock.Left + 50; // вправо
    1: lClock.Left:= lClock.Left - 50; // вліво
    2: lClock.Top:= lClock.Top + 50; // вверх
    3: lClock.Top:= lClock.Top - 50; // вниз
  end;
  // Тепер перевіримо, чи не вийшов напис за межі форми?
  // Якщо вийшла - повертаємо її назад
  // Якщо вийшла вліво:
  if lClock.Left < 0 then lClock.Left:= 0;
    // Якщо вийшла вверх:
  if lClock.Top < 0 then lClock.Top:= 0;
    // Якщо вийшла вправо:
  if (lClock.Left + lClock.Width) > fMain.Width then
      lClock.Left:= fMain.Width - lClock.Width;
    // Якщо вийшла вниз:
  if (lClock.Top + lClock.Height) > fMain.Height then
      lClock.Top:= fMain.Height - lClock.Height;
end;

procedure TfMain.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  // Задаємо початковий текст для напису:
  lClock.Caption:= TimeToStr(Now);
  // Задаємо початкове положення напису по центрі екрану:
  lClock.Left:= Trunc(fMain.Width/2 - lClock.Width/2);
  lClock.Top:= Trunc(Height/2 - lClock.Height/2);
end;

end.

