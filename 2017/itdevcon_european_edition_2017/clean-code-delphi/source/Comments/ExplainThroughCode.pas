unit ExplainThroughCode;

interface

const
  HOURLY_FLAG: Integer = 0;

type

  TEmployee = class
  public
    Age: Integer;
    Flags: Integer;
    function IsEligibleForFullBenefits(): Boolean; virtual; abstract;
  end;

implementation

var
  Employee: TEmployee;

initialization

// Check to see if the employee is eligible for full benefits
if (Employee.Flags and HOURLY_FLAG > 0) and (Employee.Age >= 65) then
begin
end;

if Employee.IsEligibleForFullBenefits() then
begin
end;

finalization

end.
