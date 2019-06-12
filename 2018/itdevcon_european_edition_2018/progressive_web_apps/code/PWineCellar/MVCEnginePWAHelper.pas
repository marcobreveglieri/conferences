unit MVCEnginePWAHelper;

interface

uses
  MVCFramework,
  MVCFramework.Commons;

type

  TMVCEnginePWAHelper = class helper for TMVCEngine
    procedure AddMediaType(const AExtension, AMimeType: string);
  end;

implementation

uses
  System.Generics.Collections, Rtti;

{ TPWAEngineHelper }

procedure TMVCEnginePWAHelper.AddMediaType(const AExtension, AMimeType: string);
var
  MediaTypes: TDictionary<string, string>;
begin
  MediaTypes := TRttiContext.Create
    .GetType(TMVCEngine)
    .GetField('FMediaTypes')
    .GetValue(Self)
    .AsObject() as TDictionary<string, string>;
  MediaTypes.AddOrSetValue(AExtension, AMimeType);
end;

end.
