program Spotify;

uses
  System.StartUpCopy,
  FMX.Forms,
  Spotify.Forms.Main in 'Spotify.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
