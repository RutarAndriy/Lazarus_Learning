// Для запуску на Windows необхідно покласти *.dll із попереднього проекту в
// корінь даного проекту. Для запуску на Linux та Unix необхідно вказати
// директорію із бібліотекою, наприклад це можна зробити так:
// export LD_LIBRARY_PATH=/path/to/library

unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn;

type

  { TfMain }

  TfMain = class(TForm)
    btnBirthday: TButton;
    btnArToRom: TButton;
    btnRomToAr: TButton;
    btnCode: TButton;
    deBirthday: TDateEdit;
    edtText: TEdit;
    edtNum: TEdit;
    lblBirthday: TLabel;
    lblNum: TLabel;
    LlblText: TLabel;
    procedure btnArToRomClick(Sender: TObject);
    procedure btnBirthdayClick(Sender: TObject);
    procedure btnCodeClick(Sender: TObject);
    procedure btnRomToArClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}
function Code(s: PChar; Key: integer): PChar; register;
         external 'firstdll';
function BeforeBirthday(Birthday:TDateTime): Integer; cdecl;
         external 'firstdll';
function ArToRom(N: Integer): PChar; stdcall;
         external 'firstdll';
function RomToAr(s: PChar): Integer; stdcall;
         external 'firstdll';

{ TfMain }

procedure TfMain.btnBirthdayClick(Sender: TObject);
begin
  if deBirthday.Text = '' then Exit;
  ShowMessage('До дня народження залишилось ' +
              IntToStr(BeforeBirthday(deBirthday.Date)) + ' днів');
end;

procedure TfMain.btnCodeClick(Sender: TObject);
begin
  if edtText.Text = '' then Exit;
  edtText.Text:= Code(PChar(edtText.Text), 10);
end;

procedure TfMain.btnRomToArClick(Sender: TObject);
begin
  if edtNum.Text = '' then Exit;
  edtNum.Text:= IntToStr(RomToAr(PChar(edtNum.Text)));
end;

procedure TfMain.btnArToRomClick(Sender: TObject);
begin
  if edtNum.Text = '' then Exit;
  edtNum.Text:= ArToRom(StrToInt(edtNum.Text));
end;

end.

