unit ITDevBot.Tests.Integration.Domain;

interface

uses
  System.Generics.Collections,
  TestFramework,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  ITDevBot.Data.Entities, ITDevBot.Data.Repository.Interfaces,
  ITDevBot.Data.Repository.Factory;

type

  TRepositoryIntegrationTestCase = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRepositoryAgendaGetItemOK;
    procedure TestRepositoryAgendaGetListOK;
    procedure TestRepositorySpeakerGetItemOK;
    procedure TestRepositorySpeakerGetListOK;
    procedure TestRepositorySponsorGetItemOK;
    procedure TestRepositorySponsorGetListOK;
  end;

implementation

procedure TRepositoryIntegrationTestCase.SetUp;
begin
  TConSqlRepositoryFactory.ConnectionString :=
    'Database=E:\DB\SQLite\ITDevCon.db;DriverID=SQLite';
end;

procedure TRepositoryIntegrationTestCase.TearDown;
begin
end;

procedure TRepositoryIntegrationTestCase.TestRepositoryAgendaGetItemOK;
var
  Repository: IDevConRepository<TDevConAgenda>;
  Item: TDevConAgenda;
begin
  Repository := TConSqlRepositoryFactory.GetAgendaRepository;
  Assert(Repository.GetItemByID(10, Item));
end;

procedure TRepositoryIntegrationTestCase.TestRepositoryAgendaGetListOK;
var
  Repository: IDevConRepository<TDevConAgenda>;
  Items: TArray<TDevConAgenda>;
begin
  Repository := TConSqlRepositoryFactory.GetAgendaRepository;
  Items := Repository.GetAll();
  Assert(Length(Items) > 0);
end;

procedure TRepositoryIntegrationTestCase.TestRepositorySpeakerGetItemOK;
var
  Repository: IDevConRepository<TDevConSpeaker>;
  Item: TDevConSpeaker;
begin
  Repository := TConSqlRepositoryFactory.GetSpeakerRepository;
  Assert(Repository.GetItemByID(1, Item));
end;

procedure TRepositoryIntegrationTestCase.TestRepositorySpeakerGetListOK;
var
  Repository: IDevConRepository<TDevConSpeaker>;
  Items: TArray<TDevConSpeaker>;
begin
  Repository := TConSqlRepositoryFactory.GetSpeakerRepository;
  Items := Repository.GetAll();
  Assert(Length(Items) > 0);
end;

procedure TRepositoryIntegrationTestCase.TestRepositorySponsorGetItemOK;
var
  Repository: IDevConRepository<TDevConSponsor>;
  Item: TDevConSponsor;
begin
  Repository := TConSqlRepositoryFactory.GetSponsorRepository;
  Assert(Repository.GetItemByID(1, Item));
end;

procedure TRepositoryIntegrationTestCase.TestRepositorySponsorGetListOK;
var
  Repository: IDevConRepository<TDevConSponsor>;
  Items: TArray<TDevConSponsor>;
begin
  Repository := TConSqlRepositoryFactory.GetSponsorRepository;
  Items := Repository.GetAll();
  Assert(Length(Items) > 0);
end;

initialization

//RegisterTest(TRepositoryIntegrationTestCase.Suite);

end.
