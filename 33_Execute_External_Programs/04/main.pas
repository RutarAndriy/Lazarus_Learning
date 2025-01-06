unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  LCLIntf, StdCtrls;

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
begin
  // Відкриваємо *.pdf за допомогою програми за замовчуванням:
  OpenDocument('..' + DirectorySeparator +
               '..' + DirectorySeparator +
               'Programming_on_Lazarus.pdf');
end;

end.

