unit ITDevCon.Tools.SplashInfo;

interface

uses
  SysUtils,
  ToolsAPI;

procedure Register;

implementation

uses
  Winapi.Windows, ITDevCon.Tools.Version;

ResourceString
  StrSplashScreenName =
    'ITDevCon Expert Demo %d.%d.%d.%d for Embarcadero RAD Studio ####';
  StrSplashScreenBuild = 'by Marco Breveglieri (Build %d.%d.%d.%d)';
  StrSplashScreenSku = 'SKU name and version';

var
  AboutIndex: Integer = -1;
  BitmapSplashScreen: HBITMAP;
  VersionInfo: TVersionInfo;

procedure Register;
var
  LServices: IOTAServices;
begin
  LServices := BorlandIDEServices As IOTAServices;
  if LServices = nil then
    Exit;
  BitmapSplashScreen := LoadBitmap(HInstance, 'SplashScreenBitmap');
  AboutIndex := (BorlandIDEServices As IOTAAboutBoxServices)
    .AddPluginInfo(Format(StrSplashScreenName, [VersionInfo.Major,
    VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]),
    '$WIZARDDESCRIPTION$.', BitmapSplashScreen, False,
    Format(StrSplashScreenBuild, [VersionInfo.Major, VersionInfo.Minor,
    VersionInfo.Release, VersionInfo.Build]), StrSplashScreenSku,
    TOTAAlphaFormat.otaafIgnored);
end;

initialization

FillVersionInfo(VersionInfo);
BitmapSplashScreen := LoadBitmap(HInstance, 'SplashScreenBitmap');
(SplashScreenServices As IOTASplashScreenServices)
  .AddPluginBitmap(Format(StrSplashScreenName, [VersionInfo.Major,
  VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]),
  BitmapSplashScreen, False, Format(StrSplashScreenBuild, [VersionInfo.Major,
  VersionInfo.Minor, VersionInfo.Release, VersionInfo.Build]),
  StrSplashScreenSku);

finalization

if AboutIndex >= 0 then
  (BorlandIDEServices as IOTAAboutBoxServices).RemovePluginInfo(AboutIndex);

end.
