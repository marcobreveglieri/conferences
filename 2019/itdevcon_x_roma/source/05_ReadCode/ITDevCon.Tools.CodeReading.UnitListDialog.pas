unit ITDevCon.Tools.CodeReading.UnitListDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type

  TUnitListDialog = class(TForm)
    ImplementationListBox: TListBox;
    UnitPanel: TPanel;
    UnitSplitter: TSplitter;
    InterfaceListBox: TListBox;
    CommandPanel: TPanel;
    CloseButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
  private
    procedure CopyUnitsToListBox(AListBox: TListBox;
      const AUnits: TArray<string>);
  public
    class procedure ShowUnits(const AInterfaceUnits: TArray<string>;
      const AImplementationUnits: TArray<string>);
  end;

implementation

{$R *.dfm}

procedure TUnitListDialog.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TUnitListDialog.CopyUnitsToListBox(AListBox: TListBox;
  const AUnits: TArray<string>);
var
  LUnit: string;
begin
  AListBox.Items.BeginUpdate;
  try
    AListBox.Items.Clear;
    for LUnit in AUnits do
      AListBox.Items.Add(LUnit);
  finally
    AListBox.Items.EndUpdate;
  end;
end;

class procedure TUnitListDialog.ShowUnits(const AInterfaceUnits,
  AImplementationUnits: TArray<string>);
begin
  with TUnitListDialog.Create(nil) do
  begin
    try
      CopyUnitsToListBox(InterfaceListBox, AInterfaceUnits);
      CopyUnitsToListBox(ImplementationListBox, AImplementationUnits);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
