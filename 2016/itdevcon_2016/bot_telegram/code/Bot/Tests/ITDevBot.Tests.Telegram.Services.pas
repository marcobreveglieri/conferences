unit ITDevBot.Tests.Telegram.Services;

interface

uses
  System.Generics.Collections, System.SysUtils, Winapi.Windows, Winapi.SHFolder,
  TestFramework,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  ITDevBot.Data.Entities, ITDevBot.Data.Repository.Interfaces,
  ITDevBot.Data.Repository.Factory,
  ITDevBot.Telegram.Services;

type

  TIntegrationTestCaseForBotTelegramBroker = class(TTestCase)
  strict private
    FBroker: TDevConTelegramBot;
    function GetConfigFilePath: string;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRunOK;
  end;

implementation

function TIntegrationTestCaseForBotTelegramBroker.GetConfigFilePath: string;
var
  Path: array [0 .. MAX_PATH] of Char;
begin
  if SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, Path) = 0 then
    Result := IncludeTrailingPathDelimiter(Path) + 'ITDevConBot_ALFA.ini'
  else
    Result := '';
end;

procedure TIntegrationTestCaseForBotTelegramBroker.SetUp;
begin
  FBroker := TDevConTelegramBot.Create(GetConfigFilePath);
end;

procedure TIntegrationTestCaseForBotTelegramBroker.TearDown;
begin
  if FBroker <> nil then
    FBroker.Free;
end;

procedure TIntegrationTestCaseForBotTelegramBroker.TestRunOK;
begin
  FBroker.ProcessUpdates;
end;

initialization

RegisterTest(TIntegrationTestCaseForBotTelegramBroker.Suite);

end.
