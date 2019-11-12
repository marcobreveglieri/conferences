unit ITDevCon.Tools.Repository.Shared;

interface

uses
  ToolsAPI;

type

  TProjectType = (Bpl, Dll);

function OtaGetProjectGroup: IOTAProjectGroup;

implementation

function OtaGetProjectGroup: IOTAProjectGroup;
var
  LModule: IOTAModule;
  LIndex: Integer;
begin
  with BorlandIDEServices as IOTAModuleServices do
  begin
    for LIndex := 0 to ModuleCount - 1 do
    begin
      LModule := Modules[LIndex];
      if LModule.QueryInterface(IOTAProjectGroup, Result) = S_OK then
        Exit;
    end;
  end;
  Result := nil;
end;

end.
