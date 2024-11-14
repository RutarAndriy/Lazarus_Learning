unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  ch1: Char; // Змінна символьного типу
  ch2: TUTF8Char;
begin
  ch1:= #90; // Літера Z
  ch2:= 'Я';
  ShowMessage(ch1 + #13 + ch2);
end;

procedure TfMain.Button2Click(Sender: TObject);
var
  s1: String; // Він же AnsiString
  s2: ShortString;
  s3: PChar;
begin
  s1:= 'Це строка із п''яти слів!';

  // Тепер присвоїмо цей же текст в ShortString
  s2:= s1;

  // Цей же текст в PChar. Для перетворення строки у цей тип
  // використовуємо функцію PChar():
  s3:= PChar(s1);

  // Зберемо повідомлення із трьох різнотипних строк. Кожний тип
  // виведемо в окремому рядку:
  ShowMessage(s1 + #13 + s2 + #13 + s3);
end;

end.

