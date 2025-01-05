unit Main;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    pbMain: TPaintBox;
    tUpdate: TTimer;
    procedure pbMainClick(Sender: TObject);
    procedure pbMainPaint(Sender: TObject);
    procedure tUpdateTimer(Sender: TObject);
  private
    TextAngle: Integer; // кут обертання тексту
  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

uses
  Math;

{ TfMain }

// Малюємо текст:
procedure TfMain.pbMainPaint(Sender: TObject);
const
  Text = '   ♥ Lazarus';
  SpectrumColors: array [0..6] of TColor = (clBlue,
                                            clRed,
                                            clFuchsia,
                                            clLime,
                                            clAqua,
                                            clYellow,
                                            clWhite);
var
  I: Integer;
begin
  // Задаємо розмір шрифту:
  pbMain.Canvas.Font.Size:= Ceil(0.058 * Min(pbMain.Width, pbMain.Height));
  // Очищуємо кисть:
  pbMain.Canvas.Brush.Style:= bsClear;

  // Промальовуємо у циклі текст під різним кутом та з різним кольором:
  for I := 0 to High(SpectrumColors) do
  begin
    pbMain.Canvas.Font.Color:= SpectrumColors[I];
    pbMain.Canvas.Font.Orientation:=
      TextAngle + Trunc(I * 3600 / Length(SpectrumColors));
    pbMain.Canvas.TextOut(pbMain.Width div 2, pbMain.Height div 2, Text);
  end;
end;

procedure TfMain.pbMainClick(Sender: TObject);
begin
  ShowMessage('А ти любиш Lazarus?');
end;

procedure TfMain.tUpdateTimer(Sender: TObject);
begin
  TextAngle := Self.TextAngle - 5;
  pbMain.Invalidate;
end;

end.

