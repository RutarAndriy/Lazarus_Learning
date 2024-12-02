unit Stats;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfStats }

  TfStats = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LinesCount: TLabel;
    WordsCount: TLabel;
    CharsCount: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  fStats: TfStats;

implementation

{$R *.lfm}

{ TfStats }

procedure TfStats.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.

