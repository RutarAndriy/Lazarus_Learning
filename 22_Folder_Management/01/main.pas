unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnAdd: TButton;
    btnPrint: TButton;
    btnSave: TButton;
    btnRead: TButton;
    edtField: TEdit;
    procedure btnAddClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  sList: TStringList;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // Знищуємо змінну:
  sList.Free;
end;

procedure TfMain.btnAddClick(Sender: TObject);
begin
  // Якщо тексту немає, одразу виходимо:
  if edtField.Text = '' then Exit;
  // Додаємо рядок в кінець тексту:
  sList.Add(edtField.Text);
  // Очищуємо edtField:
  edtField.Text:= '';
end;

procedure TfMain.btnPrintClick(Sender: TObject);
var
  i: Integer;
  message: String = '';
begin
  // Якщо взагалі є текст:
  if sList.Count > 0 then begin
    for i:= 0 to sList.Count - 1 do
      message:= message + sList[i] + #13;
    // Виводимо на екран весь текст:
    ShowMessage(message);
  end;
end;

procedure TfMain.btnSaveClick(Sender: TObject);
begin
  // Зберігаємо текст в файл:
  sList.SaveToFile('MyText.txt');
end;

procedure TfMain.btnReadClick(Sender: TObject);
begin
  // Читаємо текст із файлу, якщо він існує:
  if FileExists('MyText.txt') then begin
    sList.LoadFromFile('MyText.txt');
    btnPrintClick(nil);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Ініціалізуємо змінну:
  sList:= TStringList.Create;
end;

end.

