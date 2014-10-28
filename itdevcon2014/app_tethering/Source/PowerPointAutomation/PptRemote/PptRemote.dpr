program PptRemote;

uses
  System.StartUpCopy,
  FMX.Forms,
  PptRemote.Forms.Main in 'PptRemote.Forms.Main.pas' {MainForm},
  PptRemote.Resources.Strings in 'PptRemote.Resources.Strings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
