unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  LazUTF8;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    DE: TDirectoryEdit;
    FNE: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Button1Click(Sender: TObject);
var
  fIn, fOut: File; // нетипізовані файли: оригінал і копія
  NumRead, NumWritten: Word; // кількість зчитаних і записаних байт
  Buf: Array[1..2048] of Byte; // буфер
begin
  // Якщо файл не вибраний, відображаємо повідомлення і виходимо:
  if FNE.Text = '' then begin
    ShowMessage('Увага! Потрібно вказати або вибрати файл для копіювання');
    FNE.SetFocus;
    Exit;
  end;
  // Якщо директорія не вибрана, відображаємо повідомлення і виходимо:
  if DE.Text = '' then begin
    ShowMessage('Увага! Потрібно вказати або вибрати директорію для копії');
    DE.SetFocus;
    Exit;
  end;
  // Починаємо роботу з файлами:
  try
    AssignFile(fIn, UTF8ToSys(FNE.FileName));
    AssignFile(fOut, UTF8ToSys(DE.Directory + DirectorySeparator +
                     ExtractFileName(FNE.FileName)));
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

