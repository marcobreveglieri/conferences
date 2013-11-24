program XFilesSystemApp;

uses
  Vcl.Forms,
  UIMain in 'UIMain.pas' {MainForm},
  Archive in '..\Archive.pas',
  Authenticator in '..\Authenticator.pas',
  Communicator in '..\Communicator.pas',
  DIBootstrap in 'DIBootstrap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
