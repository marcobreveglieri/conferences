unit AlexaDemo.Model.PizzaManager;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  AlexaDemo.Entities.Pizza;

type

  TPizzaManager = class
  private
    FListOfPizzas: TList<TPizza>;
    procedure Initialize;
  public
    constructor Create;
    destructor Destroy; override;
    function GetListOfPizzas: TArray<TPizza>;
    function GetPizzaByName(const AName: string; var APizza: TPizza): Boolean;
  end;

implementation

constructor TPizzaManager.Create;
begin
  inherited Create;
  FListOfPizzas := TList<TPizza>.Create;
  Initialize;
end;

destructor TPizzaManager.Destroy;
begin
  if FListOfPizzas <> nil then
    FreeAndNil(FListOfPizzas);
  inherited Destroy;
end;

function TPizzaManager.GetListOfPizzas: TArray<TPizza>;
begin
  Result := FListOfPizzas.ToArray;
end;

function TPizzaManager.GetPizzaByName(const AName: string;
  var APizza: TPizza): Boolean;
var
  LPizza: TPizza;
begin
  for LPizza in FListOfPizzas do
  begin
    if SameText(AName, LPizza.Name) then
    begin
      APizza := LPizza;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

procedure TPizzaManager.Initialize;
var
  LPizza: TPizza;
begin
  with LPizza do
  begin
    Name := 'Margherita';
    Description := 'È la tipica pizza napoletana, '
      + 'condita con pomodoro, mozzarella (tradizionalmente è usato il '
      + 'fior di latte, non quella di bufala), basilico fresco, sale e olio; '
      + 'assieme alla pizza marinara, è la più popolare pizza italiana.';
    Price := 4;
  end;
  FListOfPizzas.Add(LPizza);

  with LPizza do
  begin
    Name := 'Marinara';
    Description := 'È una tipica pizza napoletana condita con pomodoro, aglio, '
      + 'origano e olio. Particolarmente apprezzata nell''Italia meridionale, '
      + 'risulta la seconda pizza preferita per gusto dopo quella di bufala.';
    Price := 4;
  end;
  FListOfPizzas.Add(LPizza);

  with LPizza do
  begin
    Name := 'Capricciosa';
    Description := 'Questa pizza è preparata con mozzarella, pomodoro, '
      + 'prosciutto, funghi e carciofi; alcune varianti possono includere '
      + 'olive, basilico e addirittura uova.';
    Price := 6;
  end;
  FListOfPizzas.Add(LPizza);
end;

end.
