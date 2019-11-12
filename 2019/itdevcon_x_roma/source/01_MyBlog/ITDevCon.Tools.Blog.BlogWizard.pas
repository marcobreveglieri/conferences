unit ITDevCon.Tools.Blog.BlogWizard;

interface

uses
  ToolsAPI;

type

  TBlogWizard = class(TInterfacedObject, IOTAWizard, IOTAMenuWizard)
  public
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    function GetMenuText: string;
  end;

procedure Register;

implementation

uses
  Winapi.ShellAPI, Winapi.Windows;

var
  WizardIndex: Integer = -1;

procedure TBlogWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TBlogWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TBlogWizard.Destroyed;
begin
  // No resource needs to be freed.
end;

procedure TBlogWizard.Execute;
begin
  ShellExecute(0, 'open', 'https://www.compilaquindiva.com', nil, nil,
    SW_SHOWDEFAULT);
end;

function TBlogWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.Blog';
end;

function TBlogWizard.GetMenuText: string;
begin
  Result := 'Compila Quindi Va (blog)';
end;

function TBlogWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Blog';
end;

function TBlogWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TBlogWizard.Modified;
begin
  // Not called for this wizard.
end;

procedure InitializeWizard;
var
  LServices: IOTAWizardServices;
begin
  LServices := (BorlandIDEServices as IOTAWizardServices);
  WizardIndex := LServices.AddWizard(TBlogWizard.Create);
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
