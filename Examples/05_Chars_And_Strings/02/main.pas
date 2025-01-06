unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  MaskEdit;

type

  { TfMain }

  TfMain = class(TForm)
    btnAddText: TButton;
    edtReadOnly: TEdit;
    ledt: TLabeledEdit;
    medt: TMaskEdit;
    procedure btnAddTextClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnAddTextClick(Sender: TObject);
begin
  // Додаємо текст до поля, яке доступне лише для читання:
  edtReadOnly.Text:= edtReadOnly.Text + 'Привіт! ';
end;

end.

