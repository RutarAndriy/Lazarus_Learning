unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  MaskEdit;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    LabeledEdit1: TLabeledEdit;
    MaskEdit1: TMaskEdit;
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
begin
  Edit1.Text:= Edit1.Text + 'Привіт! ';
end;

end.

