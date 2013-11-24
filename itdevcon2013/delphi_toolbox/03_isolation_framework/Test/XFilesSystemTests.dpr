program XFilesSystemTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  ArchiveTests in 'ArchiveTests.pas',
  Archive in '..\Archive.pas',
  Authenticator in '..\Authenticator.pas',
  Communicator in '..\Communicator.pas',
  AuthenticatorStub in 'Stubs\AuthenticatorStub.pas',
  CommunicatorStub in 'Stubs\CommunicatorStub.pas',
  CommunicatorMock in 'Mocks\CommunicatorMock.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

