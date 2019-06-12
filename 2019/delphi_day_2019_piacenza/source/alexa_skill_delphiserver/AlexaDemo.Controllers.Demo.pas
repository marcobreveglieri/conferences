unit AlexaDemo.Controllers.Demo;

interface

uses
  MVCFramework,
  MVCFramework.Commons;

type

  [MVCPath('/demo')]
  [MVCDoc('The controller that handles requests from Alexa service')]
  TDemoController = class(TMVCController)
  public
    [MVCConsumes('application/json')]
    [MVCPath('/')]
    [MVCHTTPMethods([HttpGET, HttpPOST])]
    [MVCDoc('Return a simple message to greet the user')]
    procedure Hello;
  end;

implementation

uses
  System.JSON;

procedure TDemoController.Hello;
resourcestring
  StrText = 'Ciao a tutti, sono una applicazione Delphi per Alexa, '
    + 'creata da Marco Breveglieri.';
var
  LResult, LResponse, LOutputSpeech: TJSONObject;
begin
  LOutputSpeech := TJSONObject.Create()
    .AddPair('type', 'PlainText')
    .AddPair('text', StrText);
  LResponse := TJSONObject.Create()
    .AddPair('outputSpeech', LOutputSpeech)
    .AddPair('shouldEndSession', TJSONBool.Create(True));
  LResult := TJSONObject.Create()
    .AddPair('version', '1.0')
    .AddPair('response', LResponse);
  Render(LResult);
end;

end.
