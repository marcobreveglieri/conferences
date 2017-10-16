unit PronounceableNames;

interface

type

// WRONG

  TDataRcrd102 = class
  strict private
    FGenYMDHMS: TDateTime; // (generation date, year, month, day, hour, minute, and second)
    FModYMDHMS: TDateTime; // (modification date, year, month, day, hour, minute, and second)
    FPszqInt: string; // ???
  end;

// OK

  TCustomer = class
  strict private
    FGenerationTimestamp: TDateTime;
    FModificationTimestamp: TDateTime;
    FUniqueID: string;
  end;


implementation

end.
