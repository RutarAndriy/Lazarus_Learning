unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, Edit;

type

  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    bAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  Contacts = record
    Name: String[100];
    Phone: String[20];
    Note: String[20];
  end; // record

var
  fMain: TfMain;
  adres: String; // шлях, звідки запущена програма

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bAddClick(Sender: TObject);
begin
  // Очищуємо поля, якщо там що-небуть є:
  fEdit.eName.Text:= '';
  fEdit.ePhone.Text:= '';
  // Встановлюємо ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  // Тепер виводимо форму:
  fEdit.ShowModal;
  // Якщо користувач нічого не ввів - виходимо:
  if (fEdit.eName.Text= '') or (fEdit.ePhone.Text= '') then Exit;
  // Якщо користувач не натиснув "Зберегти" - виходимо:
  if fEdit.ModalResult <> mrOk then Exit;
  // Інакше додаємо в сітку рядок, та заповнюємо його:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.ePhone.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.CBNote.Text;
end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  // Якщо даних немає - виходимо:
  if SG.RowCount = 1 then Exit;
  // Інакше виводимо запит на підтвердження:
  if MessageDlg('Необхідне підтвердження',
                'Ви справді хочете видалити контакт "' +
                SG.Cells[0, SG.Row] + '"?',
                mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
    SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
  // Якщо даних в сітці немає - просто виходимо:
  if SG.RowCount = 1 then Exit;
  // Інакше записуємо дані у форму редактора:
  fEdit.eName.Text:= SG.Cells[0, SG.Row];
  fEdit.ePhone.Text:= SG.Cells[1, SG.Row];
  fEdit.CBNote.Text:= SG.Cells[2, SG.Row];
  // Встановлюємо ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  // Тепер виводимо форму:
  fEdit.ShowModal;
  // Зберігаємо в сітку можливі зміни, якщо користувач натиснув "Зберегти":
  if fEdit.ModalResult = mrOk then begin
    SG.Cells[0, SG.Row]:= fEdit.eName.Text;
    SG.Cells[1, SG.Row]:= fEdit.ePhone.Text;
    SG.Cells[2, SG.Row]:= fEdit.CBNote.Text;
    end;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  // Якщо даних в сітці немає - просто виходимо:
  if SG.RowCount = 1 then exit;
  // Інакше сортуємо список:
  SG.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts; // для чергового запису
  f: file of Contacts; // файл даних
  i: Integer; // лічильник циклу
begin
  // Якщо рядки даних пусті, просто виходимо:
  if SG.RowCount = 1 then exit;
  // Інакше відкриваємо файл для запису:
  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);
    // Тепер цикл - від першого до останього запису сітки:
    for i:= 1 to SG.RowCount-1 do begin
      // Отримуємо дані поточного запису:
      MyCont.Name:= SG.Cells[0, i];
      MyCont.Phone:= SG.Cells[1, i];
      MyCont.Note:= SG.Cells[2, i];
      // Записуємо їх:
      Write(f, MyCont);
      end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts; // для чергового запису
  f: file of Contacts; // файл даних
  i: Integer; // лічильник циклу
begin
  // Спочатку отримаємо шлях програми:
  adres:= ExtractFilePath(ParamStr(0));
  // Налаштуємо сітку:
  SG.Cells[0, 0]:= 'Ім''я';
  SG.Cells[1, 0]:= 'Телефон';
  SG.Cells[2, 0]:= 'Нотатка';
  SG.ColWidths[0]:= 365;
  SG.ColWidths[1]:= 150;
  SG.ColWidths[2]:= 150;
  // Якщо файлу даних немає, просто виходимо:
  if not FileExists(adres + 'telephones.dat') then Exit;
  // Інакше файл є, відкриваємо його для читання і зчитуємо дані в сітку:
  try
    AssignFile(f, adres + 'telephones.dat');
    Reset(f);
    // Тепер цикл - від першого до останього запису сітки:
    while not Eof(f) do begin
    // Зчитуємо потрібний запис:
    Read(f, MyCont);
    // Додаємо в сітку новий рядок, і заповнюємо його:
    SG.RowCount:= SG.RowCount + 1;
    SG.Cells[0, SG.RowCount-1]:= MyCont.Name;
    SG.Cells[1, SG.RowCount-1]:= MyCont.Phone;
    SG.Cells[2, SG.RowCount-1]:= MyCont.Note;
    end;
  finally
    CloseFile(f);
  end;
end;

end.

