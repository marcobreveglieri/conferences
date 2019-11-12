unit ITDevCon.Tools.CodeReading.UnitListWizard;

interface

uses
  System.SysUtils,
  Vcl.Menus,
  ToolsAPI;

type

  TUnitListWizard = class(TInterfacedObject, IOTAWizard)
  private
    FMenuItem: TMenuItem;
    procedure HandleMenuClick(Sender: TObject);
    procedure InitializeMenu;
    function OtaGetCurrentModule: IOTAModule;
    function OtaGetCurrentSourceEditor: IOTASourceEditor;
    function OtaGetModuleSourceEditor(AModule: IOTAModule): IOTASourceEditor;
    function OtaGetSourceEditorText(ASourceEditor: IOTASourceEditor): string;
    procedure ParseUnitsFromSourceText(const ASourceText: string;
      var AInterfaceList, AImplementationList: TArray<string>);
  protected
    procedure ShowUnitList;
  public
    constructor Create;
    destructor Destroy; override;
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

uses
  System.Generics.Collections,
  ITDevCon.Tools.CodeReading.UnitListDialog;

constructor TUnitListWizard.Create;
begin
  inherited Create;
  InitializeMenu;
end;

destructor TUnitListWizard.Destroy;
begin
  if FMenuItem <> nil then
    FreeAndNil(FMenuItem);
  inherited Destroy;
end;

procedure TUnitListWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TUnitListWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TUnitListWizard.Destroyed;
begin
  // Not called for this wizard.
end;

procedure TUnitListWizard.Execute;
begin
  // Not called for this wizard.
end;

function TUnitListWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.CodeReading';
end;

function TUnitListWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Code Reading';
end;

function TUnitListWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TUnitListWizard.HandleMenuClick(Sender: TObject);
begin
  ShowUnitList;
end;

procedure TUnitListWizard.InitializeMenu;
var
  LParentMenuItem: TMenuItem;
begin
  with BorlandIDEServices as INTAServices do
  begin
    if MainMenu = nil then
      Exit;
    LParentMenuItem := MainMenu.Items.Find('Edit');
    if LParentMenuItem = nil then
      Exit;
  end;
  FMenuItem := TMenuItem.Create(LParentMenuItem);
  try
    with FMenuItem do
    begin
      Caption := 'Show &Uses List...';
      OnClick := HandleMenuClick;
    end;
    LParentMenuItem.Add(FMenuItem);
  except
    FreeAndNil(FMenuItem);
  end;
end;

procedure TUnitListWizard.Modified;
begin
  // Not called for this wizard.
end;

function TUnitListWizard.OtaGetCurrentModule: IOTAModule;
begin
  if BorlandIDEServices = nil then
  begin
    Result := nil;
    Exit;
  end;
  with BorlandIDEServices as IOTAModuleServices do
    Result := CurrentModule;
end;

function TUnitListWizard.OtaGetCurrentSourceEditor: IOTASourceEditor;
var
  LModule: IOTAModule;
begin
  LModule := OtaGetCurrentModule;
  if LModule = nil then
  begin
    Result := nil;
    Exit;
  end;
  Result := OtaGetModuleSourceEditor(LModule);
end;

function TUnitListWizard.OtaGetModuleSourceEditor(AModule: IOTAModule)
  : IOTASourceEditor;
var
  LFileIndex: Integer;
begin
  if AModule = nil then
  begin
    Result := nil;
    Exit;
  end;
  for LFileIndex := 0 to AModule.ModuleFileCount - 1 do
  begin
    if Supports(AModule.ModuleFileEditors[LFileIndex], IOTASourceEditor) then
    begin
      Result := IOTASourceEditor(AModule.ModuleFileEditors[LFileIndex]);
      Exit;
    end;
  end;
  Result := nil;
end;

function TUnitListWizard.OtaGetSourceEditorText(ASourceEditor
  : IOTASourceEditor): string;
const
  IntBufferSize: Integer = 1024;
var
  LBuffer: AnsiString;
  LEditReader: IOTAEditReader;
  LPosition, LRead: Integer;
begin
  Result := EmptyStr;
  LEditReader := ASourceEditor.CreateReader;
  try
    LPosition := 0;
    repeat
      SetLength(LBuffer, IntBufferSize);
      LRead := LEditReader.GetText(LPosition, PAnsiChar(LBuffer),
        IntBufferSize);
      if LRead <= 0 then
        Break;
      SetLength(LBuffer, LRead);
      Result := Result + String(LBuffer);
      Inc(LPosition, LRead);
    until LRead < IntBufferSize;
  finally
    LEditReader := nil;
  end;
end;

procedure TUnitListWizard.ParseUnitsFromSourceText(const ASourceText: string;
  var AInterfaceList, AImplementationList: TArray<string>);
var
  LPos, LIntfStart, LIntfEnd, LImplStart, LImplEnd: Integer;
  LText, LToken: string;
  LIntfTokens, LImplTokens: TArray<string>;
  LUnits: TList<string>;
begin
  AInterfaceList := [];
  AImplementationList := [];

  LText := ASourceText.Trim().ToLower();

  if Length(LText) <= 0 then
    Exit;

  LPos := LText.IndexOf('interface');
  if LPos < 0 then
    Exit;

  LPos := LText.IndexOf('uses', LPos);
  if LPos < 0 then
    Exit;

  LIntfStart := LPos + Length('uses');

  LPos := LText.IndexOf(';', LIntfStart);
  if LPos < 0 then
    Exit;

  LIntfEnd := LPos;

  LPos := LText.IndexOf('implementation', LPos);
  if LPos < 0 then
    Exit;

  LPos := LText.IndexOf('uses', LPos);
  if LPos < 0 then
    Exit;

  LImplStart := LPos + Length('uses');

  LPos := LText.IndexOf(';', LImplStart);
  if LPos < 0 then
    Exit;

  LImplEnd := LPos;

  LIntfTokens := ASourceText.Substring(LIntfStart, LIntfEnd - LIntfStart)
    .Replace(#13#10, '').Split([',']);

  LImplTokens := ASourceText.Substring(LImplStart, LImplEnd - LImplStart)
    .Replace(#13#10, '').Split([',']);

  LUnits := TList<string>.Create;
  try
    for LToken in LIntfTokens do
      LUnits.Add(LToken.Trim);
    LUnits.Sort;
    AInterfaceList := LUnits.ToArray;
    LUnits.Clear;
    for LToken in LImplTokens do
      LUnits.Add(LToken.Trim);
    LUnits.Sort;
    AImplementationList := LUnits.ToArray;
  finally
    LUnits.Free;
  end;

end;

procedure TUnitListWizard.ShowUnitList;
var
  LSourceEditor: IOTASourceEditor;
  LSourceText: string;
  LInterfaceUnits, LImplementationUnits: TArray<string>;
begin
  LSourceEditor := OtaGetCurrentSourceEditor;
  if LSourceEditor = nil then
    Exit;
  LSourceText := OtaGetSourceEditorText(LSourceEditor);
  ParseUnitsFromSourceText(LSourceText, LInterfaceUnits, LImplementationUnits);
  TUnitListDialog.ShowUnits(LInterfaceUnits, LImplementationUnits);
end;

var
  WizardIndex: Integer = -1;

procedure Register;
begin
  with BorlandIDEServices as IOTAWizardServices do
    WizardIndex := AddWizard(TUnitListWizard.Create);
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
