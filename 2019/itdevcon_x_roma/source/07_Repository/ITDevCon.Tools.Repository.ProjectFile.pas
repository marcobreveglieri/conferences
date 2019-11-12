unit ITDevCon.Tools.Repository.ProjectFile;

interface

uses
  ToolsAPI, ITDevCon.Tools.Repository.Shared;

type

  TProjectCreatorFile = class(TInterfacedObject, IOTAFile)
  private
    FProjectName: string;
    FProjectType: TProjectType;
  public
    constructor Create(const AProjectName: string; AProjectType: TProjectType);
    { IOTAFile }
    function GetAge: TDateTime;
    function GetSource: string;
  end;

implementation

uses
  System.Classes, System.SysUtils, Winapi.Windows;

constructor TProjectCreatorFile.Create(const AProjectName: string;
  AProjectType: TProjectType);
begin
  inherited Create;
  FProjectName := AProjectName;
  FProjectType := AProjectType;
end;

function TProjectCreatorFile.GetAge: TDateTime;
begin
  // Return the age of the file, -1 if new.
  Result := -1;
end;

function TProjectCreatorFile.GetSource: string;
const
  ResourceNames: array [Low(TProjectType) .. High(TProjectType)
    ] of string = ('TxtProjectSourceBpl', 'TxtProjectSourceDll');
var
  LResStream: TResourceStream;
  LStrStream: TStringStream;
begin
  LResStream := TResourceStream.Create(HInstance,
    ResourceNames[FProjectType], 'TEXT');
  try
    LStrStream := TStringStream.Create;
    try
      LResStream.SaveToStream(LStrStream);
      Result := LStrStream.DataString;
    finally
      LStrStream.Free;
    end;
  finally
    LResStream.Free;
  end;
  Result := Format(Result, [FProjectName]);
end;

end.
