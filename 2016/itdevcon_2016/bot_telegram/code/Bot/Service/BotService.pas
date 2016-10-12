unit BotService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  BotPollingThread;

type
  TBotServiceModule = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  strict private
    FPollingThread: TDevConBotThread;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  BotServiceModule: TBotServiceModule;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  BotServiceModule.Controller(CtrlCode);
end;

function TBotServiceModule.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TBotServiceModule.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  FPollingThread := TDevConBotThread.Create;
  try
    FPollingThread.Start;
  except
    FreeAndNil(FPollingThread);
    raise;
  end;
end;

procedure TBotServiceModule.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  if FPollingThread <> nil then
  begin
    FPollingThread.Terminate;
    FPollingThread.WaitFor;
    FreeAndNil(FPollingThread);
  end;
end;

end.
