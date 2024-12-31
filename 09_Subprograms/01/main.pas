unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnOne: TButton;
    btnTwo: TButton;
    btnThree: TButton;
    btnFour: TButton;
    btnFive: TButton;
    edtNumber: TEdit;
    lblNumber: TLabel;
    procedure btnOneClick(Sender: TObject);
    procedure btnTwoClick(Sender: TObject);
    procedure btnThreeClick(Sender: TObject);
    procedure btnFourClick(Sender: TObject);
    procedure btnFiveClick(Sender: TObject);
  private
    procedure MyPrivat; // Попередньо об'явлена процедура
    procedure MyDouble; // Подвоєння глобальної змінної
  public

  end;

var
  fMain: TfMain;
  MyNum: Real; // глобальна змінна

implementation

{$R *.lfm}

{ TfMain }

// Процедура подвоює число і виводить результат на екран:
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

// Функція подвоює число і повертає результат:
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

// Процедура змінює вхідний параметр (зміна за посиланням):
procedure PodvoenjaZaPosylanjam(var r: Real);
begin
  r:= r * 2;
end;

// Натискання на 1-шу кнопку:
procedure TfMain.btnOneClick(Sender: TObject);
begin
  Podvoenja(edtNumber.Text);
end;

// Натискання на 2-гу кнопку:
procedure TfMain.btnTwoClick(Sender: TObject);
begin
  ShowMessage(FuncPodvoenja(edtNumber.Text));
end;

// Натискання на 3-тю кнопку:
procedure TfMain.btnThreeClick(Sender: TObject);
var
  myReal: Real;
begin
  myReal:= StrToFloat(edtNumber.Text);
  PodvoenjaZaPosylanjam(myReal);
  ShowMessage(FloatToStr(myReal));
end;

// Натискання на 4-ту кнопку:
procedure TfMain.btnFourClick(Sender: TObject);
begin
  MyPrivat;
end;

// Натискання на 5-ту кнопку:
procedure TfMain.btnFiveClick(Sender: TObject);
begin
  MyNum:= StrToFloat(edtNumber.Text);
  // Подвоїмо число
  MyDouble;
  // Виведемо результат на екран
  ShowMessage(FloatToStr(MyNum));
end;

// Приватна процедура форми TfMain яка має доступ до її змінних:
procedure TfMain.MyPrivat;
var
  r: Real;
begin
  // Перетворюємо у число те, що ввів користувач:
  r:= StrToFloat(edtNumber.Text);
  // Тепер подвоїмо його:
  r:= R * 2;
  // Тепер відобразимо результат у повідомленні:
  ShowMessage(FloatToStr(r));
end;

// Приватна процедура форми TfMain яка подвоює глобальну змінну:
procedure TfMain.MyDouble;
begin
  // Подвоюємо глобальну змінну
  MyNum:= MyNum * 2;
end;

end.

