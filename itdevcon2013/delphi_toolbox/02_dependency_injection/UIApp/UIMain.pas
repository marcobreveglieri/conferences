unit UIMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Archive, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls;

type

{ TMainForm }

  TMainForm = class(TForm)
    btnArchiveLogin: TButton;
    aclMain: TActionList;
    actArchiveLogin: TAction;
    actArchiveLogout: TAction;
    btnArchiveLogout: TButton;
    tbxUserName: TEdit;
    tbxPassword: TEdit;
    lblUserName: TLabel;
    lblPassword: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actArchiveLoginExecute(Sender: TObject);
    procedure actArchiveLogoutExecute(Sender: TObject);
  private
    { Private declarations }
    FArchive: IArchive;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Spring.Container, Spring.Services;

{ TMainForm }

procedure TMainForm.aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  actArchiveLogin.Enabled := not FArchive.IsLogged;
  actArchiveLogout.Enabled := FArchive.IsLogged;
  Handled := True;
end;

procedure TMainForm.actArchiveLoginExecute(Sender: TObject);
var
  LoginUserName: string;
  LoginPassword: string;
begin
  // Login
  LoginUserName := tbxUserName.Text;
  LoginPassword := tbxPassword.Text;
  if not FArchive.Login(LoginUserName, LoginPassword) then
    Application.MessageBox('Nome utente / password non validi',
    PChar(Application.Title), MB_ICONWARNING or MB_OK);
end;

procedure TMainForm.actArchiveLogoutExecute(Sender: TObject);
begin
  // Logout
  FArchive.Logout;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FArchive := ServiceLocator.GetService<IArchive>();
end;

end.
