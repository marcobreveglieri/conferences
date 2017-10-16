unit IR.Core.App;

interface

uses
  System.IniFiles, System.IOUtils;

type

  TIRApp = class
  strict private
    FIni: TMemIniFile;
  public
    property Ini: TMemIniFile read FIni;
    constructor Create;
    destructor Destroy; override;
  end;

  function IRApp: TIRApp;
  procedure IRFreeApp;

implementation

var
  IRAppInstance: TIRApp = nil;

function IRApp: TIRApp;
begin
  if IRAppInstance = nil then
    IRAppInstance := TIRApp.Create;
  Result := IRAppInstance;
end;

procedure IRFreeApp;
begin
  if IRAppInstance = nil then
    Exit;
  IRAppInstance.Free;
end;

{ TIRApp }

constructor TIRApp.Create;
begin
  inherited Create;
  FIni := TMemIniFile.Create(TPath.Combine(TPath.GetLibraryPath, 'AppConfig.ini'));
end;

destructor TIRApp.Destroy;
begin
  if FIni <> nil then
    FIni.Free;
  inherited Destroy;
end;

initialization

finalization

  if IRAppInstance <> nil then
    IRAppInstance.Free;

end.
