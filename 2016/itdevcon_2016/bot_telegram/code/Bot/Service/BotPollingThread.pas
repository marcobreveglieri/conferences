unit BotPollingThread;

interface

uses
  System.Classes,
  ITDevBot.Telegram.Services;

type
  TDevConBotThread = class(TThread)
  strict private
    FBroker: TDevConTelegramBot;
    function GetConfigFilePath: string;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.Windows, Winapi.SHFolder;

{ BotPollingThread }

constructor TDevConBotThread.Create;
begin
  inherited Create(True);
  FBroker := TDevConTelegramBot.Create(GetConfigFilePath);
end;

destructor TDevConBotThread.Destroy;
begin
  if FBroker <> nil then
    FreeAndNil(FBroker);
  inherited Destroy;
end;

procedure TDevConBotThread.Execute;
begin
  if FBroker = nil then
    Exit;
  while not Terminated do
  begin
    try
      FBroker.ProcessUpdates;
    except on E: Exception do
      //TFile.AppendAllText('C:\Apps\ITDevConBot\Log\Log.txt', E.Message + #13#10);
    end;
    Sleep(100);
  end;
end;

function TDevConBotThread.GetConfigFilePath: string;
var
  Path: array [0 .. MAX_PATH] of Char;
begin
  if SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, Path) = 0 then
    Result := IncludeTrailingPathDelimiter(Path) + 'ITDevConBot.ini'
  else
    Result := '';
end;

end.
