unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Process;

type

  { TfMain }

  TfMain = class(TForm)
    btnRun: TButton;
    procedure btnRunClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnRunClick(Sender: TObject);
var
  Path: String;
begin
  // Отримання значення змінної PATH на різних ОС:
  {$IFDEF WINDOWS}
  Path:= GetEnvironmentVariable('PATH');
  ShowMessage(Path);
  {$ELSE}
  if RunCommand('/bin/bash', ['-c', 'echo $PATH'], Path) then
    ShowMessage(Path);
  {$ENDIF}

end;

end.

