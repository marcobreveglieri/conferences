unit ITDevCon.Tools.Repository.SampleWizard;

interface

uses
  ToolsAPI,
  ITDevCon.Tools.Repository.Shared;

type

  TSampleRepositoryWizard = class(TNotifierObject, IOTAWizard,
    IOTARepositoryWizard, IOTARepositoryWizard60, IOTARepositoryWizard80,
    IOTAProjectWizard, IOTAProjectWizard100)
  private
    FProject : IOTAProject;
    procedure CreateProject(const AProjectName: string;
      AProjectType: TProjectType);
  public
    constructor Create;
    { IOTAWizard }
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetGlyph: Cardinal;
    function GetPage: string;
    { IOTARepositoryWizard60 }
    function GetDesigner: string;
    { IOTARepositoryWizard80 }
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;
    { IOTAProjectWizard }
    { IOTAProjectWizard100 }
    function IsVisible(Project: IOTAProject): Boolean;
  end;

procedure Register;

implementation

uses
  Winapi.Windows, System.SysUtils, ITDevCon.Tools.Repository.ProjectDialog,
  ITDevCon.Tools.Repository.ProjectCreator;

resourcestring
  sAuthorName = 'Marco Breveglieri';
  sCommentText = 'This is a repository demo for ITDevCon';
  sCategoryIdString = 'ITDevCon Samples';
  sCategoryDisplayName = 'ITDevCon Gallery Category';
  sProjectCreated = 'Project created successfully!';

constructor TSampleRepositoryWizard.Create;
begin
  inherited Create;
  with BorlandIDEServices as IOTAGalleryCategoryManager do
  begin
    AddCategory(FindCategory(sCategoryDelphiNew), sCategoryIdString,
      sCategoryDisplayName);
  end;
end;

procedure TSampleRepositoryWizard.CreateProject(const AProjectName: string;
  AProjectType: TProjectType);
var
  LCreator: TSampleProjectCreator;
begin
  LCreator := TSampleProjectCreator.Create(AProjectName, AProjectType);
  with BorlandIDEServices as IOTAModuleServices do
    FProject := CreateModule(LCreator) as IOTAProject;
end;

procedure TSampleRepositoryWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TSampleRepositoryWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TSampleRepositoryWizard.Destroyed;
begin
  // Not called for this wizard.
end;

procedure TSampleRepositoryWizard.Execute;
var
  LProjectName: string;
  LProjectType: TProjectType;
begin
  // NOTE: here you can put everything!!
  if not TProjectDialogForm.CreateAndExecute(LProjectName, LProjectType) then
    Exit;
  CreateProject(LProjectName, LProjectType);
  with BorlandIDEServices as IOTAMessageServices do
    AddTitleMessage(sProjectCreated);
end;

function TSampleRepositoryWizard.GetAuthor: string;
begin
  Result := sAuthorName;
end;

function TSampleRepositoryWizard.GetComment: string;
begin
  Result := sCommentText;
end;

function TSampleRepositoryWizard.GetDesigner: string;
begin
  Result := dVCL;
end;

function TSampleRepositoryWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  // The wizard will appear under the category created in the constructor.
  with BorlandIDEServices as IOTAGalleryCategoryManager do
    Result := FindCategory(sCategoryIdString);
end;

function TSampleRepositoryWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(HInstance, 'IcoSampleRepository');
end;

function TSampleRepositoryWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.Repository.SampleRepositoryWizard';
end;

function TSampleRepositoryWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Repositories - SampleRepositoryWizard';
end;

function TSampleRepositoryWizard.GetPage: string;
begin
  // Required only for earlier version of Delphi (before 2005)
  // in order to tell the IDE on which page/tab the Project Wizard
  // should appear, but now the page is created/set in constructor.
  Result := EmptyStr;
end;

function TSampleRepositoryWizard.GetPersonality: string;
begin
  // Tells the IDE which personality the Project belongs to
  // (Delphi, C++Builder, Delphi.NET, C#, ...).
  Result := sDelphiPersonality;
end;

function TSampleRepositoryWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TSampleRepositoryWizard.IsVisible(Project: IOTAProject): Boolean;
begin
  // You may wish to disable a project wizard for a particular given project.
  // Here the wizard is visible for all projects.
  Result := True;
end;

procedure TSampleRepositoryWizard.Modified;
begin
  // Not called for this wizard.
end;

var
  WizardIndex: Integer = -1;

procedure Register;
begin
  with BorlandIDEServices as IOTAWizardServices do
    WizardIndex := AddWizard(TSampleRepositoryWizard.Create);
end;

procedure Unregister;
begin
  if WizardIndex < 0 then
    Exit;
  with BorlandIDEServices as IOTAWizardServices do
    RemoveWizard(WizardIndex);
end;

initialization

finalization

Unregister;

end.
