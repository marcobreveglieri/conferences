unit IR.Shared.UI.Frames.Widget;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects;

type
  TSharedWidgetFrame = class(TFrame)
    TileRectangle: TRectangle;
    TitleText: TText;
    WidgetLayout: TLayout;
    TitleGlowEffect: TGlowEffect;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
