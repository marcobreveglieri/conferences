unit IR.UI.Widgets.Twitter;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.JSON,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, IPPeerClient, REST.Client,
  REST.Authenticator.OAuth, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Layouts, FMX.Effects;

type

  { TTwitterWidgetFrame }

  TTwitterWidgetFrame = class(TSharedWidgetFrame)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    TweetListView: TListView;
    RefreshTimer: TTimer;
    LogoImage: TImage;
    ListRectangle: TRectangle;
    TwitterOAuth1: TOAuth1Authenticator;
    procedure RefreshTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Setup;
  end;

implementation

{$R *.fmx}

uses IR.Core.App;

procedure TTwitterWidgetFrame.RefreshTimerTimer(Sender: TObject);
begin
  inherited;
  RESTRequest.ExecuteAsync(
    procedure
    var
      StatusArray: TJSONArray;
      StatusValue: TJSONValue;
      ListItem: TListViewItem;
    begin
      TweetListView.BeginUpdate;
      try
        TweetListView.Items.Clear;
        StatusArray := RESTResponse.JSONValue as TJSONArray;
        for StatusValue in StatusArray do
        begin
          ListItem := TweetListView.Items.Add;
          // ListItem.Tag := StatusValue.GetValue<Integer>('id');
          ListItem.Objects.FindObjectT<TListItemText>('Message').Text :=
            StatusValue.GetValue<string>('text');
          ListItem.Objects.FindObjectT<TListItemText>('Author').Text :=
            StatusValue.GetValue<TJSONObject>('user').GetValue<string>('name');
          ListItem.Objects.FindObjectT<TListItemText>('UserName').Text :=
            StatusValue.GetValue<TJSONObject>('user')
            .GetValue<string>('screen_name');
        end;
      finally
        TweetListView.EndUpdate;
      end;
    end);
end;

procedure TTwitterWidgetFrame.Setup;
begin
  TwitterOAuth1.AccessToken := IRApp.Ini.ReadString('Twitter',
    'AccessToken', '');
  TwitterOAuth1.AccessTokenEndpoint := IRApp.Ini.ReadString('Twitter',
    'AccessTokenEndpoint', '');
  TwitterOAuth1.AccessTokenSecret := IRApp.Ini.ReadString('Twitter',
    'AccessTokenSecret', '');
  TwitterOAuth1.AuthenticationEndpoint := IRApp.Ini.ReadString('Twitter',
    'AuthenticationEndpoint', '');
  TwitterOAuth1.CallbackEndpoint := IRApp.Ini.ReadString('Twitter',
    'CallbackEndpoint', '');
  TwitterOAuth1.ConsumerKey := IRApp.Ini.ReadString('Twitter',
    'ConsumerKey', '');
  TwitterOAuth1.ConsumerSecret := IRApp.Ini.ReadString('Twitter',
    'ConsumerSecret', '');
  TwitterOAuth1.RequestToken := IRApp.Ini.ReadString('Twitter',
    'RequestToken', '');
  TwitterOAuth1.RequestTokenEndpoint := IRApp.Ini.ReadString('Twitter',
    'RequestTokenEndpoint', '');
  TwitterOAuth1.RequestTokenSecret := IRApp.Ini.ReadString('Twitter',
    'RequestTokenSecret', '');
  TwitterOAuth1.VerifierPIN := IRApp.Ini.ReadString('Twitter',
    'VerifierPIN', '');
  RefreshTimerTimer(nil);
end;

end.
