unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Process, FileUtil;

type

  { TfMain }

  TfMain = class(TForm)
    btnGUI: TButton;
    btnWrong: TButton;
    btnRight: TButton;
    procedure btnGUIClick(Sender: TObject);
    procedure btnWrongClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Запуск графічної програми:
procedure TfMain.btnGUIClick(Sender: TObject);
var
  MyProcess: TProcess;
  FullPath: String;
begin
  // Створюємо процес:
  MyProcess:= TProcess.Create(nil);
  // Задаємо різні параметри в залежності від ОС:
  {$IFDEF WINDOWS}
  FullPath:= FindDefaultExecutablePath('notepad');
  MyProcess.Executable:= FullPath;
  MyProcess.Parameters.Add('File_1');
  {$ELSE}
  FullPath:= FindDefaultExecutablePath('xed');
  MyProcess.Executable:= FullPath;
  MyProcess.Parameters.Add('-w');
  MyProcess.Parameters.Add('File_1');
  MyProcess.Parameters.Add('File_2');
  MyProcess.Parameters.Add('File_3');
  {$ENDIF}
  // Задаємо параметри виконання:
  MyProcess.Options:= MyProcess.Options + [poWaitOnExit];
  // Запускаємо процес:
  MyProcess.Execute;
  // Відображаємо повідомлення після завершення процесу:
  ShowMessage('OK');
  // Вивільняємо ресурси:
  MyProcess.Free;
end;

// Запуск консольної програми і читання її виводу - неправильно!
procedure TfMain.btnWrongClick(Sender: TObject);
var
  MyProcess: TProcess;
  FullPath: String;
  ProcessOutput: TStringList;
begin
  // Створюємо процес:
  MyProcess:= TProcess.Create(nil);
  // Задаємо різні параметри в залежності від ОС:
  {$IFDEF WINDOWS}
  FullPath:= FindDefaultExecutablePath('ping');
  MyProcess.Executable:= FullPath;
  MyProcess.Parameters.Add('-h');
  MyProcess.Options:= MyProcess.Options + [poWaitOnExit, poUsePipes,
                                           poNoConsole];
  {$ELSE}
  FullPath:= FindDefaultExecutablePath('ping');
  MyProcess.Executable:= FullPath;
  MyProcess.Parameters.Add('-h');
  // Опція poStderrToOutPut потрібна лише для деяких програм, таких як ping:
  MyProcess.Options:= MyProcess.Options + [poWaitOnExit, poUsePipes,
                                           poStderrToOutPut];
  {$ENDIF}
  // Запускаємо процес:
  MyProcess.Execute;
  // Створюємо список рядків:
  ProcessOutput:= TStringList.Create;
  // Заповнюємо список рядків даними із потоку виводу:
  ProcessOutput.LoadFromStream(MyProcess.Output);
  // Виводимо отримані дані:
  ShowMessage(ProcessOutput.Text);
  // Вивільняємо ресурси:
  ProcessOutput.Free;
  MyProcess.Free;
end;

// Запуск консольної програми і читання її виводу - правильно!
procedure TfMain.btnRightClick(Sender: TObject);
const
  BUF_SIZE = 2048; // розмір буфера для читання вихідних даних блоками
var
  MyProcess: TProcess; // процес для запуску
  OutputStream: TStream; // потік вихідних даних
  BytesRead: LongInt; // кількість зчитаних байт
  Buffer: array [1..BUF_SIZE] of Byte; // буфер даних
begin
  // Створюємо процес:
  MyProcess:= TProcess.Create(nil);
  // Задаємо різні параметри в залежності від ОС:
  {$IFDEF WINDOWS}
  MyProcess.Executable:= 'c:\windows\system32\cmd.exe';
  MyProcess.Parameters.Add('/c');
  MyProcess.Parameters.Add('dir /s c:\windows');
  {$ELSE}
  MyProcess.Executable:= '/bin/ls';
  MyProcess.Parameters.Add('--recursive');
  MyProcess.Parameters.Add('--all');
  MyProcess.Parameters.Add('-l');
  {$ENDIF}
  // Задаємо параметри запуску:
  MyProcess.Options:= [poUsePipes, poNoConsole];
  // Запускаємо процес:
  MyProcess.Execute;
  // Створюємо потік для збереження виведених даних:
  OutputStream:= TMemoryStream.Create;
  // Задаємо перший елемент, щоб не було попередження компілятора:
  Buffer[1]:= 0;
  // Всі дані читаються в циклі, поки дані не закінчаться:
  repeat
    // Зчитуємо дані в буфер і отримуємо кількість зчитаних байт:
    BytesRead:= MyProcess.Output.Read(Buffer, BUF_SIZE);
    // Записуємо зчитані дані у вихідний потік:
    OutputStream.Write(Buffer, BytesRead);
  until BytesRead = 0;
  // Процес завершено, тому його можна очистити:
  MyProcess.Free;
  // Зчитуємо отримані дані:
  with TStringList.Create do
  begin
    OutputStream.Position:= 0;
    LoadFromStream(OutputStream);
    ShowMessage(Text + #13 +
                '--- Кількість рядків = ' + IntToStr(Count) + ' ---' );
    Free;
  end;
  // Створюємо список рядків:
  OutputStream.Free;
end;

end.

