unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  MaskEdit, LResources, LCLType;

type
  TDynReal = array of Real;

  { TfMain }

  TfMain = class(TForm)
    btnClean: TButton;
    btnStart: TButton;
    lblDistance: TLabel;
    lblSpeedF: TLabel;
    lblSpeedS: TLabel;
    lblSpeedFly: TLabel;
    edtDistance: TMaskEdit;
    edtSpeedF: TMaskEdit;
    edtSpeedS: TMaskEdit;
    edtSpeedFly: TMaskEdit;
    pnlDraw: TPanel;
    tUpdate: TTimer;
    procedure btnCleanClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure pnlDrawPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tUpdateTimer(Sender: TObject);
  private
    fTown: TPortableNetworkGraphic;
    sTown: TPortableNetworkGraphic;
    fTrain: TPortableNetworkGraphic;
    sTrain: TPortableNetworkGraphic;
    fFly: TPortableNetworkGraphic;
    sFly: TPortableNetworkGraphic;
    fly: TPortableNetworkGraphic;
    procedure resetAll;
    procedure setEnable(enable: Boolean);
    function flyProblem(distance,
                        fSpeed,
                        sSpeed,
                        flySpeed: Integer) : TDynReal;
  public

  end;

var
  fMain: TfMain;                 // головна форма
  valueDistance: Integer = 0;    // значення поля "Відстань між містами"
  valueFSpeed: Integer = 0;      // значення поля "Швидкість першого поїзда"
  valueSSpeed: Integer = 0;      // значення поля "Швидкість другого поїзда"
  valueFlySpeed: Integer = 0;    // значення поля "Швидкість мухи"
  answer: TDynReal;              // розв'язок задачі
  animationRun: Boolean = False; // якщо true - анімація виконується
  animationEnd: Boolean = False; // якщо true - анімація закінчилася
  phase: Integer;                // етап польоту мухи
  XfTrain: Real;                 // відстань пройдена першим поїздом
  XsTrain: Real;                 // відстань пройдена другим поїздом
  Xfly: Real;                    // абсолютна відстань, яку пролетіла муха
  flyDist: Real;                 // відносна відстань, яку пролетіла муха

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.setEnable(enable: Boolean);
begin
  edtDistance.Enabled:= enable;
  edtSpeedF.Enabled:= enable;
  edtSpeedS.Enabled:= enable;
  edtSpeedFly.Enabled:= enable;
  btnClean.Enabled:= enable;
end;

procedure TfMain.resetAll;
begin
  animationRun:= False;
  btnStart.Caption:= 'Розв''язати задачу';
  setEnable(True);
  XfTrain:= 0;
  XsTrain:= 0;
  Xfly:= 0;
  phase:= 0;
  flyDist:= 0;
  Invalidate;
end;

function TfMain.flyProblem(distance,
                           fSpeed,
                           sSpeed,
                           flySpeed: Integer) : TDynReal;
var
  flyTime: Real;     // час польоту мухи
  flyDist: Real;     // відстань польоту мухи
  remDist: Real;     // відстань, яка залишилася між поїздами
  runRight: Boolean; // напрямок руху
  resCount: Integer; // кількість пройдених шляхів
begin
  remDist:= distance; // залишкова відстань = загальна відстань
  runRight:= True;    // спочатку рухаємося вправо
  resCount:= 0;       // початкова кількість шляхів = 0
  Result:= nil;       // ініціалізація початкового результату

  while remDist > 1e-2 do
  begin
    if runRight // різні розрахунки в залежності від напрямку руху
      then
        begin
          runRight:= False;
          flyTime:= remDist / (flySpeed + sSpeed)
        end
      else
        begin
          runRight:= True;
          flyTime:= remDist / (flySpeed + fSpeed)
        end;
    flyDist:= flyTime * flySpeed; // отримання відстані польоту мухи
    remDist:= remDist - flyTime * (fSpeed + sSpeed); // залишкова відстань
    resCount:= Length(Result); // отриманя кількості шляхів
    SetLength(Result, resCount + 1); // збільшення масиву на 1
    Result[resCount]:= flyDist; // зберігання отриманого шляху
  end;
end;

procedure TfMain.pnlDrawPaint(Sender: TObject);
const
  time = 1 / 90;
var
  W, H: Integer; // ширина і висота панелі малювання
  sPoint, ePoint: Integer; // початкова і кінцева точки шляху
  dLenght: Integer; // відстань між містами в пікселях
  fX, sX, flyX: Integer; // координати I, II поїзда і мухи
  lineY: Integer; // висотна координата лінії шляху
