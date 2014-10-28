program Pig;

uses
  System.StartUpCopy,
  FMX.Forms,
  Pig.UI.Forms.Main in 'Pig.UI.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
