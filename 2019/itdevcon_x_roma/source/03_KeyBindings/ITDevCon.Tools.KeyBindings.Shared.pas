unit ITDevCon.Tools.KeyBindings.Shared;

interface

uses
  ToolsAPI;

function FindSourceEditorInModule(AModule: IOTAModule): IOTASourceEditor;
function GetCurrentSourceEditor: IOTASourceEditor;

implementation

function FindSourceEditorInModule(AModule: IOTAModule): IOTASourceEditor;
var
  LFileCount, LFileIndex: Integer;
begin
  Result := nil;
  if AModule = nil then
    Exit;
  with AModule do
  begin
    LFileCount := GetModuleFileCount;
    for LFileIndex := 0 to LFileCount - 1 do
      if GetModuleFileEditor(LFileIndex).QueryInterface(IOTASourceEditor,
        Result) = S_OK then
        Break;
  end;
end;

function GetCurrentSourceEditor: IOTASourceEditor;
var
  LModuleServices: IOTAModuleServices;
begin
  LModuleServices := BorlandIDEServices as IOTAModuleServices;
  if LModuleServices = nil then
    Exit;
  Result := FindSourceEditorInModule(LModuleServices.CurrentModule);
end;

end.
