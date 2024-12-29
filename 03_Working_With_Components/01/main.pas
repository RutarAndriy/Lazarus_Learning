unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TfMain }

  TfMain = class(TForm)
    bitExit: TBitBtn;
    bitClose: TBitBtn;
    btnExit: TButton;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    spdExit: TSpeedButton;
    splHor: TSplitter;
    splVert: TSplitter;
    procedure bitExitClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.bitExitClick(Sender: TObject);
begin
  Close;
end;

end.

