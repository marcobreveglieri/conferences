object AutoSaveDialog: TAutoSaveDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auto Save Options'
  ClientHeight = 124
  ClientWidth = 275
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
  object IntervalLabel: TLabel
    Left = 8
    Top = 12
    Width = 138
    Height = 13
    AutoSize = False
    Caption = '&Interval (seconds)'
    FocusControl = IntervalEdit
  end
  object IntervalEdit: TEdit
    Left = 152
    Top = 8
    Width = 90
    Height = 21
    TabOrder = 0
    Text = '60'
    OnExit = IntervalEditExit
  end
  object IntervalUpDown: TUpDown
    Left = 242
    Top = 8
    Width = 16
    Height = 21
    Associate = IntervalEdit
    Min = 5
    Max = 7200
    Position = 60
    TabOrder = 1
  end
  object CommandPanel: TPanel
    Left = 0
    Top = 83
    Width = 275
    Height = 41
    Align = alBottom
    TabOrder = 2
    object AcceptButton: TButton
      Left = 72
      Top = 8
      Width = 90
      Height = 25
      Action = AcceptAction
      Default = True
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 168
      Top = 8
      Width = 90
      Height = 25
      Action = CancelAction
      Cancel = True
      TabOrder = 1
    end
  end
  object EnabledCheckBox: TCheckBox
    Left = 152
    Top = 48
    Width = 97
    Height = 17
    Caption = '&Enabled'
    TabOrder = 3
  end
  object DialogActions: TActionList
    Left = 24
    Top = 72
    object AcceptAction: TAction
      Caption = '&Save'
      OnExecute = AcceptActionExecute
    end
    object CancelAction: TAction
      Caption = '&Cancel'
      OnExecute = CancelActionExecute
    end
  end
end
