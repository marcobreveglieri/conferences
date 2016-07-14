program CouchDbDemo;

uses
  Vcl.Forms,
  UIFrmMain in 'UIFrmMain.pas' {MainForm},
  DMRest in 'DMRest.pas' {RestDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRestDataModule, RestDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
