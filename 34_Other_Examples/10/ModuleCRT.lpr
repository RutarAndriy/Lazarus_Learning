program ModuleCRT;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, CRT
  { you can add units after this };

begin
  TextBackground(Blue);
  ClrScr;
  GotoXY(4, 2);
  TextColor(Yellow);
  WriteLn('Hello, Andriy');
  GotoXY(4, 3);
  WriteLn('Press any key');
  WriteLn();
  ReadKey;
end.

