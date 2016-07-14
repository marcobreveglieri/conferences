unit BarcodeClient.Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    BarcodeManager: TTetheringManager;
    BarcodeAppProfile: TTetheringAppProfile;
    ProductCodeLabel: TLabel;
    CodeEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BarcodeAppProfileResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.BarcodeAppProfileResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  // Displays the received resource containing the scanned barcode as a string.
  CodeEdit.Text := AResource.Value.AsString;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Connects to available tethering managers and profiles.
  BarcodeManager.AutoConnect();
end;

end.
