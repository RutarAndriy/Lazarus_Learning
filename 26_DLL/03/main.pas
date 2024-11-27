unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  dynlibs;

type

  { TfMain }

  TfMain = class(TForm)
    bBeforeBirthday: TButton;
    bArToRom: TButton;
    bRomToAr: TButton;
    bCode: TButton;
    DE1: TDateEdit;
    eCode: TEdit;
    eNumbers: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure bArToRomClick(Sender: TObject);
    procedure bBeforeBirthdayClick(Sender: TObject);
    procedure bCodeClick(Sender: TObject);
    procedure bRomToArClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

type
  TCode = function(s: PChar; Key: integer): PChar; stdcall;
  TBeforeBirthday = function(Birthday:TDateTime): Integer; stdcall;
  TArToRom = function(N: integer): PChar; stdcall;
  TRomToAr = function(s: PChar): Integer; stdcall;

const
{$ifdef windows}
  libname = 'MyFirstDLL.dll';
{$else}
  libname = 'libmyfirstdll.so';
{$endif}
var
  fMain: TfMain;
  MyH: THandle = 0; // для дескриптору бібліотеки
  Code: TCode;
  BeforeBirthday: TBeforeBirthday;
  ArToRom: TArToRom;
  RomToAr: TRomToAr;
  libPath: String; // Шлях до бібліотеки

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bBeforeBirthdayClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if DE1.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки MyFirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  BeforeBirthday:= TBeforeBirthday(GetProcAddress(MyH, 'BeforeBirthday'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @BeforeBirthday <> nil then
    ShowMessage('До дня народження залишилось ' +
    IntToStr(BeforeBirthday(DE1.Date)) + ' днів')
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.bCodeClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if eCode.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки MyFirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  Code:= TCode(GetProcAddress(MyH, 'Code'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @Code <> nil then eCode.Text:= Code(PChar(eCode.Text), 10)
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.bRomToArClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if eNumbers.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки MyFirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  RomToAr:= TRomToAr(GetProcAddress(MyH, 'RomToAr'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @RomToAr <> nil then
    eNumbers.Text:= IntToStr(RomToAr(PChar(eNumbers.Text)))
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  libPath:= ExtractFilePath(ParamStr(0)) + libname;
end;

procedure TfMain.bArToRomClick(Sender: TObject);
begin
  // Виходимо, якщо пусто:
  if eNumbers.Text = '' then Exit;
  // Відкриваємо бібліотеку і отримуємо її дескриптор:
  MyH:= LoadLibrary(libPath);
  // Виходимо, якщо помилка:
  if MyH = 0 then begin
    ShowMessage('Помилка відкривання бібліотеки MyFirstDLL');
    Exit;
  end;
  // Отримуємо адрес потрібної функції:
  ArToRom:= TArToRom(GetProcAddress(MyH, 'ArToRom'));
  // Якщо функція прочиталася, рахуємо, інакше виходимо:
  if @ArToRom <> nil then eNumbers.Text:= ArToRom(StrToInt(eNumbers.Text))
  else ShowMessage('Потрібна функція відсутня в бібліотеці');
  // Вивантажуємо бібліотеку із пам'яті:
  FreeLibrary(MyH);
end;

end.

