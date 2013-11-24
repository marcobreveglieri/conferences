unit Archive;

interface

uses
  Classes, SysUtils,
  Authenticator, Communicator;

type

{ IArchive }

{$M+}
  IArchive = interface
    ['{793135BB-D547-48C7-A025-24858D8D4806}']
    function Login(const AUserName, APassword: string): Boolean;
    procedure Logout;
    function IsLogged: Boolean;
  end;
{$M-}

{ TArchive }

  TArchive = class (TInterfacedObject, IArchive)
  private
    FAuthenticator: IAuthenticator;
    FCommunicator: ICommunicator;
    FUserName: string;
  public
    constructor Create(AnAuthenticator: IAuthenticator; ACommunicator: ICommunicator);
    function Login(const AUserName, APassword: string): Boolean;
    procedure Logout;
    function IsLogged: Boolean;
  end;

implementation

{ TArchive }

constructor TArchive.Create(AnAuthenticator: IAuthenticator;
  ACommunicator: ICommunicator);
begin
  inherited Create;
  FAuthenticator := AnAuthenticator;
  FCommunicator := ACommunicator;
  FUserName := EmptyStr;
end;

function TArchive.IsLogged: Boolean;
begin
  Result := Length(FUserName) > 0;
end;

function TArchive.Login(const AUserName, APassword: string): Boolean;
begin
  Result := FAuthenticator.ValidateCredentials(AUserName, APassword);
  if Result then
    FUserName := AUserName
  else
    FCommunicator.SendWarning('Tentativo login fallito utente: ' + AUserName);
end;

procedure TArchive.Logout;
begin
  FUserName := EmptyStr;
end;

end.
