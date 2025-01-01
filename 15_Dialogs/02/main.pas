unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ExtDlgs,
  StdCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    btnOpen: TButton;
    imgMain: TImage;
    opnPctrDlg: TOpenPictureDialog;
    procedure btnOpenClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Відкривання зображення для перегляду:
procedure TfMain.btnOpenClick(Sender: TObject);
begin
  if opnPctrDlg.Execute then imgMain.Picture.LoadFromFile(opnPctrDlg.FileName);
end;

end.

