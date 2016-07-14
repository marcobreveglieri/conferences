object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'X-Files App Demo'
  ClientHeight = 156
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblUserName: TLabel
    Left = 24
    Top = 29
    Width = 52
    Height = 13
    Caption = '&User Name'
  end
  object lblPassword: TLabel
    Left = 24
    Top = 64
    Width = 46
    Height = 13
    Caption = '&Password'
  end
  object btnArchiveLogin: TButton
    Left = 24
    Top = 112
    Width = 75
    Height = 25
    Action = actArchiveLogin
    Default = True
    TabOrder = 2
  end
  object btnArchiveLogout: TButton
    Left = 158
    Top = 112
    Width = 75
    Height = 25
    Action = actArchiveLogout
    Default = True
    TabOrder = 3
  end
  object tbxUserName: TEdit
    Left = 112
    Top = 26
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object tbxPassword: TEdit
    Left = 112
    Top = 61
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object aclMain: TActionList
    OnUpdate = aclMainUpdate
    Left = 8
    Top = 88
    object actArchiveLogin: TAction
      Caption = '&Login'
      OnExecute = actArchiveLoginExecute
    end
    object actArchiveLogout: TAction
      Caption = 'L&ogout'
      OnExecute = actArchiveLogoutExecute
    end
  end
end
