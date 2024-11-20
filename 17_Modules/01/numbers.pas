{ В модулі описані дві функції, які перевіряють правильність вводимого
  користувачем символу. Функція TrueIntKeys перевіряє цілі числа і має такі
  параметри: key - введений користувачем символ; str - строка в TExit;
  sign - якщо True, то число зі знаком, якщо False - без знаку. Якщо корис-
  тувач ввів правильний символ, функція його не змінить, інакше повертає
  символ #0 - тобто нічого. Функція TrueFloatKeys аналогічним чином виконує
  перевірку дробових чисел. Приклад використання:
  Key:= TrueIntKeys(Key, Edit1.Text, True); // ціле зі знаком
  Key:= TrueIntKeys(Key, Edit1.Text, False); // ціле без знаку
  Key:= TrueFloatKeys(Key, Edit1.Text); // дробове
}

unit Numbers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

// Перевірка правильності символа у цілому числі:
function TrueIntKeys(key: Char; str: String; sign: Boolean): Char;
// Перевірка правильності символа у дробовому числі:
function TrueFloatKeys(key: Char; str: String): Char;

implementation

{ Перевірка правильності символа у цілому числі }
function TrueIntKeys(key: Char; str: String; sign: Boolean): Char;
begin
  // Спочатку вкажемо, що повертається той самий символ, що ввів користувач:
  Result:= key;
  // Далі виконуємо перевірку на правильність символа. Якщо символ не
  // правильний, ми його заборонемо:
  case key of
    // Всі числа дозволяємо:
    '0'..'9': ;
    // Backspace дозволяємо:
    #8: ;
    // Якщо знаковий, то дозволяємо мінус при умові, що мінус - перший
    // символ у строці:
    '-' : if sign and (Length(str) = 0) then Result:= key
          else Result:= #0; // якщо беззнакове або мінус не перший - забороняємо
    // Всі інші символи забороняємо:
    else Result:= #0;
  end; // case
end;

{ Перевірка правильності символа у дробовому числі }
function TrueFloatKeys(key: Char; str: String): Char;
var
  separator: Char;
begin
  // Отримуємо системний розділювач чисел
  separator:= DefaultFormatSettings.DecimalSeparator;
  // Спочатку вкажемо, що повертається той самий символ, що ввів користувач:
  Result:= key;
  // Далі виконуємо перевірку на правильність символа. Якщо символ не
  // правильний, ми його заборонемо:
  case key of
    // Всі числа дозволяємо:
    '0'..'9': ;
    // Backspace дозволяємо:
    #8: ;
    // Якщо розділювача ще немає - виводимо правильний розділювач, інакше
    // нічого не виводимо:
    ',' , '.' : if Pos(separator, str) = 0 then Result:= separator
                else Result:= #0;
    // Якщо знаковий, то дозволяємо мінус при умові, що мінус - перший
    // символ у строці:
    '-' : if Length(str) = 0 then Result:= key
          else Result:= #0; // якщо беззнакове або мінус не перший - забороняємо
    // Всі інші символи забороняємо:
    else Result:= #0;
  end; // case
end;

end.

