unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnResult: TButton;
    cgSities: TCheckGroup;
    rgCandidates: TRadioGroup;
    procedure btnResultClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnResultClick(Sender: TObject);
var
  s: String; // Для формування строки із містами, які проголосували
begin
  // Визначаємо переможця:
  if rgCandidates.ItemIndex = 0 then
    ShowMessage('Ви вибрали П. Порошенка')
  else if rgCandidates.ItemIndex = 1 then
    ShowMessage('Ви вибрали В. Зеленського')
  else if rgCandidates.ItemIndex = 2 then
    ShowMessage('Ви вибрали Ю. Тимошенко')
  else if rgCandidates.ItemIndex = 3 then
    ShowMessage('Ви вибрали С. Тігіпка')
  else
    ShowMessage('Ви вибрали Ю. Бойка');

  // Тепер потрібно що-небуть присвоїти змінній s, щоб ініціювати
  // її присвоїмо їй пусту строку:
  s:= '';

  // Тепер будемо збирати строку s, в залежності від включених прапорців,
  // після кожного рядка будемо вставляти знак переходу на новий рядок:
  if cgSities.Checked[0] then s:= s + 'Львів проголосував' + #13;
  if cgSities.Checked[1] then s:= s + 'Київ проголосував' + #13;
  if cgSities.Checked[2] then s:= s + 'Одеса проголосувала' + #13;
  if cgSities.Checked[3] then s:= s + 'Харків проголосував' + #13;
  if cgSities.Checked[4] then s:= s + 'Дніпро проголосував' + #13;

  // Якщо хоч один прапорець увімкнений, то строка s не пуста,
  // відобразимо її у цьому випадку:
  if s <> '' then ShowMessage(s);
end;

end.

