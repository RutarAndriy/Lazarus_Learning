unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  Grids, Edit;

type

  { TfMain }

  TfMain = class(TForm)
    pnlButtons: TPanel;
    btnAdd: TSpeedButton;
    btnEdit: TSpeedButton;
    btnDel: TSpeedButton;
    btnSort: TSpeedButton;
    sgView: TStringGrid;
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
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

procedure TfMain.btnAddClick(Sender: TObject);
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
  sgView.RowCount:= sgView.RowCount + 1;
  sgView.Cells[0, sgView.RowCount-1]:= fEdit.eName.Text;
  sgView.Cells[1, sgView.RowCount-1]:= fEdit.ePhone.Text;
  sgView.Cells[2, sgView.RowCount-1]:= fEdit.CBNote.Text;
end;

procedure TfMain.btnDelClick(Sender: TObject);
begin
  // Якщо даних немає - виходимо:
  if sgView.RowCount = 1 then Exit;
  // Інакше виводимо запит на підтвердження:
  if MessageDlg('Необхідне підтвердження',
                'Ви справді хочете видалити контакт "' +
                sgView.Cells[0, sgView.Row] + '"?',
                mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
    sgView.DeleteRow(sgView.Row);
end;

procedure TfMain.btnEditClick(Sender: TObject);
begin
  // Якщо даних в сітці немає - просто виходимо:
  if sgView.RowCount = 1 then Exit;
  // Інакше записуємо дані у форму редактора:
  fEdit.eName.Text:= sgView.Cells[0, sgView.Row];
  fEdit.ePhone.Text:= sgView.Cells[1, sgView.Row];
  fEdit.CBNote.Text:= sgView.Cells[2, sgView.Row];
  // Встановлюємо ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  // Тепер виводимо форму:
  fEdit.ShowModal;
  // Зберігаємо в сітку можливі зміни, якщо користувач натиснув "Зберегти":
  if fEdit.ModalResult = mrOk then begin
    sgView.Cells[0, sgView.Row]:= fEdit.eName.Text;
    sgView.Cells[1, sgView.Row]:= fEdit.ePhone.Text;
    sgView.Cells[2, sgView.Row]:= fEdit.CBNote.Text;
    end;
end;

procedure TfMain.btnSortClick(Sender: TObject);
begin
  // Якщо даних в сітці немає - просто виходимо:
  if sgView.RowCount = 1 then exit;
  // Інакше сортуємо список:
  sgView.SortColRow(true, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts;    // для чергового запису
  f: file of Contacts; // файл даних
  i: Integer;          // лічильник циклу
begin
  // Якщо рядки даних пусті, просто виходимо:
  if sgView.RowCount = 1 then exit;
  // Інакше відкриваємо файл для запису:
  try
    AssignFile(f, adres + 'Telephones.dat');
    Rewrite(f);
    // Тепер цикл - від першого до останього запису сітки:
    for i:= 1 to sgView.RowCount-1 do begin
      // Отримуємо дані поточного запису:
      MyCont.Name:= sgView.Cells[0, i];
      MyCont.Phone:= sgView.Cells[1, i];
      MyCont.Note:= sgView.Cells[2, i];
      // Записуємо їх:
      Write(f, MyCont);
      end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts;    // для чергового запису
  f: file of Contacts; // файл даних
begin
  // Спочатку отримаємо шлях програми:
  adres:= ExtractFilePath(ParamStr(0));
  // Налаштуємо сітку:
  sgView.Cells[0, 0]:= 'Ім''я';
  sgView.Cells[1, 0]:= 'Телефон';
  sgView.Cells[2, 0]:= 'Нотатка';
  sgView.ColWidths[0]:= 365;
  sgView.ColWidths[1]:= 150;
  sgView.ColWidths[2]:= 150;
  // Якщо файлу даних немає, просто виходимо:
  if not FileExists(adres + 'Telephones.dat') then Exit;
  // Інакше файл є, відкриваємо його для читання і зчитуємо дані в сітку:
  try
    AssignFile(f, adres + 'Telephones.dat');
    Reset(f);
    // Тепер цикл - від першого до останього запису сітки:
    while not Eof(f) do begin
    // Зчитуємо потрібний запис:
    Read(f, MyCont);
    // Додаємо в сітку новий рядок, і заповнюємо його:
    sgView.RowCount:= sgView.RowCount + 1;
    sgView.Cells[0, sgView.RowCount-1]:= MyCont.Name;
    sgView.Cells[1, sgView.RowCount-1]:= MyCont.Phone;
    sgView.Cells[2, sgView.RowCount-1]:= MyCont.Note;
    end;
  finally
    CloseFile(f);
  end;
end;

end.

