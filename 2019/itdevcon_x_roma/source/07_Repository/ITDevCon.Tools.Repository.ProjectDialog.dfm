object ProjectDialogForm: TProjectDialogForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ITDevCon - Project Creation'
  ClientHeight = 217
  ClientWidth = 354
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
  object SeparatorBevel: TBevel
    Left = 8
    Top = 161
    Width = 337
    Height = 9
    Shape = bsTopLine
  end
  object ProjectTypeLabel: TLabel
    Left = 8
    Top = 64
    Width = 109
    Height = 13
    Caption = 'Choose a Project &Type'
  end
  object ProjectNameLabel: TLabel
    Left = 8
    Top = 8
    Width = 102
    Height = 13
    Caption = 'Enter a Project &Name'
  end
  object CancelButton: TButton
    Left = 237
    Top = 176
    Width = 109
    Height = 29
    Action = CancelAction
    Cancel = True
    TabOrder = 4
  end
  object AcceptButton: TButton
    Left = 122
    Top = 176
    Width = 109
    Height = 29
    Action = AcceptAction
    Default = True
    TabOrder = 3
  end
  object ProjectTypeDllButton: TRadioButton
    Left = 8
    Top = 83
    Width = 113
    Height = 17
    Caption = 'Library (.dll)'
    TabOrder = 1
  end
  object ProjectTypeBplButton: TRadioButton
    Left = 8
    Top = 106
    Width = 113
    Height = 17
    Caption = 'Package (.bpl)'
    TabOrder = 2
  end
  object ProjectNameEdit: TEdit
    Left = 8
    Top = 27
    Width = 338
    Height = 21
    TabOrder = 0
  end
  object DialogActions: TActionList
    OnUpdate = DialogActionsUpdate
    Left = 264
    Top = 80
    object AcceptAction: TAction
      Caption = '&Confirm'
      OnExecute = AcceptActionExecute
    end
    object CancelAction: TAction
      Caption = '&Cancel'
      OnExecute = CancelActionExecute
    end
  end
end
