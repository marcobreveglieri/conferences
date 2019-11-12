unit ITDevCon.Tools.Repository.ProjectCreator;

interface

uses
  ToolsAPI,
  ITDevCon.Tools.Repository.Shared;

type

  TSampleProjectCreator = class(TInterfacedObject, IOTACreator,
    IOTAProjectCreator, IOTAProjectCreator50, IOTAProjectCreator80)
  private
    FProjectName: string;
    FProjectType: TProjectType;
  protected
  public
    constructor Create(const AProjectName: string; AProjectType: TProjectType);
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAProjectCreator }
    function GetFileName: string;
    function GetOptionFileName: string; // deprecated
    function GetShowSource: Boolean;
    procedure NewDefaultModule; // deprecated
    function NewOptionSource(const ProjectName: string): IOTAFile; // deprecated
    procedure NewProjectResource(const Project: IOTAProject);
    function NewProjectSource(const ProjectName: string): IOTAFile;
    { IOTAProjectCreator50 }
    procedure NewDefaultProjectModule(const Project: IOTAProject);
    { IOTAProjectCreator80 }
    function GetProjectPersonality: string;
  end;

implementation

uses
  System.IOUtils, System.SysUtils, ITDevCon.Tools.Repository.ProjectFile;

constructor TSampleProjectCreator.Create(const AProjectName: string;
  AProjectType: TProjectType);
begin
  inherited Create;
  FProjectName := AProjectName;
  FProjectType := AProjectType;
end;

function TSampleProjectCreator.GetCreatorType: string;
begin
  // Use a built-in (sConsole, sApplication, ...) or custom creator.
  Result := EmptyStr; // custom!
end;

function TSampleProjectCreator.GetExisting: Boolean;
begin
  // Existing project or a new project?
  Result := False;
end;

function TSampleProjectCreator.GetFileName: string;
var
  LExtension: string;
begin
  // Don't forget the (right) file extension!
  case FProjectType of
    Bpl:
      LExtension := '.dpk';
    Dll:
      LExtension := '.dpr';
  end;
  Result := TPath.Combine(GetCurrentDir, FProjectName + LExtension);
end;

function TSampleProjectCreator.GetFileSystem: string;
begin
  Result := EmptyStr; // use default
end;

function TSampleProjectCreator.GetOptionFileName: string;
begin
  // Delphi Options File (".dof") is deprecated:
  // information are stored in the .dproj file.
  Result := EmptyStr;
end;

function TSampleProjectCreator.GetOwner: IOTAModule;
begin
  Result := OtaGetProjectGroup;
end;

function TSampleProjectCreator.GetProjectPersonality: string;
begin
  // Note: not all of these personalities are
  // available in later version of the IDE!
  Result := sDelphiPersonality;
end;

function TSampleProjectCreator.GetShowSource: Boolean;
begin
  // Tells the IDE whether to show the
  // module source once created in the IDE.
  Result := False;
end;

function TSampleProjectCreator.GetUnnamed: Boolean;
begin
  // Determines whether the IDE will display
  // the SaveAs dialogue on the first occasion.
  Result := True;
end;

procedure TSampleProjectCreator.NewDefaultModule;
begin
  // TODO
end;

procedure TSampleProjectCreator.NewDefaultProjectModule(
  const Project: IOTAProject);
begin
  // TODO
end;

function TSampleProjectCreator.NewOptionSource(
  const ProjectName: string): IOTAFile;
begin
  // Allows to specify the information in the options file (deprecated).
  Result := nil;
end;

procedure TSampleProjectCreator.NewProjectResource(const Project: IOTAProject);
begin
  // Allows to create or modify the project resource.
end;

function TSampleProjectCreator.NewProjectSource(
  const ProjectName: string): IOTAFile;
begin
  Result := TProjectCreatorFile.Create(FProjectName, FProjectType);
end;

end.
