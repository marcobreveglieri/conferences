unit ITDevBot.Data.Repository.Factory;

interface

uses
  ITDevBot.Data.Entities, ITDevBot.Data.Repository.Interfaces;

type

{ TConSqlRepositoryFactory  }

  TConSqlRepositoryFactory = class
  strict private
    class var FConnectionString: string;
  public
    class function GetAgendaRepository: IDevConRepository<TDevConAgenda>;
    class function GetSpeakerRepository: IDevConRepository<TDevConSpeaker>;
    class function GetSponsorRepository: IDevConRepository<TDevConSponsor>;
    class function GetSubscriptionRepository: IDevConRepository<TDevConSubscription>;
    class property ConnectionString: string read FConnectionString
      write FConnectionString;
  end;

implementation

uses
  ITDevBot.Data.Repository.Services;

{ TConSqlRepositoryFactory  }

class function TConSqlRepositoryFactory.GetAgendaRepository
  : IDevConRepository<TDevConAgenda>;
begin
  Result := TDevConAgendaRepository.Create(FConnectionString);
end;

class function TConSqlRepositoryFactory.GetSpeakerRepository: IDevConRepository<TDevConSpeaker>;
begin
  Result := TDevConSpeakerRepository.Create(FConnectionString);
end;

class function TConSqlRepositoryFactory.GetSponsorRepository: IDevConRepository<TDevConSponsor>;
begin
  Result := TDevConSponsorRepository.Create(FConnectionString);
end;

class function TConSqlRepositoryFactory.GetSubscriptionRepository: IDevConRepository<TDevConSubscription>;
begin
  Result := TDevConSubscriptionRepository.Create(FConnectionString);
end;

end.
