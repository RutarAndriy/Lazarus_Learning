unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  myForm = record // запис
    Left: Integer; // ліва межа форми
    Top: Integer; // верхня межа форми
    Height: Integer; // висота форми
    Width: Integer; // ширина форми
    Caption: String[100]; // заголовок форми
    Checked: Boolean; // стан прапорця CheckBox1
    wsMax: Boolean; // вікно розгорнуте?
  end; // record

var
  Form1: TForm1;
  MyF: myForm; // наша змінна-запис

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Edit1.Text <> '' then Form1.Caption:= Edit1.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  f: file of myForm; // типізований файл для збереження даних
begin
  // Спочатку налаштуємо змінну-запис:
  // Не зберігаємо розміри та розташування, якщо вікно wsMaximized:
  if not (Form1.WindowState = wsMaximized) then begin
    MyF.Left:= Form1.Left;
    MyF.Top:= Form1.Top;
    MyF.Height:= Form1.Height;
    MyF.Width:= Form1.Width;
    MyF.wsMax:= False;
  end
  else MyF.wsMax:= True;
  // Решта налаштувань:
  MyF.Caption:= Form1.Caption;
  MyF.Checked:= CheckBox1.Checked;
  // Тепер створимо або перезапишемо файл налаштувань:
  try
    AssignFile(f, 'MyProg.dat');
    Rewrite(f);
    Write(f, MyF); // записуємо у файл дані із запису
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  f: file of myForm; // типізований файл для збереження даних
begin
  // Якщо файлу ще немає, просто виходимо:
  if not FileExists('MyProg.dat') then Exit;
  // Інакше відкриваємо файл і зчитуємо із нього налаштування в запис:
  try
    AssignFile(f, 'MyProg.dat');
    Reset(f);
    Read(f, MyF); // зчитали дані у змінну типу запис
  finally
    CloseFile(f);
  end;
  // Тепер налаштування необхідно застосувати до форми
  // Якщо вікно було розгорнуте, розгортаємо його, інакше налаштовуємо межі:
  if MyF.wsMax then Form1.WindowState:= wsMaximized
  else begin
    Form1.Left:= MyF.Left;
    Form1.Top:= MyF.Top;
    Form1.Height:= MyF.Height;
    Form1.Width:= MyF.Width;
  end;
  // Решта налаштувань:
  Form1.Caption:= MyF.Caption;
  CheckBox1.Checked:= MyF.Checked;
end;

end.

