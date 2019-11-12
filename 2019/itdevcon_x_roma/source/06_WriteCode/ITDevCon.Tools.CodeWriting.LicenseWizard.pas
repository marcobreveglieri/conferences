unit ITDevCon.Tools.CodeWriting.LicenseWizard;

interface

uses
  System.Classes, System.SysUtils,
  ToolsAPI,
  Vcl.Menus;

type

  TLicenseWizard = class(TInterfacedObject, IOTAWizard)
  private
    FMenuItem: TMenuItem;
    procedure HandleMenuClick(Sender: TObject);
    procedure InitializeMenu;
    function OtaGetCurrentModule: IOTAModule;
    function OtaGetCurrentSourceEditor: IOTASourceEditor;
    function OtaGetModuleSourceEditor(AModule: IOTAModule): IOTASourceEditor;
    procedure OtaSourceWriteText(AWriter: IOTAEditWriter; const ALine: string);
  protected
    procedure InsertLicense;
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

constructor TLicenseWizard.Create;
begin
  inherited Create;
  InitializeMenu;
end;

destructor TLicenseWizard.Destroy;
begin
  if FMenuItem <> nil then
    FreeAndNil(FMenuItem);
  inherited Destroy;
end;

procedure TLicenseWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TLicenseWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TLicenseWizard.Destroyed;
begin
  // Not called for this wizard.
end;

procedure TLicenseWizard.Execute;
begin
  // Not called for this wizard.
end;

function TLicenseWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.CodeWriting.LicenseWizard';
end;

function TLicenseWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Code Writing - License Wizard';
end;

function TLicenseWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TLicenseWizard.HandleMenuClick(Sender: TObject);
begin
  InsertLicense;
end;

procedure TLicenseWizard.InitializeMenu;
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
      Caption := 'Insert &License...';
      OnClick := HandleMenuClick;
    end;
    LParentMenuItem.Add(FMenuItem);
  except
    FreeAndNil(FMenuItem);
  end;
end;

procedure TLicenseWizard.InsertLicense;
var
  LResStream: TResourceStream;
  LStrStream: TStringStream;
  LHeader: string;
  LEditor: IOTASourceEditor;
  LWriter: IOTAEditWriter;
  LPosition: TOTAEditPos;
begin
  // Read the license header from the resource.
  LResStream := TResourceStream.Create(HInstance, 'TxtHeader', 'TEXT');
  try
    LStrStream := TStringStream.Create();
    try
      LResStream.SaveToStream(LStrStream);
      LHeader := LStrStream.DataString;
    finally
      LStrStream.Free;
    end;
  finally
    LResStream.Free;
  end;
  // Writes the text to the editor.
  LEditor := OtaGetCurrentSourceEditor;
  if LEditor = nil then
    Exit;
  LWriter := LEditor.CreateUndoableWriter; // CreateWriter
  try
    OtaSourceWriteText(LWriter, LHeader + sLineBreak);
  finally
    LWriter := nil;
  end;
  // Move the cursor to the begin of file.
  LPosition.Line := 1;
  LPosition.Col := 1;
  LEditor.EditViews[0].CursorPos := LPosition;
  LEditor.EditViews[0].MoveViewToCursor; // this is needed in order to scroll!
end;

procedure TLicenseWizard.Modified;
begin
  // Not called for this wizard.
end;

function TLicenseWizard.OtaGetCurrentModule: IOTAModule;
begin
  if BorlandIDEServices = nil then
  begin
    Result := nil;
    Exit;
  end;
  with BorlandIDEServices as IOTAModuleServices do
    Result := CurrentModule;
end;

function TLicenseWizard.OtaGetCurrentSourceEditor: IOTASourceEditor;
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

function TLicenseWizard.OtaGetModuleSourceEditor(AModule: IOTAModule)
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

procedure TLicenseWizard.OtaSourceWriteText(AWriter: IOTAEditWriter;
  const ALine: string);
begin
  AWriter.Insert(PAnsiChar(AnsiString(ALine)));
end;

var
  WizardIndex: Integer = -1;

procedure Register;
begin
  with BorlandIDEServices as IOTAWizardServices do
    WizardIndex := AddWizard(TLicenseWizard.Create);
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
