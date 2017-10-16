unit IR.UI.Widgets.Sponsors;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Objects, FMX.Layouts, FMX.Effects,
  FMX.TabControl;

type
  TSponsorWidgetFrame = class(TSharedWidgetFrame)
    CarouselTabControl: TTabControl;
    TabItemEmbarcadero: TTabItem;
    TabItemBittime: TTabItem;
    ImageBittime: TImage;
    ImageEmbarcadero: TImage;
    ScrollingTicker: TTimer;
    TabItemEthea: TTabItem;
    ImageEthea: TImage;
    TabItemDevArt: TTabItem;
    ImageDevArt: TImage;
    procedure ScrollingTickerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SponsorWidgetFrame: TSponsorWidgetFrame;

implementation

{$R *.fmx}

procedure TSponsorWidgetFrame.ScrollingTickerTimer(Sender: TObject);
begin
  inherited;
  if CarouselTabControl.TabIndex >= CarouselTabControl.TabCount - 1 then
    CarouselTabControl.First()
  else
    CarouselTabControl.Next();
end;

end.
