unit AlexaDemo.Modules.Main;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp,
  MVCFramework;

type
  TMainWebModule = class(TWebModule)
    procedure DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    FMVCEngine: TMVCEngine;
  public
  end;

var
  WebModuleClass: TComponentClass = TMainWebModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  AlexaDemo.Controllers.Demo, AlexaDemo.Controllers.Pizza;

{$R *.dfm}

procedure TMainWebModule.DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Delphi Alexa Demo</title></head>' +
    '<body>Delphi Alexa Demo</body>' +
    '</html>';
end;

procedure TMainWebModule.WebModuleCreate(Sender: TObject);
begin
  FMVCEngine := TMVCEngine.Create(Self);
  FMVCEngine.AddController(TDemoController);
  FMVCEngine.AddController(TPizzaController);
end;

end.
