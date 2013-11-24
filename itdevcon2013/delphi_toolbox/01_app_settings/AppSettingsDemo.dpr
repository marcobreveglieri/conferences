program AppSettingsDemo;

uses
  Vcl.Forms,
  FrmMain in 'FrmMain.pas' {MainForm},
  AppSettings in 'Models\AppSettings.pas',
  ConfigurationManager in 'Services\ConfigurationManager.pas',
  SerializationService in 'Services\SerializationService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
