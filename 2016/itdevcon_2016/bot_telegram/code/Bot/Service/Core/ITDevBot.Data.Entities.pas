unit ITDevBot.Data.Entities;

{$SCOPEDENUMS ON}

interface

uses
  System.SysUtils;

type

  TDevConEventKind = (TBD = 0, Keynote = 1, Speech = 2, CoffeeBreak = 3, Lunch = 4,
    ClosingSession = 5);

  TDevConAgendaLevel = (NA = 0, Introduction = 1, Intermediate = 2, Advanced = 3);

  TDevConRoom = (NA = 0, Kirk = 1, Spock = 2);

  TDevConAgenda = record
    Id: Integer;
    Title: string;
    When: TDateTime;
    EventKind: TDevConEventKind;
    SpeakerId: Integer;
    Room: TDevConRoom;
    Host: string;
    Description: string;
    Language: string;
    Level: TDevConAgendaLevel;
  end;

  TDevConSpeaker = record
    Id: Integer;
    Name: string;
    Role: string;
    Bio: string;
    Homepage: string;
    Photo: TBytes;
  end;

  TDevConSponsor = record
    Id: Integer;
    Name: string;
    Bio: string;
    Homepage: string;
  end;

  TDevConSubscription = record
    ChatId: Int64;
    UserName: string;
  end;

implementation

end.
