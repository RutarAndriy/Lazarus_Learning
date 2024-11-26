unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Заповнюємо заголовки рядків:
  StringGrid1.Cells[0, 1]:= 'Кошовий К.І.';
  StringGrid1.Cells[0, 2]:= 'Богданович М.О.';
  StringGrid1.Cells[0, 3]:= 'Шацький Й.Ш.';
  StringGrid1.Cells[0, 4]:= 'Тима Є.Б.';
  // Заповнюємо заголовки стовбців:
  StringGrid1.Cells[1, 0]:= 'Рік народження';
  StringGrid1.Cells[2, 0]:= 'Місце народження';
  StringGrid1.Cells[3, 0]:= 'Прописка';
  StringGrid1.Cells[4, 0]:= 'Сімейний стан';
  // Змінюємо ширину стовбців:
  StringGrid1.ColWidths[0]:= 120;
  StringGrid1.ColWidths[1]:= 120;
  StringGrid1.ColWidths[2]:= 140;
  StringGrid1.ColWidths[3]:= 100;
  StringGrid1.ColWidths[4]:= 120;
end;

procedure TfMain.Button1Click(Sender: TObject);
var
  s: String;
begin
  if InputQuery('Вкажіть нове ім''я',
     'Впишіть прізвище, ім''я та по-батькові у форматі "Прізвище І.П."',
     s) then begin
    StringGrid1.RowCount:= StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, StringGrid1.RowCount - 1]:= s;
  end;
end;

procedure TfMain.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  if ACol=1 then Value:= '99.99.9999 р.';
end;

end.

