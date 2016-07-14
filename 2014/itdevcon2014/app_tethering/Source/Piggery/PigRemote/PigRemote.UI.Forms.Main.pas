unit PigRemote.UI.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IPPeerClient, IPPeerServer, System.Tether.Manager, System.Tether.AppProfile,
  System.Actions, FMX.ActnList, FMX.Objects;

type
  TMainForm = class(TForm)
    TetheringManager: TTetheringManager;
    TetheringAppProfile: TTetheringAppProfile;
    MainActionList: TActionList;
    OinkPlayAction: TAction;
    OinkPlayButton: TButton;
    StatusButton: TButton;
    PigImage: TImage;
    StyleBook1: TStyleBook;
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
    procedure StatusButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

// NOTE:
// the "OinkPlayAction" *mirrors* actions with the same name
// which are made available by connected apps.

procedure TMainForm.StatusButtonClick(Sender: TObject);
begin
  // Show the "Connecting" status message.
  StatusButton.Text := 'Connecting...';
  // Connect to available tethering managers and app profiles.
  TetheringManager.AutoConnect();
end;

procedure TMainForm.TetheringManagerEndAutoConnect(Sender: TObject);
begin
  // Change the status text when available apps are connected.
  StatusButton.Text := 'CONNECTED to the piggery!';
end;

end.
