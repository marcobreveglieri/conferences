unit DIBootstrap;

interface

uses
  Spring.Container, Spring.Services;

implementation

uses
  Archive, Authenticator, Communicator;

initialization

  // Archive
  GlobalContainer
    .RegisterType<TArchive>()
    .Implements<IArchive>()
    .AsSingleton();

  // Authenticator
  GlobalContainer
    .RegisterType<TDemoAuthenticator>()
    .Implements<IAuthenticator>();

  // Communicator
  GlobalContainer
    .RegisterType<TDemoCommunicator>()
    .Implements<ICommunicator>();

  // Initialization
  GlobalContainer.Build;

end.
