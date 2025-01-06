unit Main;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF WINDOWS} Windows, {$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  LazUTF8, About, Stats, StrUtils;

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
    mEditUndo: TMenuItem;
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
    mFileStat: TMenuItem;
    mEditRedo: TMenuItem;
    mHelpHelp: TMenuItem;
    sepFive: TMenuItem;
    sepFour: TMenuItem;
    sepThree: TMenuItem;
    sepTwo: TMenuItem;
    mMenu: TMainMenu;
    memNotebook: TMemo;
    opnDlg: TOpenDialog;
    savDlg: TSaveDialog;
    sepOne: TMenuItem;
    procedure mCoderCodeClick(Sender: TObject);
    procedure mCoderDecodeClick(Sender: TObject);
    procedure mEditRedoClick(Sender: TObject);
    procedure mEditUndoClick(Sender: TObject);
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
    procedure mFileStatClick(Sender: TObject);
    procedure mFormatColorClick(Sender: TObject);
    procedure mFormatFontClick(Sender: TObject);
    procedure mFormatWordWrapClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mHelpAboutClick(Sender: TObject);
    procedure mHelpHelpClick(Sender: TObject);
    procedure memNotebookChange(Sender: TObject);
  private

  public

  end;

const
  historyLimit = 25;        // ліміт історії
var
  fMain: TfMain;            // головна форма
  history: array of String; // масив історії
  historyIndex: Integer;    // індекс історії
  historyUndoRedo: Boolean; // вказує на перехід вперед/назад по історії

implementation

{$R *.lfm}

{ TfMain }

// Отримання "довгого" ключа:
function LongKey(key: String; lenght: Integer): String;
begin
  Result:= key;
  while Result.Length < lenght do
    Result:= Result + key;
  Result:= Result.Substring(0, lenght);
end;

// Побітове шифрування/розшифрування:
function Cipher(text: String; key: String): String;
var
  i: Integer;
begin
  key:= LongKey(key, text.Length);
  for i:= 1 to Length(text) do
    text[i]:= Char(Ord(text[i]) xor Ord(key[i]));
  Result:= text;
end;

// Шифрування та переведення результату в HEX-формат:
function Encrypt(text: String; key: String): String;
var
  i: Integer;
  encryptedText: String;
begin
  Result:= '';
  encryptedText:= Cipher(text, key);
  for i:= 1 to Length(encryptedText) do
    Result:= Result + IntToHex(Ord(encryptedText[i])) + #32;
end;

// Переведення даних із HEX-формату та розшифровування:
function Decrypt(text: String; key: String): String;
var
  i: Integer;
  decryptedText: String;
begin
  decryptedText:= '';
  text:= StringReplace(text, ' ', '', [rfReplaceAll]);
  for i:= 0 to Trunc((Length(text) - 1) / 2) do
    decryptedText:= decryptedText + Char(Hex2Dec(text.Substring(i * 2, 2)));
  Result:= Cipher(decryptedText, key);
end;

// Зміна властивості "перенесення слів"
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

// Закриття форми:
procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він їх зберегти:
  if memNotebook.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                  mFileSaveClick(Sender);
  end; // if
end;

// Створення форми:
procedure TfMain.FormCreate(Sender: TObject);
begin
  // Ініціалізуємо масив історії:
  SetLength(history, 1);
  // Ініціалізуємо індекс історії:
  historyIndex:= 0;
  // Ініціалізуємо змінну редагування історії:
  historyUndoRedo:= False;
end;

// Виклик меню "Довідка -> Про програму":
procedure TfMain.mHelpAboutClick(Sender: TObject);
begin
  fAbout.ShowModal;
end;

// Виклик меню "Довідка -> Довідка":
procedure TfMain.mHelpHelpClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  // Викликаємо довідку на ОС Windows:
  WinExec('hh.exe CodeBook.chm', SW_SHOW);
  {$ELSE}
  // На інших ОС відображаємо повідомлення про помилку:
  ShowMessage('Довідка у форматі *.chm доступна' + #13 +
              'лише для ОС Windows');
  {$ENDIF}
end;

// Зміна тексту в полі введення:
procedure TfMain.memNotebookChange(Sender: TObject);
var
  historySize: Integer;
  i: Integer;
begin
  // Якщо виконується операція відмінити/повернути:
  if historyUndoRedo then begin
    historyUndoRedo:= False;
  end
  // В іншому випадку виконується зміна історії:
  else begin
    // Отримуємо розмір масиву:
    historySize:= Length(history);
    // Якщо дані змінюють історію, то затираємо заміщену історію:
    if historyIndex < historySize - 1 then begin
      SetLength(history, historyIndex + 1);
      historySize:= Length(history);
    end;
    // Якщо ми виходимо за ліміт історії, то затираємо перші записи:
    if historySize = historyLimit then begin
      for i:= 0 to historySize - 2 do begin
        history[i]:= history[i + 1];
      end;
      SetLength(history, historyLimit - 1);
      Dec(historyIndex, 1);
      historySize:= Length(history);
    end;
    // Збільшуємо масив на 1 елемент:
    SetLength(history, historySize + 1);
    // Збільшуємо індекс історії:
    Inc(historyIndex, 1);
    // Присвоюємо дані новому елементу:
    history[historySize]:= memNotebook.Lines.Text;
    // Даємо можливість відмінити зміни:
    mEditUndo.Enabled:= True;
  end;

  // Рахуємо символи:
  fStats.lblCharsCount.Caption:= IntToStr(UTF8Length(memNotebook.Text));
  // Рахуємо слова:
  fStats.lblWordsCount.Caption:= IntToStr(WordCount(memNotebook.Text,
                                                    StdWordDelims));
  // Рахуємо рядки:
  fStats.lblLinesCount.Caption:= IntToStr(memNotebook.Lines.Count);
end;

// Виклик меню "Правка -> Відмінити":
procedure TfMain.mEditUndoClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  // memNotebook.Undo;
  // Задіємо власну реалізацію:
  if historyIndex > 0 then begin
    // Зменшуємо індекс історіх на одиницю:
    Dec(historyIndex, 1);
    // Якщо ми на початку історії, то відміна неможлива:
    if historyIndex = 0 then mEditUndo.Enabled:= False;
    // Вказуємо на зміни:
    historyUndoRedo:= True;
    mEditRedo.Enabled:= True;
    // Вносимо зміни:
    memNotebook.Lines.Text:= history[historyIndex];
    memNotebook.SelStart:=memNotebook.Lines.Text.Length;
  end;
end;

// Виклик меню "Кодування -> Шифрувати":
procedure TfMain.mCoderCodeClick(Sender: TObject);
var
  key: String;
begin
  // Запитуємо пароль і шифруємо текст:
  key:= '';
  if InputQuery('Ввід ключа', 'Введіть ключове слово (фразу):', key)
     and (key <> '') then
       memNotebook.Text:= Encrypt(memNotebook.Text, key);
end;

// Виклик меню "Кодування -> Розшифрувати":
procedure TfMain.mCoderDecodeClick(Sender: TObject);
var
  key: String;
begin
  // Запитуємо пароль і розшифровуємо текст:
  key:= '';
  if InputQuery('Ввід ключа', 'Введіть ключове слово (фразу):', key)
     and (key <> '') then
       memNotebook.Text:= Decrypt(memNotebook.Text, key);
end;

// Виклик меню "Правка -> Повернути":
procedure TfMain.mEditRedoClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  // memNotebook.Redo;
  // Задіємо власну реалізацію:
  if historyIndex < High(history) then begin
    // Збільшуємо індекс історіх на одиницю:
    Inc(historyIndex, 1);
    // Якщо ми на кінці історії, то повторення неможливе:
    if historyIndex = Length(history) - 1 then mEditRedo.Enabled:= False;
    // Вказуємо на зміни:
    historyUndoRedo:= True;
    mEditUndo.Enabled:= True;
    // Вносимо зміни:
    memNotebook.Lines.Text:= history[historyIndex];
    memNotebook.SelStart:=memNotebook.Lines.Text.Length;
  end;
end;

// Виклик меню "Правка -> Копіювати":
procedure TfMain.mEditCopyClick(Sender: TObject);
begin
  memNotebook.CopyToClipboard;
end;

// Виклик меню "Правка -> Вирізати":
procedure TfMain.mEditCutClick(Sender: TObject);
begin
  memNotebook.CutToClipboard;
end;

// Виклик меню "Правка -> Видалити":
procedure TfMain.mEditDeleteClick(Sender: TObject);
begin
  memNotebook.ClearSelection;
end;

// Виклик меню "Правка -> Вставити":
procedure TfMain.mEditPasteClick(Sender: TObject);
begin
  memNotebook.PasteFromClipboard;
end;

// Виклик меню "Правка -> Виділити все":
procedure TfMain.mEditSelectAllClick(Sender: TObject);
begin
  memNotebook.SelectAll;
end;

// Виклик меню "Файл -> Створити":
procedure TfMain.mFileCreateClick(Sender: TObject);
begin
  // Якщо є зміни тексту, запитаємо користувача, чи не хоче він зберегти їх
  // перед створенням нового тексту:
  if memNotebook.Modified then begin
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                  mFileSaveClick(Sender);
  end; // if
  // Тепер очищуємо memNotebook, якщо є текст:
  if memNotebook.Text <> '' then memNotebook.Clear;
  // У SaveDialog забираємо ім'я файлу. Це буде означати, що файл не збережено:
  savDlg.FileName:= '';
end;

// Виклик меню "Файл -> Вихід":
procedure TfMain.mFileExitClick(Sender: TObject);
begin
  Close;
end;

// Виклик меню "Файл -> Відкрити":
procedure TfMain.mFileOpenClick(Sender: TObject);
var
  pos: Integer;
begin
  // Перевірка необхідності збереження файлу, як у "Файл -> Створити":
  if memNotebook.Modified then Begin // зміни є
    // Якщо користувач згідний зберегти зміни:
    if MessageDlg('Збереження файлу',
                  'Поточний файл був змінений. Зберегти зміни?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
    // Видаляємо символ/символи перенесення строки в кінці тексту:
    memNotebook.Text:= TrimRight(memNotebook.Text);
    // Копіюємо ім'я файлу в діалог SaveDialog, щоб потім знати куди зберігати:
    savDlg.FileName:= opnDlg.FileName;
  end; // if
end;

// Виклик меню "Файл -> Зберегти як ...":
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

// Виклик меню "Файл -> Зберегти":
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

// Виклик меню "Файл -> Статистика":
procedure TfMain.mFileStatClick(Sender: TObject);
begin
  fStats.Show;
end;

// Виклик меню "Формат -> Колір":
procedure TfMain.mFormatColorClick(Sender: TObject);
begin
  // Спочатку задаємо колір діалогу, як у memNotebook:
  clrDlg.Color:= memNotebook.Font.Color;
  // Задаємо заголовок:
  clrDlg.Title:= 'Вибір кольору';
  // Якщо діалог завершився успішно, змінюємо колір шрифту у memNotebook:
  if clrDlg.Execute then memNotebook.Font.Color:= clrDlg.Color;
end;

// Виклик меню "Формат -> Шрифт":
procedure TfMain.mFormatFontClick(Sender: TObject);
var
  c: TColor;
begin
  // Отримуємо колір шришту:
  c:= memNotebook.Font.Color;
  // Спочатку діалогу присвоюємо шрифт як у memNotebook:
  fntDlg.Font:= memNotebook.Font;
  // Задаємо заголовок:
  fntDlg.Title:= 'Вибір шрифту';
  // Якщо діалог завершився успішно, змінюємо шрифт у memNotebook:
  if fntDlg.Execute then begin
    memNotebook.Font:= fntDlg.Font;
    memNotebook.Font.Color:= c;
  end;
end;

end.

