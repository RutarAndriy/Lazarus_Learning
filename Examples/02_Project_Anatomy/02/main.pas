unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnOk: TButton;                        // кнопка "виконати"
    edtName: TEdit;                        // поле для введення імені
    lblName: TLabel;                       // пояснювальний напис
    procedure btnOkClick(Sender: TObject); // метод "реагування" на натискання
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnOkClick(Sender: TObject);
begin
  ShowMessage('Привіт, ' + edtName.Text + '!');
end;

end.

