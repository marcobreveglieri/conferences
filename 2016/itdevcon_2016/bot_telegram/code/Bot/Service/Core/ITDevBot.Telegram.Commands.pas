unit ITDevBot.Telegram.Commands;

interface

uses
  System.Classes, System.SysUtils, System.RegularExpressions,
  Telegram.Bot.Entities, Telegram.Bot.Client, ITDevBot.Data.Entities,
  ITDevBot.Data.Repository.Factory, ITDevBot.Data.Repository.Interfaces;

type

  ITelegramCommand = interface
    ['{B7F42B03-AC9C-4D89-9F97-E87C3AD8A0E9}']
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandBroadcast = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandHelp = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandInfo = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandLocation = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandSpeakerDetail = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandSpeakerList = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandSessionList = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandSponsors = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandStart = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

  TTelegramCommandSubscription = class(TInterfacedObject, ITelegramCommand)
  public
    function Handle(Client: TTelegramClient; Update: TTelegramUpdate): Boolean;
  end;

implementation

{ TTelegramCommandInfo }

function TTelegramCommandInfo.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Request: TTelegramSendMessageRequest;
begin
  Result := False;
  if LowerCase(Update.Message.Text) = '/info' then
  begin
    Request.ChatID := Update.Message.Chat.ChatID;
    Request.Text :=
      '<strong>ITDevCon</strong> is coming back on 6th and 7th October 2016. ' +
      'The innovative feature of this edition is the location. ' +
      'This year, the European Conference for Delphi developers will be held in Rome. '
      + 'We will discuss about the main improvements of the RAD Studio suite and '
      + 'how is now possible work in a fluid development environment that makes '
      + 'your workflow more efficient. ' +
      'We will also talk about new technologies and development, also for mobile, '
      + 'on different platforms: Windows, MacOSX, iOS and Android. ' +
      'It will be a great edition! <strong>See you there!</strong>';
    Request.ParseMode := 'HTML';
    Request.DisableWebPagePreview := True;
    Client.SendMessage(Request);
    Result := True;
  end;
end;

{ TTelegramCommandLocation }

function TTelegramCommandLocation.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Request: TTelegramSendVenueRequest;
begin
  Result := False;
  if LowerCase(Update.Message.Text) = '/location' then
  begin
    Request.ChatID := Update.Message.Chat.ChatID;
    Request.Title := 'Bit Time Group';
    Request.Address := 'Via di Valle Morta, 10 - Roma';
    Request.Latitude := 41.844304;
    Request.Longitude := 12.6854119;
    Request.DisableNotification := False;
    Client.SendVenue(Request);
    Result := True;
  end;
end;

{ TTelegramCommandSponsors }

function TTelegramCommandSponsors.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Markup: TStringBuilder;
  Request: TTelegramSendMessageRequest;
  Repository: IDevConRepository<TDevConSponsor>;
  Sponsor: TDevConSponsor;
begin
  Result := False;
  if LowerCase(Update.Message.Text) = '/sponsors' then
  begin
    Repository := TConSqlRepositoryFactory.GetSponsorRepository;
    Markup := TStringBuilder.Create();
    try
      Markup.AppendLine('Here are our sponsors:');
      Markup.AppendLine();
      for Sponsor in Repository.GetAll do
      begin
        Markup.AppendFormat('<strong>%s</strong> (<a href="%s">%s</a>)',
          [Sponsor.Name, Sponsor.Homepage, Sponsor.Homepage]).AppendLine();
      end;
      Markup.AppendLine();
      Request.ChatID := Update.Message.Chat.ChatID;
      Request.Text := Markup.ToString;
      Request.ParseMode := 'HTML';
      Request.DisableWebPagePreview := True;
      Client.SendMessage(Request);
    finally
      Markup.Free;
    end;
    Result := True;
  end;
end;

{ TTelegramCommandStart }

function TTelegramCommandStart.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Request: TTelegramSendMessageRequest;
  Markup: TStringBuilder;
