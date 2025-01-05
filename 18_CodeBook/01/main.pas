unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  LazUTF8;

type

  { TfMain }

  TfMain = class(TForm)
    clrDlg: TColorDialog;
    fntDlg: TFontDialog;
    mFileMenu: TMenuItem;
    mFileCreate: TMenuItem;
    mFileOpen: TMenuItem;
    mFileSave: TMenuItem;
    mFileSaveAs: TMenuItem;
    mFileExit: TMenuItem;
    mEditMenu: TMenuItem;
    mEditCancel: TMenuItem;
    mEditCut: TMenuItem;
    mEditCopy: TMenuItem;
    mEditPaste: TMenuItem;
    mEditDelete: TMenuItem;
    mEditSelectAll: TMenuItem;
    mFormatMenu: TMenuItem;
    mFormatFont: TMenuItem;
    mFormatColor: TMenuItem;
    mFormatWordWrap: TMenuItem;
    mCoderMenu: TMenuItem;
    mCoderCode: TMenuItem;
    mCoderDecode: TMenuItem;
    mHelpMenu: TMenuItem;
    mHelpAbout: TMenuItem;
    sepFour: TMenuItem;
    sepThree: TMenuItem;
    sepTwo: TMenuItem;
    sepOne: TMenuItem;
    mMenu: TMainMenu;
    memNotebook: TMemo;
    opnDlg: TOpenDialog;
    savDlg: TSaveDialog;
    procedure mCoderCodeClick(Sender: TObject);
    procedure mCoderDecodeClick(Sender: TObject);
    procedure mEditCancelClick(Sender: TObject);
    procedure mEditCopyClick(Sender: TObject);
    procedure mEditCutClick(Sender: TObject);
    procedure mEditDeleteClick(Sender: TObject);
    procedure mEditPasteClick(Sender: TObject);
    procedure mEditSelectAllClick(Sender: TObject);
    procedure mFileCreateClick(Sender: TObject);
    procedure mFileExitClick(Sender: TObject);
    procedure mFileOpenClick(Sender: TObject);
    procedure mFileSaveAsClick(Sender: TObject);
    procedure mFileSaveClick(Sender: TObject);
    procedure mFormatColorClick(Sender: TObject);
    procedure mFormatFontClick(Sender: TObject);
    procedure mFormatWordWrapClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure mHelpAboutClick(Sender: TObject);
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

procedure TfMain.mFormatWordWrapClick(Sender: TObject);
begin
  // Змінюємо меню:
  mFormatWordWrap.Checked:= not mFormatWordWrap.Checked;
  // Присвоюємо налаштування memNotebook:
  memNotebook.WordWrap:= mFormatWordWrap.Checked;
  // Якщо перенесення по словах увімкнене, потрібна тільки вертикальна
  // смуга прокрутки, інакше потрібні обидві смуги:
  if memNotebook.WordWrap then memNotebook.ScrollBars:= ssAutoVertical
  else memNotebook.ScrollBars:= ssAutoBoth;
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він їх зберегти:
  if memNotebook.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                  mFileSaveClick(Sender);
  end; // if
end;

procedure TfMain.mHelpAboutClick(Sender: TObject);
begin

  ShowMessage('Інформація про програму поки що недоступна!');

end;

procedure TfMain.mEditCancelClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  memNotebook.Undo;

  ShowMessage('Можливість відміни ще не реалізована!');

end;

procedure TfMain.mCoderCodeClick(Sender: TObject);
begin

  { Даний код не працює, бо бібліотека не компілюється у
    нових версіях програми

  // Спочатку очистимо ключ:
  MyCript.MyPassword:= '';
  if InputQuery('ВВід ключа', 'Введіть ключове слово (фразу):',
                MyCript.MyPassword) then
                  memNotebook.Text:= MyCript.Write(MyCript.Encrypt(memNotebook.Text));

  }

  ShowMessage('Шифрування ще не реалізовано!');

end;

procedure TfMain.mCoderDecodeClick(Sender: TObject);
begin

    { Даний код не працює, бо бібліотека не компілюється у
      нових версіях програми

    // Спочатку очистимо ключ:
    MyCript.MyPassword:= '';
    if InputQuery('ВВід ключа', 'Введіть ключове слово (фразу):',
                  MyCript.MyPassword) then
                    memNotebook.Text:= MyCript.Decrypt(MyCript.Read(memNotebook.Text));

    }

    ShowMessage('Розшифрування ще не реалізовано!');

