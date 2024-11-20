unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Button1Click(Sender: TObject);
var
  i: Integer; // лічильник
begin
  // Очищуємо ComboBox:
  ComboBox1.Clear;
  // Далі в циклі обходимо весь ListBox, і якщо елемент
  // виділений - копіюємо його в ComboBox:
  for i:= 0 to ListBox1.Count - 1 do
    if ListBox1.Selected[i] then
      ComboBox1.Items.Add(ListBox1.Items.Strings[i]);
  // Якщо ComboBox не пустий, виділимо перший елемент, інакше
  // не виділяємо нічого:
  if ComboBox1.Items.Count > 0 then begin
    ComboBox1.ItemIndex:= 0;
    // копіюємо в Edit1 виділений рядок із ComboBox:
    Edit1.Text:= ComboBox1.Items.Strings[ComboBox1.ItemIndex];
  end;
end;

procedure TfMain.ComboBox1Change(Sender: TObject);
begin
  // Копіюємо в Edit1 виділений рядок із ComboBox:
  Edit1.Text:= ComboBox1.Items.Strings[ComboBox1.ItemIndex];
end;

end.

