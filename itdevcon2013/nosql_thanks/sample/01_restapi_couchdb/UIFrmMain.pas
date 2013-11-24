unit UIFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DMRest, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    tsInsertDocument: TTabSheet;
    meJsonRequest: TMemo;
    pnInsertDocument: TPanel;
    btnInsertDocument: TButton;
    Splitter1: TSplitter;
    meJsonResponse: TMemo;
    btnUpdateDocument: TButton;
    Panel1: TPanel;
    txtId: TEdit;
    txtRev: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnDeleteDocument: TButton;
    btnGetDocument: TButton;
    procedure btnInsertDocumentClick(Sender: TObject);
    procedure btnUpdateDocumentClick(Sender: TObject);
    procedure btnDeleteDocumentClick(Sender: TObject);
    procedure btnGetDocumentClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

const
  StrDatabaseName = 'itdevcon';

procedure TMainForm.btnDeleteDocumentClick(Sender: TObject);
begin
  with RestDataModule.rrqDeleteDocument do
  begin
    Resource := StrDatabaseName + '/' + txtId.Text + '?rev=' + txtRev.Text;
    Execute;
  end;
  with RestDataModule.rrpDeleteDocument do
  begin
    meJsonResponse.Lines.Text := Content;
  end;
end;

procedure TMainForm.btnGetDocumentClick(Sender: TObject);
begin
  with RestDataModule.rrqGetDocument do
  begin
    Resource := StrDatabaseName + '/' + txtId.Text;
    Execute;
  end;
  with RestDataModule.rrpGetDocument do
  begin
    meJsonResponse.Lines.Text := Content;
  end;
end;

procedure TMainForm.btnInsertDocumentClick(Sender: TObject);
var
  ResponseId: string;
  ResponseRev: string;
begin
  with RestDataModule.rrqInsertDocument do
  begin
    Resource := StrDatabaseName;
    Params.ParameterByName('Document').Value := meJsonRequest.Lines.Text;
    Execute;
  end;
  with RestDataModule.rrpInsertDocument do
  begin
    meJsonResponse.Lines.Text := Content;
    GetSimpleValue('id', ResponseId);
    GetSimpleValue('rev', ResponseRev);
  end;
  txtId.Text := ResponseId;
  txtRev.Text := ResponseRev;
end;

procedure TMainForm.btnUpdateDocumentClick(Sender: TObject);
var
  ResponseId: string;
  ResponseRev: string;
begin
  with RestDataModule.rrqUpdateDocument do
  begin
    Resource := StrDatabaseName + '/' + txtId.Text;
    Params.ParameterByName('Document').Value := meJsonRequest.Lines.Text;
    Execute;
  end;
  with RestDataModule.rrpUpdateDocument do
  begin
    meJsonResponse.Lines.Text := Content;
    GetSimpleValue('id', ResponseId);
    GetSimpleValue('rev', ResponseRev);
  end;
  txtId.Text := ResponseId;
  txtRev.Text := ResponseRev;
end;

end.
