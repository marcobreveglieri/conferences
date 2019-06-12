unit AlexaDemo.Controllers.Pizza;

interface

uses
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  MVCFramework,
  MVCFramework.Commons,
  AlexaDemo.Model.PizzaManager, AlexaDemo.Entities.Pizza;

type

  [MVCPath('/pizza')]
  [MVCDoc('This controller handles requests from DelphiPizza skill')]
  TPizzaController = class(TMVCController)
  private
    FPizzaManager: TPizzaManager;
    function GetIntentResponse(ARequest: TJSONValue): TJSONObject;
    function GetIntentResponseForGetListOfPizzas(ARequest: TJSONValue): TJSONObject;
    function GetIntentResponseForGetDetailsOfPizza(ARequest: TJSONValue): TJSONObject;
    function GetLaunchResponse(ARequest: TJSONValue): TJSONObject;
  public
    constructor Create; override;
    destructor Destroy; override;
    [MVCConsumes('application/json')]
    [MVCPath('/')]
    [MVCHTTPMethods([HttpGET, HttpPOST])]
    [MVCDoc('Parse the request coming from Alexa and returns the response')]
    procedure Execute(AContext: TWebContext);
  end;

implementation

constructor TPizzaController.Create;
begin
  inherited Create;
  FPizzaManager := TPizzaManager.Create;
end;

destructor TPizzaController.Destroy;
begin
  if FPizzaManager <> nil then
    FreeAndNil(FPizzaManager);
  inherited Destroy;
end;

procedure TPizzaController.Execute(AContext: TWebContext);
var
  LRequestBody: TJSONValue;
  LRequestType: string;
  LResponse: TJSONObject;
begin
  LRequestBody := TJSONObject.ParseJSONValue(AContext.Request.Body);
  LRequestType := LRequestBody.GetValue<string>('request.type');

  LResponse := nil;
  if LRequestType = 'LaunchRequest' then
    LResponse := GetLaunchResponse(LRequestBody);
  if LRequestType = 'IntentRequest' then
    LResponse := GetIntentResponse(LRequestBody);

  if LResponse <> nil then
  begin
    Render(TJSONObject.Create()
      .AddPair('version', '1.0')
      .AddPair('response', LResponse));
    Exit;
  end;

  AContext.Response.StatusCode := 400;
  AContext.Response.ReasonString := 'Bad request';
end;

function TPizzaController.GetIntentResponse(ARequest: TJSONValue): TJSONObject;
var
  LIntentBody: TJSONValue;
  LIntentName: string;
begin
  LIntentBody := ARequest.FindValue('request.intent');
  LIntentName := LIntentBody.GetValue<string>('name');

  if LIntentName = 'getListOfPizzas' then
  begin
    Result := GetIntentResponseForGetListOfPizzas(ARequest);
    Exit;
  end;

  if LIntentName = 'getDetailsOfPizza' then
  begin
    Result := GetIntentResponseForGetDetailsOfPizza(ARequest);
    Exit;
  end;

  Result := nil;
end;

function TPizzaController.GetIntentResponseForGetDetailsOfPizza(
  ARequest: TJSONValue): TJSONObject;
var
  LSlots: TJSONValue;
  LNameOfPizza: string;
  LFoundPizza: TPizza;
  LSpeech: TJSONObject;
  LText: TStringBuilder;
begin
  LSlots := ARequest.FindValue('request.intent.slots');
  if LSlots = nil then
  begin
    Result := nil;
    Exit;
  end;

  LNameOfPizza := LSlots.GetValue<string>('nameOfPizza.value');
  if not FPizzaManager.GetPizzaByName(LNameOfPizza, LFoundPizza) then
  begin
    LSpeech := TJSONObject.Create()
      .AddPair('type', 'PlainText')
      .AddPair('text', 'Mi spiace: non ho trovato la pizza che hai chiesto.');
    Result := TJSONObject.Create()
      .AddPair('outputSpeech', LSpeech)
      .AddPair('shouldEndSession', TJSONBool.Create(False));
    Exit;
  end;

  LText := TStringBuilder.Create;
  try
    LText.AppendFormat('Qualche informazione sulla pizza: %s ...',
      [LFoundPizza.Name]);
    LText.Append(LFoundPizza.Description + '...');
    LText.AppendFormat('La pizza costa %m!', [LFoundPizza.Price]);
    LSpeech := TJSONObject.Create()
      .AddPair('type', 'PlainText')
      .AddPair('text', LText.ToString);
    Result := TJSONObject.Create()
      .AddPair('outputSpeech', LSpeech)
      .AddPair('shouldEndSession', TJSONBool.Create(False));
  finally
    LText.Free;
  end;
end;

function TPizzaController.GetIntentResponseForGetListOfPizzas(
  ARequest: TJSONValue): TJSONObject;
var
  LSpeech: TJSONObject;
  LText: TStringBuilder;
  LPizza: TPizza;
begin
  LText := TStringBuilder.Create;
  try
    LText.Append('Ecco la lista delle pizze disponibili...');
    for LPizza in FPizzaManager.GetListOfPizzas do
    begin
      LText.Append(LPizza.Name);
      LText.Append(',');
    end;
    LSpeech := TJSONObject.Create()
      .AddPair('type', 'PlainText')
      .AddPair('text', LText.ToString);
    Result := TJSONObject.Create()
      .AddPair('outputSpeech', LSpeech)
      .AddPair('shouldEndSession', TJSONBool.Create(False));
  finally
    LText.Free;
  end;
end;

function TPizzaController.GetLaunchResponse(ARequest: TJSONValue): TJSONObject;
var
  LSpeech: TJSONObject;
begin
  LSpeech := TJSONObject.Create()
    .AddPair('type', 'PlainText')
    .AddPair('text', 'Benvenuto nella pizzeria del Delphi Day!');
  Result := TJSONObject.Create()
    .AddPair('outputSpeech', LSpeech)
    .AddPair('shouldEndSession', TJSONBool.Create(False));
end;

end.