begin
  Result := False;
  if LowerCase(Update.Message.Text) <> '/start' then
    Exit;
  Markup := TStringBuilder.Create;
  try
    Markup.AppendLine('Welcome to the *ITDevCon Telegram Bot*!');
    Markup.AppendLine('Please, go _easy_ with me: I am a demo version. :)');
    Markup.AppendLine();
    Markup.AppendLine('For a list of which commands are available, tap /help.');
    Request.Text := Markup.ToString;
  finally
    Markup.Free;
  end;
  Request.ChatID := Update.Message.Chat.ChatID;
  Request.ParseMode := 'Markdown';
  Request.DisableWebPagePreview := False;
  Request.DisableNotification := False;
  Request.ReplyToMessageID := 0;
  Client.SendMessage(Request);
  Result := True;
end;

{ TTelegramCommandSpeakerList }

function TTelegramCommandSpeakerList.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Markup: TStringBuilder;
  Request: TTelegramSendMessageRequest;
  Repository: IDevConRepository<TDevConSpeaker>;
  Speaker: TDevConSpeaker;
begin
  Result := False;
  if LowerCase(Update.Message.Text) = '/speakers' then
  begin
    Repository := TConSqlRepositoryFactory.GetSpeakerRepository;
    Markup := TStringBuilder.Create();
    try
      Markup.AppendLine('Here are our speaker list:');
      Markup.AppendLine();
      for Speaker in Repository.GetAll do
      begin
        Markup.AppendFormat('<strong>%s</strong> /speaker_%d',
          [Speaker.Name, Speaker.Id]).AppendLine()
          .AppendFormat(' (<em>%s</em>)', [Speaker.Role]).AppendLine();
      end;
      Markup.AppendLine()
        .Append('Click on a speaker link to view his/her bio.');
      Request.ChatID := Update.Message.Chat.ChatID;
      Request.Text := Markup.ToString;
      Request.ParseMode := 'HTML';
      Request.DisableWebPagePreview := True;
      Client.SendMessage(Request);
    finally
      Markup.Free;
    end;
    Result := True;
  end;
end;

{ TTelegramCommandSpeakerDetail }

function TTelegramCommandSpeakerDetail.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  CommandRegEx: TRegEx;
  CommandMatch: TMatch;
  Repository: IDevConRepository<TDevConSpeaker>;
  Speaker: TDevConSpeaker;
  Markup: TStringBuilder;
  Request: TTelegramSendMessageRequest;
  Id: Integer;
begin
  Result := False;
  CommandRegEx := TRegEx.Create('\/speaker_(\d+)');
  CommandMatch := CommandRegEx.Match(LowerCase(Update.Message.Text));
  if not CommandMatch.Success then
    Exit;
  Id := StrToIntDef(CommandMatch.Groups[1].Value, -1);
  Repository := TConSqlRepositoryFactory.GetSpeakerRepository;
  if not Repository.GetItemByID(Id, Speaker) then
    Exit;
  Markup := TStringBuilder.Create;
  try
    Markup.AppendFormat('<strong>%s</strong>', [Speaker.Name]).AppendLine()
      .AppendFormat('<em>%s</em>', [Speaker.Role]).AppendLine();
    if Length(Speaker.Homepage) > 0 then
      Markup.AppendFormat('<a href="%s">%s</a>',
        [Speaker.Homepage, Speaker.Homepage]).AppendLine();
    Markup.Append(Speaker.Bio);
    Request.ChatID := Update.Message.Chat.ChatID;
    Request.Text := Markup.ToString;
    Request.ParseMode := 'HTML';
    Request.DisableWebPagePreview := True;
    Client.SendMessage(Request);
  finally
    Markup.Free;
  end;
  Result := True;
end;

{ TTelegramCommandSessionList }

