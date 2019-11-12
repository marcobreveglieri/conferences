unit ITDevCon.Tools.Repository.ProjectDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, ITDevCon.Tools.Repository.Shared;

type
  TProjectDialogForm = class(TForm)
    CancelButton: TButton;
    AcceptButton: TButton;
    SeparatorBevel: TBevel;
    ProjectTypeLabel: TLabel;
    ProjectTypeDllButton: TRadioButton;
    ProjectTypeBplButton: TRadioButton;
    ProjectNameLabel: TLabel;
    ProjectNameEdit: TEdit;
    DialogActions: TActionList;
    AcceptAction: TAction;
    CancelAction: TAction;
    procedure DialogActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure AcceptActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
  private
    function GetProjectName: string;
    function GetProjectType: TProjectType;
    function HasProjectName: Boolean;
    function HasProjectType: Boolean;
  public
    function Execute(var AProjectName: string;
      var AProjectType: TProjectType): Boolean;
    class function CreateAndExecute(var AProjectName: string;
      var AProjectType: TProjectType): Boolean;
  end;

implementation

{$R *.dfm}

procedure TProjectDialogForm.AcceptActionExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TProjectDialogForm.CancelActionExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

class function TProjectDialogForm.CreateAndExecute(var AProjectName: string;
  var AProjectType: TProjectType): Boolean;
var
  LDialog: TProjectDialogForm;
begin
  LDialog := TProjectDialogForm.Create(nil);
  try
    Result := LDialog.Execute(AProjectName, AProjectType);
  finally
    LDialog.Free;
  end;
end;

procedure TProjectDialogForm.DialogActionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  AcceptAction.Enabled := HasProjectName and HasProjectType;
  CancelAction.Enabled := True;
end;

function TProjectDialogForm.Execute(var AProjectName: string;
  var AProjectType: TProjectType): Boolean;
begin
  if ShowModal <> mrOk then
  begin
    Result := False;
    Exit;
  end;
  AProjectName := GetProjectName;
  AProjectType := GetProjectType;
  Result := True;
end;

function TProjectDialogForm.GetProjectName: string;
begin
  Result := Trim(ProjectNameEdit.Text);
end;

function TProjectDialogForm.GetProjectType: TProjectType;
begin
  if ProjectTypeBplButton.Checked then
    Result := Bpl
  else
    Result := Dll;
end;

function TProjectDialogForm.HasProjectName: Boolean;
begin
  Result := Length(GetProjectName) > 0;
end;

function TProjectDialogForm.HasProjectType: Boolean;
begin
  Result := ProjectTypeBplButton.Checked or ProjectTypeDllButton.Checked;
end;

end.
