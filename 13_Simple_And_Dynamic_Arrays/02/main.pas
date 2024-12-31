unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnStart: TButton;
    procedure btnStartClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnStartClick(Sender: TObject);
var
  s: String = '0';           // для отримання числа із запиту
  da: array of String = nil; // динамічний масив рядків
  i: Integer;                // лічильник
begin
  // Дізнаємося у користувача скільки робити рядків:
  InputQuery('Привіт', 'Скільки рядків ви хочете створити?', s);
  // Якщо нуль, то нічого не робимо, виходимо з програми:
  if StrToInt(s) = 0 then Exit;
  // Інакше задаємо вказаний розмір масиву:
  SetLength(da, StrToInt(s));
  // Тепер обійдемо увесь масив, задаючи його елементам значення:
  for i:= Low(da) to High(da) do
    da[i]:= 'Строка №' + IntToStr(i + 1);
  // Тепер знову обійдемо масив і створимо повідомлення із його рядків:
  s:= '';
  for i:= Low(da) to High(da) do
    s:= s + da[i] + #13;
  // Відобразимо отриманий результат:
  ShowMessage(s);
end;

end.

