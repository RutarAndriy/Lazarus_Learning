program Summa;

{$mode objfpc}{$H+}

uses
  LazUTF8;

var
  result, A, B: Integer;

begin
  WriteLn(UTF8ToConsole('Введіть два цілих числа'));
  ReadLn(A, B);
  result:= A + B;
  WriteLn(UTF8ToConsole('1-ше введене число = '), A);
  WriteLn(UTF8ToConsole('2-ге введене число = '), B);
  WriteLn(UTF8ToConsole('Сума двох чисел = '), result);
end.

