unit IR.UI.Widgets.Logo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Objects, FMX.Layouts, FMX.Effects;

type

{ TLogoWidgetFrame }

  TLogoWidgetFrame = class(TSharedWidgetFrame)
    LogoImage: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
