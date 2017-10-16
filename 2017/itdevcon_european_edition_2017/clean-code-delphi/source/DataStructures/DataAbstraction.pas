unit DataAbstraction;

interface

type

  IVechicle = interface
    function GetFuelTankCapacityInGallons(): Double;
    function GetGallonsOfGasoline(): Double;
    function GetPercentFuelRemaining(): Double;
  end;

  IContextDirectory = interface
    function GetAbsolutePath(): string;
  end;

  IContextOptions = interface
    function GetScratchDir: IContextDirectory;
  end;

  IContext = interface
    function GetOptions: IContextOptions;
  end;

implementation

var
  Context: IContext;
  OutputDir: string;

initialization

  OutputDir := Context.GetOptions().GetScratchDir().GetAbsolutePath();

end.
