object frmProductManager: TfrmProductManager
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Product Manager'
  ClientHeight = 323
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 261
    Top = 7
    Width = 476
    Height = 308
    Color = 55295
    ParentBackground = False
    TabOrder = 0
    object dbgProducts: TDBGrid
      Left = 16
      Top = 16
      Width = 445
      Height = 284
      Ctl3D = False
      DataSource = dmDatabase.dsrProducts
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object pnlGreyBG_PM: TPanel
    Left = 8
    Top = 8
    Width = 249
    Height = 308
    Color = clGray
    ParentBackground = False
    TabOrder = 1
    object lblProductName: TLabel
      Left = 16
      Top = 36
      Width = 103
      Height = 19
      Caption = 'Product Name:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPricePM: TLabel
      Left = 15
      Top = 64
      Width = 148
      Height = 19
      Caption = 'Product Sell Price (R):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantyPM: TLabel
      Left = 15
      Top = 115
      Width = 123
      Height = 19
      Caption = 'Product Quantity:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 15
      Top = 90
      Width = 153
      Height = 19
      Caption = 'Product Cost Price (R):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtProductName: TEdit
      Left = 125
      Top = 36
      Width = 118
      Height = 21
      TabOrder = 0
    end
    object edtProductPrice: TEdit
      Left = 169
      Top = 63
      Width = 75
      Height = 21
      TabOrder = 1
      TextHint = 'eg. 12,5'
      OnKeyPress = edtProductPriceKeyPress
    end
    object edtProductQuantity: TEdit
      Left = 144
      Top = 116
      Width = 100
      Height = 21
      TabOrder = 2
      TextHint = 'eg. 50'
      OnKeyPress = edtProductQuantityKeyPress
    end
    object btnAddProductPM: TButton
      Left = 68
      Top = 174
      Width = 114
      Height = 41
      Caption = 'Add A New Product'
      TabOrder = 3
      OnClick = btnAddProductPMClick
    end
    object btnDeleteProduct: TButton
      Left = 68
      Top = 221
      Width = 114
      Height = 37
      Caption = 'Delete A Product'
      TabOrder = 4
      OnClick = btnDeleteProductClick
    end
    object btnBackPM: TButton
      Left = 88
      Top = 264
      Width = 73
      Height = 35
      Caption = 'Back'
      TabOrder = 5
      OnClick = btnBackPMClick
    end
    object edtProductCostPrice: TEdit
      Left = 169
      Top = 89
      Width = 75
      Height = 21
      TabOrder = 6
      TextHint = 'eg. 10'
      OnKeyPress = edtProductPriceKeyPress
    end
  end
end
