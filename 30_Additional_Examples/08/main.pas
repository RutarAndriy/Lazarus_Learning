unit Main;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormSleep }

  TFormSleep = class(TForm)
    btnTest: TButton;
    btnSleep: TButton;
    procedure btnSleepClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private

  public

  end;

var
  FormSleep: TFormSleep;

implementation

{$R *.lfm}

{ TFormSleep }

procedure TFormSleep.btnSleepClick(Sender: TObject);
begin
  // Призупиняємо головний потік, інтерфейс "зависає" на 60 сек.:
  Sleep(60000);
end;

procedure TFormSleep.btnTestClick(Sender: TObject);
begin
  // Виводимо просте повідомлення:
  ShowMessage('Ви натиснули кнопку Test!');
end;

end.

