unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnCopy: TButton;
    cbSities: TComboBox;
    edtSelected: TEdit;
    lbSities: TListBox;
    procedure btnCopyClick(Sender: TObject);
    procedure cbSitiesChange(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnCopyClick(Sender: TObject);
var
  i: Integer; // лічильник
begin
  // Очищуємо ComboBox:
  cbSities.Clear;
  // Далі в циклі обходимо весь ListBox, і якщо елемент
  // виділений - копіюємо його в ComboBox:
  for i:= 0 to lbSities.Count - 1 do
    if lbSities.Selected[i] then
      cbSities.Items.Add(lbSities.Items.Strings[i]);
  // Якщо ComboBox не пустий, виділимо перший елемент, інакше
  // не виділяємо нічого:
  if cbSities.Items.Count > 0 then begin
    cbSities.ItemIndex:= 0;
    // Копіюємо в edtSelected виділений рядок із ComboBox:
    edtSelected.Text:= cbSities.Items.Strings[cbSities.ItemIndex];
  end;
end;

procedure TfMain.cbSitiesChange(Sender: TObject);
begin
  // Копіюємо в edtSelected виділений рядок із ComboBox:
  edtSelected.Text:= cbSities.Items.Strings[cbSities.ItemIndex];
end;

end.

