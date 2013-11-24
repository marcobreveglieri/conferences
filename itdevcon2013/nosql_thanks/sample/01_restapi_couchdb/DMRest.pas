unit DMRest;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client;

type
  TRestDataModule = class(TDataModule)
    rclCouchDb: TRESTClient;
    rrqServerCheck: TRESTRequest;
    rrpServerCheck: TRESTResponse;
    rrqDatabaseGetInfo: TRESTRequest;
    rrpDatabaseGetInfo: TRESTResponse;
    rrqDatabaseCreate: TRESTRequest;
    rrpDatabaseCreate: TRESTResponse;
    rrqInsertDocument: TRESTRequest;
    rrpInsertDocument: TRESTResponse;
    rrqUpdateDocument: TRESTRequest;
    rrpUpdateDocument: TRESTResponse;
    rrqDeleteDocument: TRESTRequest;
    rrpDeleteDocument: TRESTResponse;
    rrqGetDocument: TRESTRequest;
    rrpGetDocument: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RestDataModule: TRestDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
