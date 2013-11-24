unit Communicator;

interface

uses
  Classes, SysUtils, IdMessage, IdSMTP;

type

{ TCommunicator }

{$M+}
  ICommunicator = interface
    ['{362160A4-9A4F-451A-8DA7-67EE13D3078A}']
    procedure SendWarning(const AText: string);
  end;
{$M-}

{ TCommunicator }

  TCommunicator = class (TInterfacedObject, ICommunicator)
  private
  public
    procedure SendWarning(const AText: string);
  end;

implementation

{ TCommunicator }

procedure TCommunicator.SendWarning(const AText: string);
var
  SMTPClient: TIdSMTP;
  MailMessage: TIdMessage;
begin
  SMTPClient := TIdSMTP.Create(nil);
  try
    // Codice puramente esemplificativo
    SMTPClient.Host := 'myhost.smtp.com';
    SMTPClient.Username := 'smtp-username';
    SMTPClient.Password := 'smtp-password';
    MailMessage := TIdMessage.Create(nil);
    try
      with MailMessage.Recipients.Add do
      begin
        Address := 'walter.skinner@x-files.com';
      end;
      MailMessage.From.Address := 'noreply@x-files.com';
      MailMessage.Body.Text := AText;
      MailMessage.Priority := TIdMessagePriority.mpHigh;
      SMTPClient.Send(MailMessage);
    finally
      MailMessage.Free;
    end;
  finally
    SMTPClient.Free;
  end;
end;

end.
