unit SalesHistory_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, dmDatabase_U;

type
  TfrmSalesHistory = class(TForm)
    Panel2: TPanel;
    memSalesHistory: TMemo;
    btnBack: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    Procedure ShowSales;
  public
    { Public declarations }
  end;

var
  frmSalesHistory: TfrmSalesHistory;

implementation

{$R *.dfm}

procedure TfrmSalesHistory.btnBackClick(Sender: TObject);
begin
  frmSalesHistory.Close;
end;
//==================================Procedure===================================
procedure TfrmSalesHistory.FormShow(Sender: TObject);
begin
  ShowSales;
end;

//==============================================================================
//Kry Transaksies vanaf TextFile
procedure TfrmSalesHistory.ShowSales;
var
  tfSaleHistory: TextFile;
  sLine: string;
begin
  AssignFile(tfSaleHistory, 'saleshistory.txt');
  Reset(tfSaleHistory);

  while Not eof(tfSaleHistory) do
  begin
    readln(tfSaleHistory, sLine);
    memSalesHistory.Lines.Add(sLine);
  end;

  Closefile(tfSaleHistory);

end;
//==============================================================================
end.
