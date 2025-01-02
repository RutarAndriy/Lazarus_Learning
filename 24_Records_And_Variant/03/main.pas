unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnAdd: TButton;
    sgMain: TStringGrid;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgMainGetEditMask(Sender: TObject; ACol, ARow: Integer;
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
  sgMain.Cells[0, 1]:= 'Кошовий К.І.';
  sgMain.Cells[0, 2]:= 'Богданович М.О.';
  sgMain.Cells[0, 3]:= 'Шацький Й.Ш.';
  sgMain.Cells[0, 4]:= 'Тима Є.Б.';
  // Заповнюємо заголовки стовбців:
  sgMain.Cells[1, 0]:= 'Рік народження';
  sgMain.Cells[2, 0]:= 'Місце народження';
  sgMain.Cells[3, 0]:= 'Прописка';
  sgMain.Cells[4, 0]:= 'Сімейний стан';
  // Змінюємо ширину стовбців:
  sgMain.ColWidths[0]:= 120;
  sgMain.ColWidths[1]:= 120;
  sgMain.ColWidths[2]:= 140;
  sgMain.ColWidths[3]:= 100;
  sgMain.ColWidths[4]:= 120;
end;

procedure TfMain.btnAddClick(Sender: TObject);
var
  s: String;
begin
  if InputQuery('Вкажіть нове ім''я',
     'Впишіть прізвище, ім''я та по-батькові у форматі "Прізвище І.П."',
     s) then begin
    sgMain.RowCount:= sgMain.RowCount + 1;
    sgMain.Cells[0, sgMain.RowCount - 1]:= s;
  end;
end;

procedure TfMain.sgMainGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  if ACol=1 then Value:= '99.99.9999 р.';
end;

end.

