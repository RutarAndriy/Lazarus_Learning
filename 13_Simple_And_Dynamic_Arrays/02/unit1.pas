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
  s: String; // для запиту
  da: array of String; // динамічний масив рядків
  i: Integer; // лічильник
begin
  // Дізнаємося у користувача скільки робити рядків:
  s:= '0';
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
  ShowMessage(s);
end;

end.

