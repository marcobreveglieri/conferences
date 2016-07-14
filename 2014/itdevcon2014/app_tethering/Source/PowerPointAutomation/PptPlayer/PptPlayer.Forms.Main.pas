unit PptPlayer.Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ComObj, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Vcl.ImgList, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, Vcl.ExtCtrls;

type

{ TMainForm }

  TMainForm = class(TForm)
    PptOpenDialog: TOpenDialog;
    ExitButton: TButton;
    PlayerActionList: TActionList;
    PlayerImageList: TImageList;
    OpenAction: TAction;
    ExitAction: TAction;
    RestartAction: TAction;
    SlidePreviousAction: TAction;
    SlideNextAction: TAction;
    OpenButton: TButton;
    RestartButton: TButton;
    SlidePreviousButton: TButton;
    SlideNextButton: TButton;
    TetheringManager: TTetheringManager;
    TetheringAppProfile: TTetheringAppProfile;
    SeparatorBevel: TBevel;
    ConnectAction: TAction;
    ConnectButton: TButton;
    StatusPanel: TPanel;
    procedure PlayerActionListUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure ExitActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure RestartActionExecute(Sender: TObject);
    procedure SlidePreviousActionExecute(Sender: TObject);
    procedure SlideNextActionExecute(Sender: TObject);
    procedure ConnectActionExecute(Sender: TObject);
    procedure TetheringManagerEndAutoConnect(Sender: TObject);
  private
    { Private declarations }
    FPowerPointApp: OLEVariant;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  PptPlayer.Resources.Strings;

{ TMainForm }

constructor TMainForm.Create(AOwner: TComponent);
begin
  // Initialize the main form.
  inherited Create(AOwner);
  FPowerPointApp := Unassigned;
end;

destructor TMainForm.Destroy;
begin
  // Quit and release the PowerPoint application.
  if not VarIsEmpty(FPowerPointApp) then
  begin
    FPowerPointApp.Quit;
    FPowerPointApp := Unassigned;
  end;
  inherited Destroy;
end;

procedure TMainForm.ConnectActionExecute(Sender: TObject);
begin
  // Connect to available tethering managers and app profiles.
  StatusPanel.Caption := StrStatusConnecting;
  TetheringManager.AutoConnect();
end;

procedure TMainForm.ExitActionExecute(Sender: TObject);
begin
  // Close the main form.
  Self.Close;
end;

procedure TMainForm.OpenActionExecute(Sender: TObject);
begin
  // Select a PowerPoint slideshow to open.
  if not PptOpenDialog.Execute() then
    Exit;

  // Check if PowerPoint application is already started.
  if not VarIsEmpty(FPowerPointApp) then
  begin
    FPowerPointApp.Quit;
    FPowerPointApp := Unassigned;
  end;

  // Startup the PowerPoint application.
  try
    FPowerPointApp := CreateOleObject('PowerPoint.Application');
  except
    ShowMessage('Error activating PowerPoint application');
    FPowerPointApp := Unassigned;
    Exit;
  end;

  // Make Powerpoint application main window visible.
  FPowerPointApp.Visible := True;

  // Open a presentation.
  FPowerPointApp.Presentations.Open(PptOpenDialog.FileName, True, False, True);

  // Run the presentation.
  FPowerPointApp.ActivePresentation.SlideShowSettings.Run;
end;

procedure TMainForm.PlayerActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  IsPowerPointAppRunning: Boolean;
begin
  // Check whether PowerPoint is running.
  IsPowerPointAppRunning := not VarIsEmpty(FPowerPointApp);
  // Update state for all actions.
  OpenAction.Enabled := True;
  ExitAction.Enabled := True;
  RestartAction.Enabled := IsPowerPointAppRunning;
  SlidePreviousAction.Enabled := IsPowerPointAppRunning;
  SlideNextAction.Enabled := IsPowerPointAppRunning;
  Handled := True;
end;

procedure TMainForm.RestartActionExecute(Sender: TObject);
begin
  // Restart presentation from beginning.
  FPowerPointApp.ActivePresentation.SlideShowWindow.View.GoToSlide(1);
end;

procedure TMainForm.SlideNextActionExecute(Sender: TObject);
begin
  // Go to next presentation slide.
  FPowerPointApp.ActivePresentation.SlideShowWindow.View.Next;
end;

procedure TMainForm.SlidePreviousActionExecute(Sender: TObject);
begin
  // Go to previous presentation slide.
  FPowerPointApp.ActivePresentation.SlideShowWindow.View.Previous;
end;

procedure TMainForm.TetheringManagerEndAutoConnect(Sender: TObject);
begin
  // Show a message when auto connection is finished.
  StatusPanel.Caption := StrStatusConnected;
end;

end.
