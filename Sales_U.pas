unit Sales_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Data.DB,
  Vcl.Grids, Vcl.DBGrids, dmDatabase_U, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmSales = class(TForm)
    Panel1: TPanel;
    btnRemoveCart: TButton;
    btnAddCart: TButton;
    spnQuantityTransfer: TSpinEdit;
    Panel2: TPanel;
    dbgStock: TDBGrid;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    btnCheckout: TButton;
    btnBack: TButton;
    Label1: TLabel;

    procedure btnAddCartClick(Sender: TObject);
    procedure dbgStockCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnRemoveCartClick(Sender: TObject);
    procedure btnCheckoutClick(Sender: TObject);
    procedure dbgCeckoutCartCellClick(Column: TColumn);
    
  private
    { Private declarations }
    arrStock: array of string;

    sProductName, sProductCode: string;
    fProductPrice: real;
    iProductQuantity: integer;

  public
    { Public declarations }
    arrSalesCart: array of string;
    fTotalEarned: real;

    function CalculateTotalEarning: real;

  end;

var
  frmSales: TfrmSales;

implementation

{$R *.dfm}

uses MainMenu_U, SalesHistory_U;

// ================================Add Cart(>)===================================
// Voeg produkte by die checkout
procedure TfrmSales.btnAddCartClick(Sender: TObject);
var
  iQuantityTransfer, i: integer;
  bFound: boolean;
begin

  iProductQuantity := dmDatabase.tblProducts['Quantity'];

  if iProductQuantity = 0 then
  begin
    ShowMessage('Sorry, Product is out of stock.');
    Exit;
  end;

  // As transfer groter as het, stel =
  if spnQuantityTransfer.Value > iProductQuantity then
  begin
    spnQuantityTransfer.Value := iProductQuantity
  end
  else if spnQuantityTransfer.Value = 0 then
  begin
    Exit;
  end;

  iQuantityTransfer := spnQuantityTransfer.Value;

  dmDatabase.tblProducts.Edit;
  dmDatabase.tblProducts['Quantity'] := iProductQuantity - iQuantityTransfer;
  dmDatabase.tblProducts.Post;

  bFound := false;
  dmDatabase.tblCheckout.first;

  if dmDatabase.tblCheckout.RecordCount <> 0 then
  begin
    for i := 1 to dmDatabase.tblCheckout.RecordCount do
    begin
      // Kyk as produk reeds in Checkout is
      if dmDatabase.tblCheckout['Code'] = dmDatabase.tblProducts['Code'] then
      begin
        bFound := true;
      end
      else
      begin
        dmDatabase.tblCheckout.Next;
      end;
    end;
  end;

  if bFound = true then
  begin
    // As reeds is - Edit Quantity
    dmDatabase.tblCheckout.Edit;
    dmDatabase.tblCheckout['ProductName'] := dmDatabase.tblProducts
      ['ProductName'];
    dmDatabase.tblCheckout['CostPrice'] := dmDatabase.tblProducts['CostPrice'];
    dmDatabase.tblCheckout['SellPrice'] := dmDatabase.tblProducts['SellPrice'];
    dmDatabase.tblCheckout['Quantity'] := dmDatabase.tblCheckout['Quantity'] +
      iQuantityTransfer;
    dmDatabase.tblCheckout['Code'] := dmDatabase.tblProducts['Code'];
    dmDatabase.tblCheckout.Post;
  end
  else
  begin
    // As nie - voeg nuwe rekord by
    dmDatabase.tblCheckout.Insert;
    dmDatabase.tblCheckout['ProductName'] := dmDatabase.tblProducts
      ['ProductName'];
    dmDatabase.tblCheckout['CostPrice'] := dmDatabase.tblProducts['CostPrice'];
    dmDatabase.tblCheckout['SellPrice'] := dmDatabase.tblProducts['SellPrice'];
    dmDatabase.tblCheckout['Quantity'] := iQuantityTransfer;
    dmDatabase.tblCheckout['Code'] := dmDatabase.tblProducts['Code'];
    dmDatabase.tblCheckout.Post;
  end;

end;

// =================================Back=========================================
procedure TfrmSales.btnBackClick(Sender: TObject);
var
  i, j: integer;
  bFound: boolean;
