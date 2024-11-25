program Application;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, sysutils
  { you can add units after this };

var
  a, b: Integer;
begin
  // Якщо параметрів взагалі немає:
  if ParamCount = 0 then begin
    Write('Введіть перше ціле число: ');
    ReadLn(a);
    Write('Введіть друге ціле число: ');
    ReadLn(b);
  end
  // Якщо тільки один параметр:
  else if ParamCount = 1 then begin
    a:= StrToInt(ParamStr(1));
    Write('Введіть ціле число: ');
    ReadLn(b);
  end
  // Якщо параметрів більше одного:
  else begin
    a:= StrToInt(ParamStr(1));
    b:= StrToInt(ParamStr(2));
  end;
  // Тепер виведення результатів:
  WriteLn('Всього параметрів: ' + IntToStr(ParamCount));
  WriteLn('Запущена програма: ' + ParamStr(0));
  WriteLn('Змінна a = ', a, '; змінна b = ', b);
  ReadLn;
end.

