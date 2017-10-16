unit ErrorHandling;

interface

uses
  SysUtils;

type

  ICryptographer = interface
    function Decrypt(const ACodedPhrase: string; const APassword: string): string;
  end;

  ILogger = interface
    procedure Log(const AText: string);
  end;

  TUserValidator = class
  private
    FCryptographer: ICryptographer;
    FLogger: ILogger;
    procedure LogWebException(AnException: Exception);
  public
    function Login(const AUserName, APassword: string): Boolean;
  end;

implementation

{ TUserValidator }

function TUserValidator.Login(const AUserName,
  APassword: string): Boolean;
begin
  try
    // ...login dell'utente...
  except
    on E:Exception do
    begin
      LogWebException(E);
    end;
  end;
end;

procedure TUserValidator.LogWebException(AnException: Exception);
begin
  FLogger.Log(AnException.Message);
end;

end.
