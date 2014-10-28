program MMPiano;

uses
  System.StartUpCopy,
  FMX.Forms,
  MMPiano.Forms.Main in 'MMPiano.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
