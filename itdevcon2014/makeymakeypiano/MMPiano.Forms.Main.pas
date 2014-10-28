unit MMPiano.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Media, FMX.Objects, FMX.Layouts, FMX.Effects, FMX.Ani, IOUtils;

type
  TMainForm = class(TForm)
    NotePlayer: TMediaPlayer;
    PianoLayout: TGridPanelLayout;
    Note1Rectangle: TRectangle;
    Note2Rectangle: TRectangle;
    Note3Rectangle: TRectangle;
    Note4Rectangle: TRectangle;
    Note5Rectangle: TRectangle;
    Note6Rectangle: TRectangle;
    Note7Rectangle: TRectangle;
    NoteGlowEffect: TInnerGlowEffect;
    GlowFloatAnimation: TFloatAnimation;
    LogoRectangle: TRectangle;
    LogoImage: TImage;
    ConferenceImage: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure PlayNote(KeyChar: Char); overload;
    procedure PlayNote(Note: Integer); overload;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  PlayNote(KeyChar);
end;

procedure TMainForm.PlayNote(KeyChar: Char);
begin
  case KeyChar of
    'g':
      PlayNote(1);
    'f':
      PlayNote(2);
    'd':
      PlayNote(3);
    's':
      PlayNote(4);
    'a':
      PlayNote(5);
    'w':
      PlayNote(6);
    ' ':
      PlayNote(7);
    else
      PlayNote(0);
  end;
end;

procedure TMainForm.PlayNote(Note: Integer);
var
  NotePath: string;
  NoteRectangle: TRectangle;
begin
  NotePath := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)),
    'Media\Note' + IntToStr(Note) + '.mp3');
  if NotePlayer.State = TMediaState.Playing then
    NotePlayer.Stop;
  if not TFile.Exists(NotePath) then
    Exit;
  NotePlayer.FileName := NotePath;
  NotePlayer.Play;
  NoteRectangle := Self.FindComponent(Format('Note%dRectangle', [Note])) as TRectangle;
  if NoteRectangle = nil then
    Exit;
  NoteGlowEffect.Parent := NoteRectangle;
  NoteGlowEffect.Enabled := True;
  GlowFloatAnimation.Start;
end;

end.
