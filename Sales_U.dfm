object frmSales: TfrmSales
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Sales'
  ClientHeight = 418
  ClientWidth = 783
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
  object Panel1: TPanel
    Left = 310
    Top = 3
    Width = 162
    Height = 415
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 44
      Top = 48
      Width = 76
      Height = 52
      Caption = 'Quantity Transfer:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object btnRemoveCart: TButton
      Left = 30
      Top = 184
      Width = 115
      Height = 65
      Caption = '<'
      TabOrder = 0
      OnClick = btnRemoveCartClick
    end
    object btnAddCart: TButton
      Left = 31
      Top = 255
      Width = 114
      Height = 71
      Caption = '>'
      TabOrder = 1
      OnClick = btnAddCartClick
    end
    object spnQuantityTransfer: TSpinEdit
      Left = 55
      Top = 127
      Width = 57
      Height = 22
      MaxValue = 0
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
  end
  object Panel2: TPanel
    Left = 2
    Top = 3
    Width = 305
    Height = 415
    Color = 55295
    ParentBackground = False
    TabOrder = 1
    object dbgStock: TDBGrid
      Left = 13
      Top = 11
      Width = 289
      Height = 400
      BiDiMode = bdLeftToRight
      Ctl3D = False
      DataSource = dmDatabase.dsrProducts
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbgStockCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ProductName'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SellPrice'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantity'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Code'
          Width = 40
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 476
    Top = 5
    Width = 305
    Height = 411
    Color = 55295
    ParentBackground = False
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 7
      Top = 9
      Width = 291
      Height = 191
      BiDiMode = bdLeftToRight
      Ctl3D = False
      DataSource = dmDatabase.dsrCheckout
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbgCeckoutCartCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ProductName'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SellPrice'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantity'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Code'
          Width = 40
          Visible = True
        end>
    end
    object btnCheckout: TButton
      Left = 6
      Top = 208
      Width = 291
      Height = 162
      Caption = 'Checkout'
      TabOrder = 1
      OnClick = btnCheckoutClick
    end
    object btnBack: TButton
      Left = 115
      Top = 374
      Width = 90
      Height = 29
      Caption = 'Back'
      TabOrder = 2
      OnClick = btnBackClick
    end
  end
end
