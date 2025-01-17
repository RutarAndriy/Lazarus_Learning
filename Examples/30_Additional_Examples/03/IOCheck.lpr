program IOCheck;

{$mode objfpc}{$H+}

uses LazUTF8;

var
  A, B: Integer;
  error: Boolean; // зміння для контролю помилок

begin

  {$I-} // вимкнення стандартного режиму контролю вводу

  // Введення першого числа:
  WriteLn(UTF8ToConsole('Введіть перше число'));
  // Перевірка на помилковий ввід першого числа:
  error:= False;
  repeat
    ReadLn(A);
    error:= (IOResult <> 0);
    if error then WriteLn(UTF8ToConsole('Помилка! Введіть ціле число'));
  until not error;

  // Введення другого числа:
  WriteLn(UTF8ToConsole('Введіть друге число'));
  // Перевірка на помилковий ввід другого числа:
  error:= False;
  repeat
    ReadLn(B);
    error:= (IOResult <> 0);
    if error then
    begin
      WriteLn(UTF8ToConsole('Помилка! Введіть ціле число'));
      continue; // пропускаємо перевірку на нуль:
    end;
    if B = 0 then
    begin
      WriteLn(UTF8ToConsole('Друге число не може дорівнювати нулю'));
      WriteLn(UTF8ToConsole('Введіть інше число, яке не дорівнює нулю'));
    end;
  until (B <> 0) and (not error);

  {$I+} // відновлення стандартного режиму контролю вводу/виводу

  // Виведення результатів:
  WriteLn(UTF8ToConsole('A + B = '), A + B);
  WriteLn(UTF8ToConsole('A - B = '), A - B);
  WriteLn(UTF8ToConsole('A * B = '), A * B);
  WriteLn(UTF8ToConsole('A / B = '), A div B);
end.

