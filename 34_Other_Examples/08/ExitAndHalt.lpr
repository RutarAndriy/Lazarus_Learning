program ExitAndHalt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this };

procedure TestExit;
begin
  WriteLn('Text_1');
  Exit;
  WriteLn('Text_2');
end;

procedure TestHalt;
begin
  WriteLn('Text_3');
  Halt;
  WriteLn('Test_4');
end;

begin

  TestExit;
  TestHalt;
  WriteLn('Test_5');

end.

