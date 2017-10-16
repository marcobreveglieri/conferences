unit IR.UI.Widgets.ScrollingNews;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Ani, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, FMX.Effects;

type

{ TScrollingNewsWidgetFrame }

  TScrollingNewsWidgetFrame = class(TSharedWidgetFrame)
    ScrollingLabel: TLabel;
    ScrollingAnimation: TFloatAnimation;
    BuiltWidthImage: TImage;
    procedure ScrollingAnimationFinish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Setup;
  end;

implementation

{$R *.fmx}

procedure TScrollingNewsWidgetFrame.ScrollingAnimationFinish(Sender: TObject);
begin
  inherited;
  Setup;
end;

procedure TScrollingNewsWidgetFrame.Setup;
const
  Trail: Integer = 400;
  DurationLengthRatio: Integer = 100;
begin
  if Parent = nil then
    Exit;
  ScrollingAnimation.Enabled := False;
  ScrollingLabel.Position.X := Self.Width;
  ScrollingAnimation.Duration := ScrollingLabel.Width / DurationLengthRatio;
  ScrollingAnimation.StartValue := Self.Width;
  ScrollingAnimation.StopValue := 0 - ScrollingLabel.Width - Trail;
  ScrollingAnimation.Enabled := True;
  ScrollingAnimation.Start;
end;

end.
