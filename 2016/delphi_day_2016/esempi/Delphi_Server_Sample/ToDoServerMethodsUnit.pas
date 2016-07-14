unit ToDoServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth;

type
  TToDoServerMethods = class(TDSServerModule)
  private
    { Private declarations }
    FToDoList: TStrings;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    (*
    GET
      Utility.Storage
    PUT
      Utility.acceptStorage
    POST
      Utility.updateStorage
    DELETE
      Utility.cancelStorage
      *)
    function ToDo: TJSONArray;
    function acceptToDo(Key: String; Data: TJSONValue): TJSONValue;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TToDoServerMethods.acceptToDo(Key: String;
  Data: TJSONValue): TJSONValue;
begin
  FToDoList.Add(Data.Value);
end;

constructor TToDoServerMethods.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FToDoList := TStringList.Create;
  FToDoList.Add('Spesa');
  FToDoList.Add('Rifornimento');
end;

destructor TToDoServerMethods.Destroy;
begin
  FToDoList.Free;
  inherited Destroy;
end;

function TToDoServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TToDoServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TToDoServerMethods.ToDo: TJSONArray;
var
  MyElem: string;
begin
  Result := TJSONArray.Create;
  for MyElem in FToDoList do
  begin
    Result.AddElement(TJSONString.Create(MyElem));
  end;
end;

end.

