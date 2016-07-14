unit ArchiveTests;

interface

uses
  SysUtils, TestFramework,
  Delphi.Mocks,
  Archive, Authenticator, Communicator, AuthenticatorStub, CommunicatorStub, CommunicatorMock;

type

{ TTestArchive }

  TTestArchive = class(TTestCase)
  private
    FArchive: TArchive;
    FAuthenticatorMock: TMock<IAuthenticator>;
    FCommunicatorMock: TMock<ICommunicator>;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Login_Call_GoodCredentialsReturnsFalse;
    procedure Login_Call_GoodCredentialsReturnsTrue;
    procedure Login_Call_InvokeSendWarningIfFails;
  end;

implementation

{ Consts }

const
  StrLoginGoodUserName = 'good-username';
  StrLoginGoodPassword = 'good-password';
  StrLoginBadUserName = 'bad-username';
  StrLoginBadPassword = 'bad-password';

{ TTestArchive }

{$REGION 'Test initialization/finalization'}

procedure TTestArchive.SetUp;
begin
  inherited SetUp;
  // Crea il mock per l'autenticazione
  FAuthenticatorMock := TMock<IAuthenticator>.Create;
  // Ritorna esito positivo per nome utente e password corretti
  FAuthenticatorMock.Setup.WillReturn(True).When.ValidateCredentials(
    StrLoginGoodUserName, StrLoginGoodPassword);
  // Ritorna esito negativo per nome utente e password non validi
  FAuthenticatorMock.Setup.WillReturn(False).When.ValidateCredentials(
    StrLoginBadUserName, StrLoginBadPassword);
  // Crea il mock per la comunicazione
  FCommunicatorMock := TMock<ICommunicator>.Create;
  // Crea l'oggetto da sottoporre al test con le relative dipendenze
  FArchive := TArchive.Create(FAuthenticatorMock, FCommunicatorMock);
end;

procedure TTestArchive.TearDown;
begin
  inherited TearDown;
  // Distrugge l'oggetto sottoposto a test
  if FArchive <> nil then
  begin
    FArchive.Free;
    FArchive := nil;
  end;
end;

{$ENDREGION}

{$REGION 'Test methods'}

procedure TTestArchive.Login_Call_GoodCredentialsReturnsFalse;
begin
  // Il login con credenziali errate deve restituire un esito negativo
  CheckFalse(FArchive.Login(StrLoginBadUserName, StrLoginBadPassword));
end;

procedure TTestArchive.Login_Call_GoodCredentialsReturnsTrue;
begin
  // Il login con credenziali valide deve restituire un esito positivo
  CheckTrue(FArchive.Login(StrLoginGoodUserName, StrLoginGoodPassword));
end;

procedure TTestArchive.Login_Call_InvokeSendWarningIfFails;
begin
  // Aggiunge una "expectation" sul mock per la comunicazione
  // (deve essere invocato una volta il metodo SendWarning)
  FCommunicatorMock.Setup.Expect.Exactly('SendWarning', 1);

  // Effettua il login con le credenziali errate
  FArchive.Login(StrLoginBadUserName, StrLoginBadPassword);

  // Verifica che il metodo sia stato richiamato
  FCommunicatorMock.Verify;
end;

{$ENDREGION}

initialization

  // Register any test cases with the test runner
  RegisterTest(TTestArchive.Suite);

end.
