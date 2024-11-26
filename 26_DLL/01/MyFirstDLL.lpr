// У бібліотеці використовується стандартна угода передавання даних сумісна із
// програмами написаними на FreePascal. Для інших систем та мов програмування
// можливо знадобиться змінити стандартну угоду:
// - stdcall - для Windows
// - cdec - для Linux та Unix
// - register - для програм, які також написані на FreePascal

library MyFirstDLL;

{$mode objfpc}{$H+}

uses
  Classes, DateUtils, SysUtils;

const
  R: array[1..13] of String[2] =
  ('I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M');
  A: array[1..13] of Integer =
  (1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000);

// Шифрування/розшифрування
function Code(s: PChar; Key: Integer): PChar; register;
var
  i: Integer;
  ss: String;
begin
  ss:= s;
  for i:= 1 to length(s) do
    ss[i]:= Char(Ord(ss[i]) xor Key);
  Result:= PChar(ss);
end;

// Днів до чергового дня народження
function BeforeBirthday(Birthday:TDateTime): Integer; register;
var
  d,m,y: Word; // день, місяць і рік
  mydate: TDateTime;
begin
  mydate:= Birthday;
  // Розберемо дату, змінимо рік на поточний і зберемо назад:
  DecodeDate(mydate, y, m, d);
  y:= YearOf(Date);
  mydate:= EncodeDate(y, m, d);
  // Якщо ДН сьогодні:
  if mydate = Date then Result:= 0
  // Якщо буде:
  else if mydate > Date then Result:= DaysBetween(Date, mydate)
  // Якщо вже був:
  else begin
  // Встановимо дату ДН на наступний рік і знову порахуємо:
  y:= y + 1;
  mydate:= EncodeDate(y, m, d);
  Result:= DaysBetween(Date, mydate);
  end; // else
end;

// Арабські в римські
function ArToRom(N: integer): PChar; register;
var
  i: integer;
  s: string;
begin
  s := '';
  i := 13;
  while N > 0 do begin
    while A[i] > N do Dec(i);
    s := s + R[i];
    Dec(N, A[i]);
  end;
  Result := PChar(s);
end;

// Римські в арабські
function RomToAr(s: PChar): Integer; register;
var
  i, p: Integer;
begin
  Result := 0;
  i := 13;
  p := 1;
  while p <= Length(s) do begin
    while Copy(s, p, Length(R[i])) <> R[i] do begin
      Dec(i);
      if i = 0 then Exit;
      end; // while 2
    Result := Result + A[i];
    p := p + Length(R[i]);
    end; // while 1
end;

exports
  Code name 'Code',
  BeforeBirthday name 'BeforeBirthday',
  ArToRom name 'ArToRom',
  RomToAr name 'RomToAr';
begin
end.
