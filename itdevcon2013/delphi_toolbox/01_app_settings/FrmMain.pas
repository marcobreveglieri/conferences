unit FrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, AppSettings, ConfigurationManager, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    btnConfigurationSave: TButton;
    btnConfigurationLoad: TButton;
    aclMain: TActionList;
    actConfigurationLoad: TAction;
    actConfigurationSave: TAction;
    gbxSettings: TGroupBox;
    cbxSettingSaveOnExit: TCheckBox;
    cbxSettingConfirmOnExit: TCheckBox;
    actSettingSaveOnExit: TAction;
    actSettingConfirmOnExit: TAction;
    lblSettingLicenseUser: TLabel;
    tbxSettingLicenseUser: TEdit;
    tbxSettingLicenseSerial: TEdit;
    lblSettingsLicenseSerial: TLabel;
    tbxSettingRecentListSize: TEdit;
    lblSettingRecentListSize: TLabel;
    bvlLine: TBevel;
    updRecentListSize: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure actConfigurationLoadExecute(Sender: TObject);
    procedure actConfigurationSaveExecute(Sender: TObject);
    procedure aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSettingSaveOnExitExecute(Sender: TObject);
    procedure actSettingConfirmOnExitExecute(Sender: TObject);
    procedure tbxSettingRecentListSizeExit(Sender: TObject);
  private
    { Private declarations }
    FSettings: TAppSettings;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  // Aggiorna lo stato dei controlli
  if FSettings = nil then
    Exit;
  actSettingConfirmOnExit.Checked := FSettings.ConfirmOnExit;
  actSettingSaveOnExit.Checked := FSettings.SaveOnExit;
  Handled := True;
end;

procedure TMainForm.actConfigurationLoadExecute(Sender: TObject);
begin
  // Carica le impostazioni di configurazione
  if FSettings <> nil then
    FSettings.Free;
  FSettings := TConfigurationManager.Load(TAppSettings, True);
  tbxSettingLicenseUser.Text := FSettings.LicenseUser;
  tbxSettingLicenseSerial.Text := FSettings.LicenseSerial;
  updRecentListSize.Position := FSettings.RecentListSize;
end;

procedure TMainForm.actConfigurationSaveExecute(Sender: TObject);
begin
  // Salva le impostazioni di configurazione
  FSettings.LicenseUser := tbxSettingLicenseUser.Text;
  FSettings.LicenseSerial := tbxSettingLicenseSerial.Text;
  FSettings.RecentListSize := updRecentListSize.Position;
  TConfigurationManager.Save(FSettings, True);
end;

procedure TMainForm.actSettingConfirmOnExitExecute(Sender: TObject);
begin
  // Modifica l'impostazione per la conferma all'uscita del programma
  FSettings.ConfirmOnExit := not FSettings.ConfirmOnExit;
end;

procedure TMainForm.actSettingSaveOnExitExecute(Sender: TObject);
begin
  // Modifica l'impostazione per il salvataggio all'uscita
  FSettings.SaveOnExit := not FSettings.SaveOnExit;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FSettings.ConfirmOnExit then
  begin
    if Application.MessageBox('Sei sicuro di voler uscire?',
      PChar('Uscita'), MB_ICONWARNING or MB_YESNO) <> IDYES then
    begin
      CanClose := False;
      Exit;
    end;
  end;
  CanClose := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Carica le impostazioni all'avvio (o crea un profilo predefinito)
  actConfigurationLoad.Execute;
end;

procedure TMainForm.tbxSettingRecentListSizeExit(Sender: TObject);
begin
  updRecentListSize.Position := StrToIntDef(tbxSettingRecentListSize.Text,
    updRecentListSize.Position);
end;

end.
