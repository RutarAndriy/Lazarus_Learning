unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ExtDlgs, ComCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    Image1: TImage;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    FileOpen: TMenuItem;
    FileExit: TMenuItem;
    CloseMenu: TMenuItem;
    Separator2: TMenuItem;
    pWindowMaximize: TMenuItem;
    pWindowMinimize: TMenuItem;
    pWindowNormal: TMenuItem;
    pFileSaveAs: TMenuItem;
    pFileOpen: TMenuItem;
    pWindowMenu: TMenuItem;
    pFileMenu: TMenuItem;
    OPD: TOpenPictureDialog;
    PopupMenu1: TPopupMenu;
    SPD: TSavePictureDialog;
    ToolBar1: TToolBar;
    bExit: TToolButton;
    ToolButton1: TToolButton;
    bOpen: TToolButton;
    bSaveAs: TToolButton;
    WindowMaximize: TMenuItem;
    WindowMinimize: TMenuItem;
    WindowNormal: TMenuItem;
    Separator1: TMenuItem;
    FileSaveAs: TMenuItem;
    WindowMenu: TMenuItem;
    procedure FileExitClick(Sender: TObject);
    procedure FileOpenClick(Sender: TObject);
    procedure FileSaveAsClick(Sender: TObject);
    procedure WindowMaximizeClick(Sender: TObject);
    procedure WindowMinimizeClick(Sender: TObject);
    procedure WindowNormalClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FileExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FileOpenClick(Sender: TObject);
begin
  if OPD.Execute then Image1.Picture.LoadFromFile(OPD.FileName);
end;

procedure TfMain.FileSaveAsClick(Sender: TObject);
begin
  if SPD.Execute then Image1.Picture.SaveToFile(SPD.FileName);
end;

procedure TfMain.WindowMaximizeClick(Sender: TObject);
begin
  fMain.WindowState:= wsMaximized;
end;

procedure TfMain.WindowMinimizeClick(Sender: TObject);
begin
  fMain.WindowState:= wsMinimized;
end;

procedure TfMain.WindowNormalClick(Sender: TObject);
begin
  fMain.WindowState:= wsNormal;
end;

end.

