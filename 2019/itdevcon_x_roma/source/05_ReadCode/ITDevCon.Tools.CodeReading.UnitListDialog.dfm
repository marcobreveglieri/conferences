object UnitListDialog: TUnitListDialog
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Unit List Dialog'
  ClientHeight = 393
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object UnitPanel: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 344
    Align = alClient
    TabOrder = 0
    object UnitSplitter: TSplitter
      Left = 1
      Top = 169
      Width = 704
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 98
      ExplicitWidth = 294
    end
    object ImplementationListBox: TListBox
      Left = 1
      Top = 172
      Width = 704
      Height = 171
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
    object InterfaceListBox: TListBox
      Left = 1
      Top = 1
      Width = 704
      Height = 168
      Align = alTop
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object CommandPanel: TPanel
    Left = 0
    Top = 344
    Width = 706
    Height = 49
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 584
      Top = 10
      Width = 115
      Height = 28
      Caption = '&Close'
      TabOrder = 0
      OnClick = CloseButtonClick
    end
  end
end
