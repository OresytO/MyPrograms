object Form1: TForm1
  Left = 687
  Top = 139
  Width = 360
  Height = 181
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object BitBtn1: TBitBtn
    Left = 24
    Top = 72
    Width = 150
    Height = 25
    Caption = #1057#1090#1074#1086#1088#1077#1085#1085#1103' '#1090#1072#1073#1083#1080#1094#1100
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 40
    Width = 297
    Height = 24
    EditLabel.Width = 173
    EditLabel.Height = 16
    EditLabel.Caption = #1064#1083#1103#1093' '#1076#1086' '#1092#1072#1081#1083#1091' '#1073#1072#1079#1080' '#1076#1072#1085#1080#1093
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 24
    Top = 104
    Width = 150
    Height = 25
    Caption = #1047#1085#1080#1097#1077#1085#1085#1103' '#1090#1072#1073#1083#1080#1094#1100
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 176
    Top = 72
    Width = 150
    Height = 25
    Caption = #1047#1072#1087#1086#1074#1085#1077#1085#1085#1103' '#1090#1072#1073#1083#1080#1094#1100
    TabOrder = 3
    OnClick = BitBtn3Click
  end
  object ADOConnection1: TADOConnection
    Provider = 'Microsoft.ACE.OLEDB.12.0'
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 32
  end
end
