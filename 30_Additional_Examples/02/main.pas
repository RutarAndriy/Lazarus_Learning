unit Main;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormSleep }

  TFormSleep = class(TForm)
    ButtonTest: TButton;
    ButtonSleep: TButton;
    procedure ButtonSleepClick(Sender: TObject);
    procedure ButtonTestClick(Sender: TObject);
  private

  public

  end;

var
  FormSleep: TFormSleep;

implementation

{$R *.lfm}

{ TFormSleep }

procedure TFormSleep.ButtonSleepClick(Sender: TObject);
begin
  // Призупиняємо головний потік, інтерфейс "зависає" на 60 сек.:
  Sleep(60000);
end;

procedure TFormSleep.ButtonTestClick(Sender: TObject);
begin
  // Виводимо просте повідомлення:
  ShowMessage('Ви натиснули кнопку Test!');
end;

end.

