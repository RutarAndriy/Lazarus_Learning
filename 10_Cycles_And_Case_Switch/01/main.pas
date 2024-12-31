unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnForDo: TButton;
    btn100n: TButton;
    btnWhileDo: TButton;
    btnRepeatUntil: TButton;
    btnCase: TButton;
    procedure btnForDoClick(Sender: TObject);
    procedure btn100nClick(Sender: TObject);
    procedure btnWhileDoClick(Sender: TObject);
    procedure btnRepeatUntilClick(Sender: TObject);
    procedure btnCaseClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Натиснуто кнопку "for ... do"
procedure TfMain.btnForDoClick(Sender: TObject);
var
  b: Byte;
begin
  // Прохід циклу "вперед":
  for b:= 1 to 10 do ShowMessage('Прохід циклу №' + IntToStr(b));
  // Прохід циклу "назад":
  for b:= 10 downto 1 do ShowMessage('Прохід циклу №' + IntToStr(b));
end;

// Натиснуто кнопку "100/n"
procedure TfMain.btn100nClick(Sender: TObject);
var
  s: String = ''; // для збирання результатів ділення
  b: ShortInt;    // лічильник
  r: Real;        // результат ділення
begin
  for b:= -10 to 10 do begin // початок циклу
    // Якщо нуль, то не ділимо:
    if b = 0 then begin
      s:= s + 'Ділення на нуль заборонено' + #13;
      continue;
    end;
    // Ділимо:
    r:= 100 / b;
    // Тепер додаємо результат у строку s:
    s:= s + '100 / ' + IntToStr(b) + ' = ' +
                       FormatFloat('#.00', r) + #13;
  end; // кінець циклу
  // Тепер одразу виводимо усі отримані результати:
  ShowMessage(s);
end;

// Натиснуто кнопку "while ... do"
procedure TfMain.btnWhileDoClick(Sender: TObject);
var
  s: String; // для отримання числа від користувача
  r: Real;   // результат ділення
begin
  // Починаємо цикл:
  while true do begin
    // Очищуємо строку:
    s:= '';
    // Отримуємо число від користувача:
    InputQuery('100 / на ...', 'Введіть число', s);
    // Якщо нуль, виводимо повідомлення та виходимо із циклу:
    if s = '0' then begin
      ShowMessage('На нуль ділити не можна');
      break;
    end;
    // Якщо ще не вийшли, значить не нуль, ділимо:
    r:= 100 / StrToFloat(s);
    // Виводимо результат:
    ShowMessage('100 / ' + s + ' = ' + FloatToStr(r));
  end; // кінець циклу
end;

// Натиснуто кнопку "repeat ... until"
procedure TfMain.btnRepeatUntilClick(Sender: TObject);
var
  i: Byte;
  s: String = '';
begin
  // Задамо початкове значення лічильника:
  i:= 1;
  // Тепер сам цикл:
  repeat
    s:= s + 'Квадрат від ' + IntToStr(i) + ' дорівнює '
                           + IntToStr(i * i) + #13;
    i:= i + 1;
  until i > 10;
  // Звіт:
  ShowMessage(s);
end;

// Натиснуто кнопку "case"
procedure TfMain.btnCaseClick(Sender: TObject);
var
  i: Integer;
  s: String = '';
begin
  // Отримаємо число від користувача:
  InputQuery('Квадрат цілого числа', 'Введіть ціле число від 1 до 3', s);
  // Перетворемо строкове представлення числа у число:
  i:= StrToInt(s);
  // Тепер вибір case:
  case i of
    1: ShowMessage('Квадрат від 1 дорівнює 1');
    2: ShowMessage('Квадрат від 2 дорівнює 4');
    3: ShowMessage('Квадрат від 3 дорівнює 9');
    else ShowMessage('Вевідоме число, немає рішення');
  end;
end;

end.

