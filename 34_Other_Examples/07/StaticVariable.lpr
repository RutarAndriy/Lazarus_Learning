program StaticVariable;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this };

procedure IncStaticVariable;
const
  x: Integer = 2;
begin
  WriteLn('X before added = ', x);
  x:= x + 17;
  WriteLn('X after added = ', x);
end;

begin

  WriteLn('Change X first time:');
  IncStaticVariable;

  WriteLn('Change X second time:');
  IncStaticVariable;

end.

