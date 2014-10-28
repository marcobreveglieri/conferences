program PptPlayer;



uses
  Vcl.Forms,
  PptPlayer.Forms.Main in 'PptPlayer.Forms.Main.pas' {MainForm},
  PptPlayer.Resources.Strings in 'PptPlayer.Resources.Strings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PowerPoint Player';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
