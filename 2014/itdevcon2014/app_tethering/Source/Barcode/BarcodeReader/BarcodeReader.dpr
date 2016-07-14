program BarcodeReader;

uses
  System.StartUpCopy,
  FMX.Forms,
  BarcodeReader.Forms.Main in 'BarcodeReader.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