function TTelegramCommandSessionList.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Text: string;
  PeriodStart, PeriodEnd: TDateTime;
  Markup: TStringBuilder;
  Request: TTelegramSendMessageRequest;
  AgendaRepository: IDevConRepository<TDevConAgenda>;
  SpeakerRepository: IDevConRepository<TDevConSpeaker>;
  AgendaItem: TDevConAgenda;
  SpeakerItem: TDevConSpeaker;
  RoomName: string;
begin
  Result := False;
  Text := LowerCase(Update.Message.Text);

  // Day selection
  if Text = '/sessions' then
  begin
    Markup := TStringBuilder.Create;
    try
      Markup.AppendLine('Select the day of your interest:').AppendLine();
      Markup.AppendLine('<strong>Day 1</strong>')
        .AppendLine('<em>Thursday 06 October</em>')
        .AppendLine('/sessions_day1');
      Markup.AppendLine('<strong>Day 2</strong>')
        .AppendLine('<em>Friday 07 October</em>').AppendLine('/sessions_day2');
      Request.Text := Markup.ToString;
    finally
      Markup.Free;
    end;
    Request.ChatID := Update.Message.Chat.ChatID;
    Request.ParseMode := 'HTML';
    Request.DisableWebPagePreview := True;
    Client.SendMessage(Request);
    Result := True;
    Exit;
  end;

  // Session list for day
  if (Text = '/sessions_day1') then
  begin
    PeriodStart := EncodeDate(2016, 10, 6);
    PeriodEnd := EncodeDate(2016, 10, 7);
  end
  else if (Text = '/sessions_day2') then
  begin
    PeriodStart := EncodeDate(2016, 10, 7);
    PeriodEnd := EncodeDate(2016, 10, 8);
  end
  else
    Exit;

  AgendaRepository := TConSqlRepositoryFactory.GetAgendaRepository;
  SpeakerRepository := TConSqlRepositoryFactory.GetSpeakerRepository;

  Markup := TStringBuilder.Create;
  try
    for AgendaItem in AgendaRepository.GetAll do
    begin
      if (AgendaItem.When < PeriodStart) or (AgendaItem.When >= PeriodEnd) then
        Continue;

      if AgendaItem.EventKind <> TDevConEventKind.Speech then
      begin
        Markup.Append(FormatDateTime('t', AgendaItem.When)).AppendLine()
          .AppendFormat('<em>%s</em>', [AgendaItem.Title]).AppendLine()
          .AppendLine();
      end
      else
      begin
        Markup.Append(FormatDateTime('t', AgendaItem.When));
        if SpeakerRepository.GetItemByID(AgendaItem.SpeakerId, SpeakerItem) then
          Markup.AppendFormat(' -- %s', [SpeakerItem.Name]);
        Markup.AppendLine();
        Markup.AppendFormat('<strong>%s</strong>', [AgendaItem.Title])
          .AppendLine();
        if AgendaItem.Room <> TDevConRoom.NA then
        begin
          case AgendaItem.Room of
            TDevConRoom.Kirk:
              RoomName := 'Kirk';
            TDevConRoom.Spock:
              RoomName := 'Spock';
          end;
          Markup.AppendFormat(' @ %s', [RoomName]).AppendLine();
        end;

        Markup.AppendLine();
      end;

    end;
    Request.Text := Markup.ToString;
  finally
    Markup.Free;
  end;

  Request.ChatID := Update.Message.Chat.ChatID;
  Request.ParseMode := 'HTML';
  Request.DisableWebPagePreview := True;
  Client.SendMessage(Request);

  Result := True;
end;

{ TTelegramCommandSubscription }

function TTelegramCommandSubscription.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Request: TTelegramSendMessageRequest;
  SubcriptionStatus: Boolean;
  SubscriptionItem: TDevConSubscription;
  SubscriptionRepository: IDevConRepository<TDevConSubscription>;
