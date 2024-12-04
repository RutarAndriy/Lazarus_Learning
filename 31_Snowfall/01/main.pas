unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Math, LCLType;

const
  SnowflakeCount = 400; // кількість сніжинок

type
  // Об'єкт-сніжинка:
  TSnowflake = record
    X: Single;         // координата X
    Y: Single;         // координата Y
    Speed: Single;     // швидкість падіння
    Size: Integer;     // розмір
    Time: Single;      // час падіння
    TimeDelta: Single; // коеф. зміни часу
  end;

  { TfMain }

  TfMain = class(TForm)
    RepaintTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure RepaintTimerTimer(Sender: TObject);
  private
    // Фонове зображення:
    BackgroundImage: TPortableNetworkGraphic;
    // Розміри фонового зображення:
    BackgroundRect: TRect;
    // Кількість кадрів за секунду:
    FPS: Integer;
    // Відображення FPS:
    ShowFPS: Boolean;
    // Час останнього вимірювання FPS:
    lastTime: Integer;
    // Кількість "тіків":
    tick: Integer;
    // Масив сніжинок:
    Snow: array [0..SnowflakeCount - 1] of TSnowflake;
    // Метод для створення нової сніжинки:
    function MakeSnowflake: TSnowflake;
    // Метод для створення всіх сніжинок:
    procedure MakeSnow;
    // Оновлення сніжинок:
    procedure UpdateSnow;
  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormPaint(Sender: TObject);
var
  X, Y, Size, i: Integer;
  ScaleCoef, DeltaX, t: Single;
begin
  // Якщо завантажено фонове зображення - малюємо його:
  if BackgroundImage <> nil
  // Розрахунок пропорцій зображення:
  then begin
    // Якщо ширина форми є більшою ніж висота:
    if ClientWidth > ClientHeight then begin
      ScaleCoef:= ClientHeight / BackgroundImage.Height;
      if BackgroundImage.Width * ScaleCoef < ClientWidth then
        ScaleCoef:= ClientWidth / BackgroundImage.Width;
      end
    // Якщо висота форми є більшою ніж ширина:
    else begin
      ScaleCoef:= ClientWidth / BackgroundImage.Width;
      if BackgroundImage.Height * ScaleCoef < ClientHeight then
        ScaleCoef:= ClientHeight / BackgroundImage.Height;
    end;

    //if BackgroundImage.Width > BackgroundImage.Height
    //  then MaxImage:= BackgroundImage.Width
    //  else MaxImage:= BackgroundImage.Height;

    BackgroundRect.Width:= Trunc(BackgroundImage.Width * ScaleCoef);
    BackgroundRect.Height:= Trunc(BackgroundImage.Height * ScaleCoef);

    //BackgroundRect.Width:= 200;
    //BackgroundRect.Height:= 150;
    // Задаємо позицію зображення:
    BackgroundRect.SetLocation(
      Trunc(ClientWidth/2 - BackgroundRect.Width/2),
      Trunc(ClientHeight/2 - BackgroundRect.Height/2));
    // Малюємо фонове зображення:
    Canvas.StretchDraw(BackgroundRect, BackgroundImage)
  end
  else begin
    // Замальовуємо всю форму чорним кольором:
    Canvas.Brush.Color:= clBlack;
    Canvas.FillRect(0, 0, ClientWidth, ClientHeight);
  end;
  // Задаємо колір та стиль малювання:
  Canvas.Pen.Style:= psClear;
  Canvas.Brush.Color:= clWhite;
  // Малюємо сніжинки:
  for i:= 0 to High(Snow) do begin
    // Отримуємо розмір сніжинки:
    Size:= Snow[i].Size;
    // Отримуємо час падіння сніжинки:
    t:= Snow[i].Time;
    // Розраховуємо зміщення сніжинки залежно від часу її падіння:
    DeltaX:= Sin(t * 27) +
             Sin(t * 21.3) +
             Sin(t * 18.75) * 3 +
             Sin(t * 7.6) * 7 +
             Sin(t * 5.23) * 10;
    DeltaX:= DeltaX * 10;
    // Задаємо координату X:
    X:= Trunc(Snow[i].X + DeltaX);
    // Задаємо координату Y:
    Y:= Trunc(Snow[i].Y);
    // малюємо сніжинку:
    Canvas.Ellipse(X, Y, X + Size, Y + Size);
  end;
  if ShowFPS then begin
    // Вимірюємо FPS:
    if (GetTickCount64 - lastTime > 1000) then begin
      lastTime:= GetTickCount64;
      FPS:= tick;
      tick:= 0;
    end else
      tick:= tick + 1;
    Canvas.Brush.Color := clBlack;
    Canvas.Font.Color := clWhite;
    Canvas.TextOut(3, 3, 'FPS: ' + IntToStr(FPS));
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Створюємо об'єкт-зображення:
  BackgroundImage:= TPortableNetworkGraphic.Create;
  try
    // Намагаємося завантажити зображення:
    BackgroundImage.LoadFromFile('./Background.png');
    BackgroundRect.Create(0, 0, 0, 0);
  except
    // Очищуємо BackgroundImage, якщо при завантаженні відбулася помилка:
    FreeAndNil(BackgroundImage);
  end;
  // Створюємо сніжинки:
  MakeSnow;
  // За замовчуванням FPS не відображаються:
  ShowFPS:= False;
  // Задаємо час останного вимірювання FPS:
  lastTime:= GetTickCount64;
  // Задаємо кількість "тіків":
  tick:= 0;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  // Очищуємо зображення якщо воно ініціалізоване:
  if BackgroundImage <> nil then BackgroundImage.Destroy;
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При натисненні Ctrl+F відображаємо/проховуємо FPS:
  if (Key = VK_F) and (ssCtrl in Shift) then
    ShowFPS:= not ShowFPS;
end;

procedure TfMain.RepaintTimerTimer(Sender: TObject);
begin
  UpdateSnow;
  Invalidate;
end;

function TfMain.MakeSnowflake: TSnowflake;
const
  MaxSpeed = 5;
  MaxSize = 9;
  MaxTimeDelta = 0.0015;
  Bounds = 30;
begin
  // Задаємо випадкову координату по X:
  Result.X:= RandomRange(-Bounds, ClientWidth + Bounds);
  // Задаємо координату по X:
  Result.Y:= -MaxSize * 3;
  // Задаємо випадкову швидкість падіння:
  Result.Speed:= 0.5 + Random * MaxSpeed;
  // Задаємо випадковий розмір сніжинки:
  Result.Size:= RandomRange(2, MaxSize);
  // Задаємо випадковий час падіння зніжинки:
  Result.Time:= Random * Pi;
  // Задаємо випадкове збільшення часу падіння сніжинки:
  Result.TimeDelta:= Random * MaxTimeDelta;
end;

procedure TfMain.MakeSnow;
var
  i: Integer;
begin
  for i:= 0 to High(Snow) do
    Snow[i]:= MakeSnowflake;
end;

procedure TfMain.UpdateSnow;
var
  i: Integer;
begin
  for i:= 0 to High(Snow) do begin
    // Збільшуємо координати по Y:
    Snow[i].Y:= Snow[i].Y + Snow[i].Speed;
    // Збільшуємо час падіння сніжинки:
    Snow[i].Time:= Snow[i].Time + Snow[i].TimeDelta;
    // Створюємо заново сніжинку, якщо вона впала за межі форми:
    if Snow[i].Y > ClientHeight then
      Snow[i]:= MakeSnowflake;
  end;
end;

end.

