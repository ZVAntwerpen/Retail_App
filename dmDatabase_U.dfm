object dmDatabase: TdmDatabase
  OldCreateOrder = False
  Height = 219
  Width = 365
  object tblUsers: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblUsers'
    Left = 104
    Top = 40
  end
  object conDatabase: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=E:\Sk' +
      'ool\IT\Gr11\PAT\Fase 2\Win32\Debug\Database.mdb;Mode=ReadWrite;P' +
      'ersist Security Info=False;Jet OLEDB:System database="";Jet OLED' +
      'B:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engi' +
      'ne Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Par' +
      'tial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:N' +
      'ew Database Password="";Jet OLEDB:Create System Database=False;J' +
      'et OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on C' +
      'ompact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet ' +
      'OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 40
  end
  object dsrUsers: TDataSource
    DataSet = tblUsers
    Left = 104
    Top = 112
  end
  object tblProducts: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblProducts'
    Left = 176
    Top = 40
  end
  object dsrProducts: TDataSource
    DataSet = tblProducts
    Left = 168
    Top = 112
  end
  object tblCheckout: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'tblCheckout'
    Left = 248
    Top = 40
  end
  object dsrCheckout: TDataSource
    DataSet = tblCheckout
    Left = 248
    Top = 112
  end
end
