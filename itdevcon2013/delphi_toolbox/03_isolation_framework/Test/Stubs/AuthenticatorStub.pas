unit AuthenticatorStub;

interface

uses
  Authenticator;

{ Routines }

  function CreateAuthenticatorStub(AValidateResult: Boolean): IAuthenticator;

implementation

type

{ TAuthenticatorStub }

  TAuthenticatorStub = class (TInterfacedObject, IAuthenticator)
  private
    FValidateResult: Boolean;
  public
    constructor Create(AValidateResult: Boolean);
    function ValidateCredentials(const AUserName, APassword: string): Boolean;
  end;

constructor TAuthenticatorStub.Create(AValidateResult: Boolean);
begin
  inherited Create;
  FValidateResult := AValidateResult;
end;

function TAuthenticatorStub.ValidateCredentials(const AUserName,
  APassword: string): Boolean;
begin
  Result := FValidateResult;
end;

{ Routines }

function CreateAuthenticatorStub(AValidateResult: Boolean): IAuthenticator;
begin
  Result := TAuthenticatorStub.Create(AValidateResult);
end;

end.
