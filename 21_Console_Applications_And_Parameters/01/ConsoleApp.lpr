program ConsoleApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, LazUTF8;

var
  a, b: Integer;
begin
  // Якщо параметрів взагалі немає:
  if ParamCount = 0 then begin
    Write(UTF8ToConsole('Введіть перше ціле число: '));
    ReadLn(a);
    Write(UTF8ToConsole('Введіть друге ціле число: '));
    ReadLn(b);
  end
  // Якщо тільки один параметр:
  else if ParamCount = 1 then begin
    a:= StrToInt(ParamStr(1));
    Write(UTF8ToConsole('Введіть ціле число: '));
    ReadLn(b);
  end
  // Якщо параметрів більше одного:
  else begin
    a:= StrToInt(ParamStr(1));
    b:= StrToInt(ParamStr(2));
  end;
  // Тепер виведення результатів:
  WriteLn(UTF8ToConsole('Всього параметрів: ') + IntToStr(ParamCount));
  WriteLn(UTF8ToConsole('Запущена програма: ') + ParamStr(0));
  WriteLn(UTF8ToConsole('Змінна a = '), a, UTF8ToConsole('; змінна b = '), b);
  ReadLn;
end.

