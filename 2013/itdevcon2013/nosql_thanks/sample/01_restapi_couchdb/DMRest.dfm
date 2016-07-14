object RestDataModule: TRestDataModule
  OldCreateOrder = False
  Height = 529
  Width = 626
  object rclCouchDb: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://127.0.0.1:5984'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    Left = 48
    Top = 40
  end
  object rrqServerCheck: TRESTRequest
    Client = rclCouchDb
    Params = <>
    Response = rrpServerCheck
    Left = 48
    Top = 136
  end
  object rrpServerCheck: TRESTResponse
    Left = 168
    Top = 136
  end
  object rrqDatabaseGetInfo: TRESTRequest
    Client = rclCouchDb
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'DBName'
        Options = [poAutoCreated]
        Value = 'itdevcon'
      end>
    Resource = '{DBName}'
    Response = rrpDatabaseGetInfo
    Left = 48
    Top = 208
  end
  object rrpDatabaseGetInfo: TRESTResponse
    Left = 168
    Top = 208
  end
  object rrqDatabaseCreate: TRESTRequest
    Client = rclCouchDb
    Method = rmPUT
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'DBName'
        Options = [poAutoCreated]
        Value = 'itdevcon'
      end>
    Resource = '{DBName}'
    Response = rrpDatabaseCreate
    Left = 48
    Top = 272
  end
  object rrpDatabaseCreate: TRESTResponse
    Left = 168
    Top = 272
  end
  object rrqInsertDocument: TRESTRequest
    Client = rclCouchDb
    Method = rmPOST
    Params = <
      item
        name = 'Document'
        Value = '{ "title" : "NoSQL"}'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'itdevcon'
    Response = rrpInsertDocument
    Left = 352
    Top = 136
  end
  object rrpInsertDocument: TRESTResponse
    Left = 472
    Top = 136
  end
  object rrqUpdateDocument: TRESTRequest
    Client = rclCouchDb
    Method = rmPUT
    Params = <
      item
        name = 'Document'
        Value = '{ "title" : "NoSQL"}'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'itdevcon'
    Response = rrpUpdateDocument
    Left = 352
    Top = 216
  end
  object rrpUpdateDocument: TRESTResponse
    Left = 472
    Top = 216
  end
  object rrqDeleteDocument: TRESTRequest
    Client = rclCouchDb
    Method = rmDELETE
    Params = <
      item
        name = 'Document'
        Value = '{ "title" : "NoSQL"}'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = rrpDeleteDocument
    Left = 352
    Top = 288
  end
  object rrpDeleteDocument: TRESTResponse
    Left = 472
    Top = 288
  end
  object rrqGetDocument: TRESTRequest
    Client = rclCouchDb
    Params = <>
    Response = rrpGetDocument
    Left = 352
    Top = 352
  end
  object rrpGetDocument: TRESTResponse
    Left = 472
    Top = 352
  end
end
