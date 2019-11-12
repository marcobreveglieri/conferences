unit ITDevCon.Tools.AutoSave.Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, ITDevCon.Tools.AutoSave.Options, System.Actions, Vcl.ActnList;

type

  TAutoSaveDialog = class(TForm)
    IntervalLabel: TLabel;
    IntervalEdit: TEdit;
    IntervalUpDown: TUpDown;
    CommandPanel: TPanel;
    AcceptButton: TButton;
    CancelButton: TButton;
    EnabledCheckBox: TCheckBox;
    DialogActions: TActionList;
    AcceptAction: TAction;
    CancelAction: TAction;
    procedure IntervalEditExit(Sender: TObject);
    procedure AcceptActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
  public
    class function Configure(var AOptions: TAutoSaveOptions): Boolean;
  end;

implementation

{$R *.dfm}

class function TAutoSaveDialog.Configure(var AOptions
  : TAutoSaveOptions): Boolean;
var
  LForm: TAutoSaveDialog;
begin
  LForm := TAutoSaveDialog.Create(nil);
  try
    LForm.EnabledCheckBox.Checked := AOptions.Enabled;
    LForm.IntervalUpDown.Position := AOptions.Interval;
    LForm.IntervalEdit.Text := IntToStr(AOptions.Interval);
    if not(LForm.ShowModal = mrOk) then
    begin
      Result := False;
      Exit;
    end;
    AOptions.Enabled := LForm.EnabledCheckBox.Checked;
    AOptions.Interval := LForm.IntervalUpDown.Position;
    Result := True;
  finally
    LForm.Free;
  end;
end;

procedure TAutoSaveDialog.AcceptActionExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TAutoSaveDialog.CancelActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAutoSaveDialog.IntervalEditExit(Sender: TObject);
begin
  IntervalUpDown.Position := StrToIntDef(IntervalEdit.Text,
    IntervalUpDown.Position);
end;

end.
