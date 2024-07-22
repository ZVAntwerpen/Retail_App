unit dmDatabase_U;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmDatabase = class(TDataModule)
    tblUsers: TADOTable;
    conDatabase: TADOConnection;
    dsrUsers: TDataSource;
    tblProducts: TADOTable;
    dsrProducts: TDataSource;
    tblCheckout: TADOTable;
    dsrCheckout: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
