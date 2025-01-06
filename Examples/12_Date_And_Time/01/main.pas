unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Calendar,
  EditBtn, LazUTF8;

type

  { TfMain }

  TfMain = class(TForm)
    btnRun: TButton;
    cldMain: TCalendar;
    dedtMain: TDateEdit;
    procedure btnRunClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnRunClick(Sender: TObject);
var
  dt: TDateTime;
  s: String;
  i: Integer;
  year, month, day: Word;
  hour, min, sec, msec: Word;
  leap: Boolean;
begin
  dt:= Date; // отримання в dt поточної дати
  ShowMessage(DateToStr(dt));
  dt:= Time; // отримання в dt поточного часу
  ShowMessage(TimeToStr(dt));
  dt:= Now; // отримання в dt поточної дати та часу
  ShowMessage(DateTimeToStr(dt));
  // Системні змінні, у яких зберігаються короткі та довгі
  // правила запису часу і дати:
  ShowMessage('ShortDateFormat -> ' + ShortDateFormat + #13 +
              'LongDateFormat  -> ' + LongDateFormat + #13 +
              'ShortTimeFormat -> ' + ShortTimeFormat + #13 +
              'LongTimeFormat  -> ' + LongTimeFormat);
  // Форматований вивід дати і часу:
  s:= SysToUTF8(FormatDateTime('dd mmmm yyyy - hh:nn:ss', Now));
  ShowMessage(s);
  // Ще один варіант форматованого виводу дати і часу:
  DateTimeToString(s, 'dddddd', Now);
  ShowMessage(s);
  // Отримання дня тижня, відлік починається з неділі:
  i:= DayOfWeek(Now);
  // Розбиває дату на рік, місяць і день:
  DecodeDate(Now, year, month, day);
  // Збирає дату з окремих елементів:
  dt:= EncodeDate(year, month, day);
  // Розбиває час на години, хвилини, секунди та мілісекунди:
  DecodeTime(Now, hour, min, sec, msec);
  // Збирає час з окремих елементів:
  dt:= EncodeTime(hour, min, sec, msec);
  // Перевірка "високосності" року:
  leap:= IsLeapYear(year);
end;

end.

