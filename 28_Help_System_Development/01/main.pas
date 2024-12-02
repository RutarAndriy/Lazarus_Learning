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
    CD: TColorDialog;
    FD: TFontDialog;
    FileMenu: TMenuItem;
    FileCreate: TMenuItem;
    FileOpen: TMenuItem;
    FileSave: TMenuItem;
    FileSaveAs: TMenuItem;
    FileExit: TMenuItem;
    EditMenu: TMenuItem;
    EditUndo: TMenuItem;
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
    FileStat: TMenuItem;
    EditRedo: TMenuItem;
    HelpHelp: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    MM: TMainMenu;
    Memo1: TMemo;
    OD: TOpenDialog;
    SD: TSaveDialog;
    N5: TMenuItem;
    procedure CoderCodeClick(Sender: TObject);
    procedure CoderDecodeClick(Sender: TObject);
    procedure EditRedoClick(Sender: TObject);
    procedure EditUndoClick(Sender: TObject);
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
    procedure FileStatClick(Sender: TObject);
    procedure FormatColorClick(Sender: TObject);
    procedure FormatFontClick(Sender: TObject);
    procedure FormatWordWrapClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure HelpAboutClick(Sender: TObject);
    procedure HelpHelpClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

const
  historyLimit = 25;
var
  fMain: TfMain; // головна форма
  history: array of String; // масив історії
  historyIndex: Integer; // індекс історії
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
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                    FileSaveClick(Sender);
  end; // if
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Ініціалізуємо масив історії
  SetLength(history, 1);
  // Ініціалізуємо індекс історії
  historyIndex:= 0;
  // Ініціалізуємо змінну редагування історії
  historyUndoRedo:= False;
end;

procedure TfMain.HelpAboutClick(Sender: TObject);
begin
  fAbout.ShowModal;
end;

procedure TfMain.HelpHelpClick(Sender: TObject);
begin
  {$ifdef windows}
  // Викликаємо довідку на ОС Windows:
  WinExec('hh.exe CodeBook.chm', SW_SHOW);
  {$else}
  // На інших ОС відображаємо повідомлення про помилку:
  ShowMessage('Довідка у форматі *.chm доступна' + #13 +
              'лише для ОС Windows');
  {$endif}
end;

procedure TfMain.Memo1Change(Sender: TObject);
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
    history[historySize]:= Memo1.Lines.Text;
    // Даємо можливість відмінити зміни:
    EditUndo.Enabled:= True;
  end;

  // Рахуємо символи:
  fStats.CharsCount.Caption:= IntToStr(UTF8Length(Memo1.Text));
  // Рахуємо слова:
  fStats.WordsCount.Caption:= IntToStr(WordCount(Memo1.Text, StdWordDelims));
  // Рахуємо рядки:
  fStats.LinesCount.Caption:= IntToStr(Memo1.Lines.Count);
end;

procedure TfMain.EditUndoClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  // Memo1.Undo;
  // Задіємо власну реалізацію:
  if historyIndex > 0 then begin
    // Зменшуємо індекс історіх на одиницю:
    Dec(historyIndex, 1);
    // Якщо ми на початку історії, то відміна неможлива:
    if historyIndex = 0 then EditUndo.Enabled:= False;
    // Вказуємо на зміни:
    historyUndoRedo:= True;
    EditRedo.Enabled:= True;
    // Вносимо зміни:
    Memo1.Lines.Text:= history[historyIndex];
    Memo1.SelStart:=Memo1.Lines.Text.Length;
  end;
end;

procedure TfMain.CoderCodeClick(Sender: TObject);
var
  key: String;
begin
  // Запитуємо пароль і шифруємо текст:
  key:= '';
  if InputQuery('Ввід ключа', 'Введіть ключове слово (фразу):', key)
     and (key <> '') then
       Memo1.Text:= Encrypt(Memo1.Text, key);
end;

procedure TfMain.CoderDecodeClick(Sender: TObject);
var
  key: String;
begin
  // Запитуємо пароль і розшифровуємо текст:
  key:= '';
  if InputQuery('Ввід ключа', 'Введіть ключове слово (фразу):', key)
     and (key <> '') then
       Memo1.Text:= Decrypt(Memo1.Text, key);
end;

procedure TfMain.EditRedoClick(Sender: TObject);
begin
  // Дана функція ще не реалізована для компонента TMemo:
  // Memo1.Redo;
  // Задіємо власну реалізацію:
  if historyIndex < High(history) then begin
    // Збільшуємо індекс історіх на одиницю:
    Inc(historyIndex, 1);
    // Якщо ми на кінці історії, то повторення неможливе:
    if historyIndex = Length(history) - 1 then EditRedo.Enabled:= False;
    // Вказуємо на зміни:
    historyUndoRedo:= True;
    EditUndo.Enabled:= True;
    // Вносимо зміни:
    Memo1.Lines.Text:= history[historyIndex];
    Memo1.SelStart:=Memo1.Lines.Text.Length;
  end;
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
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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

procedure TfMain.FileStatClick(Sender: TObject);
begin
  fStats.Show;
end;

procedure TfMain.FormatColorClick(Sender: TObject);
begin
  // Спочатку задаємо колір діалогу, як у Memo1:
  CD.Color:= Memo1.Font.Color;
  // Задаємо заголовок:
  CD.Title:= 'Вибір кольору';
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
  // Задаємо заголовок:
  FD.Title:= 'Вибір шрифту';
  // Якщо діалог завершився успішно, змінюємо шрифт у Memo1:
  if FD.Execute then begin
    Memo1.Font:= FD.Font;
    Memo1.Font.Color:= c;
  end;
end;

end.

