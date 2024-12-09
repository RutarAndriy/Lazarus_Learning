unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  Path: String;
begin
  // Отримання значення змінної PATH на різних ОС:
  {$ifdef windows}
  Path:= GetEnvironmentVariable('PATH');
  ShowMessage(Path);
  {$else}
  if RunCommand('/bin/bash', ['-c', 'echo $PATH'], Path) then
    ShowMessage(Path);
  {$endif}

end;

end.

