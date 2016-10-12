unit ITDevBot.Telegram.Services;

interface

uses
  System.Classes, System.SysUtils, System.IniFiles, System.Generics.Collections,
  Telegram.Bot.Entities, Telegram.Bot.Client,
  ITDevBot.Data.Entities, ITDevBot.Telegram.Commands;

type

  TDevConTelegramBot = class
  strict private
    FClient: TTelegramClient;
    FCommands: TList<ITelegramCommand>;
    FIniFile: TMemIniFile;
  strict protected
    procedure HandleUpdate(AUpdate: TTelegramUpdate);
  public
    constructor Create(const AConfigFilePath: string);
    destructor Destroy; override;
    procedure ProcessUpdates;
  end;

implementation

uses
  ITDevBot.Data.Repository.Factory, ITDevBot.Data.Repository.Interfaces;

constructor TDevConTelegramBot.Create(const AConfigFilePath: string);
begin
  inherited Create();
  if not FileExists(AConfigFilePath) then
    raise Exception.Create('File di configurazione non esistente nel percorso: '+ AConfigFilePath);
  FCommands := TList<ITelegramCommand>.Create;
  FCommands.Add(TTelegramCommandStart.Create);
  FCommands.Add(TTelegramCommandInfo.Create);
  FCommands.Add(TTelegramCommandLocation.Create);
  FCommands.Add(TTelegramCommandSponsors.Create);
  FCommands.Add(TTelegramCommandSpeakerList.Create);
  FCommands.Add(TTelegramCommandSpeakerDetail.Create);
  FCommands.Add(TTelegramCommandSessionList.Create);
  FCommands.Add(TTelegramCommandSubscription.Create);
  FCommands.Add(TTelegramCommandBroadcast.Create);
  FCommands.Add(TTelegramCommandHelp.Create);
  FIniFile := TMemIniFile.Create(AConfigFilePath);
  FClient := TTelegramClient.Create(FIniFile.ReadString('Bot', 'Token',
    EmptyStr));
  TConSqlRepositoryFactory.ConnectionString := Format('Database=%s;DriverID=%s',
    [FIniFile.ReadString('DB', 'Database', EmptyStr), FIniFile.ReadString('DB',
    'DriverID', EmptyStr)]);
end;

destructor TDevConTelegramBot.Destroy;
begin
  if FClient <> nil then
    FreeAndNil(FClient);
  if FCommands <> nil then
    FreeAndNil(FCommands);
  if FIniFile <> nil then
    FreeAndNil(FIniFile);
  inherited Destroy;
end;

procedure TDevConTelegramBot.HandleUpdate(AUpdate: TTelegramUpdate);
var
  Command: ITelegramCommand;
  Request: TTelegramSendMessageRequest;
begin
  for Command in FCommands do
  begin
    if Command.Handle(FClient, AUpdate) then
      Exit;
  end;
  // Send the sorry message.
  Request.ChatID := AUpdate.Message.Chat.ChatID;
  Request.Text := 'Sorry, I did not understand your request. :)';
  Request.ParseMode := 'Markdown';
  Request.DisableWebPagePreview := False;
  Request.DisableNotification := False;
  Request.ReplyToMessageID := 0;
  FClient.SendMessage(Request);
end;

procedure TDevConTelegramBot.ProcessUpdates;
var
  UpdateList: TArray<TTelegramUpdate>;
  UpdateItem: TTelegramUpdate;
  Request: TTelegramGetUpdatesRequest;
begin
  Request.Offset := Int64.Parse(FIniFile.ReadString('Updates', 'LastID', '-1')) + 1;
  Request.Limit := FIniFile.ReadInteger('Updates', 'Limit', 100);
  Request.Timeout := FIniFile.ReadInteger('Updates', 'Timeout', 120);

  UpdateList := FClient.GetUpdates(Request);

  for UpdateItem in UpdateList do
  begin
    FIniFile.WriteInteger('Updates', 'LastID', UpdateItem.UpdateID);
    FIniFile.UpdateFile;
    try
      HandleUpdate(UpdateItem);
    except
      // TODO: Exception handling
    end;
  end;
end;

end.
