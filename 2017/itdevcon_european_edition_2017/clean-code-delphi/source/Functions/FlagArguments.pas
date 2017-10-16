unit FlagArguments;

interface

// WRONG
procedure Render(ForceUpdate: Boolean);

// BETTER
procedure RenderAndForceUpdate();
procedure RenderNotForcingUpdate();

implementation

procedure Render(ForceUpdate: Boolean);
begin
  // ...
end;

procedure RenderAndForceUpdate();
begin
  // ...
end;

procedure RenderNotForcingUpdate();
begin
  // ...
end;

initialization

Render(True);

end.
