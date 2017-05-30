object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'NASA APOD Demo'
  ClientHeight = 401
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 141
    Width = 57
    Height = 13
    Caption = 'Spiegazione'
  end
  object MediaImage: TImage
    Left = 336
    Top = 40
    Width = 417
    Height = 289
    Proportional = True
    Stretch = True
  end
  object TitleEdit: TLabeledEdit
    Left = 24
    Top = 40
    Width = 273
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Titolo'
    TabOrder = 0
  end
  object DateEdit: TLabeledEdit
    Left = 24
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 23
    EditLabel.Height = 13
    EditLabel.Caption = 'Data'
    TabOrder = 1
  end
  object ExplanationMemo: TMemo
    Left = 24
    Top = 160
    Width = 273
    Height = 113
    Lines.Strings = (
      'ExplanationMemo')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object DownloadButton: TButton
    Left = 24
    Top = 304
    Width = 273
    Height = 25
    Caption = 'Scarica'
    TabOrder = 3
    OnClick = DownloadButtonClick
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://api.nasa.gov/planetary/apod?api_key={API_KEY}'
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'API_KEY'
        Options = [poAutoCreated]
        Value = '0000000000000000000000000000000000000000'
      end>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 544
    Top = 8
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 624
    Top = 8
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 712
    Top = 8
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 712
    Top = 64
  end
end
