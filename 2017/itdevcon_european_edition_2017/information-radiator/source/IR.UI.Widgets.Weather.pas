unit IR.UI.Widgets.Weather;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.JSON,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Layouts, FMX.Controls.Presentation,
  FMX.Objects, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ScrollBox, FMX.Memo, System.ImageList, FMX.ImgList,
  FMX.Effects;

type

{ TWeatherWidgetFrame }

  TWeatherWidgetFrame = class(TSharedWidgetFrame)
    ConditionImage: TImage;
    TemperatureLabel: TLabel;
    LocationLayout: TLayout;
    ConditionLabel: TLabel;
    LocationLabel: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    SampleMemo: TMemo;
    WeatherImageList: TImageList;
  private
    { Private declarations }
    FApiKey: string;
  protected
    { Protected declarations }
    procedure Loaded; override;
  public
    { Public declarations }
    procedure ParseInfo(const JSONPacket: string);
    procedure ShowWeatherIcon(WeatherObject: TJSONObject);
    procedure UpdateInfo;
  end;

implementation

{$R *.fmx}

uses
  FMX.MultiResBitmap,
  IR.Core.App;

{ TWeatherWidgetFrame }

procedure TWeatherWidgetFrame.Loaded;
begin
  inherited;
  FApiKey := IRApp.Ini.ReadString('Weather', 'ApiKey', '');
  ParseInfo(SampleMemo.Lines.Text);
  UpdateInfo;
end;

procedure TWeatherWidgetFrame.ParseInfo(const JSONPacket: string);
var
  WeatherData: TJSONValue;
  WeatherArray: TJSONArray;
  WeatherObject, TemperatureObject: TJSONObject;
  TemperatureValue: Double;
begin
  WeatherData := TJSONObject.ParseJSONValue(JSONPacket);
  try
    WeatherArray := TJSONArray(WeatherData);
    if WeatherArray.Count <= 0 then
      Exit;
    WeatherObject := TJSONObject(WeatherArray.Items[0]);
    ShowWeatherIcon(WeatherObject);
    TemperatureObject := WeatherObject.GetValue<TJSONObject>('Temperature');
    TemperatureValue := TemperatureObject
      .GetValue<TJSONObject>('Metric')
      .GetValue<double>('Value');
    TemperatureLabel.Text := FloatToStr(Trunc(TemperatureValue)) + '°';
  finally
    WeatherData.Free;
  end;
end;

procedure TWeatherWidgetFrame.ShowWeatherIcon(WeatherObject: TJSONObject);
var
  IconIndex: Integer;
  IconName: string;
  IconBitmap: TCustomBitmapItem;
  IconSize: TSize;
begin
  IconIndex := WeatherObject.GetValue<Integer>('WeatherIcon');  
  IconName := Format('%.2d-s', [IconIndex]);
  if not WeatherImageList.BitmapItemByName(IconName, IconBitmap, IconSize) then 
    Exit;
  ConditionImage.Bitmap := IconBitmap.Bitmap;  
end;

procedure TWeatherWidgetFrame.UpdateInfo;
begin
  RESTRequest.Params.ParameterByName('apikey').Value := FApiKey;
  RESTRequest.ExecuteAsync(
    procedure()
    begin
      ParseInfo(RESTResponse.Content);
    end);
end;

end.
