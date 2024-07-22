object frmSalesHistory: TfrmSalesHistory
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Sales History'
  ClientHeight = 297
  ClientWidth = 564
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
  object Panel2: TPanel
    Left = -1
    Top = -7
    Width = 569
    Height = 310
    Color = 55295
    ParentBackground = False
    TabOrder = 0
    object memSalesHistory: TMemo
      Left = 7
      Top = 10
      Width = 550
      Height = 262
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btnBack: TButton
      Left = 250
      Top = 278
      Width = 75
      Height = 25
      Caption = 'Back'
      TabOrder = 1
      OnClick = btnBackClick
    end
  end
end
