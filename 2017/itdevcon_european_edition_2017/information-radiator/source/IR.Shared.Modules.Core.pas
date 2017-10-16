unit IR.Shared.Modules.Core;

interface

uses
  System.SysUtils, System.Classes, IR.Core.App;

type
  TCoreModule = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CoreModule: TCoreModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