begin

  // Отримуємо ширину і висоту панелі малювання:
  W:= pnlDraw.Width;
  H:= pnlDraw.Height;

  // Отримуємо початкову і кінцеву точку маршруту та відстань між ними:
  sPoint:= fTown.Width div 2 + W div 40;
  ePoint:= W - sTown.Width div 2 - W div 40;
  dLenght:= ePoint - sPoint;

  // Якщо анімація запущена, то виконуємо додаткові розрахунки:
  if animationRun then
  begin

    XfTrain:= XfTrain + valueFSpeed * time;
    XsTrain:= XsTrain + valueSSpeed * time;
    flyDist:= flyDist + valueFlySpeed * time;

    if phase mod 2 = 0 then
      // парна фаза:
      begin
        Xfly:= Xfly + valueFlySpeed * time;
        if flyDist > answer[phase] then
          begin
            flyDist:= 0;
            Xfly:= valueDistance - XsTrain;
            phase:= phase + 1;
          end;
      end
    else
      // непарна фаза:
      begin
        Xfly:= Xfly - valueFlySpeed * time;
        if flyDist > answer[phase] then
          begin
            flyDist:= 0;
            Xfly:= XfTrain;
            phase:= phase + 1;
          end;
      end;
  end;

  // На нуль ділити не можна, тому при значенні 0 змінюємо його на 1:
  if valueDistance = 0 then valueDistance:= 1;

  // Розраховуємо ккординати об'єктів:
  fX:=   Round(sPoint + XfTrain * dLenght / valueDistance);
  sX:=   Round(ePoint - XsTrain * dLenght / valueDistance);
  flyX:= Round(sPoint + Xfly    * dLenght / valueDistance);

  // Поїзди зустрілися між собою:
  if sX - fX < 3 then
    begin
      animationRun:= False;
      animationEnd:= True;
    end;

  // Допоміжна змінна:
  lineY:= Round(H*19/20);

  // Малюємо міста та маршрут поїздів:
  pnlDraw.Canvas.Draw(sPoint - fTown.Width div 2, H div 25, fTown);
  pnlDraw.Canvas.Draw(ePoint - sTown.Width div 2, H div 25, sTown);
  pnlDraw.Canvas.Pen.Color:= clGray;
  pnlDraw.Canvas.Pen.Width:= 2;
  pnlDraw.Canvas.Line(sPoint, lineY, ePoint, lineY);
  pnlDraw.Canvas.Brush.Color:= clBlack;
  pnlDraw.Canvas.Ellipse(sPoint - 4, lineY - 4, sPoint + 4, lineY + 4);
  pnlDraw.Canvas.Ellipse(ePoint - 4, lineY - 4, ePoint + 4, lineY + 4);

  // Малюємо перший поїзд:
  pnlDraw.Canvas.Brush.Color:= clRed;
  pnlDraw.Canvas.Ellipse(fX   - 4, lineY - 4, fX   + 4, lineY + 4);
  pnlDraw.Canvas.Draw(fX - fTrain.Width, lineY - fTrain.Height - 10, fTrain);

  // Малюємо другий поїзд:
  pnlDraw.Canvas.Brush.Color:= clBlue;
  pnlDraw.Canvas.Ellipse(sX   - 4, lineY - 4, sX   + 4, lineY + 4);
  pnlDraw.Canvas.Draw(sX - 0, lineY - sTrain.Height - 10, sTrain);

  // Малюємо муху:
  if phase mod 2 = 0 then fly:= fFly
                     else fly:= sFly;
  pnlDraw.Canvas.Brush.Color:= clLime;
  pnlDraw.Canvas.Ellipse(flyX - 4, lineY - 4, flyX + 4, lineY + 4);
  pnlDraw.Canvas.Draw(flyX - fly.Width div 2, lineY - Round(H*8/20), fly);

end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FreeAndNil(fTown);
  FreeAndNil(sTown);
  FreeAndNil(fTrain);
  FreeAndNil(sTrain);
  FreeAndNil(fFly);
  FreeAndNil(sFly);
end;

procedure TfMain.btnCleanClick(Sender: TObject);
begin
  edtDistance.Text:= '';
  edtSpeedF.Text:= '';
  edtSpeedS.Text:= '';
  edtSpeedFly.Text:= '';
end;

