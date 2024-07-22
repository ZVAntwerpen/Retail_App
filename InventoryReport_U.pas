unit InventoryReport_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dmDatabase_U, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmInventoryReport = class(TForm)
    pnlYellowBG_IR: TPanel;
    memInventoryReport: TMemo;
    btnBack: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInventoryReport: TfrmInventoryReport;

implementation

{$R *.dfm}



//-------------------------CLOSE-----------------------------------------------
procedure TfrmInventoryReport.btnBackClick(Sender: TObject);
begin
 frmInventoryReport.Close;
end;
 //=============================SHOW_FORM======================================
procedure TfrmInventoryReport.FormShow(Sender: TObject);
var
sProduct, sProductName, sProductCode : string;
iProductQuantity : integer;
fProductPrice, fProductCostPrice : real;
begin

//Lees rekords in databasis in Memo in
  with dmDatabase do
  begin
     tblProducts.First;

     memInventoryReport.Clear;
     memInventoryReport.Lines.Add('Product'+#9+'Price'+#9+'Quantity'+#9+'Code');
     memInventoryReport.Lines.Add('------------------------------------------');

    while NOT tblProducts.Eof do
    begin
      sProductName := tblProducts['ProductName'];
      fProductPrice := tblProducts['SellPrice'];
      fProductCostPrice := tblProducts['CostPrice'];
      iProductQuantity := tblProducts['Quantity'];
      sProductCode := tblProducts['Code'];
      sProduct := sProductName + #9 + FloatToStr(fProductPrice) + #9 +
        IntToStr(iProductQuantity) + #9 + sProductCode;


      memInventoryReport.Lines.Add(sProduct);

      tblProducts.Next;
    end;
  end;

end;
//==============================================================================
end.
