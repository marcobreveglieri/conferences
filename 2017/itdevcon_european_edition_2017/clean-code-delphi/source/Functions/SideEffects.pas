unit SideEffects;

interface

type

  ICryptographer = interface
    function Decrypt(const ACodedPhrase: string; const APassword: string): string;
  end;

  TUser = class;

  TUser = class
  public
    Null: TUser;
    function GetPhraseEncodedByPassword(): string; virtual; abstract;
  end;

  TUserGateway = class
    class function FindByName(const AUserName: string): TUser; virtual; abstract;
  end;

  TUserSession = class
    class procedure Initialize(); virtual; abstract;
  end;

  TUserValidator = class
  private
    FCryptographer: ICryptographer;
  public
    function CheckPassword(const AUserName, APassword: string): Boolean;
  end;

implementation

{ TUserValidator }

function TUserValidator.CheckPassword(const AUserName: string;
 const APassword: string): Boolean;
var
  User: TUser;
  CodedPhrase, ClearPhrase: string;
begin
  Result := False;
  User := TUserGateway.FindByName(AUserName);
  if User <> User.Null then
  begin
    CodedPhrase := User.GetPhraseEncodedByPassword();
    ClearPhrase := FCryptographer.Decrypt(CodedPhrase, APassword);
    if ClearPhrase = 'Valid Password' then
    begin
      TUserSession.Initialize();
      Result := True;
    end;
  end;
end;

end.
