unit BarcodeReader.Forms.Main;

// NOTE:
// this sample contains code to invoke "Barcode Scanner" application written by
// Andrea Magni (see http://blog.delphiedintorni.it/2014/10/leggere-e-produrre-barcode-con-delphi.html)

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IPPeerClient, IPPeerServer, System.Tether.Manager, System.Tether.AppProfile,
  System.Actions, FMX.ActnList, System.Messaging,
  Androidapi.JNI.App, Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.JavaTypes,
  Androidapi.Helpers;

type
  TMainForm = class(TForm)
    HeaderToolBar: TToolBar;
    FooterToolBar: TToolBar;
    HeaderLabel: TLabel;
    BarcodeManager: TTetheringManager;
    BarcodeAppProfile: TTetheringAppProfile;
    MainActionList: TActionList;
    ScanAction: TAction;
    ScanButton: TButton;
    CodeLabel: TLabel;
    procedure ScanActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMessageSubscriptionID: Integer;
    procedure HandleActivityMessage(const Sender: TObject; const M: TMessage);
    function HandleActivityResult(RequestCode, ResultCode: Integer; Data: JIntent): Boolean;
    procedure SendBarcodeValue(const ACode: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

const SCAN_REQUEST_CODE = 0;

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Connect to available tethering managers and profiles.
  BarcodeManager.AutoConnect();
end;

procedure TMainForm.HandleActivityMessage(const Sender: TObject;
  const M: TMessage);
begin
  // Handle the activity result notification message.
  if M is TMessageResultNotification then
    HandleActivityResult(
      TMessageResultNotification(M).RequestCode,
      TMessageResultNotification(M).ResultCode,
      TMessageResultNotification(M).Value);
end;

function TMainForm.HandleActivityResult(RequestCode, ResultCode: Integer;
  Data: JIntent): Boolean;
var
  LScanContent, LScanFormat: string;
begin
  // Handle the barcode scanning activity result and extract information.
  Result := False;
  TMessageManager.DefaultManager.Unsubscribe(TMessageResultNotification, FMessageSubscriptionID);
  FMessageSubscriptionID := 0;
  if RequestCode = SCAN_REQUEST_CODE then
  begin
    if ResultCode = TJActivity.JavaClass.RESULT_OK then
    begin
      Result := True;
      if Assigned(Data) then
      begin
        LScanContent := JStringToString(Data.getStringExtra(StringToJString('SCAN_RESULT')));
        LScanFormat := JStringToString(Data.getStringExtra(StringToJString('SCAN_RESULT_FORMAT')));
        TThread.Synchronize(nil,
          procedure
          begin
            // Display the read barcode value.
            CodeLabel.Text := LScanContent;
            // Send the code to connected apps.
            SendBarcodeValue(LScanContent);
            Realign; // avoid GUI glitches
          end
        );
      end;
    end
    else
      TThread.Synchronize(nil,
        procedure
        begin
          // Scan has been cancelled by the user.
          Realign; // avoid GUI glitches
        end
      );
  end;
end;

procedure TMainForm.ScanActionExecute(Sender: TObject);
var
  Intent: JIntent;
begin
  // Set the activity result message handler.
  FMessageSubscriptionID := TMessageManager.DefaultManager.SubscribeToMessage(
    TMessageResultNotification, HandleActivityMessage);

  // Launch "Barcode Scanner" application for scanning.
  Intent := TJIntent.JavaClass.init(StringToJString('com.google.zxing.client.android.SCAN'));
  Intent.setPackage(StringToJString('com.google.zxing.client.android'));
  Intent.putExtra(StringToJString('SCAN_MODE'),
    StringToJString('ONE_D_MODE,QR_CODE_MODE,PRODUCT_MODE,DATA_MATRIX_MODE'));

  // Start the activity and wait for result.
  SharedActivity.startActivityForResult(Intent, SCAN_REQUEST_CODE);
end;

procedure TMainForm.SendBarcodeValue(const ACode: string);
var
  RemoteProfile: TTetheringProfileInfo;
begin
  // Scan connected remote tethering profiles which are listening
  // and send them a string resource containing the scanned barcode.
  for RemoteProfile in BarcodeManager.RemoteProfiles do
    BarcodeAppProfile.SendString(RemoteProfile, 'Code', ACode);
end;

end.
