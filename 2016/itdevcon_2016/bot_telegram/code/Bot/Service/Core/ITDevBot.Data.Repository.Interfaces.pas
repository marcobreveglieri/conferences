unit ITDevBot.Data.Repository.Interfaces;

interface

uses
  System.SysUtils, ITDevBot.Data.Entities;

type

  IDevConRepository<T> = interface
    ['{6BA91E5A-78AE-4B38-9D5D-6276B8F24F48}']
    function GetAll: TArray<T>;
    function GetItemByID(const ID: Integer; var R: T): Boolean;
    function GetItemByText(const Text: string; var R: T): Boolean;
    procedure DeleteItem(const R: T);
    procedure InsertOrUpdateItem(const R: T);
  end;

implementation

end.