begin
  Result := False;

  if LowerCase(Update.Message.Text) = '/subscribe' then
    SubcriptionStatus := True
  else if LowerCase(Update.Message.Text) = '/unsubscribe' then
    SubcriptionStatus := False
  else
    Exit;

  SubscriptionItem.ChatID := Update.Message.Chat.ChatID;
  SubscriptionItem.UserName := Update.Message.From.UserName;

  SubscriptionRepository := TConSqlRepositoryFactory.GetSubscriptionRepository;

  if SubcriptionStatus then
  begin
    SubscriptionRepository.InsertOrUpdateItem(SubscriptionItem);
    Request.Text :=
      'I am happy you have *subscribed* to notifications. Thanks!';
  end
  else
  begin
    SubscriptionRepository.DeleteItem(SubscriptionItem);
    Request.Text := 'I am sorry you have *unsubscribed* to notifications. :(';
  end;

  Request.ChatID := Update.Message.Chat.ChatID;
  Request.ParseMode := 'Markdown';
  Request.DisableWebPagePreview := True;
  Client.SendMessage(Request);
  Result := True;
end;

{ TTelegramCommandBroadcast }

function TTelegramCommandBroadcast.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
const
  StrCommandName = '/broadcast_message';
var
  Request: TTelegramSendMessageRequest;
  SubscriptionRepository: IDevConRepository<TDevConSubscription>;
  MessageText: string;
  SubscriptionItem: TDevConSubscription;
  CountDone, CountTotal: Integer;
begin
  Result := False;

  if not LowerCase(Update.Message.Text).StartsWith(StrCommandName, False) then
    Exit;

  MessageText := Update.Message.Text.Replace(StrCommandName, EmptyStr).Trim();

  SubscriptionRepository := TConSqlRepositoryFactory.GetSubscriptionRepository;

  CountDone := 0;
  CountTotal := 0;

  for SubscriptionItem in SubscriptionRepository.GetAll do
  begin
    Inc(CountTotal);
    try
      Request.ChatID := SubscriptionItem.ChatID;
      Request.Text := MessageText;
      Request.ParseMode := 'Markdown';
      Request.DisableWebPagePreview := False;
      Client.SendMessage(Request);
      Inc(CountDone);
    except
      on E: Exception do
        // TODO: Log exception
    end;
  end;

  // Final report
  Request.ChatID := Update.Message.Chat.ChatID;
  Request.Text := Format('Broadcast message sent to *%d* of *%d*.',
    [CountDone, CountTotal]);
  Request.ParseMode := 'Markdown';
  Request.DisableWebPagePreview := False;
  Client.SendMessage(Request);

  Result := True;
end;

{ TTelegramCommandHelp }

function TTelegramCommandHelp.Handle(Client: TTelegramClient;
  Update: TTelegramUpdate): Boolean;
var
  Markup: TStringBuilder;
  Request: TTelegramSendMessageRequest;
begin
  Result := False;

  if LowerCase(Update.Message.Text) <> '/help' then
    Exit;

  Markup := TStringBuilder.Create;
  try
    Markup.AppendLine
      ('This bot supports the following main <em>commands</em>:');

    Markup.AppendLine();

    Markup.AppendFormat('%s - %s',
      ['/help', 'Display this help message']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/info', 'Get general information about ITDevCon']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/location', 'Get the location of the event']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/sessions', 'Show the list of planned talks by day']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/speakers', 'Show the list of the speakers']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/sponsors', 'Show the conference sponsor information']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/subscribe', 'Subscribe to live notifications']).AppendLine();
    Markup.AppendFormat('%s - %s',
      ['/unsubscribe', 'Unsubscribe from live notifications']).AppendLine();

    Markup.AppendLine();

    Markup.AppendLine
      ('Found bugs? Tell them to my creator <strong>Marco Breveglieri</strong>: @marco_alka');

    Request.Text := Markup.ToString;
  finally
    Markup.Free;
  end;

  Request.ChatID := Update.Message.Chat.ChatID;
  Request.ParseMode := 'HTML';
  Request.DisableWebPagePreview := True;
  Client.SendMessage(Request);
  Result := True;
end;

end.
