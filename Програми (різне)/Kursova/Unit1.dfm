object Form1: TForm1
  Left = 749
  Top = 13
  Width = 1391
  Height = 880
  Caption = ','
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 352
    Top = 152
    Width = 769
    Height = 337
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 208
      Top = 144
      Width = 361
      Height = 36
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' "'#1042#1110#1076#1076#1110#1083' '#1082#1072#1076#1088#1110#1074'"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -30
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 264
      Top = 56
      Width = 269
      Height = 36
      Caption = #1050#1059#1056#1057#1054#1042#1040' '#1056#1054#1041#1054#1058#1040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -30
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Button1: TButton
    Left = 648
    Top = 528
    Width = 169
    Height = 65
    Caption = #1042#1048#1061#1030#1044
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 8
    object N1: TMenuItem
      Caption = #1056#1045#1044#1040#1050#1058#1054#1056' '#1041#1044' "'#1042#1030#1044#1044#1030#1051' '#1050#1040#1044#1056#1030#1042'"'
      object Viddil1: TMenuItem
        Caption = #1042#1030#1044#1044#1030#1051
        OnClick = Viddil1Click
      end
      object Personal1: TMenuItem
        Caption = #1055#1045#1056#1057#1054#1053#1040#1051
        OnClick = Personal1Click
      end
      object N2: TMenuItem
        Caption = #1056#1054#1041#1030#1058#1053#1048#1050#1048
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1044#1054#1042#1030#1044#1050#1048
        OnClick = N3Click
      end
    end
  end
end
