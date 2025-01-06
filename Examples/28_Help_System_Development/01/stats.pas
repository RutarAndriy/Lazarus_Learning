unit Stats;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfStats }

  TfStats = class(TForm)
    btnOk: TBitBtn;
    lblLines: TLabel;
    lblWords: TLabel;
    lblChars: TLabel;
    lblLinesCount: TLabel;
    lblWordsCount: TLabel;
    lblCharsCount: TLabel;
    procedure btnOkClick(Sender: TObject);
  private

  public

  end;

var
  fStats: TfStats;

implementation

{$R *.lfm}

{ TfStats }

procedure TfStats.btnOkClick(Sender: TObject);
begin
  Close;
end;

end.

