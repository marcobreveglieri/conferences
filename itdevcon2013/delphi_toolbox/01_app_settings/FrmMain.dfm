object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Application Settings Demo'
  ClientHeight = 234
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object bvlLine: TBevel
    Left = 8
    Top = 176
    Width = 546
    Height = 10
    Shape = bsTopLine
  end
  object btnConfigurationSave: TButton
    Left = 376
    Top = 192
    Width = 177
    Height = 25
    Action = actConfigurationSave
    TabOrder = 2
  end
  object btnConfigurationLoad: TButton
    Left = 193
    Top = 192
    Width = 177
    Height = 25
    Action = actConfigurationLoad
    TabOrder = 1
  end
  object gbxSettings: TGroupBox
    Left = 8
    Top = 8
    Width = 545
    Height = 146
    Caption = 'Settings'
    TabOrder = 0
    object lblSettingLicenseUser: TLabel
      Left = 184
      Top = 22
      Width = 68
      Height = 13
      Caption = 'Utente licenza'
    end
    object lblSettingsLicenseSerial: TLabel
      Left = 184
      Top = 81
      Width = 109
      Height = 13
      Caption = 'Numero di serie licenza'
    end
    object lblSettingRecentListSize: TLabel
      Left = 336
      Top = 22
      Width = 71
      Height = 13
      Caption = 'Recent list size'
    end
    object cbxSettingSaveOnExit: TCheckBox
      Left = 16
      Top = 64
      Width = 177
      Height = 17
      Action = actSettingSaveOnExit
      TabOrder = 1
    end
    object cbxSettingConfirmOnExit: TCheckBox
      Left = 16
      Top = 41
      Width = 177
      Height = 17
      Action = actSettingConfirmOnExit
      TabOrder = 0
    end
    object tbxSettingLicenseUser: TEdit
      Left = 184
      Top = 41
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object tbxSettingLicenseSerial: TEdit
      Left = 184
      Top = 100
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object tbxSettingRecentListSize: TEdit
      Left = 336
      Top = 41
      Width = 81
      Height = 21
      TabOrder = 4
      Text = '0'
      OnExit = tbxSettingRecentListSizeExit
    end
    object updRecentListSize: TUpDown
      Left = 417
      Top = 41
      Width = 16
      Height = 21
      Associate = tbxSettingRecentListSize
      TabOrder = 5
    end
  end
  object aclMain: TActionList
    OnUpdate = aclMainUpdate
    Left = 16
    Top = 128
    object actConfigurationLoad: TAction
      Caption = '&Load settings now'
      OnExecute = actConfigurationLoadExecute
    end
    object actConfigurationSave: TAction
      Caption = 'Save settings now'
      OnExecute = actConfigurationSaveExecute
    end
    object actSettingSaveOnExit: TAction
      AutoCheck = True
      Caption = 'Save on exit'
      OnExecute = actSettingSaveOnExitExecute
    end
    object actSettingConfirmOnExit: TAction
      AutoCheck = True
      Caption = 'Confirm on exit'
      OnExecute = actSettingConfirmOnExitExecute
    end
  end
end
