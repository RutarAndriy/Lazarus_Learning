// Для запуску на Linux та Unix необхідно вказати директорію із бібліотекою,
// наприклад це можна зробити так:
// export LD_LIBRARY_PATH=/path/to/library

unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn;

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
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}
function Code(s: PChar; Key: integer): PChar; register;
         external 'myfirstdll';
function BeforeBirthday(Birthday:TDateTime): Integer; register;
         external 'myfirstdll';
function ArToRom(N: Integer): PChar; register;
         external 'myfirstdll';
function RomToAr(s: PChar): Integer; register;
         external 'myfirstdll';

{ TfMain }

procedure TfMain.bBeforeBirthdayClick(Sender: TObject);
begin
  if DE1.Text = '' then Exit;
  ShowMessage('До дня народження залишилось ' +
              IntToStr(BeforeBirthday(DE1.Date)) + ' днів');
end;

procedure TfMain.bCodeClick(Sender: TObject);
begin
  if eCode.Text = '' then Exit;
  eCode.Text:= Code(PChar(eCode.Text), 10);
end;

procedure TfMain.bRomToArClick(Sender: TObject);
begin
  if eNumbers.Text = '' then Exit;
  eNumbers.Text:= IntToStr(RomToAr(PChar(eNumbers.Text)));
end;

procedure TfMain.bArToRomClick(Sender: TObject);
begin
  if eNumbers.Text = '' then Exit;
  eNumbers.Text:= ArToRom(StrToInt(eNumbers.Text));
end;

end.

