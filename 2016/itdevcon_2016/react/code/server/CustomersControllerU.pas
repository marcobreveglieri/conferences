unit CustomersControllerU;

interface

uses
  MVCFramework, CustomersTDGU;

type

  [MVCPath('/api')]
  TCustomersController = class(TMVCController)
  private
    FCustomersTDG: TCustomersTDG;
  protected
    function GetDAL: TCustomersTDG;
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/hellos/($FirstName)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetSpecializedHello(const FirstName: string);

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($ID)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(const ID: UInt64);

    procedure OnBeforeAction(Context: TWebContext; const AActionName: string;
      var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;
  end;

implementation

procedure TCustomersController.Index;
begin
  // use Context property to access to the HTTP request and response
  Render('Hello World');

end;

procedure TCustomersController.GetCustomer(const ID: UInt64);
begin
  Render(GetDAL.GetCustomerById(ID), true, true);
end;

procedure TCustomersController.GetCustomers;
begin
  Render(GetDAL.GetCustomers);
end;

function TCustomersController.GetDAL: TCustomersTDG;
begin
  if not Assigned(FCustomersTDG) then
    FCustomersTDG := TCustomersTDG.Create(nil);
  Result := FCustomersTDG;
end;

procedure TCustomersController.GetSpecializedHello(const FirstName: string);
begin
  Render('Hello ' + FirstName);

end;

procedure TCustomersController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TCustomersController.OnBeforeAction(Context: TWebContext; const AActionName: string;
  var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

end.
