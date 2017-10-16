unit IR.UI.Widgets.ChuckNorris;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Objects, FMX.Controls.Presentation,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  System.JSON, System.NetEncoding, FMX.Effects, FMX.Layouts;

type

{ TChuckNorrisWidgetFrame }

  TChuckNorrisWidgetFrame = class(TSharedWidgetFrame)
    ChuckImage: TImage;
    QuoteLabel: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    UpdateTimer: TTimer;
    GlowEffect: TGlowEffect;
    procedure UpdateTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

{ TChuckNorrisWidgetFrame }

constructor TChuckNorrisWidgetFrame.Create(AOwner: TComponent);
begin
  inherited;
  QuoteLabel.Text := EmptyStr;
  UpdateTimer.Enabled := True;
  UpdateTimerTimer(nil);
end;

procedure TChuckNorrisWidgetFrame.UpdateTimerTimer(Sender: TObject);
begin
  inherited;
  RESTRequest.ExecuteAsync(
    procedure
    var
      ValueObject: TJSONObject;
      S: string;
    begin
      ValueObject := TJSONObject(RESTResponse.JSONValue);
      ValueObject := TJSONObject(ValueObject.GetValue('value'));
      S := ValueObject.GetValue<string>('joke');
      QuoteLabel.Text := THTMLEncoding.HTML.Decode(S);
    end
  );
end;

end.
