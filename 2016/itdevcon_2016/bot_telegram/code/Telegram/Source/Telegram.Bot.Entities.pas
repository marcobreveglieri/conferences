unit Telegram.Bot.Entities;

interface

type

  TTelegramChat = record
    ChatID: Int64;
    ChatType: string;
    Title: string;
    UserName: string;
    FirstName: string;
    LastName: string;
  end;

  TTelegramUser = record
    UserID: Int64;
    FirstName: string;
    LastName: string;
    UserName: string;
  end;

  TTelegramMessageEntity = record
    EntityType: string;
    Offset: Integer;
    Length: Integer;
    Url: string;
    User: TTelegramUser;
  end;

  TTelegramPhotoSize = record
    FileID: string;
    Width: Integer;
    Height: Integer;
    FileSize: Integer;
  end;

  TTelegramAudio = record
    FileID: string;
    Duration: Integer;
    Performer: string;
    Title: string;
    MimeType: string;
    FileSize: Integer;
  end;

  TTelegramDocument = record
    FileID: string;
    Thumb: TTelegramPhotoSize;
    FileName: string;
    MimeType: string;
    FileSize: Integer;
  end;

  TTelegramSticker = record
    FileID: string;
    Width: Integer;
    Height: Integer;
    Thumb: TTelegramPhotoSize;
    Emoji: string;
    FileSize: Integer;
  end;

  TTelegramVideo = record
    FileID: string;
    Width: Integer;
    Height: Integer;
    Duration: Integer;
    Thumb: TTelegramPhotoSize;
    MimeType: string;
    FileSize: Integer;
  end;

  TTelegramVoice = record
    FileID: string;
    Duration: Integer;
    MimeType: string;
    FileSize: Integer;
  end;

  TTelegramContact = record
    PhoneNumber: string;
    FirstName: string;
    LastName: string;
    UserID: Int64;
  end;

  TTelegramLocation = record
    Longitude: Double;
    Latitude: Double;
  end;

  TTelegramVenue = record
    Location: TTelegramLocation;
    Title: string;
    Address: string;
    FoursquareID: string;
  end;

  PTelegramMessage = ^TTelegramMessage;

  TTelegramMessage = record
    MessageID: Int64;
    From: TTelegramUser;
    Date: TDateTime; // UNIX time
    Chat: TTelegramChat;
    ForwardFrom: TTelegramUser;
    ForwardFromChat: TTelegramChat;
    ForwardDate: TDateTime;
    ReplyToMessage: PTelegramMessage;
    EditDate: TDateTime;
    Text: string;
    Entities: array of TTelegramMessageEntity;
    Audio: TTelegramAudio;
    Document: TTelegramDocument;
    Photo: array of TTelegramPhotoSize;
    Sticker: TTelegramSticker;
    Video: TTelegramVideo;
    Voice: TTelegramVoice;
    Caption: string;
    Contact: TTelegramContact;
    Location: TTelegramLocation;
    Venue: TTelegramVenue;
    NewChatMember: TTelegramUser;
    LeftChatMember: TTelegramUser;
    NewChatTitle: string;
    NewChatPhoto: array of TTelegramPhotoSize;
    DeleteChatPhoto: Boolean;
    GroupChatCreated: Boolean;
    SuperGroupChatCreated: Boolean;
    ChannelChatCreated: Boolean;
    MigrateToChatID: Int64;
    MigrateFromChatID: Int64;
    PinnedMessage: PTelegramMessage;
  end;

  TTelegramUserProfilePhotos = record
    TotalCount: Integer;
    Photos: array of array of TTelegramPhotoSize;
  end;

  TTelegramUpdate = record
    UpdateID: Int64;
    Message: TTelegramMessage;
    EditedMessage: TTelegramMessage;
  end;

  TTelegramKeyboardButton = record
    Text: string;
    RequestContact: Boolean;
    RequestLocation: Boolean;
  end;

  TTelegramKeyboardButtonRow = TArray<TTelegramKeyboardButton>;

  TTelegramReplyKeyboardMarkup = record
    Keyboard: TArray<TTelegramKeyboardButtonRow>;
    ResizeKeyboard: Boolean;
    OneTimeKeyboard: Boolean;
    Selective: Boolean;
  end;

  TTelegramReplyKeyboardHide = record
    HideKeyboard: Boolean;
    Selective: Boolean;
  end;

  TTelegramForceReply = record
    ForceReply: Boolean;
    Selective: Boolean;
  end;

  TTelegramGetUpdatesRequest = record
    Offset: Int64;
    Limit: Integer;
    Timeout: Integer;
  end;

  TTelegramSendLocationRequest = record
    ChatID: Int64;
    Latitude: Double;
    Longitude: Double;
    DisableNotification: Boolean;
    ReplyToMessageID: Int64;
  end;

  TTelegramSendMessageRequest = record
    ChatID: Int64;
    Text: string;
    ParseMode: string;
    DisableWebPagePreview: Boolean;
    DisableNotification: Boolean;
    ReplyToMessageID: Int64;
    ReplyMarkup: TTelegramReplyKeyboardMarkup;
  end;

  TTelegramSendVenueRequest = record
    ChatID: Int64;
    Latitude: Double;
    Longitude: Double;
    Title: string;
    Address: string;
    FoursquareID: string;
    DisableNotification: Boolean;
    ReplyToMessageID: Int64;
  end;

implementation

end.
