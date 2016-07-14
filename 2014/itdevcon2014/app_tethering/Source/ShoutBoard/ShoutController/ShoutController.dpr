program ShoutController;

uses
  System.StartUpCopy,
  FMX.Forms,
  ShoutController.Forms.Main in 'ShoutController.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
