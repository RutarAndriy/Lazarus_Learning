unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    ChG1: TCheckGroup;
    RG1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
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
  s: String; // Для формування строки із містами, які проголосували
begin
  // Визначаємо переможця
  if RG1.ItemIndex = 0 then
    ShowMessage('Ви вибрали П. Порошенка')
  else if RG1.ItemIndex = 1 then
    ShowMessage('Ви вибрали В. Зеленського')
  else if RG1.ItemIndex = 2 then
    ShowMessage('Ви вибрали Ю. Тимошенко')
  else if RG1.ItemIndex = 3 then
    ShowMessage('Ви вибрали С. Тігіпка')
  else
    ShowMessage('Ви вибрали Ю. Бойка');

  // Тепер потрібно що-небуть присвоїти змінній s, щоб ініціювати
  // її присвоїмо просто пусту строку:
  s:= '';

  // Тепер будемо збирати строку s, в залежності від включених прапорців,
  // після кожного рядка будемо вставляти знак переходу на новий рядок
  if ChG1.Checked[0] then s:= s + 'Львів проголосував' + #13;
  if ChG1.Checked[1] then s:= s + 'Київ проголосував' + #13;
  if ChG1.Checked[2] then s:= s + 'Одеса проголосувала' + #13;
  if ChG1.Checked[3] then s:= s + 'Харків проголосував' + #13;
  if ChG1.Checked[4] then s:= s + 'Дніпро проголосував' + #13;

  // Якщо хоч один прапорець увімкнений, то строка s не пуста,
  // відобразимо її у цьому випадку
  if s <> '' then ShowMessage(s);
end;

end.

