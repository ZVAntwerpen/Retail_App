object frmInventoryReport: TfrmInventoryReport
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Inventory Report'
  ClientHeight = 373
  ClientWidth = 688
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
  object pnlYellowBG_IR: TPanel
    Left = 8
    Top = 8
    Width = 670
    Height = 357
    Color = 55295
    ParentBackground = False
    TabOrder = 0
    object memInventoryReport: TMemo
      Left = 25
      Top = 8
      Width = 624
      Height = 289
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btnBack: TButton
      Left = 271
      Top = 303
      Width = 130
      Height = 49
      Caption = 'Back'
      TabOrder = 1
      OnClick = btnBackClick
    end
  end
end
