unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    cbType: TComboBox;
    edtPhone: TEdit;
    edtName: TEdit;
    lblName: TLabel;
    lblPhone: TLabel;
    lblType: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  edtName.SetFocus;
end;

end.

