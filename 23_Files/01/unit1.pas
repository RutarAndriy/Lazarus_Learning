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
    Edit1: TEdit;
    Memo1: TMemo;
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
  tf: TextFile; // текстовий файл
  s: String;
begin
  // Якщо користувач не ввів строку в Edit1, просто вийдемо:
  if Edit1.Text = '' then Exit;
  // Інакше в s отримуємо текст:
  s:= Edit1.Text;
  // Тепер зв'язуємо файлову змінну tf із файлом mytext.txt:
  AssignFile(tf, 'mytext.txt');
  // Далі може виникнути виняткова ситуація, тому
  // вкладемо небезпечний код у блок try-finally-end:
  try
    // Якщо файлу немає (кнопку натиснули вперше), створюємо його:
    if not FileExists('mytext.txt') then Rewrite(tf)
    // Інакше відкриємо для запису, встановимо вказівник у кінець файлу:
    else Append(tf);
    // Тут просто записуємо строку в файл:
    WriteLn(tf, s);
    // Очищуємо Edit1, щоб користувач бачив, що подія відбулася:
    Edit1.Text:= '';
  finally
    CloseFile(tf); // Закриваємо файл
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  tf: TextFile; // текстовий файл
  s: String;
begin
  // Якщо файлу немає, просто виходимо:
  if not FileExists('mytext.txt') then Exit;
  // Інакше спочатку очищуємо Memo1:
  Memo1.Clear;
  // Зв'язуємо файлову змінну tf із файлом mytext.txt:
  AssignFile(tf, 'mytext.txt');
  // Далі може виникнути виняткова ситуація, тому
  // вкладемо небезпечний код у блок try-finally-end:
  try
    Reset(tf); // відкрили файл для читання, вказівник на початку файлу
    // Робимо, поки не кінець файлу:
    while not EOF(tf) do begin
      ReadLn(tf, s); // читаємо в s черговий рядок
      Memo1.Lines.Add(s); // додаємо цей рядок у Memo1
    end;
  finally
    CloseFile(tf); // Закриваємо файл
  end;
end;

end.

