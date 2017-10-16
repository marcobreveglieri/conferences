unit SwitchOk;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type

{ TEmployeeKind }

  TEmployeeKind = (Commissioned, Hourly, Salaried);

{ TEmployee }

  TEmployee = record
    Kind: TEmployeeKind;
    FirstName: string;
    LastName: string;
  end;

{ IPayCalculator }

  IPayCalculator = interface
    function CalculatePay(Employee: TEmployee): Currency;
  end;

{ TEmployeeCommissionedPayCalculator }

  TEmployeeCommissionedPayCalculator = class (TInterfacedObject, IPayCalculator)
  public
    function CalculatePay(Employee: TEmployee): Currency;
  end;

{ TEmployeeHourlyPayCalculator }

  TEmployeeHourlyPayCalculator = class (TInterfacedObject, IPayCalculator)
  public
    function CalculatePay(Employee: TEmployee): Currency;
  end;

{ TEmployeeSalariedPayCalculator }

  TEmployeeSalariedPayCalculator = class (TInterfacedObject, IPayCalculator)
  public
    function CalculatePay(Employee: TEmployee): Currency;
  end;

{ Routines }

function CalculatePay(Employee: TEmployee): Currency;
procedure RegisterCalculator(AKind: TEmployeeKind; ACalculator: IPayCalculator);
procedure UnregisterCalculator(AKind: TEmployeeKind);

implementation

var
  Calculators: TDictionary<TEmployeeKind, IPayCalculator>;

function CalculatePay(Employee: TEmployee): Currency;
var
  PayCalculator: IPayCalculator;
begin
  if not Calculators.TryGetValue(Employee.Kind, PayCalculator) then
    raise Exception.Create('Calculator not found or not registered');
  Result := PayCalculator.CalculatePay(Employee);
end;

procedure RegisterCalculator(AKind: TEmployeeKind; ACalculator: IPayCalculator);
begin
  Calculators.Add(AKind, ACalculator);
end;

procedure UnregisterCalculator(AKind: TEmployeeKind);
begin
  if Calculators.ContainsKey(AKind) then
    Calculators.Remove(AKind);
end;

{ TEmployeeCommissionedPayCalculator }

function TEmployeeCommissionedPayCalculator.CalculatePay(
  Employee: TEmployee): Currency;
begin
  Result := 0;
end;

{ TEmployeeHourlyPayCalculator }

function TEmployeeHourlyPayCalculator.CalculatePay(
  Employee: TEmployee): Currency;
begin
  Result := 0;
end;

{ TEmployeeSalariedPayCalculator }

function TEmployeeSalariedPayCalculator.CalculatePay(
  Employee: TEmployee): Currency;
begin
  Result := 0;
end;

initialization

  Calculators := TDictionary<TEmployeeKind, IPayCalculator>.Create();

  RegisterCalculator(TEmployeeKind.Commissioned, TEmployeeCommissionedPayCalculator.Create);
  RegisterCalculator(TEmployeeKind.Hourly, TEmployeeHourlyPayCalculator.Create);
  RegisterCalculator(TEmployeeKind.Salaried, TEmployeeSalariedPayCalculator.Create);

finalization

if Calculators <> nil then
  Calculators.Free;

end.
