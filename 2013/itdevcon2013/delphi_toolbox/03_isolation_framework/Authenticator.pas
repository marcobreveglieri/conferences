unit Authenticator;

interface

uses
  Classes, SysUtils, Data.DB, SqlExpr;

type

{ IAuthenticator }

{$M+}
  IAuthenticator = interface
    ['{C1F2E32B-C209-4008-B439-BA36AAF0A610}']
    function ValidateCredentials(const AUserName, APassword: string): Boolean;
  end;
{$M-}

{ TAuthenticator }

  TAuthenticator = class (TInterfacedObject, IAuthenticator)
  public
    function ValidateCredentials(const AUserName, APassword: string): Boolean;
  end;

implementation

{ TAuthenticator }

function TAuthenticator.ValidateCredentials(
  const AUserName, APassword: string): Boolean;
var
  Connection: TSQLConnection;
  Params: TParams;
  ResultSet: TDataSet;
begin
  Connection := TSQLConnection.Create(nil);
  try
    Connection.Open;
    Params := TParams.Create(nil);
    try
      // Codice a puro titolo esemplificativo
      Params.ParamValues['UserName'] := AUserName;
      Params.ParamValues['Password'] := APassword;
      Connection.Execute('SELECT * FROM Credentials '
        + 'WHERE (UserName = :UserName) AND (Password = :Password)',
        Params, ResultSet);
      Result := (ResultSet.RecordCount > 0);
    finally
      Params.Free;
    end;
  finally
    Connection.Free;
  end;
end;

end.
