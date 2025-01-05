program ClassExample;

{$mode delphi}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, Main;

procedure Test;
var
  Rect: TRect;
begin
  // Створення екземпляру класу TRect:
  Rect := TRect.Create;
  try
    // Задання ширини і висоти:
    Rect.Width := 20;
    Rect.Height := 5;
    // Виведення ширини, висоти та площі:
    Writeln('Width = ', Rect.Width);
    Writeln('Height = ', Rect.Height);
    Writeln('Area = ', Rect.CalcArea);
  finally
    // Знищення екземпляру класу (звільнення пам'яті):
    Rect.Free;
  end;
  // Очікуємо вводу перед завершенням програми:
  Readln;
end;

begin
  try
    Test;
  except
    on E: Exception do
      Writeln('*** ', E.ToString, ' ***');
  end;
end.

