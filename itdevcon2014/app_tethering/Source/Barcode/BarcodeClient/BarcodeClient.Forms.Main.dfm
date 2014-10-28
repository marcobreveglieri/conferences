object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Barcode Client'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object ProductCodeLabel: TLabel
    Left = 32
    Top = 24
    Width = 95
    Height = 19
    Caption = '&Product Code'
    FocusControl = CodeEdit
  end
  object CodeEdit: TEdit
    Left = 176
    Top = 21
    Width = 441
    Height = 27
    TabOrder = 0
  end
  object BarcodeManager: TTetheringManager
    Text = 'BarcodeManager'
    AllowedAdapters = 'Network'
    Left = 72
    Top = 200
  end
  object BarcodeAppProfile: TTetheringAppProfile
    Manager = BarcodeManager
    Text = 'BarcodeAppProfile'
    Group = 'Barcode'
    Actions = <>
    Resources = <>
    OnResourceReceived = BarcodeAppProfileResourceReceived
    Left = 200
    Top = 200
  end
end
