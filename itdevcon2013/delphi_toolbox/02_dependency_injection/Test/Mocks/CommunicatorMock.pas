unit CommunicatorMock;

interface

uses
  Communicator;

{ Routines }

  function CreateCommunicatorMock: ICommunicator;

implementation

type

{ TCommunicatorMock }

  TCommunicatorMock = class (TInterfacedObject, ICommunicator)
  private
    FWarningSent: Boolean;
  public
    procedure SendWarning(const AText: string);
    property WarningSent: Boolean read FWarningSent;
  end;

procedure TCommunicatorMock.SendWarning(const AText: string);
begin
  FWarningSent := True;
end;

{ Routines }

function CreateCommunicatorMock: ICommunicator;
begin
  Result := TCommunicatorMock.Create;
end;

end.
