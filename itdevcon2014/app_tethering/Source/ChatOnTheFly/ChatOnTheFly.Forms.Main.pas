unit ChatOnTheFly.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Memo, System.Actions,
  FMX.ActnList, IPPeerClient, IPPeerServer, System.Tether.Manager,
  System.Tether.AppProfile;

type
  TMainForm = class(TForm)
    HeaderToolBar: TToolBar;
    FooterToolBar: TToolBar;
    HeaderLabel: TLabel;
    MessageEdit: TEdit;
    SendMessageButton: TButton;
    ChatMemo: TMemo;
    MainActionList: TActionList;
    SendMessageAction: TAction;
    ChatManager: TTetheringManager;
    ChatAppProfile: TTetheringAppProfile;
    NameToolBar: TToolBar;
    NameEdit: TEdit;
    NameLabel: TLabel;
    procedure SendMessageActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChatManagerRequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure ChatAppProfileResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure MessageEditKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure MainActionListUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    FPassword: string;
    procedure AppendToChatLog(const AText: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.AppendToChatLog(const AText: string);
begin
  // Append text to the chat log memo control, adding a separator.
  if ChatMemo.Lines.Count > 0 then
    ChatMemo.Lines.Add(StringOfChar('-', 10));
  ChatMemo.Lines.Add(AText);
end;

procedure TMainForm.ChatAppProfileResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  // Add any new message received as a string resource
  // from a connected app to the chat log control.
  AppendToChatLog(AResource.Value.AsString);
end;

procedure TMainForm.ChatManagerRequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  // Set the password required by the manager this app is trying to connect to.
  Password := FPassword;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Set the password required by other instances (with tethering managers)
  // to create a connection to hosted app profiles. You can also ask the user
  // to manually enter this password through an Input Box or similar.
  FPassword := 'toc';
  // Auto discover and connect to available tethering managers and profiles.
  ChatManager.AutoConnect();
end;

procedure TMainForm.MainActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  // Enable the message sending action only if nickname and text are specified.
  SendMessageAction.Enabled := (Length(Trim(NameEdit.Text)) > 0)
    and (Length(Trim(MessageEdit.Text)) > 0);
  Handled := True;
end;

procedure TMainForm.MessageEditKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  // Send the message by hitting return key.
  if Key = vkReturn then
    SendMessageAction.Execute;
end;

procedure TMainForm.SendMessageActionExecute(Sender: TObject);
var
  RemoteProfile: TTetheringProfileInfo;
  MessageText: string;
begin
  // Create a formatted log for the message to send to connected apps.
  MessageText := Format('%s says: "%s"',
    [Trim(NameEdit.Text), Trim(MessageEdit.Text)]);
  // Append the message to the chat log.
  AppendToChatLog(MessageText);
  // Scan remote connected profiles and send the message log as a resource.
  for RemoteProfile in ChatManager.RemoteProfiles do
    ChatAppProfile.SendString(RemoteProfile, 'New message', MessageText);
  // Empty the message input box for new text.
  MessageEdit.Text := EmptyStr;
end;

end.
