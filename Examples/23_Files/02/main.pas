unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnGenerate: TButton;
    btnRead: TButton;
    lbView: TListBox;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnGenerateClick(Sender: TObject);
var
  f: File of Integer; // файл типу цілого числа
  i: Integer;         // лічильник для циклу
begin
  AssignFile(f, 'MyTypedFile.dat');
  Rewrite(f);
  for i:= 1 to 10 do // виконуємо цикл 10 разів
    Write(f, Random(1000)); // записуємо у файл випадкове ціле число
  CloseFile(f);
end;

procedure TfMain.btnReadClick(Sender: TObject);
var
  f: File of Integer;
  i: Integer; // для отримання значень елементів
begin
  // Виходимо із процедури, якщо файлу немає:
  if not FileExists('MyTypedFile.dat') then Exit;
  lbView.Clear;
  AssignFile(f, 'MyTypedFile.dat');
  // Відкриваємо для читання:
  Reset(f);
  // Робимо від першого до останнього елемента:
  while not EOF(f) do begin
    Read(f, i); // зчитуємо черговий елемент у змінну k
    lbView.Items.Add(IntToStr(i)); // записуємо це значення в lbView
  end;
  CloseFile(f);
end;

end.

