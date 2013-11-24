unit CommunicatorStub;

interface

uses
  Communicator;

{ Routines }

  function CreateCommunicatorStub: ICommunicator;

implementation

type

{ TCommunicatorStub }

  TCommunicatorStub = class (TInterfacedObject, ICommunicator)
  private
  public
    procedure SendWarning(const AText: string);
  end;

procedure TCommunicatorStub.SendWarning(const AText: string);
begin
  // Nessuna azione da eseguire in questo contesto
end;

{ Routines }

function CreateCommunicatorStub: ICommunicator;
begin
  Result := TCommunicatorStub.Create;
end;

end.
