program ChatOnTheFly;

uses
  System.StartUpCopy,
  FMX.Forms,
  ChatOnTheFly.Forms.Main in 'ChatOnTheFly.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Chat On The Fly';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
