unit Main;

{$mode delphi}

interface

uses
  Classes, SysUtils;

type

  { TRect }

  TRect = class                           // клас-квадрат
  private
    FHeight: Integer;                     // тут зберігається висота квадрату
    FWidth: Integer;                      // тут зберігається ширина квадрату
    procedure SetHeight(AValue: Integer); // задання висоти
    procedure SetWidth(AValue: Integer);  // задання ширини
  public
    // Властивість-ширина:
    property Width: Integer read FWidth write SetWidth;
    // Властивість-висота:
    property Height: Integer read FHeight write SetHeight;
    function CalcArea: Integer;           // функція повертає площу квадрату
  end;

implementation

{ TRect }

procedure TRect.SetHeight(AValue: Integer);
begin
  if AValue > 0 then
    Self.FHeight := AValue
  else
    Self.FHeight := 0;
end;

procedure TRect.SetWidth(AValue: Integer);
begin
  if AValue > 0 then
    Self.FWidth := AValue
  else
    Self.FWidth := 0;
end;

function TRect.CalcArea: Integer;
begin
  Result := Self.Width * Self.Height;
end;

end.

