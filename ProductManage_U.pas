unit ProductManage_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, dmDatabase_U, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmProductManager = class(TForm)
    dbgProducts: TDBGrid;
    pnlGreyBG_PM: TPanel;
    edtProductName: TEdit;
    edtProductPrice: TEdit;
    edtProductQuantity: TEdit;
    lblProductName: TLabel;
    lblPricePM: TLabel;
    lblQuantyPM: TLabel;
    btnAddProductPM: TButton;
    btnDeleteProduct: TButton;
    btnBackPM: TButton;
    Label1: TLabel;
    edtProductCostPrice: TEdit;

    procedure btnAddProductPMClick(Sender: TObject);
    procedure btnBackPMClick(Sender: TObject);
    procedure btnDeleteProductClick(Sender: TObject);
    procedure edtProductPriceKeyPress(Sender: TObject; var Key: Char);
    procedure edtProductQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    arrProducts: array of string;

  end;

var
  frmProductManager: TfrmProductManager;

implementation

{$R *.dfm}

uses MainMenu_U;

// ================================BACK=========================================
procedure TfrmProductManager.btnBackPMClick(Sender: TObject);
begin
  frmProductManager.Close;
end;

// ============================Delete_Product===================================
procedure TfrmProductManager.btnDeleteProductClick(Sender: TObject);
begin
  dmDatabase.tblProducts.Delete;
end;

// ============================Add_Product======================================
procedure TfrmProductManager.btnAddProductPMClick(Sender: TObject);
var
  sProductName, sProductCode, sNewProduct, sProduct: string;
  fProductPrice, fProductCostPrice : real;
  iProductQuantity, iLengthProductName: integer;
begin

  if (edtProductName.Text <> '') AND (edtProductPrice.Text <> '') AND
    (edtProductQuantity.Text <> '') then
  begin

    sProductName := edtProductName.Text;
    fProductPrice := StrToFloat(edtProductPrice.Text);
    fProductCostPrice := StrToFloat(edtProductCostPrice.Text);
    iProductQuantity := StrToInt(edtProductQuantity.Text);

    if (fProductPrice <= 0) OR (iProductQuantity <= 0) then
    begin
      ShowMessage('Invalid Product');
      Exit;
    end;

    // Kry Produk te kode
    iLengthProductName := Length(sProductName);
    sProductCode := '#' + Copy(sProductName, 1, 1) +
      Copy(sProductName, iLengthProductName, 1) + IntToStr(iLengthProductName);

    SetLength(arrProducts, Length(arrProducts) + 1);
    sNewProduct := sProductName + '#' + FloatToStr(fProductPrice) + '-' +
      IntToStr(iProductQuantity) + '%' + sProductCode;;
    arrProducts[High(arrProducts)] := sNewProduct;

    with dmDatabase do
    begin
      tblProducts.Insert;
      tblProducts['ProductName'] := sProductName;
      tblProducts['SellPrice'] := fProductPrice;
      tblProducts['CostPrice'] := fProductCostPrice;
      tblProducts['Quantity'] := iProductQuantity;
      tblProducts['Code'] := sProductCode;
      tblProducts.Post;
    end;

    edtProductName.Text := '';
    edtProductPrice.Text := '';
    edtProductCostPrice.Text := '';
    edtProductQuantity.Text := '';

    edtProductName.SetFocus;
  end
  else
  begin
    ShowMessage('Invalid Product');
    Exit;
  end;

end;

// ===============================Only_Num_Input================================
procedure TfrmProductManager.edtProductPriceKeyPress(Sender: TObject;
  var Key: Char);
begin        //Input mag slegs n integer wees
  if NOT CharInSet(Key, ['0' .. '9', #8, #127, '.', ',']) then
  begin
    Key := #0;
  end;
end;

procedure TfrmProductManager.edtProductQuantityKeyPress(Sender: TObject;
  var Key: Char);
begin
  if NOT CharInSet(Key, ['0' .. '9', #8, #127]) then
  begin
    Key := #0;
  end;
end;

// ====================================On_Show==================================
procedure TfrmProductManager.FormShow(Sender: TObject);
var
  iCount, iProductQuantity: integer;
  sProductName, sProductCode, sProduct: string;
  fProductPrice, fProductCostPrice : real;
begin
  dbgProducts.Columns[0].Width := 230;
  dbgProducts.Columns[1].Width := 100;
  dbgProducts.Columns[2].Width := 100;
  dbgProducts.Columns[3].Width := 80;

  with dmDatabase do
  begin
    tblProducts.First;
    iCount := 0;

    while NOT tblProducts.Eof do
    begin
      sProductName := tblProducts['ProductName'];
      fProductPrice := tblProducts['SellPrice'];
      fProductCostPrice := tblProducts['CostPrice'];
      iProductQuantity := tblProducts['Quantity'];
      sProductCode := tblProducts['Code'];
      sProduct := sProductName + #9 + FloatToStr(fProductPrice) + #9 +
        IntToStr(iProductQuantity) + #9 + sProductCode;

      Inc(iCount);
      SetLength(arrProducts, iCount + 1);
      arrProducts[iCount] := sProduct;

      tblProducts.Next;
    end;
  end;
end;

// =============================================================================
end.
