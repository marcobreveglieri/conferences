unit ITDevBot.Data.Repository.Services;

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Async, FireDAC.Stan.Def,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  ITDevBot.Data.Entities, ITDevBot.Data.Repository.Interfaces;

type

  TDevConRepository<T> = class(TInterfacedObject, IDevConRepository<T>)
  strict private
    FConnection: TFDConnection;
  strict protected
    function LoadFrom(ADataSet: TDataSet): T; virtual; abstract;
  public
    constructor Create(const AConnectionString: string);
    destructor Destroy; override;
    function Execute(const SQL: string; const Params: array of Variant): Integer;
    function FetchAll(const SQL: string; const Params: array of Variant)
      : TArray<T>;
    function FetchOne(const SQL: string; const Params: array of Variant;
      var R: T): Boolean;
    function GetAll: TArray<T>; virtual; abstract;
    function GetItemByID(const ID: Integer; var R: T): Boolean;
      virtual; abstract;
    function GetItemByText(const Text: string; var R: T): Boolean;
      virtual; abstract;
    procedure DeleteItem(const R: T); virtual; abstract;
    procedure InsertOrUpdateItem(const R: T); virtual; abstract;
    property Connection: TFDConnection read FConnection;
  end;

  TDevConAgendaRepository = class(TDevConRepository<TDevConAgenda>)
  strict protected
    function LoadFrom(ADataSet: TDataSet): TDevConAgenda; override;
  public
    function GetAll: TArray<TDevConAgenda>; override;
    function GetItemByID(const ID: Integer; var R: TDevConAgenda)
      : Boolean; override;
    function GetItemByText(const Text: string; var R: TDevConAgenda)
      : Boolean; override;
    procedure DeleteItem(const R: TDevConAgenda); override;
    procedure InsertOrUpdateItem(const R: TDevConAgenda); override;
  end;

  TDevConSpeakerRepository = class(TDevConRepository<TDevConSpeaker>)
  strict protected
    function LoadFrom(ADataSet: TDataSet): TDevConSpeaker; override;
  public
    function GetAll: TArray<TDevConSpeaker>; override;
    function GetItemByID(const ID: Integer; var R: TDevConSpeaker)
      : Boolean; override;
    function GetItemByText(const Text: string; var R: TDevConSpeaker)
      : Boolean; override;
    procedure DeleteItem(const R: TDevConSpeaker); override;
    procedure InsertOrUpdateItem(const R: TDevConSpeaker); override;
  end;

  TDevConSponsorRepository = class(TDevConRepository<TDevConSponsor>)
  strict protected
    function LoadFrom(ADataSet: TDataSet): TDevConSponsor; override;
  public
    function GetAll: TArray<TDevConSponsor>; override;
    function GetItemByID(const ID: Integer; var R: TDevConSponsor)
      : Boolean; override;
    function GetItemByText(const Text: string; var R: TDevConSponsor)
      : Boolean; override;
    procedure DeleteItem(const R: TDevConSponsor); override;
    procedure InsertOrUpdateItem(const R: TDevConSponsor); override;
  end;

  TDevConSubscriptionRepository = class(TDevConRepository<TDevConSubscription>)
  strict protected
    function LoadFrom(ADataSet: TDataSet): TDevConSubscription; override;
  public
    function GetAll: TArray<TDevConSubscription>; override;
    function GetItemByID(const ID: Integer; var R: TDevConSubscription)
      : Boolean; override;
    function GetItemByText(const Text: string; var R: TDevConSubscription)
      : Boolean; override;
    procedure DeleteItem(const R: TDevConSubscription); override;
    procedure InsertOrUpdateItem(const R: TDevConSubscription); override;
  end;

implementation

{ TConRepository }