end;

procedure TfMain.mEditCopyClick(Sender: TObject);
begin
  memNotebook.CopyToClipboard;
end;

procedure TfMain.mEditCutClick(Sender: TObject);
begin
  memNotebook.CutToClipboard;
end;

procedure TfMain.mEditDeleteClick(Sender: TObject);
begin
  memNotebook.ClearSelection;
end;

procedure TfMain.mEditPasteClick(Sender: TObject);
begin
  memNotebook.PasteFromClipboard;
end;

procedure TfMain.mEditSelectAllClick(Sender: TObject);
begin
  memNotebook.SelectAll;
end;

procedure TfMain.mFileCreateClick(Sender: TObject);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він зберегти їх
  // перед створенням нового тексту:
  if memNotebook.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                  mFileSaveClick(Sender);
  end; // if
  // Тепер очищуємо memNotebook, якщо є текст:
  if memNotebook.Text <> '' then memNotebook.Clear;
  // У SaveDialog забираємо ім'я файлу. Це буде означати, що файл не збережено:
  savDlg.FileName:= '';
end;

procedure TfMain.mFileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.mFileOpenClick(Sender: TObject);
begin
  // Перевірка необхідності збереження файлу, як у "Файл -> Створити":
  if memNotebook.Modified then Begin // зміни є
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
                  mFileSaveClick(Sender);
  end; // if

  // Очищуємо ім'я файлу в діалозі OpenDialog, змінюємо заголовок та
  // викликаємо метод LoadFromFile якщо діалог відбувся:
  opnDlg.FileName:= '';
  opnDlg.Title:= 'Відкрити існуючий файл';
  if opnDlg.Execute then begin
    // Очищуємо memNotebook якщо є текст:
    if memNotebook.Text <> '' then memNotebook.Clear;
    // Читаємо із файлу:
    memNotebook.Lines.LoadFromFile(UTF8ToSys(opnDlg.FileName));
    // Копіюємо ім'я файлу в діалог SaveDialog, щоб потім знати куди зберігати:
    savDlg.FileName:= opnDlg.FileName;
  end; // if
end;

procedure TfMain.mFileSaveAsClick(Sender: TObject);
begin
  // Переписуємо заголовок вікна діалогу, інакше він буде англійською
  // мовою. Якщо збереження відбулося, то властивість Modified у memNotebook
  // змінюємо на False, оскільки всі зміни вже збережені:
  savDlg.Title:= 'Зберегти як';
  if savDlg.Execute then begin
    memNotebook.Lines.SaveToFile(UTF8ToSys(savDlg.FileName));
    memNotebook.Modified:= False;
  end;
end;

procedure TfMain.mFileSaveClick(Sender: TObject);
begin
  // Якщо ім'я файлу відомо, то не потрібно викликати діалог SaveDialog,
  // просто викликаємо метод SaveToFile:
  if savDlg.FileName <> '' then begin
    memNotebook.Lines.SaveToFile(UTF8ToSys(savDlg.FileName));
    // Встановлюємо значення Modified False, оскільки всі зміни вже збережені:
    memNotebook.Modified:= False;
  end // if
  // Інакше ім'я файлу не відомо, викликаємо "Зберегти як ...":
  else mFileSaveAsClick(Sender);
end;

procedure TfMain.mFormatColorClick(Sender: TObject);
begin
  // Спочатку задаємо колір діалогу, як у memNotebook:
  clrDlg.Color:= memNotebook.Font.Color;
  // Якщо діалог завершився успішно, змінюємо колір шрифту у memNotebook:
  if clrDlg.Execute then memNotebook.Font.Color:= clrDlg.Color;
end;

procedure TfMain.mFormatFontClick(Sender: TObject);
var
  c: TColor;
begin
  // Отримуємо колір шришту:
  c:= memNotebook.Font.Color;
  // Спочатку діалогу присвоюємо шрифт як у memNotebook:
  fntDlg.Font:= memNotebook.Font;
  // Якщо діалог завершився успішно, змінюємо шрифт у memNotebook:
  if fntDlg.Execute then begin
    memNotebook.Font:= fntDlg.Font;
    memNotebook.Font.Color:= c;
  end;
end;

end.

