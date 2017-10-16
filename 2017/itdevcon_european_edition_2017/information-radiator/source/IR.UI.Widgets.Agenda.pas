unit IR.UI.Widgets.Agenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IR.Shared.UI.Frames.Widget, FMX.Layouts, FMX.Effects, FMX.Objects,
  System.ImageList, FMX.ImgList;

type
  TAgendaWidgetFrame = class(TSharedWidgetFrame)
    SessionImage: TImage;
    SessionImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
