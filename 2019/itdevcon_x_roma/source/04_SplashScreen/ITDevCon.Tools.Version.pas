unit ITDevCon.Tools.Version;

interface

type
  TVersionInfo = record
    Major: Integer;
    Minor: Integer;
    Release: Integer;
    Build: Integer;
  end;

procedure FillVersionInfo(var AVersionInfo: TVersionInfo);

implementation

uses
  Winapi.Windows;

procedure FillVersionInfo(var AVersionInfo: TVersionInfo);
var
  LBuffer: array [0 .. MAX_PATH] of Char;
  LVerValue: PVSFixedFileInfo;
  LHandle, LVerInfoSize, LVerValueSize: Cardinal;
  PVerInfo: Pointer;
begin
  GetModuleFileName(HInstance, LBuffer, MAX_PATH);
  LVerInfoSize := GetFileVersionInfoSize(LBuffer, LHandle);
  if LVerInfoSize = 0 then
  begin
    FillChar(AVersionInfo, SizeOf(AVersionInfo), 0);
    Exit;
  end;
  GetMem(PVerInfo, LVerInfoSize);
  try
    GetFileVersionInfo(LBuffer, 0, LVerInfoSize, PVerInfo);
    VerQueryValue(PVerInfo, '\', Pointer(LVerValue), LVerValueSize);
    with LVerValue^ do
    begin
      AVersionInfo.Major := dwFileVersionMS shr 16;
      AVersionInfo.Minor := dwFileVersionMS and $FFFF;
      AVersionInfo.Release := dwFileVersionLS shr 16;
      AVersionInfo.Build := dwFileVersionLS and $FFFF;
    end;
  finally
    FreeMem(PVerInfo, LVerInfoSize);
  end;
end;

end.
