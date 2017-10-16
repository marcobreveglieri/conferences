unit IR.UI.Widgets.Clock;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Effects;

type

{ TClockWidgetFrame }

  TClockWidgetFrame = class(TSharedWidgetFrame)
    ClockCircle: TCircle;
    LayoutZiffer: TLayout;
    Text1: TText;
    rrHour: TRoundRect;
    rrMin: TRoundRect;
    rrSec: TRoundRect;
    Layout1: TLayout;
    Text2: TText;
    Layout2: TLayout;
    Text3: TText;
    Layout3: TLayout;
    Text4: TText;
    Layout4: TLayout;
    Text5: TText;
    Layout5: TLayout;
    Text6: TText;
    Layout6: TLayout;
    Text7: TText;
    Layout7: TLayout;
    Text8: TText;
    Layout8: TLayout;
    Text9: TText;
    Layout9: TLayout;
    Text10: TText;
    Layout10: TLayout;
    Text11: TText;
    Layout11: TLayout;
    Text12: TText;
    UpdateTimer: TTimer;
    TimeLabel: TLabel;
    DayLabel: TLabel;
    procedure UpdateTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TClockWidgetFrame.UpdateTimerTimer(Sender: TObject);
var
  Moment: TDateTime;
begin
  Moment := Now;
  rrHour.RotationAngle := (30 * StrToInt(FormatDateTime('h', Moment))) +
    (6 * (StrToInt(FormatDateTime('n', Moment)) / 12));
  rrMin.RotationAngle := 6 * StrToInt(FormatDateTime('n', Moment));
  rrSec.RotationAngle := 6 * StrToInt(FormatDateTime('ss', Moment));
  TimeLabel.Text := FormatDateTime('hh:mm', Moment);
  DayLabel.Text := FormatDateTime('dd mmmm', Moment, TFormatSettings.Create());
end;

end.
