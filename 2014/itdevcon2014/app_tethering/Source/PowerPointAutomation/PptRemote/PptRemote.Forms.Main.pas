unit PptRemote.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, FMX.StdCtrls,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.Objects;

type

{ TMainForm }

  TMainForm = class(TForm)
    TetheringManager: TTetheringManager;
    TetheringAppProfile: TTetheringAppProfile;
    StatusLayout: TPanel;
    SlidePreviousButton: TButton;
    SlideNextButton: TButton;
    ContainerLayout: TGridPanelLayout;
    ConnectButton: TButton;
    StatusPanel: TPanel;
    PlayerActionList: TActionList;
    SlidePreviousAction: TAction;
    SlideNextAction: TAction;
    SlidePreviousImage: TImage;
    SlideNextImage: TImage;
    ConnectAction: TAction;
    StatusLabel: TLabel;
    RestartAction: TAction;
    procedure ConnectActionExecute(Sender: TObject);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  PptRemote.Resources.Strings;

{ TMainForm }

procedure TMainForm.ConnectActionExecute(Sender: TObject);
begin
  // Connect to available tethering managers and app profiles.
  StatusLabel.Text := StrStatusConnecting;
  TetheringManager.AutoConnect();
end;

procedure TMainForm.TetheringManagerEndAutoConnect(Sender: TObject);
begin
  // Show a message when auto connection is finished:
  // now this app can remotely execute any mirrored action
  // that is shared by connected apps.
  StatusLabel.Text := StrStatusConnected;
end;

end.
