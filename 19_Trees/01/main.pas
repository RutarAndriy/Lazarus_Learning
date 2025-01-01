unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnNewNode: TButton;
    btnNewChildNode: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    btnSort: TButton;
    btnCollapse: TButton;
    btnExpand: TButton;
    imgList: TImageList;
    pnlButtons: TPanel;
    trvMain: TTreeView;
    procedure btnCollapseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnNewChildNodeClick(Sender: TObject);
    procedure btnNewNodeClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnNewNodeClick(Sender: TObject);
var
  NodeCaption: String; // для отримання заголовку нового вузла
  NewNode: TTreeNode;  // для створення нового вузла
begin
  // Спочатку очистимо заголовок:
  NodeCaption:= '';
  // Тепер, якщо користувач не ввів заголовок нового вузла, виходимо:
  if not InputQuery('Ввід заголовку', 'Введіть заголовок розділу',
                    NodeCaption) then Exit;
  // Якщо ми тут, то заголовок є. Створюємо батьківський вузол:
  NewNode:= trvMain.Items.Add(nil, NodeCaption);
  // Присвоюємо йому картинку під індексом 0:
  NewNode.ImageIndex:= 0;
end;

procedure TfMain.btnSortClick(Sender: TObject);
begin
  trvMain.AlphaSort;
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  trvMain.SaveToFile('MyLibrary.dat');
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // Якщо файл існує, то завантажимо його:
  if FileExists('MyLibrary.dat') then
    trvMain.LoadFromFile('MyLibrary.dat');
  // Тепер пройдемося по списку і кожному вузлу присвоїмо
  // потрібну піктограму:
  for i:= 0 to trvMain.Items.Count - 1 do
    if trvMain.Items[i].Parent = nil then trvMain.Items[i].ImageIndex:= 0
    else trvMain.Items[i].ImageIndex:= 1;
end;

procedure TfMain.btnNewChildNodeClick(Sender: TObject);
var
  NodeCaption: String;
  NewNode: TTreeNode;
begin
  NodeCaption:= '';
  if not InputQuery('Ввід заголовку', 'Введіть заголовок підрозділу',
                    NodeCaption) then Exit;
  NewNode:= trvMain.Items.AddChild(trvMain.Selected, NodeCaption);
  if NewNode.Parent = nil then NewNode.ImageIndex:= 0
  else NewNode.ImageIndex:= 1;
end;

procedure TfMain.btnDeleteClick(Sender: TObject);
begin
  if trvMain.Selected <> nil then
    trvMain.Items.Delete(trvMain.Selected);
end;

procedure TfMain.btnCollapseClick(Sender: TObject);
begin
  trvMain.FullCollapse;
end;

procedure TfMain.btnEditClick(Sender: TObject);
var
  NodeCaption: String;
begin
  NodeCaption:= '';
  if not InputQuery('Ввід заголовку', 'Введіть новий заголовок',
                    NodeCaption) then Exit;
  trvMain.Selected.Text:= NodeCaption;
end;

procedure TfMain.btnExpandClick(Sender: TObject);
begin
  trvMain.FullExpand;
end;

end.

