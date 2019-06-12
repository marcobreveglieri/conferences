unit Logger;

interface

type

{ TConsole }

  TConsole = class
  public
    class procedure Log(const AText: string);
  end;

implementation

{ TConsole }

class procedure TConsole.Log(const AText: string);
begin
  Writeln(AText);
end;

end.
