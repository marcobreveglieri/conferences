unit Pong;

interface

uses
  Classes, Windows, Ikaria, ActorSystem;

type

{ TPongActor }

  TPongActor = class(TActor)
  private
    function IsPingMessage(Msg: TTuple): Boolean;
    procedure Pong(PID: TProcessID);
    procedure ReactToPing(Msg: TTuple);
  protected
    procedure RegisterActions(Table: TActorMessageTable); override;
  end;

implementation

{ TPongActor }

uses
  Logger;

function TPongActor.IsPingMessage(Msg: TTuple): Boolean;
begin
  Result := MatchMessageName(Msg, PingMessageName);
end;

procedure TPongActor.Pong(PID: TProcessID);
begin
  Send(PID, PongMessageName);
end;

procedure TPongActor.ReactToPing(Msg: TTuple);
begin
  TConsole.Log('ping');
  Sleep(50);
  Pong(Self.ParentID);
end;

procedure TPongActor.RegisterActions(Table: TActorMessageTable);
begin
  inherited RegisterActions(Table);
  Table.Add(IsPingMessage, ReactToPing);
end;

end.
