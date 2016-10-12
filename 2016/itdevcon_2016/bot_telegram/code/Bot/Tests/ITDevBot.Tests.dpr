program ITDevBot.Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  ITDevBot.Tests.Integration.Domain in 'ITDevBot.Tests.Integration.Domain.pas',
  ITDevBot.Tests.Telegram.Services in 'ITDevBot.Tests.Telegram.Services.pas';

{R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

