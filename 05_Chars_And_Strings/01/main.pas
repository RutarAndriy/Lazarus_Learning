unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType;

type

  { TfMain }

  TfMain = class(TForm)
    btnChar: TButton;
    btnString: TButton;
    procedure btnCharClick(Sender: TObject);
    procedure btnStringClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnCharClick(Sender: TObject);
var
  ch1: Char; // Змінна символьного типу
  ch2: TUTF8Char;
begin
  ch1:= #90; // Літера Z
  ch2:= 'Я';
  ShowMessage(ch1 + #13 + ch2);
end;

procedure TfMain.btnStringClick(Sender: TObject);
var
  s1: String; // Він же AnsiString, якщо використовується {$H+}
  s2: ShortString; // ShortString = String[255]
  s3: PChar; // Вказівник на строку в кінці якої є символом закінчення строки
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

