unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnTest: TButton;
    procedure btnTestClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnTestClick(Sender: TObject);
var
  i: Integer;
  st: TStringList;
begin
  // Створюємо список рядків:
  st:= TStringList.Create;
  try
    // Генеруємо список для налагоджування:
    for i:= -3 to 3 do begin
      st.Append('10/' + IntToStr(i) + '=' + FloatToStr(10 / i));
    end;
    // Виводимо список на екран:
    ShowMessage(st.Text);
  finally
    // st буде очищена навіть у випадку run-time помилки:
    st.Free;
  end;
end;

end.

