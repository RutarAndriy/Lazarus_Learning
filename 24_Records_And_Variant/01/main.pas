unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnSet: TButton;
    cbTest: TCheckBox;
    edtCaption: TEdit;
    lblCaption: TLabel;
    procedure btnSetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  myForm = record         // запис
    Left: Integer;        // ліва межа форми
    Top: Integer;         // верхня межа форми
    Height: Integer;      // висота форми
    Width: Integer;       // ширина форми
    Caption: String[100]; // заголовок форми
    Checked: Boolean;     // стан прапорця cbTest
    wsMax: Boolean;       // вікно розгорнуте?
  end; // record

var
  fMain: TfMain;
  MyF: myForm;            // наша змінна-запис

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnSetClick(Sender: TObject);
begin
  if edtCaption.Text <> '' then fMain.Caption:= edtCaption.Text;
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  f: file of myForm; // типізований файл для збереження даних
begin
  // Спочатку налаштуємо змінну-запис:
  // Не зберігаємо розміри та розташування, якщо вікно wsMaximized:
  if not (fMain.WindowState = wsMaximized) then begin
    MyF.Left:= fMain.Left;
    MyF.Top:= fMain.Top;
    MyF.Height:= fMain.Height;
    MyF.Width:= fMain.Width;
    MyF.wsMax:= False;
  end
  else MyF.wsMax:= True;
  // Решта налаштувань:
  MyF.Caption:= fMain.Caption;
  MyF.Checked:= cbTest.Checked;
  // Тепер створимо або перезапишемо файл налаштувань:
  try
    AssignFile(f, 'RecordFile.dat');
    Rewrite(f);
    Write(f, MyF); // записуємо у файл дані із запису
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  f: file of myForm; // типізований файл для збереження даних
begin
  // Якщо файлу ще немає, просто виходимо:
  if not FileExists('RecordFile.dat') then Exit;
  // Інакше відкриваємо файл і зчитуємо із нього налаштування в запис:
  try
    AssignFile(f, 'RecordFile.dat');
    Reset(f);
    Read(f, MyF); // зчитали дані у змінну типу запис
  finally
    CloseFile(f);
  end;
  // Тепер налаштування необхідно застосувати до форми:
  // Якщо вікно було розгорнуте, розгортаємо його, інакше налаштовуємо межі:
  if MyF.wsMax then fMain.WindowState:= wsMaximized
  else begin
    fMain.Left:= MyF.Left;
    fMain.Top:= MyF.Top;
    fMain.Height:= MyF.Height;
    fMain.Width:= MyF.Width;
  end;
  // Решта налаштувань:
  fMain.Caption:= MyF.Caption;
  cbTest.Checked:= MyF.Checked;
end;

end.

