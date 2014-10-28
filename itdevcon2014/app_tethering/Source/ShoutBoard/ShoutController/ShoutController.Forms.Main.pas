unit ShoutController.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, FMX.StdCtrls,
  FMX.Objects, System.Actions, FMX.ActnList, FMX.Colors, FMX.Layouts, FMX.Memo,
  FMX.ListBox;

type
  TMainForm = class(TForm)
    TetheringAppProfile: TTetheringAppProfile;
    TetheringManager: TTetheringManager;
    StatusPanel: TPanel;
    StatusCircle: TCircle;
    TetheringConnectButton: TButton;
    MainActionList: TActionList;
    TetheringConnectAction: TAction;
    MessageGridPanelLayout: TGridPanelLayout;
    MessageTextLabel: TLabel;
    MessageTextMemo: TMemo;
    BackgroundColorLabel: TLabel;
    MessageSetButton: TButton;
    MessageSetAction: TAction;
    MessageColorComboBox: TColorComboBox;
    procedure MainActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
    procedure MessageSetActionExecute(Sender: TObject);
    procedure TetheringConnectActionExecute(Sender: TObject);
  private
    { Private declarations }
    FTetheringConnected: Boolean;
    procedure UpdateMessageResources;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.MainActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  // Update the state of available actions and controls.
  if FTetheringConnected then
    StatusCircle.Fill.Color := TAlphaColors.Green
  else
    StatusCircle.Fill.Color := TAlphaColors.Red;
  TetheringConnectAction.Enabled := not FTetheringConnected;
  MessageSetAction.Enabled := True;
  Handled := True;
end;

procedure TMainForm.MessageSetActionExecute(Sender: TObject);
begin
  // When the user decides to set a new message (text, color, etc.),
  // update the corresponding resources to make connected apps
  // reflect these changes.
  UpdateMessageResources;
end;

procedure TMainForm.TetheringConnectActionExecute(Sender: TObject);
begin
  // Connect to available tethering managers and app profiles.
  TetheringManager.AutoConnect();
end;

procedure TMainForm.TetheringManagerEndAutoConnect(Sender: TObject);
begin
  // Set the tethering status to "connected" and set the initial message.
  FTetheringConnected := True;
  MessageSetAction.Execute;
end;

procedure TMainForm.UpdateMessageResources;
begin
  // Update text and background color resources in order to make
  // connected apps which have subscribed these resources to be
  // notified and reflect these changes updating their UI.
  TetheringAppProfile.Resources.FindByName('MessageText').Value := MessageTextMemo.Text;
  TetheringAppProfile.Resources.FindByName('MessageBackgroundColor').Value := MessageColorComboBox.Color;
end;

end.
