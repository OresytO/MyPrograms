object FShow: TFShow
  Left = 322
  Top = 15
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1075#1083#1103#1076
  ClientHeight = 810
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -23
  Font.Name = 'Times New Roman'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 26
  object Label6: TLabel
    Left = 324
    Top = 136
    Width = 180
    Height = 26
    Caption = #1055'.'#1030'.'#1041'. '#1077#1082#1089#1087#1077#1076#1080#1090#1086#1088#1072
  end
  object DBGrid1: TDBGrid
    Left = 10
    Top = 256
    Width = 983
    Height = 265
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BBack: TBitBtn
    Left = 10
    Top = 10
    Width = 300
    Height = 50
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 1
    OnClick = BBackClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000074120000741200000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF1E22B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E22B61D22B9FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2121BBD8
      D8FF1D22B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF1D22B9D8D8FF8285FF1D22B9FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1D22B9D5DAFD8285FF76
      7AFE0004C10004C10004C10004C10004C10105BFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF1D22B9D8D8FF8285FF767AFE6B6EFF5C60FE4D51FF4045FF3436FE282A
      FF0004C1FFFFFFFFFFFFFFFFFFFFFFFF2121BBD5DAFD8285FF767AFE6B6EFF5C
      5EFF4D51FF4446FE3238FD282AFF191DFF0105BFFFFFFFFFFFFFFFFFFF0004B3
      D9D7FF8285FF787AFE6B6EFF5C60FE4D51FF4045FF3238FD282AFF191DFF1013
      FE0004C1FFFFFFFFFFFFFFFFFFFFFFFF0004B3787AFE676BFF5C60FE4D51FF40
      45FF3436FE282AFF1C1DFE1013FE090AFE0004C1FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF0004B35C60FE4D51FF4446FE3436FE282AFF191DFF1013FE090AFE0005
      FE0004C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0004B34045FF3436FE28
      2AFF0004B30004B30004B30105BF0004B30004B3FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF0004B3282AFF191DFF0105BFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0004B30D
      14FD0004B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0004B30004B3FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF0004B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 20
    Spacing = 85
  end
  object Selection: TBitBtn
    Left = 10
    Top = 70
    Width = 300
    Height = 50
    Caption = #1047#1088#1086#1073#1080#1090#1080' '#1074#1080#1073#1110#1088#1082#1091
    TabOrder = 2
    OnClick = SelectionClick
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000074120000741200000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080
      8080808080808080808080808080808080808080808080808080808080808080
      8080808080808080808080808080808080808080808080808080808080808080
      8080808080808080808080808080808080808080808080808080000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808080000000FFFFFF
      8080808080808080808080808080808080808080808080808080808080808080
      8080808080808080808080808080808080808080808080808080808080808080
      8080808080808080808080808080808080808080000000808080000000FFFFFF
      C0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FF
      FFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0C0C0C00000000000
      00000000000000000000C0C0C0000000000000000000000000000000C0C0C000
      0000000000000000000000000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFFFFF
      FFFFFFFFFFFFFF000000C0C0C0FFFFFFFFFFFFFFFFFFFFFFFF000000C0C0C0FF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0000000000000000000000000000000000000000000000000C0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0C0C0C000000000000000000000
      0000000000000000000000000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFC0C0C0C0C0C0000000000000C0C0C0FFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFFC0C0C0FFFFFF000000FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFF000000000000000000FFFFFFFFFFFFFFFFFF000000FFFF
      FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFF000000000000000000000000000000FFFFFF000000FFFF
      FFC0C0C0C0C0C0000000000000C0C0C0FFFFFFC0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFFC0C0C0FFFFFF000000FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFF000000000000000000000000FFFFFFFFFFFF000000FFFF
      FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFC0C0C0FFFFFF00000000000000
      0000000000000000FFFFFF000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0FFFFFF000000000000000000000000000000FFFFFF000000FFFF
      FFC0C0C0C0C0C0000000000000C0C0C0FFFFFFC0C0C0FFFFFF00000000000000
      0000FFFFFFFFFFFFFFFFFF000000FFFFFF808080000000808080000000FFFFFF
      C0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFFC0C0C0FFFFFF000000FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000C0C0C0808080000000808080000000FFFFFF
      FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFF
      FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF808080000000808080000000FFFFFF
      C0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FF
      FFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0808080000000808080000000FFFFFF
      FFFFFF000000000000000000000000000000000000C0C0C0FFFFFFC0C0C0FFFF
      FFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFF00000000000000000000000000
      0000000000C0C0C0FFFFFFC0C0C0FFFFFF808080000000808080000000FFFFFF
      C0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0
      C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0FF
      FFFFC0C0C0FFFFFFC0C0C0FFFFFFC0C0C0808080000000808080000000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000808080000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000808080000000FF0000
      FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000000000C0C0C0000000C0C0C0000000C0C0C0000000808080000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 20
    Spacing = 20
  end
  object BExit: TBitBtn
    Left = 10
    Top = 190
    Width = 300
    Height = 50
    Caption = #1042#1080#1093#1110#1076
    TabOrder = 3
    OnClick = BExitClick
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000074120000741200000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000FFFFFF000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000000000FF
      FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
      00000000000000FFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      00FFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFF
      FFFFFFFF000000000000000000000000000000000000000000000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF000000000000000000000000000000000000000000000000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 20
    Spacing = 70
  end
  object ComboBox2: TComboBox
    Left = 324
    Top = 176
    Width = 400
    Height = 34
    ItemHeight = 26
    TabOrder = 4
    OnChange = ComboBox2Change
    OnDropDown = ComboBox2DropDown
  end
  object GroupBox1: TGroupBox
    Left = 736
    Top = 8
    Width = 257
    Height = 97
    Caption = #1071#1082#1110' '#1079#1072#1087#1080#1089#1080' '#1074#1110#1076#1086#1073#1088#1072#1078#1072#1090#1080'?'
    TabOrder = 5
    object RadioButton1: TRadioButton
      Left = 8
      Top = 24
      Width = 153
      Height = 17
      Caption = #1040#1082#1090#1080#1074#1085#1110
      TabOrder = 0
    end
    object RadioButton3: TRadioButton
      Left = 8
      Top = 72
      Width = 113
      Height = 17
      Caption = #1042#1089#1110
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Caption = #1053#1077#1072#1082#1090#1080#1074#1085#1110
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 736
    Top = 112
    Width = 257
    Height = 97
    Caption = #1071#1082#1110' '#1079#1072#1087#1080#1089#1080' '#1074#1110#1076#1086#1073#1088#1072#1078#1072#1090#1080'?'
    TabOrder = 6
    object RadioButton4: TRadioButton
      Left = 8
      Top = 24
      Width = 113
      Height = 17
      Caption = #1042#1093#1110#1076#1085#1110
      TabOrder = 0
    end
    object RadioButton5: TRadioButton
      Left = 8
      Top = 48
      Width = 113
      Height = 17
      Caption = #1042#1080#1093#1110#1076#1085#1110
      TabOrder = 1
    end
    object RadioButton6: TRadioButton
      Left = 8
      Top = 72
      Width = 113
      Height = 17
      Caption = #1042#1089#1110
      Checked = True
      TabOrder = 2
      TabStop = True
    end
  end
  object GroupBox3: TGroupBox
    Left = 324
    Top = 8
    Width = 201
    Height = 121
    Caption = #1044#1072#1090#1072' '#1074#1110#1076#1087#1088#1072#1074#1083#1077#1085#1085#1103
    TabOrder = 7
    object Label1: TLabel
      Left = 10
      Top = 30
      Width = 9
      Height = 26
      Caption = #1079
    end
    object Label2: TLabel
      Left = 10
      Top = 74
      Width = 24
      Height = 26
      Caption = #1076#1086
    end
    object DateTimePicker1: TDateTimePicker
      Left = 40
      Top = 30
      Width = 150
      Height = 34
      CalAlignment = dtaLeft
      Date = 41462.3773228819
      Time = 41462.3773228819
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 40
      Top = 74
      Width = 150
      Height = 34
      CalAlignment = dtaLeft
      Date = 41462.3773743634
      Time = 41462.3773743634
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 528
    Top = 8
    Width = 201
    Height = 121
    Caption = #1044#1072#1090#1072' '#1086#1090#1088#1080#1084#1072#1085#1085#1103
    TabOrder = 8
    object Label3: TLabel
      Left = 10
      Top = 30
      Width = 9
      Height = 26
      Caption = #1079
    end
    object Label4: TLabel
      Left = 10
      Top = 74
      Width = 24
      Height = 26
      Caption = #1076#1086
    end
    object DateTimePicker3: TDateTimePicker
      Left = 40
      Top = 30
      Width = 150
      Height = 34
      CalAlignment = dtaLeft
      Date = 41476.7510689005
      Time = 41476.7510689005
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object DateTimePicker4: TDateTimePicker
      Left = 40
      Top = 74
      Width = 150
      Height = 34
      CalAlignment = dtaLeft
      Date = 41476.7511559144
      Time = 41476.7511559144
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object BPrint_documents: TBitBtn
    Left = 10
    Top = 130
    Width = 300
    Height = 50
    Caption = #1044#1088#1091#1082#1091#1074#1072#1090#1080' '#1076#1086#1088#1091#1095#1077#1085#1085#1103
    TabOrder = 9
    OnClick = BPrint_documentsClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    Margin = 20
    NumGlyphs = 2
    Spacing = 20
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 536
    Width = 985
    Height = 265
    DataSource = DataSource2
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -23
    TitleFont.Name = 'Times New Roman'
    TitleFont.Style = []
  end
  object ComboBox3: TComboBox
    Left = 324
    Top = 216
    Width = 400
    Height = 34
    ItemHeight = 26
    TabOrder = 11
    OnChange = ComboBox3Change
    OnDropDown = ComboBox3DropDown
  end
  object CheckBox1: TCheckBox
    Left = 736
    Top = 216
    Width = 250
    Height = 34
    Caption = #1056#1086#1079#1076#1088#1091#1082' '#1084#1072#1088#1096#1088#1091#1090#1091
    TabOrder = 12
  end
  object ADODataSet1: TADODataSet
    Connection = FStart.ADOConnection1
    Parameters = <>
    Left = 88
    Top = 328
  end
  object ADOCommand1: TADOCommand
    Connection = FStart.ADOConnection1
    Prepared = True
    Parameters = <>
    Left = 72
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 88
    Top = 296
  end
  object ADODataSet2: TADODataSet
    Connection = FStart.ADOConnection1
    Parameters = <>
    Left = 320
    Top = 176
  end
  object ADODataSet3: TADODataSet
    Connection = FStart.ADOConnection1
    Parameters = <>
    Left = 112
    Top = 576
  end
  object DataSource2: TDataSource
    DataSet = ADODataSet3
    Left = 112
    Top = 544
  end
  object DataSource3: TDataSource
    DataSet = ADODataSet4
    Left = 240
  end
  object ADODataSet4: TADODataSet
    Connection = FStart.ADOConnection1
    Parameters = <>
    Left = 240
    Top = 32
  end
  object ADODataSet5: TADODataSet
    Connection = FStart.ADOConnection1
    Parameters = <>
    Left = 320
    Top = 216
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 528
    Top = 136
  end
end
