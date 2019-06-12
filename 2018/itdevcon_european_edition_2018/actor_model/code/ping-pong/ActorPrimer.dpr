program ActorPrimer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Ikaria,
  ActorSystem in 'ActorSystem.pas',
  Ping in 'Ping.pas',
  Pong in 'Pong.pas',
  Logger in 'Logger.pas';

var
  Pinger: TProcessID;

begin

  try

    // Creo l'attore "Ping" e salvo il suo reference.
    Pinger := Spawn(TPingActor);

    // Attendo 10 secondi prima di chiudere il processo.
    Sleep(10000);

    // Elimino l'attore
    Kill(Pinger);

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
