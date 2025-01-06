unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  FileUtil;

type

  { TfMain }

  TfMain = class(TForm)
    btnConsole: TButton;
    btnGUI: TButton;
    procedure btnConsoleClick(Sender: TObject);
    procedure btnGUIClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  Exec: String;
  Args: array of String;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnConsoleClick(Sender: TObject);
var
  FullPath: String;
  res: Integer;
begin
  // Різні параметри для різних ОС:
  {$IFDEF WINDOWS}
    Exec:= 'ping';
    SetLength(Args, 1);
    Args[0]:= 'www.google.com';
  {$ELSE}
    Exec:= 'ping';
    SetLength(Args, 3);
    Args[0]:= '-c';
    Args[1]:= '5';
    Args[2]:= 'www.google.com';
  {$ENDIF}
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

procedure TfMain.btnGUIClick(Sender: TObject);
var
  FullPath: String;
  res: Integer;
begin
  // Різні параметри для різних ОС:
  {$IFDEF WINDOWS}
    Exec:= 'notepad';
    SetLength(Args, 1);
    Args[0]:= 'New_File';
  {$ELSE}
    Exec:= 'xed';
    SetLength(Args, 4);
    Args[0]:= '-w';
    Args[1]:= 'File_1';
    Args[2]:= 'File_2';
    Args[3]:= 'File_3';
  {$ENDIF}
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

