program Functions;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this };

var
  F: Integer = 5;
  S: Integer = 17;
  Z: Integer;

procedure TestProc;
begin
  WriteLn('Test Procedure');
end;

procedure WriteProc (text: String);
begin
  WriteLn('Text: ' + text);
end;

function AddOne (a: Integer; b: Integer): Integer;
begin
  AddOne:= a + b;
end;

procedure AddTwo (a, b: Integer; var res: Integer);
begin
  res:= a + b;
end;

function AddThree (const a: Integer; const b: Integer): Integer;
begin
  Result:= a + b;
end;

begin

  TestProc;
  WriteProc('Andriy');

  Z:= 0;
  Z:= AddOne(F, S);
  WriteLn('AddOne: ', Z);

  Z:= 0;
  AddTwo(F, S, Z);
  WriteLn('AddTwo: ', Z);

  Z:= 0;
  Z:= AddThree(F, S);
  WriteLn('AddTwo: ', Z);

end.