constructor TDevConRepository<T>.Create(const AConnectionString: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.LoginPrompt := False;
  FConnection.Open(AConnectionString);
end;

destructor TDevConRepository<T>.Destroy;
begin
  if FConnection <> nil then
    FreeAndNil(FConnection);
  inherited Destroy;
end;

function TDevConRepository<T>.Execute(const SQL: string;
  const Params: array of Variant): Integer;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Result := Query.ExecSQL(SQL, Params);
  finally
    Query.Free;
  end;
end;

function TDevConRepository<T>.FetchAll(const SQL: string;
  const Params: array of Variant): TArray<T>;
var
  Query: TFDQuery;
  Index: Integer;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.Open(SQL, Params);
    SetLength(Result, Query.RecordCount);
    Index := -1;
    while not Query.Eof do
    begin
      Inc(Index);
      Result[Index] := LoadFrom(Query);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TDevConRepository<T>.FetchOne(const SQL: string;
  const Params: array of Variant; var R: T): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.Open(SQL, Params);
    Result := not Query.IsEmpty;
    if Result then
      R := LoadFrom(Query);
  finally
    Query.Free;
  end;
end;

{ TConAgendaRepository }

procedure TDevConAgendaRepository.DeleteItem(const R: TDevConAgenda);
begin
  Execute('DELETE FROM Agenda WHERE Id = :Id', [R.Id]);
end;

function TDevConAgendaRepository.GetAll: TArray<TDevConAgenda>;
begin
  Result := FetchAll('SELECT * FROM Agenda ORDER BY [When]', []);
end;

function TDevConAgendaRepository.GetItemByID(const ID: Integer;
  var R: TDevConAgenda): Boolean;
begin
  Result := FetchOne('SELECT * FROM Agenda WHERE Id = :ID', [ID], R);
end;

function TDevConAgendaRepository.GetItemByText(const Text: string;
  var R: TDevConAgenda): Boolean;
begin
  Result := FetchOne('SELECT * FROM Agenda WHERE Title = :Text', [Text], R);
end;

procedure TDevConAgendaRepository.InsertOrUpdateItem(const R: TDevConAgenda);
begin
  raise Exception.Create('Not implemented');
end;

function TDevConAgendaRepository.LoadFrom(ADataSet: TDataSet): TDevConAgenda;
begin
  with Result do
  begin
    ID := ADataSet.FieldByName('Id').AsInteger;
    Title := ADataSet.FieldByName('Title').AsString;
    When := ADataSet.FieldByName('When').AsDateTime;
    EventKind := TDevConEventKind(ADataSet.FieldByName('EventId').AsInteger);
    if not ADataSet.FieldByName('SpeakerId').IsNull then
      SpeakerId := ADataSet.FieldByName('SpeakerId').AsInteger
    else
      SpeakerId := -1;
    if not ADataSet.FieldByName('RoomId').IsNull then
      Room := TDevConRoom(ADataSet.FieldByName('RoomId').AsInteger)
    else
      Room := TDevConRoom.NA;
    if not ADataSet.FieldByName('Host').IsNull then
      Host := ADataSet.FieldByName('Host').AsString
    else
      Host := String.Empty;
    if not ADataSet.FieldByName('Description').IsNull then
      Description := ADataSet.FieldByName('Description').AsString
    else
      Description := String.Empty;
    if not ADataSet.FieldByName('Language').IsNull then
      Language := ADataSet.FieldByName('Language').AsString
    else
      Language := String.Empty;
    if not ADataSet.FieldByName('LevelId').IsNull then
      Level := TDevConAgendaLevel(ADataSet.FieldByName('LevelId').AsInteger)
    else
      Level := TDevConAgendaLevel.NA;
  end;
end;

{ TConSpeakerRepository }

procedure TDevConSpeakerRepository.DeleteItem(const R: TDevConSpeaker);
begin
  Execute('DELETE FROM Speaker WHERE Id = :Id', [R.Id]);
end;

function TDevConSpeakerRepository.GetAll: TArray<TDevConSpeaker>;
begin
  Result := FetchAll('SELECT * FROM Speaker ORDER BY [Id]', []);
end;

function TDevConSpeakerRepository.GetItemByID(const ID: Integer;
  var R: TDevConSpeaker): Boolean;
begin
  Result := FetchOne('SELECT * FROM Speaker WHERE Id = :Id', [ID], R);
end;

function TDevConSpeakerRepository.GetItemByText(const Text: string;
  var R: TDevConSpeaker): Boolean;
begin
  Result := FetchOne('SELECT * FROM Speaker WHERE Name = :Text', [Text], R);
end;

procedure TDevConSpeakerRepository.InsertOrUpdateItem(const R: TDevConSpeaker);
begin
  raise Exception.Create('Not implemented');
end;

function TDevConSpeakerRepository.LoadFrom(ADataSet: TDataSet): TDevConSpeaker;
begin
  with Result do
  begin
    ID := ADataSet.FieldByName('Id').AsInteger;
    Name := ADataSet.FieldByName('Name').AsString;
    Role := ADataSet.FieldByName('Role').AsString;
    if not ADataSet.FieldByName('Bio_ENG').IsNull then
      Bio := ADataSet.FieldByName('Bio_ENG').AsString
    else if not ADataSet.FieldByName('Bio_ITA').IsNull then
      Bio := ADataSet.FieldByName('Bio_ITA').AsString
    else
      Bio := EmptyStr;
    if not ADataSet.FieldByName('Homepage').IsNull then
      Homepage := ADataSet.FieldByName('Homepage').AsString
    else
      Homepage := String.Empty;
  end;
end;

{ TConSponsorRepository }

procedure TDevConSponsorRepository.DeleteItem(const R: TDevConSponsor);
begin
  Execute('DELETE FROM Sponsor WHERE Id = :Id', [R.Id]);
end;

function TDevConSponsorRepository.GetAll: TArray<TDevConSponsor>;
begin
  Result := FetchAll('SELECT * FROM Sponsor ORDER BY [Id]', []);
end;

function TDevConSponsorRepository.GetItemByID(const ID: Integer;
  var R: TDevConSponsor): Boolean;
begin
  Result := FetchOne('SELECT * FROM Sponsor WHERE Id = :Id', [ID], R);
end;

function TDevConSponsorRepository.GetItemByText(const Text: string;
  var R: TDevConSponsor): Boolean;
begin
  Result := FetchOne('SELECT * FROM Sponsor WHERE Name = :Text', [Text], R);
end;

procedure TDevConSponsorRepository.InsertOrUpdateItem(const R: TDevConSponsor);
begin
  raise Exception.Create('Not implemented');
end;

function TDevConSponsorRepository.LoadFrom(ADataSet: TDataSet): TDevConSponsor;
begin
  with Result do
  begin
    ID := ADataSet.FieldByName('Id').AsInteger;
    Name := ADataSet.FieldByName('Name').AsString;
    Bio := ADataSet.FieldByName('Bio').AsString;
    if not ADataSet.FieldByName('Homepage').IsNull then
      Homepage := ADataSet.FieldByName('Homepage').AsString
    else
      Homepage := String.Empty;
  end;
end;

{ TDevConSubscriptionRepository }

procedure TDevConSubscriptionRepository.DeleteItem(
  const R: TDevConSubscription);
begin
  Execute('DELETE FROM Subscription WHERE ChatId = :ChatId', [R.ChatId]);
end;

function TDevConSubscriptionRepository.GetAll: TArray<TDevConSubscription>;
begin
  Result := FetchAll('SELECT * FROM Subscription ORDER BY [ChatId]', []);
end;

function TDevConSubscriptionRepository.GetItemByID(const ID: Integer;
  var R: TDevConSubscription): Boolean;
begin
  Result := FetchOne('SELECT * FROM Subscription WHERE ChatID = :Id', [ID], R);
end;

function TDevConSubscriptionRepository.GetItemByText(const Text: string;
  var R: TDevConSubscription): Boolean;
begin
  Result := FetchOne('SELECT * FROM Subscription WHERE UserName = :Text', [Text], R);
end;

procedure TDevConSubscriptionRepository.InsertOrUpdateItem(
  const R: TDevConSubscription);
begin
  Execute('INSERT OR REPLACE INTO Subscription (ChatId, UserName) '
    + 'VALUES (:ChatId, :UserName)', [R.ChatId, R.UserName]);
end;

function TDevConSubscriptionRepository.LoadFrom(
  ADataSet: TDataSet): TDevConSubscription;
begin
  with Result do
  begin
    ChatId := ADataSet.FieldByName('ChatId').AsLargeInt;
    if not ADataSet.FieldByName('UserName').IsNull then
      UserName := ADataSet.FieldByName('UserName').AsString
    else
      UserName := String.Empty;
  end;
end;

end.
