unit About;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TfAbout }

  TfAbout = class(TForm)
    btnOk: TBitBtn;
    lblTitle: TLabel;
    lblCopyright: TLabel;
    memText: TMemo;
    pnlMain: TPanel;
  private

  public

  end;

var
  fAbout: TfAbout;

implementation

{$R *.lfm}

end.

