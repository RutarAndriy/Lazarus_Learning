unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  f: File of Integer; // файл типу цілого числа
  i: Integer; // лічильник для циклу
begin
  AssignFile(f, 'mytypefile.dat');
  Rewrite(f);
  for i:= 1 to 10 do // робимо 10 разів
    Write(f, Random(1000)); // записуємо у файл випадкове ціле число
  CloseFile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f: File of Integer;
  i: Integer; // для отримання значень елементів
begin
  // виходимо із процедури, якщо файлу немає:
  if not FileExists('mytypefile.dat') then Exit;
  ListBox1.Clear;
  AssignFile(f, 'mytypefile.dat');
  // Відкриваємо для читання:
  Reset(f);
  // Робимо від першого до останнього елемента:
  while not EOF(f) do begin
    Read(f, i); // зчитуємо черговий елемент у змінну k
    ListBox1.Items.Add(IntToStr(i)); // записуємо це значення в ListBox1
  end;
  CloseFile(f);
end;

end.

