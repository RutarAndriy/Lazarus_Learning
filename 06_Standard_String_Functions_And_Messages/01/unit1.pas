unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LazUTF8, LCLType;

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
  s1: String;
  s2: String;
  YourName: String;
begin
  // Об'єднання строк
  s1:= Concat('Строка №1', #13, 'Строка №2', #13, 'Строка №3');
  ShowMessage(s1);

  s2:= 'Hello';
  ShowMessage(IntToStr(Length(s2))); // 5
  s2:= 'Привіт';
  ShowMessage(IntToStr(Length(s2))); // 12

  // Наступний код вимагає модуль LazUTF8
  ShowMessage(IntToStr(UTF8Length(s2))); // 6

  // Пошук підстроки у строці
  ShowMessage(IntToStr(UTF8Pos('ив', s2))); // 3

  // Отримання підстроки
  ShowMessage(UTF8Copy(s2, 3, 2)); // ив

  // Видалення частини строки
  UTF8Delete(s2, 3, 2); // Пріт
  ShowMessage(s2);

  s2:= 'Привіт';

  // Переведення строки у верхній та нижній регістр
  ShowMessage(UTF8UpperCase(s2)); // ПРИВІТ
  ShowMessage(UTF8LowerCase(s2)); // привіт

  // Ще один варіант виведення тексту
  if Application.MessageBox('Повідомлення', 'Заголовок', MB_ICONINFORMATION +
     MB_YESNOCANCEL) = IDYES then ShowMessage('Ви натиснули кнопку Так');

  // І ще один варіант виведення повідомлення
  if MessageDlg('Підтвердження', 'Ви дійсно хочете закрити програму?',
     mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then Close;

  // Вікно для введення даних
  YourName:= 'Невідомий';
  if InputQuery('Хто ви?', 'Вкажіть ваше ім''я', YourName) then
     ShowMessage('Привіт, ' + YourName + '!');
end;

end.

