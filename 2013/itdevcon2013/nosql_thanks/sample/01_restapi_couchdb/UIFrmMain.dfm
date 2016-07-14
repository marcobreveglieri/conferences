object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'CouchDB Demo'
  ClientHeight = 578
  ClientWidth = 1087
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 24
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1087
    Height = 537
    ActivePage = tsInsertDocument
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 897
    ExplicitHeight = 578
    object tsInsertDocument: TTabSheet
      Caption = 'Insert/update document'
      ExplicitWidth = 281
      ExplicitHeight = 154
      object Splitter1: TSplitter
        Left = 0
        Top = 329
        Width = 1079
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 49
      end
      object meJsonRequest: TMemo
        Left = 0
        Top = 0
        Width = 1079
        Height = 329
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          '{'
          
            '        "Title": "NoSQL, thanks! Creare e accedere a database No' +
            'SQL in Delphi",'
          '        "Speaker": "Marco Breveglieri",'
          '        "Agenda": {'
          '                "Room": "TComponent",'
          '                "StartTime": "11.50"'
          '        },'
          '        "Tags": ["delphi","database","nosql","rest"],'
          '        "Level": 1'
          '}')
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = -3
        ExplicitTop = -3
        ExplicitWidth = 889
      end
      object pnInsertDocument: TPanel
        Left = 0
        Top = 447
        Width = 1079
        Height = 51
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 488
        ExplicitWidth = 889
        object btnInsertDocument: TButton
          Left = 0
          Top = 6
          Width = 241
          Height = 35
          Caption = '&Insert'
          TabOrder = 0
          OnClick = btnInsertDocumentClick
        end
        object btnUpdateDocument: TButton
          Left = 247
          Top = 6
          Width = 241
          Height = 35
          Caption = '&Update'
          TabOrder = 1
          OnClick = btnUpdateDocumentClick
        end
        object btnDeleteDocument: TButton
          Left = 494
          Top = 6
          Width = 241
          Height = 35
          Caption = '&Delete'
          TabOrder = 2
          OnClick = btnDeleteDocumentClick
        end
        object btnGetDocument: TButton
          Left = 741
          Top = 6
          Width = 241
          Height = 35
          Caption = '&Get'
          TabOrder = 3
          OnClick = btnGetDocumentClick
        end
      end
      object meJsonResponse: TMemo
        Left = 0
        Top = 332
        Width = 1079
        Height = 115
        Align = alClient
        TabOrder = 2
        ExplicitLeft = 352
        ExplicitTop = 224
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 537
    Width = 1087
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 368
    ExplicitTop = 288
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 9
      Top = 6
      Width = 17
      Height = 24
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 497
      Top = 6
      Width = 39
      Height = 24
      Caption = 'REV'
    end
    object txtId: TEdit
      Left = 32
      Top = 6
      Width = 449
      Height = 32
      TabOrder = 0
    end
    object txtRev: TEdit
      Left = 542
      Top = 6
      Width = 339
      Height = 32
      TabOrder = 1
    end
  end
end
