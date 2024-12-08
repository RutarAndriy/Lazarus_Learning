unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    RefreshTimer: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
  private
    Screenshot: TBitmap;
  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

uses
  LCLType, LCLIntf;

// Функція для отримання скріншоту екрану:
function TakeScreenshot: TBitmap;
var
  ScreenDC: HDC;
  ScreenBitmap: TBitmap;
begin
  Result := nil;
  ScreenDC := 0;
  // Створюємо ScreenBitmap для захоплення екрану:
  ScreenBitmap := TBitmap.Create;
  try
    // Отримуємо контекст екрану:
    ScreenDC := GetDC(0);
    // Завантажуємо в ScreenBitmap скріншот екрану:
    ScreenBitmap.LoadFromDevice(ScreenDC);
    // Створюємо Result для збереження скріншоту, в "натівному" форматі lcl,
    // оскільки на linux/osx формат зображення захопленого з допомогою
    // LoadFromDevice може бути не "натівним" для lcl - його відмальовування
    // може бути повільним:
    Result := TBitmap.Create;
    try
      // Змінюємо розміри Result під розміри скріншоту:
      Result.SetSize(ScreenBitmap.Width, ScreenBitmap.Height);
      // Малюємо скріншот на Result:
      Result.Canvas.Draw(0, 0, ScreenBitmap);
    except
      // Що-небуть пішло не так, знищуємо Result та кидаємо виняток:
      Result.Free;
      raise;
    end;
  finally
    ScreenBitmap.Free;
    ReleaseDC(0, ScreenDC);
  end;
end;

{ TfMain }

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= caNone;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Затримка перед запуском ефекту:
  Sleep(5000);
  // Робимо скріншот екрану:
  Screenshot:= TakeScreenshot;
  // Забираємо рамку форми:
  BorderStyle:= bsNone;
  // Робимо вікно розгорнутим на весь екран:
  WindowState:= wsFullScreen;
  // Відображаємо вікно над усіма іншими вікнами:
  FormStyle:= fsSystemStayOnTop;
  // Вимикаємо курсор:
  Cursor:= crNone;
  // Заливаємо форму чорним кольором:
  Color:= clBlack;
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При натисканні Ctrl+Z виходимо із програми:
  if (Key = VK_Z) and (ssCtrl in Shift) then Halt;
end;

procedure TfMain.FormPaint(Sender: TObject);
var
  i, j: Integer;
  SpanX, SpanY, SpanHeight: Integer;
begin
  // Малюємо фон:
  if Random(31) <> 0 then
    Canvas.Draw(Random(11) - 5, 0, Screenshot)
  else begin
    Canvas.Brush.Color:= clFuchsia;
    Canvas.FillRect(0, 0, Screenshot.Width, Screenshot.Height);
  end;
  Canvas.Brush.Color:= clBlack;

  // Малюємо відрізки:
  for i:= 0 to 11 do begin
    SpanHeight:= 4 + Random(120);
    if Random(5) = 0 then
      SpanX:= Random(121) - 60
    else
      SpanX:= Random(31) - 15;
    SpanY:= Random(Screenshot.Height);
    Canvas.FillRect(0, SpanY, Screenshot.Width, SpanY + SpanHeight);
    BitBlt(
      Canvas.Handle, // куди малюємо (на форму)
      SpanX, SpanY, // x та y на формі
      Screenshot.Width, SpanHeight, // ширина і висота фрагмента
      Screenshot.Canvas.Handle, // звідки малюємо (із скріншоту)
      0, SpanY, // x та y на скріншоті
      cmSrcCopy // просте копіювання пікселів
    );
  end;

  // Малюємо лінії:
  for j:= 0 to Random(7) do begin
    SpanY:= Random(Screenshot.Height);
    if Random(5) = 0 then
      Canvas.Pen.Color:= clFuchsia
    else
      Canvas.Pen.Color:= clLime;
    for i:= 0 to Random(40) do begin
      if Random(3) = 0 then
        Canvas.Line(
          0, SpanY, // x1, y1
          Screenshot.Width, SpanY + i // x2, y2
        );
    end;
  end;
end;

procedure TfMain.RefreshTimerTimer(Sender: TObject);
begin
  ShowOnTop;
  Invalidate;
end;

end.

