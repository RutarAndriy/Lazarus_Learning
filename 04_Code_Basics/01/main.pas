unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Button1Click(Sender: TObject);
const
  priv = 'Привіт, ';
var
  MyName: String;
begin
  MyName:= priv + Edit1.Text + '!';
  ShowMessage(MyName);
  MyName:= 'Раді вас бачити, ' + Edit1.Text + '!';
  ShowMessage(MyName);
end;

end.

