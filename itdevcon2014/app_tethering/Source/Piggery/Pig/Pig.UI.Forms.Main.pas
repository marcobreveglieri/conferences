unit Pig.UI.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, IPPeerClient, IPPeerServer, System.Tether.Manager,
  System.Tether.AppProfile, System.Actions, FMX.ActnList, FMX.Media,
  System.IOUtils;

type
  TMainForm = class(TForm)
    OinkPlayButton: TButton;
    PigImage: TImage;
    StatusButton: TButton;
    AppActionList: TActionList;
    OinkPlayAction: TAction;
    TetheringManager: TTetheringManager;
    TetheringAppProfile: TTetheringAppProfile;
    MediaPlayer: TMediaPlayer;
    procedure StatusButtonClick(Sender: TObject);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
    procedure OinkPlayActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.OinkPlayActionExecute(Sender: TObject);
begin
  // NOTE:
  // This action is shared and can be mirrored and invoked by connected apps.

  // Play the "oink" sound effect through the MediaPlayer components
  // (or stop the sound if it is already playing).
  if MediaPlayer.State = TMediaState.Playing then
    MediaPlayer.Stop
  else begin
    MediaPlayer.FileName := System.IOUtils.TPath.GetDocumentsPath + PathDelim + 'oink.mp3';
    MediaPlayer.Play;
  end;
end;

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
  StatusButton.Text := 'CONNECTED! Happy oink!';
end;

end.
