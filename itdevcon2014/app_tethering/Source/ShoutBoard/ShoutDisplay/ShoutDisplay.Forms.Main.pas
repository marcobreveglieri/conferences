unit ShoutDisplay.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, IPPeerClient, IPPeerServer, System.Tether.Manager,
  System.Tether.AppProfile;

type
  TMainForm = class(TForm)
    BackgroundRect: TRectangle;
    MessageLabel: TLabel;
    TetheringManager: TTetheringManager;
    TetheringAppProfile: TTetheringAppProfile;
    procedure FormCreate(Sender: TObject);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
    procedure TetheringAppProfileResources0ResourceReceived(
      const Sender: TObject; const AResource: TRemoteResource);
    procedure TetheringAppProfileResources1ResourceReceived(
      const Sender: TObject; const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Connect to available tethering managers and app profiles.
  MessageLabel.Text := EmptyStr;
  TetheringManager.AutoConnect();
end;

procedure TMainForm.TetheringAppProfileResources0ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  // When the "message text" resource is received,
  // display it inside the big label on the screen.
  MessageLabel.Text := AResource.Value.AsString;
end;

procedure TMainForm.TetheringAppProfileResources1ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  // When the "background color" resource is received,
  // set it for filling the app background rectangle.
  BackgroundRect.Fill.Color := AResource.Value.AsInteger;
end;

procedure TMainForm.TetheringManagerEndAutoConnect(Sender: TObject);
begin
  // Show a message when auto connection is finished.
  MessageLabel.Text := '- Ready -';
end;

end.
