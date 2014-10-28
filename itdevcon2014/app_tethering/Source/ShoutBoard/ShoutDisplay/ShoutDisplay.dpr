program ShoutDisplay;

uses
  System.StartUpCopy,
  FMX.Forms,
  ShoutDisplay.Forms.Main in 'ShoutDisplay.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
