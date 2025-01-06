// Види стандартних угод передавання даних:
// ------------------------------------------------------------------------
// |  Команда  |    Обробка    |      Очищувач       | Передавання парам. |
// |  виклику  |   параметрів  |       стеку         |   через регістри   |
// ------------------------------------------------------------------------
// | register  | зліва-направо | підпрограма         |         +          |
// | pascal    | зліва-направо | підпрограма         |         -          |
// | cdecl     | справа-наліво | викликаюча програма |         -          |
// | stdcall   | справа-наліво | підпрограма         |         -          |
// ------------------------------------------------------------------------

library FirstDLL;

{$mode objfpc}{$H+}

uses
  Classes, DateUtils, SysUtils;

const
  R: array[1..13] of String[2] = // римські числа
  ('I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M');
  A: array[1..13] of Integer =   // арабські аналоги
  (1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000);

// Шифрування/розшифрування:
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

// Кількість днів, які залишилися до чергового дня народження:
function BeforeBirthday(Birthday:TDateTime): Integer; cdecl;
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

// Переведення арабських чисел в римські:
function ArToRom(N: integer): PChar; stdcall;
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

// Переведення римських чисел в арабські:
function RomToAr(s: PChar): Integer; stdcall;
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
  Code           name 'Code',
  BeforeBirthday name 'BeforeBirthday',
  ArToRom        name 'ArToRom',
  RomToAr        name 'RomToAr';

begin
end.
