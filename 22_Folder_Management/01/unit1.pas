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
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  sl: TStringList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // Знищуємо змінну:
  sl.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Якщо тексту немає, одразу виходимо:
  if Edit1.Text = '' then Exit;
  // Додаємо рядок в кінець тексту:
  sl.Add(Edit1.Text);
  // Очищуємо Edit1:
  Edit1.Text:= '';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // Якщо взагалі є текст:
  if sl.Count > 0 then
    // Тобі виводимо на екран останній рядок:
    ShowMessage(sl[sl.Count - 1]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  // Зберігаємо текст в файл:
  sl.SaveToFile('mytext.txt');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  // Читаємо текст із файлу, якщо він існує:
  if FileExists('mytext.txt') then
    sl.LoadFromFile('mytext.txt');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Ініціалізуємо змінну:
  sl:= TStringList.Create;
end;

end.