begin

  dmDatabase.tblCheckout.first;
  bFound := false;

  // Verwyder alle produkte vanaf Checkout na produkte en delete die rekords
  if dmDatabase.tblCheckout.RecordCount >= 1 then
  begin
    for i := 1 to dmDatabase.tblCheckout.RecordCount do
    begin

      for j := 1 to dmDatabase.tblProducts.RecordCount do
      begin

        if dmDatabase.tblCheckout['Code'] = dmDatabase.tblProducts['Code'] then
        begin
          bFound := true;
        end
        else
        begin
          dmDatabase.tblProducts.Next;
        end;
      end;

      if bFound = true then
      begin
        dmDatabase.tblProducts.Edit;
        dmDatabase.tblProducts['ProductName'] := dmDatabase.tblCheckout
          ['ProductName'];
        dmDatabase.tblProducts['CostPrice'] := dmDatabase.tblCheckout
          ['CostPrice'];
        dmDatabase.tblProducts['SellPrice'] := dmDatabase.tblCheckout
          ['SellPrice'];
        dmDatabase.tblProducts['Quantity'] := dmDatabase.tblProducts['Quantity']
          + dmDatabase.tblCheckout['Quantity'];
        dmDatabase.tblProducts['Code'] := dmDatabase.tblCheckout['Code'];
        dmDatabase.tblProducts.Post;
      end;

      dmDatabase.tblCheckout.Delete;
      dmDatabase.tblCheckout.Next;
    end;
  end;

  frmSales.Close;

end;
 //============================Checkout=========================================
procedure TfrmSales.btnCheckoutClick(Sender: TObject);
var
  fTotalProductSell, fFinalTotalSell, fTotalProductCost, fFinalTotalCost : real;
  i: integer;
  sInvoice, sSale, sTableHeader, sTransaction: string;
  tfSalesHistory: TextFile;
begin
  fTotalProductSell := 0;
  fFinalTotalSell := 0;
  fTotalProductCost := 0;
  fFinalTotalCost := 0;

  if dmDatabase.tblCheckout.RecordCount > 0 then
  begin
    dmDatabase.tblCheckout.First;
    sInvoice := 'Invoice:' + sLineBreak;
    sTransaction := '';

    // Header vir die tabel
    sTableHeader := 'Product' + #9 + 'Quantity' + #9 + 'Cost Price' + #9 + 'Sell Price';

    while not dmDatabase.tblCheckout.Eof do
    begin
      with dmDatabase do
      begin     //Werk total uit
        fTotalProductSell := tblCheckout['SellPrice'] * tblCheckout['Quantity'];
        fFinalTotalSell := fFinalTotalSell + fTotalProductSell;

        fTotalProductCost := tblCheckout['CostPrice'] * tblCheckout['Quantity'];
        fFinalTotalCost := fFinalTotalCost + fTotalProductCost;


          sTransaction := sTransaction + tblCheckout['ProductName'] + ': ' +
          FloatToStr(tblCheckout['SellPrice']) + ' x ' +
          IntToStr(tblCheckout['Quantity']) + ' = ' + FloatToStrf(fTotalProductSell,
          ffCurrency, 10, 2) + #13 + ' ';



        // Add lines by die tabel
        sSale := tblCheckout['ProductName'] + #9 +
          IntToStr(tblCheckout['Quantity']) + #9 +
          FloatToStrf(tblCheckout['CostPrice'], ffCurrency, 10, 2) + #9 +
          FloatToStrf(tblCheckout['SellPrice'], ffCurrency, 10, 2) + #9 +
          FloatToStrf(fTotalProductSell, ffCurrency, 10, 2);

        sInvoice := sInvoice + sSale + sLineBreak;

        tblCheckout.Next;
      end;
    end;

    sInvoice := sLineBreak + sInvoice;
    sInvoice := sInvoice + sLineBreak + 'Profit: ' + FloatToStrf((fFinalTotalSell-fFinalTotalCost), ffCurrency, 10, 2);
    sInvoice := sInvoice + #13 + '====================================================';


     sTransaction := sTransaction + #13 + 'Final Total: ' + FloatToStrf(fFinalTotalSell,
      ffCurrency, 10, 2);
    ShowMessage(sTransaction);

    // Function - Calculate profit
    CalculateTotalEarning;

    //Lees in TextFile
    AssignFile(tfSalesHistory, 'saleshistory.txt');

    Append(tfSalesHistory);

    WriteLn(tfSalesHistory, sInvoice);

    CloseFile(tfSalesHistory);

    // Clear die checkout table
    for i := 1 to dmDatabase.tblCheckout.RecordCount do
    begin
      dmDatabase.tblCheckout.Delete;
      dmDatabase.tblCheckout.Next;
    end;
  end;
end;


// =====================================RemoveCart(<)============================
procedure TfrmSales.btnRemoveCartClick(Sender: TObject);
var
  iQuantityTransfer, i: integer;
  bFound: boolean;
