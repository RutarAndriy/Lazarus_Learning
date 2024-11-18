unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  b: Byte;
begin
  // Прохід циклу "вперед":
  for b:= 1 to 10 do ShowMessage('Прохід циклу №' + IntToStr(b));
  // Прохід циклу "назад":
  for b:= 10 downto 1 do ShowMessage('Прохід циклу №' + IntToStr(b));
end;

procedure TfMain.Button2Click(Sender: TObject);
var
  s: String; // для збирання результатів ділення
  b: ShortInt; // лічильник
  r: Real; // результат ділення
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

procedure TfMain.Button3Click(Sender: TObject);
var
  s: String; // для отримання числа від користувача
  r: Real; // результат ділення
begin
  // Починаємо цикл
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

procedure TfMain.Button4Click(Sender: TObject);
var
  i: Byte;
  s: String;
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

procedure TfMain.Button5Click(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  // Очистимо строку:
  s:= '';
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

