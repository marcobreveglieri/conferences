unit Telegram.Bot.Parsers;

interface

uses
  System.SysUtils, System.JSON, System.DateUtils,
  Telegram.Bot.Entities;

type

{ TTelegramJsonParser }

  TTelegramJsonParser = class
  public
    class procedure CheckResponseOk(JSON: TJSONValue);
    class function ParseChat(AValue: TJSONValue): TTelegramChat;
    class function ParseMessage(AValue: TJSONValue): TTelegramMessage;
    class function ParseUser(AValue: TJSONValue): TTelegramUser;
    class function ParseUpdates(AValue: TJSONValue): TArray<TTelegramUpdate>;
  end;

implementation

{ TTelegramJsonParser }

class procedure TTelegramJsonParser.CheckResponseOk(JSON: TJSONValue);
begin
  if (JSON.GetValue<Boolean>('ok') <> true) then
    raise Exception.Create('Response error'); // TODO: Parse error message!
end;

class function TTelegramJsonParser.ParseChat(AValue: TJSONValue): TTelegramChat;
begin
  Result.ChatID := AValue.GetValue<Int64>('id');
  Result.FirstName := AValue.GetValue<string>('first_name');
  if not AValue.TryGetValue('username', Result.UserName) then
    Result.UserName := EmptyStr;
  Result.ChatType := AValue.GetValue<string>('type');
end;

class function TTelegramJsonParser.ParseMessage(AValue: TJSONValue): TTelegramMessage;
begin
  Result.MessageID := AValue.GetValue<Int64>('message_id');
  Result.From := ParseUser(AValue.GetValue<TJSONObject>('from'));
  Result.Chat := ParseChat(AValue.GetValue<TJSONObject>('chat'));
  Result.Date := UnixToDateTime(AValue.GetValue<Int64>('date'));
  if not AValue.TryGetValue('text', Result.Text) then
    Result.Text := EmptyStr;
end;

class function TTelegramJsonParser.ParseUpdates(AValue: TJSONValue): TArray<TTelegramUpdate>;
var
  Data: TJSONArray;
  Item: TJSONValue;
  I: Integer;
begin
  Data := AValue as TJSONArray;
  SetLength(Result, Data.Count);
  for I := 0 to Data.Count - 1 do
  begin
    Item := Data.Items[I];
    Result[I].UpdateID := Item.GetValue<Int64>('update_id');
    Result[I].Message := ParseMessage(Item.GetValue<TJSONObject>('message'));
  end;
end;

class function TTelegramJsonParser.ParseUser(AValue: TJSONValue): TTelegramUser;
begin
  Result.UserID := AValue.GetValue<Int64>('id');
  Result.FirstName := AValue.GetValue<string>('first_name');
  if not AValue.TryGetValue('username', Result.UserName) then
    Result.UserName := EmptyStr;
end;

end.