procedure TfMain.btnStartClick(Sender: TObject);
begin
  // Перевіряємо введені дані:
  valueDistance:= StrToInt(edtDistance.Text); // відстань між містами
  valueFSpeed:=   StrToInt(edtSpeedF.Text);   // швидкість першого поїзда
  valueSSpeed:=   StrToInt(edtSpeedS.Text);   // швидкість другого поїзда
  valueFlySpeed:= StrToInt(edtSpeedFly.Text); // швидкість мухи

  // Перевірка відстані між містами:
  if valueDistance < 100 then
  begin
    edtDistance.Color:= clHighlight;
    ShowMessage('Відстань між містами замала!');
    edtDistance.Text:= '100';
    edtDistance.Color:= clDefault;
    Exit;
  end;

  // Перевірка швидкості мухи:
  if valueFlySpeed > 500 then
  begin
    edtSpeedFly.Color:= clHighlight;
    ShowMessage('Мухи так швидко не літають :)');
    edtSpeedFly.Text:= '500';
    edtSpeedFly.Color:= clDefault;
    Exit;
  end;

  // Перевірка швидкості мухи відносно швидкості поїздів:
  if (valueFlySpeed < valueFSpeed) or
     (valueFlySpeed < valueSSpeed) then
  begin
    edtSpeedFly.Color:= clHighlight;
    ShowMessage('Швидкістю мухи не може бути меншою ніж швидкість поїздів!');
    if valueFSpeed > valueSSpeed
    then
      edtSpeedFly.Text:= IntToStr(valueFSpeed)
    else
      edtSpeedFly.Text:= IntToStr(valueSSpeed);
    edtSpeedFly.Color:= clDefault;
    Exit;
  end;

  // Задаємо дані і розв'язуємо задачу:
  answer:= flyProblem(valueDistance, valueFSpeed, valueSSpeed, valueFlySpeed);

  if animationRun
  then resetAll
  else
    begin
      animationRun:= True;
      btnStart.Caption:= 'Зупинити';
      setEnable(False);
    end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  // Завантажуємо раніше упаковані ресурси, їх можна запакувати утилітою,
  // яка знаходиться в наступні директорії: $LazarusDir/tools/lazres
  // Упаковка зображень відбувається наступним чином:
  // lazres ResName.lrs Res1.png Res2.png ... ResN.png
  try
    // Перше місто:
    fTown:= TPortableNetworkGraphic.Create;
    fTown.LoadFromLazarusResource('firstTown');
    // Друге місто:
    sTown:= TPortableNetworkGraphic.Create;
    sTown.LoadFromLazarusResource('secondTown');;
    // Перший поїзд:
    fTrain:= TPortableNetworkGraphic.Create;
    fTrain.LoadFromLazarusResource('firstTrain');;
    // Другий поїзд:
    sTrain:= TPortableNetworkGraphic.Create;
    sTrain.LoadFromLazarusResource('secondTrain');;
    // Муха, яка летить вперед:
    fFly:= TPortableNetworkGraphic.Create;
    fFly.LoadFromLazarusResource('firstFly');;
    // Муха, яка летить назад:
    sFly:= TPortableNetworkGraphic.Create;
    sFly.LoadFromLazarusResource('secondFly');;
  except
    ShowMessage('Помилка завантаження ресурсів' + #13 +
                'Програму неможливо запустити');
    FreeAndNil(fTown);
    FreeAndNil(sTown);
    FreeAndNil(fTrain);
    FreeAndNil(sTrain);
    FreeAndNil(fFly);
    FreeAndNil(sFly);
    Halt;
  end;
  // Ініціалізуємо необхідні змінні:
  resetAll;
end;

procedure TfMain.tUpdateTimer(Sender: TObject);
var
  i: Integer;
  s: String;
  r: Real;
begin
  if animationRun
  then
    Invalidate
  else
    if animationEnd then
      begin
        r:= 0;
        s:= '';
        animationEnd:= False;
        for i:= 0 to Length(answer) - 1 do begin
          s:= s + Format('Відрізок шляху № %.2d: %.3n км',
             [i + 1, answer[i]]) + #13;
          r:= r + answer[i];
        end;
        s:= s + #13 + 'Загальний шлях мухи: ' + Format('%.3n км', [r]);
        MessageDlg('Задача виконана', s, mtConfirmation, [mbOk], 0);
        resetAll;
      end;
end;

initialization

{$I images.lrs}

end.

