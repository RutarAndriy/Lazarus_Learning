// Для коректного підвантаження бібліотеки необхідно покласти
// файл *.so (для Linux/Unix) або *.dll (для Windows) із попереднього
// проекту в корінь даного проекту.

unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  DynLibs;

type

  { TfMain }

  TfMain = class(TForm)
    btnBirthday: TButton;
    btnArToRom: TButton;
    btnRomToAr: TButton;
    btnCode: TButton;
    deBirthday: TDateEdit;
    edtText: TEdit;
    endNum: TEdit;
    lblBirthday: TLabel;
    lblNum: TLabel;
    lblText: TLabel;
    procedure btnArToRomClick(Sender: TObject);
    procedure btnBirthdayClick(Sender: TObject);
    procedure btnCodeClick(Sender: TObject);
    procedure btnRomToArClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  TCode = function(s: PChar; Key: integer): PChar; register;
  TBeforeBirthday = function(Birthday:TDateTime): Integer; cdecl;
  TArToRom = function(N: integer): PChar; stdcall;
  TRomToAr = function(s: PChar): Integer; stdcall;

const
{$ifdef windows}
  libname = 'FirstDLL.dll';
{$else}
  libname = 'libfirstdll.so';
{$endif}
var
  fMain: TfMain;
  Code: TCode;
  BeforeBirthday: TBeforeBirthday;
  ArToRom: TArToRom;
  RomToAr: TRomToAr;
  MyH: THandle = 0; // для дескриптору бібліотеки
  libPath: String;  // шлях до бібліотеки

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnBirthdayClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if deBirthday.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки FirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  BeforeBirthday:= TBeforeBirthday(GetProcAddress(MyH, 'BeforeBirthday'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @BeforeBirthday <> nil then
    ShowMessage('До дня народження залишилось ' +
    IntToStr(BeforeBirthday(deBirthday.Date)) + ' днів')
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.btnCodeClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if edtText.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки FirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  Code:= TCode(GetProcAddress(MyH, 'Code'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @Code <> nil then edtText.Text:= Code(PChar(edtText.Text), 10)
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.btnRomToArClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if endNum.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки FirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  RomToAr:= TRomToAr(GetProcAddress(MyH, 'RomToAr'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @RomToAr <> nil then
    endNum.Text:= IntToStr(RomToAr(PChar(endNum.Text)))
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  libPath:= ExtractFilePath(ParamStr(0)) + libname;
end;

procedure TfMain.btnArToRomClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if endNum.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки FirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  ArToRom:= TArToRom(GetProcAddress(MyH, 'ArToRom'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @ArToRom <> nil then endNum.Text:= ArToRom(StrToInt(endNum.Text))
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

end.

