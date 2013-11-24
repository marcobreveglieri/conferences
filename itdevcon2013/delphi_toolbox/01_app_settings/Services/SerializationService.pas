unit SerializationService;

interface

uses
  Classes, SysUtils;

type

{ TSerializationService }

  /// <summary>
  /// Fornisce metodi e funzioni che consentono di serializzare oggetti
  ///  per il loro trasferimento via file, via socket o con altri metodi
  ///  di comunicazione tra processi e servizi.
  /// </summary>
  /// <remarks>
  /// E' necessario ricordare di registrare le classi per poter utilizzare
  ///  le funzioni di serializzazione/deserializzazione, tramite la
  ///  procedura RegisterClass().
  /// </remarks>
  TSerializationService = class
  public
    /// <summary>
    /// Serializza il componente specificato come parametro, memorizzandolo
    ///  all'interno di un file esterno.
    /// </summary>
    class procedure ComponentToFile(AComponent: TComponent; const AFileName: string);
    /// <summary>
    /// Deserializza un componente prelevando le sue caratteristiche
    ///  da un file esterno e creandone una nuova istanza.
    /// </summary>
    class function FileToComponent(const AFileName: string): TComponent; overload;
    /// <summary>
    /// Deserializza un componente prelevando le sue caratteristiche
    ///  da un file esterno.
    /// </summary>
    class procedure FileToComponent(const AFileName: string; AComponent: TComponent); overload;
  end;

implementation

{ TSerializationService }

class procedure TSerializationService.ComponentToFile(AComponent: TComponent;
  const AFileName: string);
var
  BinStream: TMemoryStream;
  FileStream: TFileStream;
begin
  BinStream := TMemoryStream.Create;
  try
    FileStream := TFileStream.Create(AFileName, fmCreate);
    try
      BinStream.WriteComponent(AComponent);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, FileStream);
    finally
      FileStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;

class function TSerializationService.FileToComponent(
  const AFileName: string): TComponent;
var
  BinStream: TMemoryStream;
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    BinStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(FileStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      Result := BinStream.ReadComponent(nil);
    finally
      BinStream.Free;
    end;
  finally
    FileStream.Free;
  end;
end;

class procedure TSerializationService.FileToComponent(const AFileName: string;
  AComponent: TComponent);
var
  BinStream: TMemoryStream;
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    BinStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(FileStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      BinStream.ReadComponent(AComponent);
    finally
      BinStream.Free;
    end;
  finally
    FileStream.Free;
  end;
end;

end.
