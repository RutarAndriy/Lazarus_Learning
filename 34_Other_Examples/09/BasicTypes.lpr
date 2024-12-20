program BasicTypes;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils
  { you can add units after this };

var
  X1: Byte;     // 1 byte  (0..255)                  +
  X2: ShortInt; // 1 byte  (-128..127)               +-
  X3: Word;     // 2 bytes (0..65535)                +
  X4: SmallInt; // 2 bytes (-32768..32767)           +-
  X5: Integer;  // 4 bytes (-2147483648..2147483647) +-
  X6: LongInt;  // 4 bytes (-2147483648..2147483647) +-
  X7: LongWord; // 4 bytes (0..4294967295)           +
  X8: Cardinal; // 4 bytes (0..4294967295)           +
  X9: Int64;    // 8 bytes (-2e63..2e63-1)           +-

  Res: Integer; // допоміжна змінна

  i1: 1..9;       // інтервал від 1 до 9
  i2: -10..15;    // інтервал від -10 до 15
  i3: 2000..2008; // інтервал від 2000 до 2008

  course: (first, second, third, fourth, fifth); // тип - перелічення

  Num1: set of 0..10; // визначена множина
  Num2: set of 0..30; // визначена множина
  Num3: set of Byte;  // невизначена множина

  BolTrue:  Boolean = True;  // True або 1
  BolFalse: Boolean = False; // False або 0

  Y1: Real48;   // 6 bytes  (2.9e-39..1.7e38)
  Y2: Real;     // 8 bytes  (5.0e-324..1.7e308)
  Y3: Single;   // 4 bytes  (1.5e-45..3.4e38)
  Y4: Double;   // 8 bytes  (5.0e-324..1.7e308)
  Y5: Extended; // 10 bytes (3.6e-4932..1.1e4932)
  Y6: Comp;     // 8 bytes  (-2e63..2e63)
  Y7: Currency; // 8 bytes  (-922337203685477.5808..922337203685477.5807)

  var P1: ^Integer;   // вказівник на тип Integer
  var P2: ^Real;      // вказівник на тип Real
  var P3: ^String;    // вказівник на строку
  var P4: Pointer;    // нетипізований вказівник

  C1: Char;       // змінна типу Char
  C2: Char = 'M'; // змінна типу Char, якій присвоєно символ M
  C3: Char = #65; // змінна типу Char, якій присвоєно символ A

  S1: String;            // змінна - строка
  S2: String[15];        // змінна - строка, яка має довжину 15 символів (ANSI)
  S3: String = 'Привіт'; // змінна - строка, якій присвоєно значення "Привіт"

begin

  // Змінюємо значення множини:
  Num1:= [1..10, 13, 27];
  // Перевірка входження числа 13 у множину Num1
  if 13 in Num1 then WriteLn('Число 13 є у множині Num1')
                else WriteLn('Числа 13 немає у множині Num1');

  // Змінюємо значення множини:
  Num2:= [1..10, 13, 27];
  // Перевірка входження числа 13 у множину Num1
  if 13 in Num2 then WriteLn('Число 13 є у множині Num2')
                else WriteLn('Числа 13 немає у множині Num2');

  // Змінюємо значення множини:
  Num3:= [1..10, 13, 27];
  // Перевірка входження числа 13 у множину Num1
  if 13 in Num3 then WriteLn('Число 13 є у множині Num3')
                else WriteLn('Числа 13 немає у множині Num3');

  // Перевірка входження числа 13 у множину "на льоту"
  if 13 in [1..12, 14, 17..20]
    then WriteLn('Число 13 є у множині [1..12, 14, 17..20]')
    else WriteLn('Числа 13 немає у множині [1..12, 14, 17..20]');

  WriteLn('Chr: ',    Chr(74));     // повертає символ за його кодом ANSI
  WriteLn('Ord: ',    Ord('J'));    // повертає ANSI-код символа
  WriteLn('Pred: ',   Pred('J'));   // повертає попередній символ
  WriteLn('Succ: ',   Succ('J'));   // повертає наступний символ
  WriteLn('Upcase: ', UpCase('z')); // переводить символ у верхній регістр

  // Об'єднання строк:
  WriteLn('Concat: ', Concat('ABC', 'D', 'EFG'));

  // Отримання довжини строки (розміру):
  WriteLn('Lenght: ', Length('Оля'));

  // Задає розмір строки:
  // SetLenght (str, lenght);

  // Отримання підстроки:
  WriteLn('Copy: ', Copy('Emergency', 2, 5));

  // Видаляє підстроку із строки:
  // Delete(str, start, count);

  // Вставляє підстроку text в позицію pos:
  // Insert(str, text, pos);

  // Пошук підстроки:
  WriteLn('Pos: ', Pos('ry', 'Henry'));

  // Перетворює число в строку:
  Str(15:0, S1);
  WriteLn('Str (15:0): ', S1);
  Str(25.0:6:0, S1);
  WriteLn('Str (25.0:6:0): ', S1);
  Str(15.6:0:3, S1);
  WriteLn('Str (15.6:0:3): ', S1);

  // Намагаємося перетворити строку в число:
  Val('15', X1, Res);
  WriteLn('X1: ', X1, ', Res: ', Res);
  Val('6h', X1, Res);
  WriteLn('X1: ', X1, ', Res: ', Res);
  Val('17.4', Y2, Res);
  WriteLn('Y2: ', Y2, ', Res: ', Res);
  Val('17,4', Y2, Res);
  WriteLn('Y2: ', Y2, ', Res: ', Res);

  // Переведення строки у верхній та нижній регістри:
  WriteLn(LowerCase('Hello'));
  WriteLn(UpCase('Hello'));

  // Порівняння строк враховуючи і не враховуючи регістр:
  WriteLn('CompareStr(Hello, hello) = ', CompareStr('Hello', 'hello'));
  WriteLn('CompareText(Hello, hello) = ', CompareText('Hello', 'hello'));

  // Видалення пробілів на початку і вкінці строки:
  WriteLn('Trim(''   Hello   '') = ', Trim('   Hello   '));

end.

