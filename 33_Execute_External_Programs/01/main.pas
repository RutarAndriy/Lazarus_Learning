unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FileUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Exec: String;
  Args: array of String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  FullPath: String;
  res: Integer;
begin
  // Різні параметри для різних ОС:
  {$ifdef windows}
    Exec:= 'ping';
    SetLength(Args, 1);
    Args[0]:= 'www.google.com';
  {$else}
    Exec:= 'ping';
    SetLength(Args, 3);
    Args[0]:= '-c';
    Args[1]:= '5';
    Args[2]:= 'www.google.com';
  {$endif}
  try
    // Отримуємо шлях до виконуваної програми:
    FullPath:= FindDefaultExecutablePath(Exec);
    // Запускаємо новий процес, на час запуску програма "зависає":
    if FullPath <> '' then begin
      res:= SysUtils.ExecuteProcess(FullPath, Args);
      // Відображаємо інформаційне повідомлення:
      ShowMessage('Роботу завершено, код завершення: ' + IntToStr(res));
    end
    else
      // Відображаємо повідомлення про помилку:
      ShowMessage('Програму ' + Exec + ' не знайдено');
  except
    // Якщо сталася помилка відображаємо повідомлення:
    ShowMessage('Сталася помилка :(');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FullPath: String;
  res: Integer;
begin
  // Різні параметри для різних ОС:
  {$ifdef windows}
    Exec:= 'notepad';
    SetLength(Args, 1);
    Args[0]:= 'New_File';
  {$else}
    Exec:= 'xed';
    SetLength(Args, 4);
    Args[0]:= '-w';
    Args[1]:= 'File_1';
    Args[2]:= 'File_2';
    Args[3]:= 'File_3';
  {$endif}
  try
    // Отримуємо шлях до виконуваної програми:
    FullPath:= FindDefaultExecutablePath(Exec);
    // Запускаємо новий процес, на час запуску програма "зависає":
    if FullPath <> '' then begin
      res:= SysUtils.ExecuteProcess(FullPath, Args);
      // Відображаємо інформаційне повідомлення:
      ShowMessage('Роботу завершено, код завершення: ' + IntToStr(res));
    end
    else
      // Відображаємо повідомлення про помилку:
      ShowMessage('Програму ' + Exec + ' не знайдено');
  except
    // Якщо сталася помилка відображаємо повідомлення:
    ShowMessage('Сталася помилка :(');
  end;
end;

end.

