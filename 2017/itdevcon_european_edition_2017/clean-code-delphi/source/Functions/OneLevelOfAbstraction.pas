unit OneLevelOfAbstraction;

interface

uses
  System.IOUtils;

procedure RenderPageAndWriteToFile(const APath: string);
function GetHtml(): string;
function RenderPage(const AHtml: string): string;

implementation

function GetHtml(): string;
begin
  Result := '';
end;

function RenderPage(const AHtml: string): string;
begin
  Result := '';
end;

procedure RenderPageAndWriteToFile(const APath: string);
var
  HtmlText, PageContents: string;
begin
  HtmlText := GetHtml();
  PageContents := RenderPage(HtmlText);
  TFile.WriteAllText(APath, PageContents);
end;

end.
