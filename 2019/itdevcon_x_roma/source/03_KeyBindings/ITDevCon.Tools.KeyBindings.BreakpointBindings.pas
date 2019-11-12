unit ITDevCon.Tools.KeyBindings.BreakpointBindings;

interface

uses
  Classes, ToolsAPI, System.SysUtils;

type

  TBreakpointKeyBinding = class(TNotifierObject, IOTAKeyboardBinding)
  private
    procedure ChangeBreakpoint(const Context: IOTAKeyContext;
      KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
  public
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
  end;

procedure Register;

implementation

uses
  Vcl.Menus,
  ITDevCon.Tools.KeyBindings.Shared;

var
  KeyBindingIndex: Integer = -1;

procedure InitializeWizard;
var
  LServices: IOTAKeyboardServices;
begin
  LServices := (BorlandIDEServices as IOTAKeyboardServices);
  KeyBindingIndex := LServices.AddKeyboardBinding(TBreakpointKeyBinding.Create);
end;

procedure FinalizeWizard;
var
  LServices: IOTAKeyboardServices;
begin
  if KeyBindingIndex < 0 then
    Exit;
  LServices := (BorlandIDEServices as IOTAKeyboardServices);
  LServices.RemoveKeyboardBinding(KeyBindingIndex);
end;

procedure TBreakpointKeyBinding.BindKeyboard(const BindingServices
  : IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+F8')],
    ChangeBreakpoint, nil);
  BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Alt+F8')],
    ChangeBreakpoint, nil);
end;

procedure TBreakpointKeyBinding.ChangeBreakpoint(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  LDebuggerServices: IOTADebuggerServices;
  LSourceEditor: IOTASourceEditor;
  LSourceFileName: string;
  LBreakpoint: IOTABreakpoint;
  LBkptIndex: Integer;
  LSourceBkpt: IOTASourceBreakpoint;
  LEditPos: TOTAEditPos;
begin
  // Find the current source editor.
  LSourceEditor := GetCurrentSourceEditor();
  if LSourceEditor = nil then
    Exit;
  // Get the editing file name.
  LSourceFileName := LSourceEditor.FileName;
  // Get the current cursor position.
  LEditPos := LSourceEditor.EditViews[0].CursorPos;
  // Find the debugger service manager.
  LDebuggerServices := BorlandIDEServices as IOTADebuggerServices;
  if LDebuggerServices = nil then
    Exit;
  // Search the breakpoint at cursor position.
  LBreakpoint := nil;
  for LBkptIndex := 0 to LDebuggerServices.SourceBkptCount - 1 do
  begin
    LSourceBkpt := LDebuggerServices.SourceBkpts[LBkptIndex];
    if LSourceBkpt.LineNumber <> LEditPos.Line then
      Continue;
    if AnsiCompareFileName(LSourceBkpt.FileName, LSourceFileName) <> 0 then
      Continue;
    LBreakpoint := LSourceBkpt;
    Break;
  end;
  // If breakpoint does not exist, then create it at current position.
  if LBreakpoint = nil then
  begin
    LBreakpoint := LDebuggerServices.NewSourceBreakpoint(LSourceFileName,
      LEditPos.Line, LDebuggerServices.GetCurrentProcess);
  end;
  // Edit breakpoint properties or toggle activation.
  if KeyCode = TextToShortCut('Ctrl+Shift+F8') then
    LBreakpoint.Edit(True)
  else if KeyCode = TextToShortCut('Ctrl+Alt+F8') then
    LBreakpoint.Enabled := not LBreakpoint.Enabled;
  // Key binding has been handled.
  BindingResult := krHandled;
end;

function TBreakpointKeyBinding.GetBindingType: TBindingType;
begin
  // Adds to the main binding and not an entirely
  // new keyboard binding set like "IDE Classic".
  Result := btPartial;
end;

function TBreakpointKeyBinding.GetDisplayName: string;
begin
  // Display name that appears under the
  // [Key Mappings|Enhancement Modules] section.
  Result := 'ITDevCon Tools KeyBindings';
end;

function TBreakpointKeyBinding.GetName: string;
begin
  Result := 'ITDevConCodeFocusBindings';
end;

procedure Register;
begin
  InitializeWizard;
end;

initialization

finalization

FinalizeWizard;

end.
