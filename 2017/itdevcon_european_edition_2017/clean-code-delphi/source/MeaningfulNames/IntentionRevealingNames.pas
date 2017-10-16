unit IntentionRevealingNames;

interface

uses
  System.Generics.Collections;

// WRONG

var
  d: Integer; // elapsed time in days

// OK

var
  ElapsedTimeInDays: Integer;
  DaysSinceCreation: Integer;

// WRONG

function GetThem(): TArray<Integer>;

// OK

function GetArrayOfEvenNumbers: TArray<Integer>;

implementation

// WRONG

function GetThem(): TArray<Integer>;
var
  List: TList<Integer>;
  I: Integer;
begin
  List := TList<Integer>.Create;
  try
    for I := 1 to 100 do
      if I mod 2 = 0 then
        List.Add(I);
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

// OK

function GetArrayOfEvenNumbers: TArray<Integer>;
const
  RangeMin: Integer = 1;
  RangeMax: Integer = 100;
var
  EvenNumberList: TList<Integer>;
  CurrentNumber: Integer;
begin
  EvenNumberList := TList<Integer>.Create;
  try
    for CurrentNumber := RangeMin to RangeMax do
      if CurrentNumber mod 2 = 0 then
        EvenNumberList.Add(CurrentNumber);
    Result := EvenNumberList.ToArray;
  finally
    EvenNumberList.Free;
  end;
end;

end.
