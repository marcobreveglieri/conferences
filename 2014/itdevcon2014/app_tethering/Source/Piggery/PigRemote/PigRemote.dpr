program PigRemote;

uses
  FMX.Forms,
  PigRemote.UI.Forms.Main in 'PigRemote.UI.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
