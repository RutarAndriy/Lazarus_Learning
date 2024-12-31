unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnBool: TButton;
    btnRadio: TButton;
    cbFlag: TCheckBox;
    rbOne: TRadioButton;
    rbTwo: TRadioButton;
    rbThree: TRadioButton;
    rbFour: TRadioButton;
    rbFive: TRadioButton;
    procedure btnBoolClick(Sender: TObject);
    procedure btnRadioClick(Sender: TObject);
    procedure cbFlagChange(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnBoolClick(Sender: TObject);
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

procedure TfMain.btnRadioClick(Sender: TObject);
begin
  if rbOne.Checked then
    ShowMessage('Ви вибрали радіокнопку №1')
  else if rbTwo.Checked then
    ShowMessage('Ви вибрали радіокнопку №2')
  else if rbThree.Checked then
    ShowMessage('Ви вибрали радіокнопку №3')
  else if rbFour.Checked then
    ShowMessage('Ви вибрали радіокнопку №4')
  else
    ShowMessage('Ви вибрали радіокнопку №5')
end;

procedure TfMain.cbFlagChange(Sender: TObject);
begin
  if cbFlag.Checked then
    ShowMessage('Наш прапорець увімкнутий!')
  else
    ShowMessage('Наш прапорець вимкнений!');
end;

end.

