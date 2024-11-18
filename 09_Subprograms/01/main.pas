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
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure MyPrivat; // Попередньо об'явлена процедура
    procedure MyDouble; // Подвоєння глобальної змінної
  public

  end;

var
  fMain: TfMain;
  MyNum: Real;

implementation

{$R *.lfm}

{ TfMain }

procedure Podvoenja(st: String);
var
  r: Real;
begin
  // Отриману строку перетворюємо в число:
  r:= StrToFloat(st);
  // Тепер подвоїмо його:
  r:= R * 2;
  // Тепер відобразимо результат у повідомленні:
  ShowMessage(FloatToStr(r));
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  Podvoenja(Edit1.Text);
end;

function FuncPodvoenja(st: String): String;
var
  r: Real;
begin
  // Отриману строку перетворюємо в число:
  r:= StrToFloat(st);
  // Тепер подвоїмо його:
  r:= R * 2;
  // Тепер повернемо результат у вигляді строки::
  Result:= FloatToStr(r);
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  ShowMessage(FuncPodvoenja(Edit1.Text));
end;

procedure PodvoenjaZaPosylanjam(var r: Real);
begin
  r:= r * 2;
end;

procedure TfMain.Button3Click(Sender: TObject);
var
  myReal: Real;
begin
  myReal:= StrToFloat(Edit1.Text);
  PodvoenjaZaPosylanjam(myReal);
  ShowMessage(FloatToStr(myReal));
end;

procedure TfMain.Button4Click(Sender: TObject);
begin
  MyPrivat;
end;

procedure TfMain.Button5Click(Sender: TObject);
begin
  MyNum:= StrToFloat(Edit1.Text);
  // Подвоїмо число
  MyDouble;
  // Виведемо результат на екран
  ShowMessage(FloatToStr(MyNum));
end;

procedure TfMain.MyPrivat;
var
  r: Real;
begin
  // Перетворюємо у число те, що ввів користувач:
  r:= StrToFloat(Edit1.Text);
  // Тепер подвоїмо його:
  r:= R * 2;
  // Тепер відобразимо результат у повідомленні:
  ShowMessage(FloatToStr(r));
end;

procedure TfMain.MyDouble;
begin
  // Подвоюємо глобальну змінну
  MyNum:= MyNum * 2;
end;

end.

