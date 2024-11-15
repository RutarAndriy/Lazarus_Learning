unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ChB1: TCheckBox;
    RB1: TRadioButton;
    RB2: TRadioButton;
    RB3: TRadioButton;
    RB4: TRadioButton;
    RB5: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ChB1Change(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.Button1Click(Sender: TObject);
var
  a,b: Boolean;
begin
  a:= False;
  b:= True;

  if a then
    ShowMessage('Дія №1')
  else if b then
    ShowMessage('Дія №2')
  else if a or b then
    ShowMessage('Дія №3')
  else
    ShowMessage('Дія №4');

  if not a then begin
    ShowMessage('Дія №1');
    ShowMessage('Дія №2');
    ShowMessage('Дія №3');
  end;

end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  if RB1.Checked then
    ShowMessage('Ви вибрали радіокнопку №1')
  else if RB2.Checked then
    ShowMessage('Ви вибрали радіокнопку №2')
  else if RB3.Checked then
    ShowMessage('Ви вибрали радіокнопку №3')
  else if RB4.Checked then
    ShowMessage('Ви вибрали радіокнопку №4')
  else
    ShowMessage('Ви вибрали радіокнопку №5')
end;

procedure TfMain.ChB1Change(Sender: TObject);
begin
  if ChB1.Checked then
    ShowMessage('Наш прапорець увімкнутий!')
  else
    ShowMessage('Наш прапорець вимкнений!');
end;

end.

