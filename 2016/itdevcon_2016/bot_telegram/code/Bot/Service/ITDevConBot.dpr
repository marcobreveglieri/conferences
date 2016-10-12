program ITDevConBot;

uses
  Vcl.SvcMgr,
  BotService in 'BotService.pas' {BotServiceModule: TService},
  ITDevBot.Data.Entities in 'Core\ITDevBot.Data.Entities.pas',
  ITDevBot.Data.Repository.Factory in 'Core\ITDevBot.Data.Repository.Factory.pas',
  ITDevBot.Data.Repository.Interfaces in 'Core\ITDevBot.Data.Repository.Interfaces.pas',
  ITDevBot.Data.Repository.Services in 'Core\ITDevBot.Data.Repository.Services.pas',
  ITDevBot.Telegram.Services in 'Core\ITDevBot.Telegram.Services.pas',
  BotPollingThread in 'BotPollingThread.pas',
  ITDevBot.Telegram.Commands in 'Core\ITDevBot.Telegram.Commands.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TBotServiceModule, BotServiceModule);
  Application.Run;
end.
