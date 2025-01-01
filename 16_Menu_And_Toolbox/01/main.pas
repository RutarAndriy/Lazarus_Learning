unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ExtDlgs, ComCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    imgMain: TImage;
    imgList: TImageList;
    mMenu: TMainMenu;
    mFileMenu: TMenuItem;
    mFileOpen: TMenuItem;
    mFileExit: TMenuItem;
    pCloseMenu: TMenuItem;
    sepTwo: TMenuItem;
    pWindowMaximize: TMenuItem;
    pWindowMinimize: TMenuItem;
    pWindowNormal: TMenuItem;
    pFileSaveAs: TMenuItem;
    pFileOpen: TMenuItem;
    pWindowMenu: TMenuItem;
    pFileMenu: TMenuItem;
    opnPctrDlg: TOpenPictureDialog;
    pMenu: TPopupMenu;
    savPctrDlg: TSavePictureDialog;
    tlbMain: TToolBar;
    btnExit: TToolButton;
    btnSep: TToolButton;
    btnOpen: TToolButton;
    btnSaveAs: TToolButton;
    mWindowMaximize: TMenuItem;
    mWindowMinimize: TMenuItem;
    mWindowNormal: TMenuItem;
    sepOne: TMenuItem;
    mFileSaveAs: TMenuItem;
    mWindowMenu: TMenuItem;
    procedure mFileExitClick(Sender: TObject);
    procedure mFileOpenClick(Sender: TObject);
    procedure mFileSaveAsClick(Sender: TObject);
    procedure mWindowMaximizeClick(Sender: TObject);
    procedure mWindowMinimizeClick(Sender: TObject);
    procedure mWindowNormalClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Закриття програми:
procedure TfMain.mFileExitClick(Sender: TObject);
begin
  Close;
end;

// Відкривання файлу для перегляду:
procedure TfMain.mFileOpenClick(Sender: TObject);
begin
  if opnPctrDlg.Execute then imgMain.Picture.LoadFromFile(opnPctrDlg.FileName);
end;

// Збереження файлу:
procedure TfMain.mFileSaveAsClick(Sender: TObject);
begin
  if savPctrDlg.Execute then imgMain.Picture.SaveToFile(savPctrDlg.FileName);
end;

// Розгортання вікна програми:
procedure TfMain.mWindowMaximizeClick(Sender: TObject);
begin
  fMain.WindowState:= wsMaximized;
end;

// Згортання вікна програми:
procedure TfMain.mWindowMinimizeClick(Sender: TObject);
begin
  fMain.WindowState:= wsMinimized;
end;

// Відновлення вікна програми:
procedure TfMain.mWindowNormalClick(Sender: TObject);
begin
  fMain.WindowState:= wsNormal;
end;

end.

