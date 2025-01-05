program IntVsReal;

{$mode objfpc}{$H+}

uses LazUTF8;

var
  A1, B1, C1: Integer;
  A2, B2, C2: Real;

begin
  WriteLn(UTF8ToConsole('Введіть 2 цілих числа:'));
  ReadLn(A1, B1);
  WriteLn('A = ', A1, ' B = ', B1);
  C1:= A1 + B1;
  WriteLn(UTF8ToConsole('Додавання A+B, C = '), C1);
  C1:= A1 - B1;
  WriteLn(UTF8ToConsole('Віднімання A-B, C = '), C1);
  C1:= A1 * B1;
  WriteLn(UTF8ToConsole('Множення A*B, C = '), C1);
  C1:= A1 div B1;
  WriteLn(UTF8ToConsole('Ділення націло A/B, C = '), C1);
  C1:= A1 mod B1;
  WriteLn(UTF8ToConsole('Залишок від вілення A/B, C = '), C1);
  C1:= Abs(A1);
  WriteLn(UTF8ToConsole('Абсолютна величина A, C = '), C1);
  C1:= Sqr(B1);
  WriteLn(UTF8ToConsole('Квадрат числа B, C = '), C1);
  C1:= Sqr(B1 * B1);
  WriteLn(UTF8ToConsole('Квадрат числа B*B, C = '), C1);

  WriteLn('---------------');

  WriteLn(UTF8ToConsole('Введіть 2 дробових числа:'));
  ReadLn(A2, B2);
  WriteLn('A = ', A2:0:2, ' B = ', B2:0:2);
  C2:= A2 + B2;
  WriteLn(UTF8ToConsole('Додавання A+B, C = '), C2:0:2);
  C2:= A2 - B2;
  WriteLn(UTF8ToConsole('Віднімання A-B, C = '), C2:0:2);
  C2:= A2 * B2;
  WriteLn(UTF8ToConsole('Множення A*B, C = '), C2:0:2);
  C2:= A2 / B2;
  WriteLn(UTF8ToConsole('Ділення A/B, C = '), C2:0:2);
  C1:= Trunc(A2);
  WriteLn(UTF8ToConsole('Ціла частина від A, C = '), C1);
  C1:= Round(A2);
  WriteLn(UTF8ToConsole('Заокруглення A, C = '), C1);
end.

