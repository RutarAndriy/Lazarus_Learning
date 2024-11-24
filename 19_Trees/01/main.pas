unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    bNewNode: TButton;
    bNewChildNode: TButton;
    bDelete: TButton;
    bEdit: TButton;
    bSort: TButton;
    bCollapse: TButton;
    bExpand: TButton;
    IL: TImageList;
    Panel1: TPanel;
    TreeView1: TTreeView;
    procedure bCollapseClick(Sender: TObject);
    procedure bDeleteClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bExpandClick(Sender: TObject);
    procedure bNewChildNodeClick(Sender: TObject);
    procedure bNewNodeClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
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

procedure TfMain.bNewNodeClick(Sender: TObject);
var
  NodeCaption: String; // для отримання заголовку нового вузла
  NewNode: TTreeNode; // для створення нового вузла
begin
  // Спочатку очистимо заголовок:
  NodeCaption:= '';
  // Тепер, якщо користувач не ввів заголовок нового вузла, виходимо:
  if not InputQuery('Ввід заголовку', 'Введіть заголовок розділу',
                    NodeCaption) then Exit;
  // Якщо ми тут, то заголовок є. Створюємо батьківський вузол:
  NewNode:= TreeView1.Items.Add(nil, NodeCaption);
  // Присвоюємо йому картинку під індексом 0:
  NewNode.ImageIndex:= 0;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  TreeView1.AlphaSort;
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TreeView1.SaveToFile('MyLibrary.dat');
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // Якщо файл існує, то завантажимо його:
  if FileExists('MyLibrary.dat') then
    TreeView1.LoadFromFile('MyLibrary.dat');
  // Тепер пройдемося по списку і кожному вузлу присвоїмо
  // потрібну піктограму
  for i:= 0 to TreeView1.Items.Count - 1 do
    if TreeView1.Items[i].Parent = nil then TreeView1.Items[i].ImageIndex:= 0
    else TreeView1.Items[i].ImageIndex:= 1;
end;

procedure TfMain.bNewChildNodeClick(Sender: TObject);
var
  NodeCaption: String;
  NewNode: TTreeNode;
begin
  NodeCaption:= '';
  if not InputQuery('Ввід заголовку', 'Введіть заголовок підрозділу',
                    NodeCaption) then Exit;
  NewNode:= TreeView1.Items.AddChild(TreeView1.Selected, NodeCaption);
  if NewNode.Parent = nil then NewNode.ImageIndex:= 0
  else NewNode.ImageIndex:= 1;
end;

procedure TfMain.bDeleteClick(Sender: TObject);
begin
  if TreeView1.Selected <> nil then
    TreeView1.Items.Delete(TreeView1.Selected);
end;

procedure TfMain.bCollapseClick(Sender: TObject);
begin
  TreeView1.FullCollapse;
end;

procedure TfMain.bEditClick(Sender: TObject);
var
  NodeCaption: String;
begin
  NodeCaption:= '';
  if not InputQuery('Ввід заголовку', 'Введіть новий заголовок',
                    NodeCaption) then Exit;
  TreeView1.Selected.Text:= NodeCaption;
end;

procedure TfMain.bExpandClick(Sender: TObject);
begin
  TreeView1.FullExpand;
end;

end.

