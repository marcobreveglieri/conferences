unit ITDevCon.Tools.Basic.FirstWizard;

interface

uses
  ToolsAPI;

type

  TFirstWizard = class(TInterfacedObject, IOTAWizard)
  public
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
  end;

procedure Register;

implementation

var
  WizardIndex: Integer = -1;

procedure TFirstWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TFirstWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TFirstWizard.Destroyed;
begin
  // No resource needs to be freed.
end;

procedure TFirstWizard.Execute;
begin
end;

function TFirstWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.Basic';
end;

function TFirstWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Basic Wizard';
end;

function TFirstWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TFirstWizard.Modified;
begin
  // Not called for this wizard.
end;

procedure InitializeWizard;
var
  LServices: IOTAWizardServices;
begin
  LServices := (BorlandIDEServices as IOTAWizardServices);
  WizardIndex := LServices.AddWizard(TFirstWizard.Create);
end;

procedure FinalizeWizard;
var
  LServices: IOTAWizardServices;
begin
  if WizardIndex < 0 then
    Exit;
  LServices := (BorlandIDEServices as IOTAWizardServices);
  LServices.RemoveWizard(WizardIndex);
end;

procedure Register;
begin
  InitializeWizard;
end;

initialization

finalization

FinalizeWizard;

end.
