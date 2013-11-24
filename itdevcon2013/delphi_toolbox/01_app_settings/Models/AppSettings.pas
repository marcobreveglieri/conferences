unit AppSettings;

interface

uses
  Classes, SysUtils;

type

{ TAppSettings }

  TAppSettings = class (TComponent)
  private
    FConfirmOnExit: Boolean;
    FLicenseSerial: string;
    FLicenseUser: string;
    FRecentListSize: Integer;
    FSaveOnExit: Boolean;
    function IsLicenseSerialStored: Boolean;
    function IsLicenseUserStored: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ConfirmOnExit: Boolean read FConfirmOnExit write FConfirmOnExit default True;
    property LicenseSerial: string read FLicenseSerial write FLicenseSerial stored IsLicenseSerialStored;
    property LicenseUser: string read FLicenseUser write FLicenseUser stored IsLicenseUserStored;
    property RecentListSize: Integer read FRecentListSize write FRecentListSize default 10;
    property SaveOnExit: Boolean read FSaveOnExit write FSaveOnExit default True;
  end;

{ Class references }

  TAppSettingsClass = class of TAppSettings;

implementation

{ TAppSettings }

constructor TAppSettings.Create(AOwner: TComponent);
begin
  FConfirmOnExit := True;
  FLicenseSerial := 'TRIAL';
  FLicenseUser := EmptyStr;
  FSaveOnExit := True;
  FRecentListSize := 10;
end;

function TAppSettings.IsLicenseSerialStored: Boolean;
begin
  Result := FLicenseSerial <> 'TRIAL';
end;

function TAppSettings.IsLicenseUserStored: Boolean;
begin
  Result := Length(FLicenseUser) > 0;
end;

initialization

  RegisterClass(TAppSettings);

end.
