unit ConfigurationManager;

interface

uses
  Classes, SysUtils, Windows, IOUtils, SHFolder,
  AppSettings, SerializationService;

type

{ TConfigurationManager }

  TConfigurationManager = class
  private
    class function GetFilePath(const AName: string; ForUser: Boolean): string;
  public
    class function Load(AClass: TAppSettingsClass; ForUser: Boolean): TAppSettings;
    class procedure Save(AInstance: TAppSettings; ForUser: Boolean);
  end;

implementation

const
  StrAppCompany = 'MarcoBreveglieri';
  StrAppProduct = 'AppSettingsDemo';
  StrAppVersion = '1.0';
  StrFileName = 'Settings.dfm';

{ TConfigurationManager }

class function TConfigurationManager.GetFilePath(const AName: string;
  ForUser: Boolean): string;
const
  SCOPE_CSIDL: array [Boolean] of Integer = (
    CSIDL_COMMON_APPDATA, CSIDL_LOCAL_APPDATA);
var
  Buffer: PWideChar;
  BasePath: string;
begin
  // Alloca il buffer in cui ricevere il percorso
  Buffer := StrAlloc(MAX_PATH + 1);
  try
    // Azzera il contenuto del buffer
    FillMemory(Buffer, MAX_PATH + 1, 0);
    // Richiama la funzione che restituisce il percorso dei file dell'applicazione
    if not Succeeded(SHGetFolderPath(0, SCOPE_CSIDL[ForUser], 0, 0, Buffer)) then
      raise Exception.Create('Cannot get path for configuration');
    // Converte il buffer nel tipo stringa nativo
    BasePath := StrPas(Buffer);
  finally
    // Rilascia la memoria allocata per il buffer
    StrDispose(Buffer);
  end;
  // Include il delimitatore di percorso
  BasePath := IncludeTrailingPathDelimiter(Trim(BasePath));
  // Completa il percorso con le informazioni sull'applicazione
  if Length(StrAppCompany) > 0 then
    BasePath := IncludeTrailingPathDelimiter(BasePath + StrAppCompany);
  if Length(StrAppProduct) > 0 then
    BasePath := IncludeTrailingPathDelimiter(BasePath + StrAppProduct);
  if Length(StrAppVersion) > 0 then
    BasePath := IncludeTrailingPathDelimiter(BasePath + StrAppVersion);
  // Restituisce il percorso completo e pronto all'uso
  Result := IncludeTrailingPathDelimiter(Trim(BasePath)) + AName;
end;

class function TConfigurationManager.Load(AClass: TAppSettingsClass;
  ForUser: Boolean): TAppSettings;
var
  ConfigPath: string;
begin
  // Inizializza il valore di ritorno della funzione
  Result := nil;
  // Ottiene il nome del file di configurazione
  ConfigPath := Self.GetFilePath(StrFileName, ForUser);
  // Se il file di configurazione esiste, carica le impostazioni contenute,
  // altrimenti crea una nuova istanza predefinita della configurazione
  if TFile.Exists(ConfigPath) then
  begin
    try
      Result := TSerializationService.FileToComponent(ConfigPath) as AClass
    except
    end;
  end;
  // Se non è stato possibile ottenere una configurazione,
  // ne crea una utilizzando i valori predefiniti
  if Result = nil then
    Result := AClass.Create(nil);
end;

class procedure TConfigurationManager.Save(AInstance: TAppSettings;
  ForUser: Boolean);
var
  ConfigPath: string;
  ConfigDir: string;
begin
  // Ottiene il percorso completo del file di configurazione
  ConfigPath := GetFilePath(StrFileName, ForUser);
  // Determina il percorso della directory che conterrà il file
  ConfigDir := ExtractFileDir(ConfigPath);
  // Verifica che la directory esista su file system;
  // in caso negativo, provvede a crearla
  if (not TDirectory.Exists(ConfigDir)) then
    TDirectory.CreateDirectory(ConfigDir);
  // Salva il file di configurazione nel percorso
  TSerializationService.ComponentToFile(AInstance, ConfigPath);
end;

end.
