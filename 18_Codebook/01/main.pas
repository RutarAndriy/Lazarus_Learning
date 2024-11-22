unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  LazUTF8, BlowFish;

type

  { TfMain }

  TfMain = class(TForm)
    CD: TColorDialog;
    FD: TFontDialog;
    FileMenu: TMenuItem;
    FileCreate: TMenuItem;
    FileOpen: TMenuItem;
    FileSave: TMenuItem;
    FileSaveAs: TMenuItem;
    FileExit: TMenuItem;
    EditMenu: TMenuItem;
    EditCancel: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    EditDelete: TMenuItem;
    EditSelectAll: TMenuItem;
    FormatMenu: TMenuItem;
    FormatFont: TMenuItem;
    FormatColor: TMenuItem;
    FormatWordWrap: TMenuItem;
    CoderMenu: TMenuItem;
    CoderCode: TMenuItem;
    CoderDecode: TMenuItem;
    HelpMenu: TMenuItem;
    HelpAbout: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    MM: TMainMenu;
    Memo1: TMemo;
    OD: TOpenDialog;
    SD: TSaveDialog;
    procedure CoderCodeClick(Sender: TObject);
    procedure CoderDecodeClick(Sender: TObject);
    procedure EditCancelClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditDeleteClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure EditSelectAllClick(Sender: TObject);
    procedure FileCreateClick(Sender: TObject);
    procedure FileExitClick(Sender: TObject);
    procedure FileOpenClick(Sender: TObject);
    procedure FileSaveAsClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure FormatColorClick(Sender: TObject);
    procedure FormatFontClick(Sender: TObject);
    procedure FormatWordWrapClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  fMain: TfMain;
  sTemp : AnsiString;
  lentmp : Integer;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormatWordWrapClick(Sender: TObject);
begin
  // Змінюємо меню:
  FormatWordWrap.Checked:= not FormatWordWrap.Checked;
  // Присвоюємо налаштування Memo1:
  Memo1.WordWrap:= FormatWordWrap.Checked;
  // Якщо перенесення по словах увімкнене, потрібна тільки вертикальна
  // смуга прокрутки, інакше потрібні обидві смуги:
  if Memo1.WordWrap then Memo1.ScrollBars:= ssAutoVertical
  else Memo1.ScrollBars:= ssAutoBoth;
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він їх зберегти
  if Memo1.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                    FileSaveClick(Sender);
  end; // if
end;

procedure TfMain.EditCancelClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  Memo1.Undo;

  ShowMessage('Можливість відміни ще не реалізована!');

end;

procedure TfMain.CoderCodeClick(Sender: TObject);
begin

  { Даний код не працює, бо бібліотека не компілюється у
    нових версіях програми

  // Спочатку очистимо ключ:
  MyCript.MyPassword:= '';
  if InputQuery('ВВід ключа', 'Введіть ключове слово (фразу):',
                MyCript.MyPassword) then
                  Memo1.Text:= MyCript.Write(MyCript.Encrypt(Memo1.Text));

  }

  ShowMessage('Шифрування ще не реалізовано!');

end;

procedure TfMain.CoderDecodeClick(Sender: TObject);
begin

    { Даний код не працює, бо бібліотека не компілюється у
      нових версіях програми

    // Спочатку очистимо ключ:
    MyCript.MyPassword:= '';
    if InputQuery('ВВід ключа', 'Введіть ключове слово (фразу):',
                  MyCript.MyPassword) then
                    Memo1.Text:= MyCript.Decrypt(MyCript.Read(Memo1.Text));

    }

    ShowMessage('Розшифрування ще не реалізовано!');

end;

procedure TfMain.EditCopyClick(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

procedure TfMain.EditCutClick(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

procedure TfMain.EditDeleteClick(Sender: TObject);
begin
  Memo1.ClearSelection;
end;

procedure TfMain.EditPasteClick(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

procedure TfMain.EditSelectAllClick(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TfMain.FileCreateClick(Sender: TObject);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він зберегти їх
  // перед створенням нового тексту
  if Memo1.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                    FileSaveClick(Sender);
  end; // if
  // Тепер очищуємо Memo1, якщо є текст:
  if Memo1.Text <> '' then Memo1.Clear;
  // У SaveDialog забираємо ім'я файлу. Це буде означати, що файл не збережено:
  SD.FileName:= '';
end;

procedure TfMain.FileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FileOpenClick(Sender: TObject);
begin
  // Перевірка необхідності збереження файлу, як у "Файл -> Створити":
  if Memo1.Modified then Begin // зміни є
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                    FileSaveClick(Sender);
  end; // if

  // Очищуємо ім'я файлу в діалозі OpenDialog, змінюємо заголовок та
  // викликаємо метод LoadFromFile якщо діалог відбувся:
  OD.FileName:= '';
  OD.Title:= 'Відкрити існуючий файл';
  if OD.Execute then begin
    // Очищуємо Memo1 якщо є текст:
    if Memo1.Text <> '' then Memo1.Clear;
    // Читаємо із файлу:
    Memo1.Lines.LoadFromFile(UTF8ToSys(OD.FileName));
    // Копіюємо ім'я файлу в діалог SaveDialog, щоб потім знати куди зберігати:
    SD.FileName:= OD.FileName;
  end; // if
end;

procedure TfMain.FileSaveAsClick(Sender: TObject);
begin
  // Переписуємо заголовок вікна діалогу, інакше він буде англійською
  // мовою. Якщо збереження відбулося, то властивість Modified у Memo1
  // змінюємо на False, оскільки всі зміни вже збережені:
  SD.Title:= 'Зберегти як';
  if SD.Execute then begin
    Memo1.Lines.SaveToFile(UTF8ToSys(SD.FileName));
    Memo1.Modified:= False;
  end;
end;

procedure TfMain.FileSaveClick(Sender: TObject);
begin
  // Якщо ім'я файлу відомо, то не потрібно викликати діалог SaveDialog,
  // просто викликаємо метод SaveToFile:
  if SD.FileName <> '' then begin
    Memo1.Lines.SaveToFile(UTF8ToSys(SD.FileName));
    // Встановлюємо значення Modified False, оскільки всі зміни вже збережені:
    Memo1.Modified:= False;
  end // if
  // Інакше ім'я файлу не відомо, викликаємо "Зберегти як ...":
  else FileSaveAsClick(Sender);
end;

procedure TfMain.FormatColorClick(Sender: TObject);
begin
  // Спочатку задаємо колір діалогу, як у Memo1:
  CD.Color:= Memo1.Font.Color;
  // Якщо діалог завершився успішно, змінюємо колір шрифту у Memo1:
  if CD.Execute then Memo1.Font.Color:= CD.Color;
end;

procedure TfMain.FormatFontClick(Sender: TObject);
var
  c: TColor;
begin
  // Отримуємо колір шришту
  c:= Memo1.Font.Color;
  // Спочатку діалогу присвоюємо шрифт як у Memo1:
  FD.Font:= Memo1.Font;
  // Якщо діалог завершився успішно, змінюємо шрифт у Memo1:
  if FD.Execute then begin
    Memo1.Font:= FD.Font;
    Memo1.Font.Color:= c;
  end;
end;

end.

