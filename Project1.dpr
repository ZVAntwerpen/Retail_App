program Project1;

uses
  Vcl.Forms,
  MainMenu_U in 'MainMenu_U.pas' {frmMainMenu},
  Sales_U in 'Sales_U.pas' {frmSales},
  SalesHistory_U in 'SalesHistory_U.pas' {frmSalesHistory},
  InventoryReport_U in 'InventoryReport_U.pas' {frmInventoryReport},
  ProductManage_U in 'ProductManage_U.pas' {frmProductManager},
  dmDatabase_U in 'dmDatabase_U.pas' {dmDatabase: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmSales, frmSales);
  Application.CreateForm(TfrmSalesHistory, frmSalesHistory);
  Application.CreateForm(TfrmInventoryReport, frmInventoryReport);
  Application.CreateForm(TfrmProductManager, frmProductManager);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.Run;
end.
