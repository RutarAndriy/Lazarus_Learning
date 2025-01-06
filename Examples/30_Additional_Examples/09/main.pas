unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TFormEdit }

  TFormEdit = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    memMain: TMemo;
    pnlBottom: TPanel;
  private

  public

  end;

var
  FormEdit: TFormEdit;

implementation

{$R *.lfm}

end.

