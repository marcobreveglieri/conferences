unit IR.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects;

type
  TMainForm = class(TForm)
    ContainerLayout: TScaledLayout;
    LeftColumnLayout: TFlowLayout;
    GridPanelLayout: TGridPanelLayout;
    CenterColumnLayout: TFlowLayout;
    RightColumnLayout: TFlowLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  IR.Shared.UI.Frames.Widget,
  IR.UI.Widgets.Weather,
  IR.UI.Widgets.Logo,
  IR.UI.Widgets.Clock,
  IR.UI.Widgets.ScrollingNews, IR.UI.Widgets.ChuckNorris, IR.UI.Widgets.Twitter,
  IR.UI.Widgets.Sponsors, IR.UI.Widgets.Agenda;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ContainerLayout.Height := Self.Height;
  ContainerLayout.Width := Self.Width;
  with TScrollingNewsWidgetFrame.Create(Self) do
  begin
    Parent := ContainerLayout;
    Align := TAlignLayout.Bottom;
    Setup;
  end;
  with TLogoWidgetFrame.Create(Self) do
  begin
    Parent := LeftColumnLayout;
  end;
  with TClockWidgetFrame.Create(Self) do
  begin
    Parent := LeftColumnLayout;
  end;
  with TWeatherWidgetFrame.Create(Self) do
  begin
    Parent := LeftColumnLayout;
  end;
  with TChuckNorrisWidgetFrame.Create(Self) do
  begin
    Parent := LeftColumnLayout;
  end;
  with TSponsorWidgetFrame.Create(Self) do
  begin
    Parent := LeftColumnLayout;
    Height := 160;
  end;
  with TAgendaWidgetFrame.Create(Self) do
  begin
    Parent := CenterColumnLayout;
    Position.Y := 0;
  end;
  with TTwitterWidgetFrame.Create(Self) do
  begin
    Parent := RightColumnLayout;
    Align := TAlignLayout.Client;
    Height := RightColumnLayout.Height - Margins.Bottom;
    Setup;
  end;
end;

end.
