unit UIMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ExtCtrls,
  JSON, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  JPEG;

type
  TMainForm = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    TitleEdit: TLabeledEdit;
    DateEdit: TLabeledEdit;
    ExplanationMemo: TMemo;
    Label1: TLabel;
    DownloadButton: TButton;
    MediaImage: TImage;
    IdHTTP1: TIdHTTP;
    procedure DownloadButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.DownloadButtonClick(Sender: TObject);
var
  ApodData: TJSONValue;
  MediaStream: TMemoryStream;
begin
  RESTRequest1.Execute;
  ApodData := TJSONObject.ParseJSONValue(RESTResponse1.Content);
  TitleEdit.Text := ApodData.GetValue<string>('title');
  DateEdit.Text := ApodData.GetValue<string>('date');
  ExplanationMemo.Text := ApodData.GetValue<string>('explanation');
  MediaStream := TMemoryStream.Create;
  try
    IdHTTP1.Get(ApodData.GetValue<string>('url'), MediaStream);
    MediaStream.Position := 0;
    MediaImage.Picture.LoadFromStream(MediaStream);
  finally
    MediaStream.Free;
  end;
end;

end.
