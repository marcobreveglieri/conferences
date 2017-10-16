unit Switch;

interface

uses
  Classes, SysUtils;

type

{ TEmployeeKind }

  TEmployeeKind = (Commissioned, Hourly, Salaried);

{ TEmployee }

  TEmployee = record
    Kind: TEmployeeKind;
    FirstName: string;
    LastName: string;
  end;

function CalculatePay(Employee: TEmployee): Currency;

implementation

function CalculateCommissionedPay(Employee: TEmployee): Currency;
begin
  Result := 0;
end;

function CalculateHourlyPay(Employee: TEmployee): Currency;
begin
  Result := 0;
end;

function CalculateSalariedPay(Employee: TEmployee): Currency;
begin
  Result := 0;
end;

function CalculatePay(Employee: TEmployee): Currency;
begin
  case Employee.Kind of
    Commissioned:
      Result := CalculateCommissionedPay(Employee);
    Hourly:
      Result := CalculateHourlyPay(Employee);
    Salaried:
      Result := CalculateSalariedPay(Employee);
    else
      raise Exception.Create('Invalid employee kind');
    end;
end;

end.
