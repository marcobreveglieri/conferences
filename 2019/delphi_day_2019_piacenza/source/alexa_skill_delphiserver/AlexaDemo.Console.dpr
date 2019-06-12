program AlexaDemo.Console;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  IdSSLOpenSSL,
  Web.WebReq,
  Web.WebBroker,
  AlexaDemo.Modules.Main in 'AlexaDemo.Modules.Main.pas' {MainWebModule: TWebModule},
  AlexaDemo.Controllers.Demo in 'AlexaDemo.Controllers.Demo.pas',
  AlexaDemo.Controllers.Pizza in 'AlexaDemo.Controllers.Pizza.pas',
  AlexaDemo.Model.PizzaManager in 'AlexaDemo.Model.PizzaManager.pas',
  AlexaDemo.Entities.Pizza in 'AlexaDemo.Entities.Pizza.pas';

{$R *.res}


procedure StartServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  Writeln(Format('Starting HTTP Server on port %d', [AServer.DefaultPort]));
  AServer.Bindings.Clear;
  AServer.Active := True;
end;

procedure StopServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  if not AServer.Active then
    Exit;
  Writeln('Stopping Server');
  AServer.Active := False;
  AServer.Bindings.Clear;
  Writeln('Stopped');
end;

type
  TGetSSLPassword = class
    procedure OnGetSSLPassword(var APassword: String);
  end;

procedure TGetSSLPassword.OnGetSSLPassword(var APassword: String);
begin
  APassword := '';
end;

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LGetSSLPassword: TGetSSLPassword;
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
begin
  LGetSSLPassword := nil;
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    LGetSSLPassword := TGetSSLPassword.Create;
    LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(LServer);
    LIOHandleSSL.SSLOptions.CertFile := 'yourname.pem';
    LIOHandleSSL.SSLOptions.RootCertFile := '';
    LIOHandleSSL.SSLOptions.KeyFile := 'yourname.key';
    LIOHandleSSL.OnGetPassword := LGetSSLPassword.OnGetSSLPassword;
    LServer.IOHandler := LIOHandleSSL;
    StartServer(LServer);
    Readln;
    StopServer(LServer);
  finally
    LServer.Free;
    LGetSSLPassword.Free;
  end;
end;

begin
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(443);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end

end.
