program Labels;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this };

label
  L1, L2, L3, L4;

begin

  WriteLn('Start of program');
  WriteLn(' ------- ');
  goto L3;
  L1:WriteLn('First text');
  goto L4;
  L2:WriteLn('Second text');
  goto L1;
  L3:WriteLn('Third text');
  goto L2;
  L4:WriteLn(' ------- ');
  WriteLn('End of program');

end.