begin

  iQuantityTransfer := spnQuantityTransfer.Value;
  iProductQuantity := dmDatabase.tblCheckout['Quantity'];

  // As transfer groter as het, stel =
  if spnQuantityTransfer.Value > iProductQuantity then
  begin
    spnQuantityTransfer.Value := iProductQuantity
  end
  else if spnQuantityTransfer.Value = 0 then
  begin
    Exit;
  end;

  dmDatabase.tblCheckout.Edit;
  dmDatabase.tblCheckout['Quantity'] := iProductQuantity - iQuantityTransfer;
  dmDatabase.tblCheckout.Post;

  bFound := false;
  dmDatabase.tblProducts.first;

  // Kyk waar rekord is en voeg Quantity by
  if dmDatabase.tblProducts.RecordCount <> 0 then
  begin
    for i := 1 to dmDatabase.tblProducts.RecordCount do
    begin

      if dmDatabase.tblCheckout['Code'] = dmDatabase.tblProducts['Code'] then
      begin
        bFound := true;
      end
      else
      begin
        dmDatabase.tblProducts.Next;
      end;
    end;
  end;

  if bFound = true then
  begin
    dmDatabase.tblProducts.Edit;
    dmDatabase.tblProducts['ProductName'] := dmDatabase.tblCheckout
      ['ProductName'];
    dmDatabase.tblProducts['CostPrice'] := dmDatabase.tblCheckout['CostPrice'];
    dmDatabase.tblProducts['SellPrice'] := dmDatabase.tblCheckout['SellPrice'];
    dmDatabase.tblProducts['Quantity'] := dmDatabase.tblProducts['Quantity'] +
      iQuantityTransfer;
    dmDatabase.tblProducts['Code'] := dmDatabase.tblCheckout['Code'];
    dmDatabase.tblProducts.Post;
  end;

  // Indien 0 in checkout, Delete rekord
  if dmDatabase.tblCheckout['Quantity'] = 0 then
  begin
    dmDatabase.tblCheckout.Delete;
  end;

end;

// ===============================OnSelect=======================================
// Selekteer n produk in Grid
// Checkout
procedure TfrmSales.dbgCeckoutCartCellClick(Column: TColumn);
begin
  btnRemoveCart.Enabled := true;
  btnAddCart.Enabled := false;
  spnQuantityTransfer.MinValue := 1;
  spnQuantityTransfer.Visible := true;

  iProductQuantity := dmDatabase.tblCheckout['Quantity'];
  spnQuantityTransfer.MaxValue := iProductQuantity;
end;

// Products
procedure TfrmSales.dbgStockCellClick(Column: TColumn);
begin
  btnAddCart.Enabled := true;
  btnRemoveCart.Enabled := false;
  spnQuantityTransfer.MinValue := 1;
  spnQuantityTransfer.Visible := true;

  iProductQuantity := dmDatabase.tblProducts['Quantity'];
  spnQuantityTransfer.MaxValue := iProductQuantity;
end;

// ===================================On Show===================================
// Sodra Sales oop gemaak word:
procedure TfrmSales.FormShow(Sender: TObject);
var
  sProduct: string;
  iCount: integer;
begin
  btnAddCart.Enabled := false;
  btnRemoveCart.Enabled := false;
  spnQuantityTransfer.Visible := false;

  with dmDatabase do
  begin
    tblProducts.first;
    tblCheckout.first;
    iCount := 0;

    while NOT tblProducts.Eof do
    begin
      sProductName := tblProducts['ProductName'];
      fProductPrice := tblProducts['SellPrice'];

      iProductQuantity := tblProducts['Quantity'];
      sProductCode := tblProducts['Code'];
      sProduct := sProductName + #9 + FloatToStr(fProductPrice) + #9 +
        IntToStr(iProductQuantity) + #9 + sProductCode;

      Inc(iCount);
      SetLength(arrStock, iCount + 1);
      arrStock[iCount] := sProduct;

      tblProducts.Next;
    end;
  end;
end;

//=====================CalculateTotalEarning(function)=========================

function TfrmSales.CalculateTotalEarning: real;
var
  fCostPrice, fProductCost, fProductSell, fSellPrice: real;
  i: integer;
begin

  dmDatabase.tblCheckout.first;
  fCostPrice := 0;
  fSellPrice := 0;

  for i := 1 to dmDatabase.tblCheckout.RecordCount do
  begin
    // Trek kosprys vanaf verkoopsprys af
    fProductCost := dmDatabase.tblCheckout['CostPrice'] * dmDatabase.tblCheckout
      ['Quantity'];
    fCostPrice := fCostPrice + fProductCost;

    fProductSell := dmDatabase.tblCheckout['SellPrice'] * dmDatabase.tblCheckout
      ['Quantity'];
    fSellPrice := fSellPrice + fProductSell;

    dmDatabase.tblCheckout.Next;
  end;

  fTotalEarned := fSellPrice - fCostPrice;

  Result := fTotalEarned;
end;
// ==============================================================================

end.
