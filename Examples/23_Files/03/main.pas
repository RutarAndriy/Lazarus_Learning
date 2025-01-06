unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  LazUTF8;

type

  { TfMain }

  TfMain = class(TForm)
    btnCopy: TButton;
    deCopyPath: TDirectoryEdit;
    fneOriginalFile: TFileNameEdit;
    lblOriginalFile: TLabel;
    lblCopyPath: TLabel;
    procedure btnCopyClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnCopyClick(Sender: TObject);
var
  fIn, fOut: File;             // бінарні файли: оригінал і копія
  NumRead:    Word = 0;        // кількість зчитаних байт
  NumWritten: Word = 0;        // кількість записаних байт
  Buf: Array[1..2048] of Byte; // буфер
begin
  Buf[1]:= 0; // задаємо перший елемент, щоб не було попередження компілятора
  // Якщо файл не вибраний, відображаємо повідомлення і виходимо:
  if fneOriginalFile.Text = '' then begin
    ShowMessage('Увага! Потрібно вказати або вибрати файл для копіювання');
    fneOriginalFile.SetFocus;
    Exit;
  end;
  // Якщо директорія не вибрана, відображаємо повідомлення і виходимо:
  if deCopyPath.Text = '' then begin
    ShowMessage('Увага! Потрібно вказати або вибрати директорію для копії');
    deCopyPath.SetFocus;
    Exit;
  end;
  // Починаємо роботу з файлами:
  try
    AssignFile(fIn, UTF8ToSys(fneOriginalFile.FileName));
    AssignFile(fOut, UTF8ToSys(deCopyPath.Directory + DirectorySeparator +
                     ExtractFileName(fneOriginalFile.FileName)));
    Reset(fIn, 1);
    Rewrite(fOut, 1);
    // Змінюємо курсор на пісочний годинник:
    Screen.Cursor:= crHourGlass;
    Repeat
      BlockRead(fIn, Buf, SizeOf(Buf), NumRead);
      BlockWrite(fOut, Buf, NumRead, NumWritten);
    until (NumRead = 0) or (NumWritten <> NumRead);
  finally
    CloseFile(fIn);
    CloseFile(fOut);
    // Змінюємо курсор на звичайний вигляд:
    Screen.Cursor:= crDefault;
    ShowMessage('Копіювання завершено!');
  end;

end;

end.

