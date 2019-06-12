unit Ping;

interface

uses
  Classes, Windows, Ikaria, ActorSystem;

type

{ TPingActor }

  TPingActor = class(TActor)
  private
    FPonger: TProcessID;
    function IsPongMessage(Msg: TTuple): Boolean;
    procedure Ping();
    procedure ReactToPong(Msg: TTuple);
  protected
    procedure RegisterActions(Table: TActorMessageTable); override;
  public
    procedure SetUp; override;
  end;

implementation

{ TPingActor }

uses
  Pong, Logger;

function TPingActor.IsPongMessage(Msg: TTuple): Boolean;
begin
  Result := MatchMessageName(Msg, PongMessageName);
end;

procedure TPingActor.Ping();
begin
  Send(FPonger, PingMessageName);
end;

procedure TPingActor.ReactToPong(Msg: TTuple);
begin
  TConsole.Log('pong');
  Sleep(100);
  Ping();
end;

procedure TPingActor.RegisterActions(Table: TActorMessageTable);
begin
  inherited RegisterActions(Table);
  Table.Add(IsPongMessage, ReactToPong);
end;

procedure TPingActor.SetUp;
begin
  FPonger := Self.SpawnLink(TPongActor);
  Ping();
end;

end.
