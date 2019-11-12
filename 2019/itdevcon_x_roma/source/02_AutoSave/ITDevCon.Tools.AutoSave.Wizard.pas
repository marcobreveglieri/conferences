unit ITDevCon.Tools.AutoSave.Wizard;

interface

uses
  System.SysUtils, System.IniFiles,
  Vcl.ExtCtrls, Vcl.Menus,
  ToolsAPI,
  ITDevCon.Tools.AutoSave.Options;

type

  TAutoSaveWizard = class(TInterfacedObject, IOTAWizard)
  private
    FIniPath: string;
    FMenuItem: TMenuItem;
    FOptions: TAutoSaveOptions;
    FTimer: TTimer;
    procedure HandleMenuClick(Sender: TObject);
    procedure HandleTimerTick(Sender: TObject);
  protected
    procedure InitializeIniPath;
    procedure InitializeMenu;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure UpdateFiles;
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
  Winapi.Windows,
  ITDevCon.Tools.AutoSave.Dialog;

constructor TAutoSaveWizard.Create;
begin
  inherited Create;
  FOptions.Enabled := True;
  FOptions.Interval := 5;
  FTimer := TTimer.Create(nil);
  FTimer.OnTimer := HandleTimerTick;
  FTimer.Enabled := False;
  InitializeIniPath;
  InitializeMenu;
  LoadSettings;
end;

destructor TAutoSaveWizard.Destroy;
begin
  if FMenuItem <> nil then
    FreeAndNil(FMenuItem);
  if FTimer <> nil then
    FreeAndNil(FTimer);
  inherited Destroy;
end;

procedure TAutoSaveWizard.AfterSave;
begin
  // Not called for this wizard.
end;

procedure TAutoSaveWizard.BeforeSave;
begin
  // Not called for this wizard.
end;

procedure TAutoSaveWizard.Destroyed;
begin
  // Resources are freed in destructor.
end;

procedure TAutoSaveWizard.Execute;
begin
  // Not called for this wizard.
end;

function TAutoSaveWizard.GetIDString: string;
begin
  Result := 'ITDevCon.Tools.AutoSave';
end;

function TAutoSaveWizard.GetName: string;
begin
  Result := 'ITDevCon Tools - Auto Save';
end;

function TAutoSaveWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TAutoSaveWizard.HandleMenuClick(Sender: TObject);
begin
  if not TAutoSaveDialog.Configure(FOptions) then
    Exit;
  SaveSettings;
  LoadSettings;
end;

procedure TAutoSaveWizard.HandleTimerTick(Sender: TObject);
begin
  FTimer.Enabled := False;
  try
    UpdateFiles;
  finally
    FTimer.Enabled := FOptions.Enabled;
  end;
end;

procedure TAutoSaveWizard.InitializeIniPath;
var
  LPath: string;
  LSize: Cardinal;
begin
  SetLength(LPath, MAX_PATH);
  LSize := GetModuleFileName(HInstance, PChar(LPath), MAX_PATH);
  SetLength(LPath, LSize);
  FIniPath := ChangeFileExt(LPath, '.ini');
end;

procedure TAutoSaveWizard.InitializeMenu;
var
  LNTAServices: INTAServices;
  LDivMenuItem, LViewMenuItem: TMenuItem;
begin
  LNTAServices := BorlandIDEServices as INTAServices;
  if LNTAServices.MainMenu = nil then
    Exit;
  LViewMenuItem := LNTAServices.MainMenu.Items.Find('View');
  if LViewMenuItem = nil then
    Exit;
  FMenuItem := TMenuItem.Create(LViewMenuItem);
  with FMenuItem do
  begin
    Caption := '&Auto Save Options...';
    ShortCut := TextToShortCut('Ctrl+Shift+Alt+A');
    OnClick := HandleMenuClick;
  end;
  LDivMenuItem := LViewMenuItem.Find('-');
  if LDivMenuItem <> nil then
    LViewMenuItem.Insert(LDivMenuItem.MenuIndex, FMenuItem)
  else
    LViewMenuItem.Add(FMenuItem);
end;

procedure TAutoSaveWizard.LoadSettings;
begin
  with TIniFile.Create(FIniPath) do
  begin
    try
      FOptions.Enabled := ReadBool('Options', 'Enabled', FOptions.Enabled);
      FOptions.Interval := ReadInteger('Options', 'Interval', FOptions.Interval);
    finally
      Free;
    end;
  end;
  FTimer.Interval := FOptions.Interval * 1000;
  FTimer.Enabled := FOptions.Enabled;
end;

procedure TAutoSaveWizard.Modified;
begin
  // Not called for this wizard.
end;

procedure TAutoSaveWizard.SaveSettings;
begin
  with TIniFile.Create(FIniPath) do
  begin
    try
      WriteBool('Options', 'Enabled', FOptions.Enabled);
      WriteInteger('Options', 'Interval', FOptions.Interval);
    finally
      Free;
    end;
  end;
end;

procedure TAutoSaveWizard.UpdateFiles;
var
  LServices: IOTAEditorServices;
  LIterator: IOTAEditBufferIterator;
  LEditBuffer: IOTAEditBuffer;
  LIndex: Integer;
begin
  LServices := BorlandIDEServices as IOTAEditorServices;
  if LServices = nil then
    Exit;
  if not LServices.GetEditBufferIterator(LIterator) then
    Exit;
  for LIndex := 0 to LIterator.Count - 1 do
  begin
    LEditBuffer := LIterator.EditBuffers[LIndex];
    if not LEditBuffer.IsModified then
      Continue;
    LEditBuffer.Module.Save(False, True);
  end;
end;

var
  WizardIndex: Integer = -1;

procedure Register;
var
  LServices: IOTAWizardServices;
begin
  LServices := (BorlandIDEServices as IOTAWizardServices);
  WizardIndex := LServices.AddWizard(TAutoSaveWizard.Create);
end;

procedure Unregister;
var
  LServices: IOTAWizardServices;
begin
  if WizardIndex < 0 then
    Exit;
  LServices := (BorlandIDEServices as IOTAWizardServices);
  LServices.RemoveWizard(WizardIndex);
end;

initialization

finalization

Unregister;

end.
