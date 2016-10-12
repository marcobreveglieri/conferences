unit Telegram.Bot.Client;

interface

uses
  System.SysUtils, System.JSON, REST.Client, REST.Json, REST.Types,
  IPPeerClient,
  Telegram.Bot.Entities,
  Telegram.Bot.Parsers;

type

  TRESTRequestParamProc = reference to procedure (Params: TRESTRequestParameterList);

{ TTelegramClient }

  TTelegramClient = class (TObject)
  strict private
    FToken: string;
    function Execute(const ACommand: string; const AParamProc: TRESTRequestParamProc = nil): TJSONValue;
  public
    constructor Create(const AToken: string);
    function GetMe: TTelegramUser;
    function GetUpdates(const ARequest: TTelegramGetUpdatesRequest): TArray<TTelegramUpdate>;
    function SendLocation(const ARequest: TTelegramSendLocationRequest): TTelegramMessage;
    function SendMessage(const ARequest: TTelegramSendMessageRequest): TTelegramMessage;
    function SendVenue(const ARequest: TTelegramSendVenueRequest): TTelegramMessage;
  end;

implementation

{ TTelegramClient }

constructor TTelegramClient.Create(const AToken: string);
begin
  inherited Create;
  FToken := AToken;
end;

function TTelegramClient.GetMe: TTelegramUser;
begin
  Result := TTelegramJsonParser.ParseUser(Execute('getMe'));
end;

function TTelegramClient.GetUpdates(const ARequest: TTelegramGetUpdatesRequest): TArray<TTelegramUpdate>;
var
  R: TTelegramGetUpdatesRequest;
  JSON: TJSONValue;
begin
  R := ARequest;
  JSON := Execute('getUpdates',
    procedure (Params: TRESTRequestParameterList)
    begin
      with Params.AddItem do
      begin
        Name := 'offset';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Offset.ToString;
      end;
      with Params.AddItem do
      begin
        Name := 'limit';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Limit.ToString;
      end;
      with Params.AddItem do
      begin
        Name := 'timeout';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Timeout.ToString;
      end;
    end);
  Result := TTelegramJsonParser.ParseUpdates(JSON);
end;

function TTelegramClient.SendLocation(
  const ARequest: TTelegramSendLocationRequest): TTelegramMessage;
var
  R: TTelegramSendLocationRequest;
  JSON: TJSONValue;
begin
  R:= ARequest;
  JSON := Execute('sendLocation',
    procedure (Params: TRESTRequestParameterList)
    begin
      with Params.AddItem do
      begin
        Name := 'chat_id';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ChatID.ToString;
      end;
      with Params.AddItem do
      begin
        Name := 'latitude';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := FloatToJson(R.Latitude);
      end;
      with Params.AddItem do
      begin
        Name := 'longitude';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := FloatToJson(R.Longitude);
      end;
      with Params.AddItem do
      begin
        Name := 'disable_notification';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.DisableNotification.ToString.ToLower;
      end;
      with Params.AddItem do
      begin
        Name := 'reply_to_message_id';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ReplyToMessageID.ToString;
      end;
    end);
  Result := TTelegramJsonParser.ParseMessage(JSON);
end;

function TTelegramClient.SendMessage(
  const ARequest: TTelegramSendMessageRequest): TTelegramMessage;
var
  R: TTelegramSendMessageRequest;
  JsonResponse: TJSONValue;
begin
  R:= ARequest;
  JsonResponse := Execute('sendMessage',
    procedure (Params: TRESTRequestParameterList)
    begin
      with Params.AddItem do
      begin
        Name := 'chat_id';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ChatID.ToString;
      end;
      with Params.AddItem do
      begin
        Name := 'text';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Text;
      end;
      with Params.AddItem do
      begin
        Name := 'parse_mode';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ParseMode;
      end;
      with Params.AddItem do
      begin
        Name := 'disable_web_page_preview';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.DisableWebPagePreview.ToString.ToLower;
      end;
      with Params.AddItem do
      begin
        Name := 'disable_notification';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.DisableNotification.ToString.ToLower;
      end;
      if R.ReplyToMessageID > 0 then
        with Params.AddItem do
        begin
          Name := 'reply_to_message_id';
          Kind := TRESTRequestParameterKind.pkGETorPOST;
          Value := R.ReplyToMessageID.ToString;
        end;
      if Length(R.ReplyMarkup.Keyboard) > 0 then
      begin
        with Params.AddItem do
        begin
          Name := 'reply_markup';
          Kind := TRESTRequestParameterKind.pkGETorPOST;
          Value := '';
        end;
      end;
    end);
  Result := TTelegramJsonParser.ParseMessage(JsonResponse);
end;

function TTelegramClient.SendVenue(
  const ARequest: TTelegramSendVenueRequest): TTelegramMessage;
var
  R: TTelegramSendVenueRequest;
  JSON: TJSONValue;
begin
  R:= ARequest;
  JSON := Execute('sendVenue',
    procedure (Params: TRESTRequestParameterList)
    begin
      with Params.AddItem do
      begin
        Name := 'chat_id';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ChatID.ToString;
      end;
      with Params.AddItem do
      begin
        Name := 'latitude';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := FloatToJson(R.Latitude);
      end;
      with Params.AddItem do
      begin
        Name := 'longitude';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := FloatToJson(R.Longitude);
      end;
      with Params.AddItem do
      begin
        Name := 'title';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Title;
      end;
      with Params.AddItem do
      begin
        Name := 'address';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.Address;
      end;
      if Length(R.FoursquareID) > 0 then
        with Params.AddItem do
        begin
          Name := 'foursquare_id';
          Kind := TRESTRequestParameterKind.pkGETorPOST;
          Value := R.FoursquareID;
        end;
      if R.DisableNotification then
        with Params.AddItem do
        begin
          Name := 'disable_notification';
          Kind := TRESTRequestParameterKind.pkGETorPOST;
          Value := R.DisableNotification.ToString.ToLower;
        end;
      with Params.AddItem do
      begin
        Name := 'reply_to_message_id';
        Kind := TRESTRequestParameterKind.pkGETorPOST;
        Value := R.ReplyToMessageID.ToString;
      end;
    end);
  Result := TTelegramJsonParser.ParseMessage(JSON);
end;

function TTelegramClient.Execute(const ACommand: string; const AParamProc: TRESTRequestParamProc = nil): TJSONValue;
const
  StrBaseUrl = 'https://api.telegram.org/bot%s/';
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  Client := TRESTClient.Create(Format(StrBaseUrl, [FToken]));
  try
    Request := TRESTRequest.Create(nil);
    try
      Request.Client := Client;
      Request.Accept := 'application/json';
      Request.AcceptCharset := 'UTF-8, *;q=0.8';
      Request.HandleRedirects := True;
      Request.Resource := ACommand;
      if Assigned(AParamProc) then
        AParamProc(Request.Params);
      Request.SynchronizedEvents := False;
      Response := TRESTResponse.Create(nil);
      try
        Request.Response := Response;
        Request.Execute;
        Result := TJSONObject.ParseJSONValue(Response.Content);
        TTelegramJsonParser.CheckResponseOk(Result);
        Result := Result.GetValue<TJSONValue>('result');
      finally
        Response.Free;
      end;
    finally
      Request.Free;
    end;
  finally
    Client.Free;
  end;
end;

end.
