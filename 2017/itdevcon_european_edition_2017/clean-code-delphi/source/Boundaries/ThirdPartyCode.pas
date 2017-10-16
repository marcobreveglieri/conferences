unit ThirdPartyCode;

interface

implementation

uses
  System.Generics.Collections;

type

  TSensor = record
  end;

  TSensors = class
  private
    FSensors: TList<TSensor>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetByIndex(AIndex: Integer): TSensor;
  end;

var
  SensorList: TList<TSensor>;
  Sensors: TSensors;
  SensorItem: TSensor;

{ TSensors }

constructor TSensors.Create;
begin
  inherited;
  FSensors := TList<TSensor>.Create;
end;

destructor TSensors.Destroy;
begin
  FSensors.Free;
  inherited Destroy;
end;

function TSensors.GetByIndex(AIndex: Integer): TSensor;
begin
  Result := FSensors.Items[AIndex];
end;

initialization

  SensorList := TList<TSensor>.Create;
  SensorItem := SensorList.Items[0];

  Sensors := TSensors.Create;
  SensorItem := Sensors.GetByIndex(0);


finalization

  SensorList.Free;
  Sensors.Free;

end.
