unit Spotify.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, Data.Bind.Components, Data.Bind.ObjectScope, Fmx.Bind.GenData,
  Data.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, IPPeerClient, REST.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  Data.Bind.DBScope, FireDAC.Stan.StorageBin, FMX.Controls.Presentation,
  FMX.Edit, FMX.StdCtrls, FMX.Objects, System.JSON, IdHTTP, ShellAPI;

type
  TMainForm = class(TForm)
    ListView1: TListView;
    BindingsList1: TBindingsList;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    SearchAuthorEdit: TEdit;
    SearchAuthorLabel: TLabel;
    SearchAuthorButton: TButton;
    LinkListControlToField1: TLinkListControlToField;
    SpotifyOpenButton: TButton;
    Image1: TImage;
    procedure SearchAuthorButtonClick(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpotifyOpenButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;


implementation

{$R *.fmx}

procedure TMainForm.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  ImageJson: string;
  ImageUrl: string;
  ImageValue: TJSONValue;
  ImageArray: TJSONArray;
  PosStart: Integer;
  PosEnd: Integer;
  ImageStream: TMemoryStream;
begin
  ImageJson := BindSourceDB1.DataSet.FieldByName('images').AsString;
  PosStart := ImageJson.IndexOf('"url":"');
  PosStart := PosStart + 7;
  PosEnd := ImageJson.IndexOf('"', PosStart);
  ImageUrl := ImageJson.Substring(PosStart, PosEnd - PosStart);
  ImageStream := TMemoryStream.Create;
  try
    with TIdHTTP.Create do
    begin
      Get(ImageUrl, ImageStream);
      ImageStream.Position := 0;
      Image1.Bitmap.LoadFromStream(ImageStream);
    end;
  finally
    ImageStream.Free;
  end;
end;

procedure TMainForm.SearchAuthorButtonClick(Sender: TObject);
begin
  FDMemTable1.Close;
  RESTClient1.Params.ParameterByName('NAME').Value := SearchAuthorEdit.Text;
  RESTRequest1.Execute;
end;

procedure TMainForm.SpotifyOpenButtonClick(Sender: TObject);
var
  AuthorUrl: string;
begin
  AuthorUrl := BindSourceDB1.DataSet.FieldByName('external_urls.spotify').AsString;
  ShellExecute(0, 'open', PChar(AuthorUrl), nil, nil, 0);
end;

end.
