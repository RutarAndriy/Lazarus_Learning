program StaticVar;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes;

procedure IncStaticVariable;
const
  x: Integer = 2;
begin
  WriteLn('X перед додаванням = ', x);
  x:= x + 17;
  WriteLn('X після додавання = ', x);
end;

begin

  WriteLn('Змінюємо X перший раз:');
  IncStaticVariable;

  WriteLn('CЗмінюємо X другий раз:');
  IncStaticVariable;

end.

