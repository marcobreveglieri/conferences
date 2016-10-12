unit TelegramClientIntegrationTests;

interface

uses
  TestFramework, System.SysUtils, REST.Types, System.JSON, Telegram.Bot.Entities,
  REST.Client, IPPeerClient, Telegram.Bot.Parsers, Telegram.Bot.Client;

type

  TestTTelegramHttpClient = class(TTestCase)
  strict private
    FClient: TTelegramClient;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetMe;
    procedure TestGetUpdates;
    procedure TestSendMessage;
    procedure TestGetUpdatesAndReplyToThem;
  end;

implementation

procedure TestTTelegramHttpClient.SetUp;
begin
  FClient := TTelegramClient.Create('000000000:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA_????');
end;

procedure TestTTelegramHttpClient.TearDown;
begin
  if FClient <> nil then
  begin
    FClient.Free;
    FClient := nil;
  end;
end;

procedure TestTTelegramHttpClient.TestGetMe;
var
  User: TTelegramUser;
begin
  User := FClient.GetMe;
  Assert(User.FirstName <> EmptyStr);
end;

procedure TestTTelegramHttpClient.TestGetUpdates;
var
  Request: TTelegramGetUpdatesRequest;
  Updates: TArray<TTelegramUpdate>;
begin
  Request.Offset := 0;
  Request.Limit := 100;
  Request.Timeout := 1000;
  Updates := FClient.GetUpdates(Request);
  Assert(Length(Updates) >= 0);
end;

procedure TestTTelegramHttpClient.TestGetUpdatesAndReplyToThem;
var
  UpdateList: TArray<TTelegramUpdate>;
  UpdateItem: TTelegramUpdate;
  UpdateRequest: TTelegramGetUpdatesRequest;
  LastUpdateID: Int64;
  Request: TTelegramSendMessageRequest;
  i: Integer;
begin
  LastUpdateID := -1;
  for i := 1 to 10 do
  begin
    UpdateRequest.Offset := LastUpdateID + 1;
    UpdateRequest.Limit := 100;
    UpdateRequest.Timeout := 30;
    UpdateList := FClient.GetUpdates(UpdateRequest);
    for UpdateItem in UpdateList do
    begin
      LastUpdateID := UpdateItem.UpdateID;
      if UpdateItem.Message.Text = EmptyStr then
        Continue;
      Request.ChatID := UpdateItem.Message.Chat.ChatID;
      Request.Text := '_Echo:_ ' + UpdateItem.Message.Text;
      Request.ParseMode := 'Markdown';
      Request.DisableWebPagePreview := False;
      Request.DisableNotification := False;
      Request.ReplyToMessageID := 0;
      FClient.SendMessage(Request);
    end;
  end;
end;

procedure TestTTelegramHttpClient.TestSendMessage;
var
  Request: TTelegramSendMessageRequest;
  Message: TTelegramMessage;
begin
  Request.ChatID := 0;
  Request.Text := 'Questa _risposta_ è un semplice *test*';
  Request.ParseMode := 'Markdown';
  Request.DisableWebPagePreview := False;
  Request.DisableNotification := False;
  Request.ReplyToMessageID := 1;
  Message := FClient.SendMessage(Request);
  Assert(Message.MessageID > 0);
end;

initialization

  RegisterTest(TestTTelegramHttpClient.Suite);

end.
