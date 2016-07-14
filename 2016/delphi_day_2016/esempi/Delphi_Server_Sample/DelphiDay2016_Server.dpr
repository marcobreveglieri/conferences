program DelphiDay2016_Server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  ToDoServerMethodsUnit in 'ToDoServerMethodsUnit.pas' {ToDoServerMethods: TDSServerModule},
  ToDoWebModuleUnit in 'ToDoWebModuleUnit.pas' {ToDoWebModule: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
