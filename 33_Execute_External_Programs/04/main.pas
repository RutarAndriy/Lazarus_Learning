unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  LCLIntf, StdCtrls;

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
begin
  // Відкриваємо *.pdf за допомогою програми за замовчуванням:
  OpenDocument('..' + DirectorySeparator +
               '..' + DirectorySeparator +
               'Programming_on_Lazarus.pdf');
end;

end.

