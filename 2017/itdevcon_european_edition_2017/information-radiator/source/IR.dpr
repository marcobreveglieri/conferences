program IR;

uses
  System.StartUpCopy,
  FMX.Forms,
  IR.Forms.Main in 'IR.Forms.Main.pas' {MainForm},
  IR.Shared.UI.Frames.Widget in 'IR.Shared.UI.Frames.Widget.pas' {SharedWidgetFrame: TFrame},
  IR.UI.Widgets.Weather in 'IR.UI.Widgets.Weather.pas' {WeatherWidgetFrame: TFrame},
  IR.UI.Widgets.Logo in 'IR.UI.Widgets.Logo.pas' {LogoWidgetFrame: TFrame},
  IR.UI.Widgets.Clock in 'IR.UI.Widgets.Clock.pas' {ClockWidgetFrame: TFrame},
  IR.UI.Widgets.ScrollingNews in 'IR.UI.Widgets.ScrollingNews.pas' {ScrollingNewsWidgetFrame: TFrame},
  IR.UI.Widgets.ChuckNorris in 'IR.UI.Widgets.ChuckNorris.pas' {ChuckNorrisWidgetFrame: TFrame},
  IR.UI.Widgets.Twitter in 'IR.UI.Widgets.Twitter.pas' {TwitterWidgetFrame: TFrame},
  IR.Core.App in 'IR.Core.App.pas',
  IR.UI.Widgets.Sponsors in 'IR.UI.Widgets.Sponsors.pas' {SponsorWidgetFrame: TFrame},
  IR.UI.Widgets.Agenda in 'IR.UI.Widgets.Agenda.pas' {AgendaWidgetFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ITDevCon IR (Information Radiator)';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
