unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnAdd: TButton;
    btnRead: TButton;
    edtField: TEdit;
    memView: TMemo;
    procedure btnAddClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnAddClick(Sender: TObject);
var
  tf: TextFile; // текстовий файл
  s: String;
begin
  // Якщо користувач не ввів строку в edtField, просто вийдемо:
  if edtField.Text = '' then Exit;
  // Інакше в s отримуємо текст:
  s:= edtField.Text;
  // Тепер зв'язуємо файлову змінну tf із файлом MyText.txt:
  AssignFile(tf, 'MyText.txt');
  // Далі може виникнути виняткова ситуація, тому
  // вкладемо небезпечний код у блок try-finally-end:
  try
    // Якщо файлу немає (кнопку натиснули вперше), створюємо його:
    if not FileExists('MyText.txt') then Rewrite(tf)
    // Інакше відкриємо для запису, встановимо вказівник у кінець файлу:
    else Append(tf);
    // Тут просто записуємо строку в файл:
    WriteLn(tf, s);
    // Очищуємо edtField, щоб користувач бачив, що подія відбулася:
    edtField.Text:= '';
  finally
    CloseFile(tf); // Закриваємо файл
  end;
end;

procedure TfMain.btnReadClick(Sender: TObject);
var
  tf: TextFile; // текстовий файл
  s: String;
begin
  // Якщо файлу немає, просто виходимо:
  if not FileExists('MyText.txt') then Exit;
  // Інакше спочатку очищуємо memView:
  memView.Clear;
  // Зв'язуємо файлову змінну tf із файлом MyText.txt:
  AssignFile(tf, 'MyText.txt');
  // Далі може виникнути виняткова ситуація, тому
  // вкладемо небезпечний код у блок try-finally-end:
  try
    Reset(tf); // відкрили файл для читання, вказівник на початку файлу
    // Робимо, поки не кінець файлу:
    while not EOF(tf) do begin
      ReadLn(tf, s); // читаємо в s черговий рядок
      memView.Lines.Add(s); // додаємо цей рядок у memView
    end;
  finally
    CloseFile(tf); // Закриваємо файл
  end;
end;

end.

