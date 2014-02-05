object Form3: TForm3
  Left = 450
  Top = 296
  Width = 1264
  Height = 785
  Caption = 'Form3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 320
    Top = 8
    Width = 382
    Height = 36
    Caption = #1030#1053#1060#1054#1056#1052#1040#1062#1030#1071' '#1055#1056#1054' '#1050#1040#1044#1056#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 96
    Top = 312
    Width = 233
    Height = 25
    Caption = #1042#1074#1077#1076#1110#1090#1100' '#1085#1086#1084#1077#1088' '#1088#1086#1073#1110#1090#1085#1080#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 104
    Top = 96
    Width = 817
    Height = 201
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 104
    Top = 48
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 656
    Width = 137
    Height = 57
    Caption = #1047#1040#1050#1056#1048#1058#1048
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 392
    Width = 121
    Height = 73
    Caption = #1055#1086#1096#1091#1082' '#1082#1072#1076#1088#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 96
    Top = 352
    Width = 121
    Height = 24
    TabOrder = 4
  end
  object Button3: TButton
    Left = 584
    Top = 328
    Width = 89
    Height = 33
    Caption = #1053#1086#1074#1080#1081
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 592
    Top = 376
    Width = 73
    Height = 49
    Caption = #1042#1110#1076#1082#1088#1080#1090#1080
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 688
    Top = 320
    Width = 89
    Height = 41
    Caption = 'Word'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 688
    Top = 384
    Width = 89
    Height = 41
    Caption = #1042' '#1076#1086#1082#1091#1084#1077#1085#1090
    TabOrder = 8
    OnClick = Button6Click
  end
  object Memo1: TMemo
    Left = 376
    Top = 328
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 9
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 368
    Top = 48
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data' +
      ' Source=Kursova1'
    LoginPrompt = False
    Left = 416
    Top = 48
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'workers'
    Left = 456
    Top = 48
    object ADOTable1COD_WORKERS: TIntegerField
      FieldName = 'COD_WORKERS'
    end
    object ADOTable1PRIZV: TStringField
      FieldName = 'PRIZV'
      Size = 30
    end
    object ADOTable1NAME: TStringField
      FieldName = 'NAME'
      Size = 30
    end
    object ADOTable1POBATKOVI: TStringField
      FieldName = 'POBATKOVI'
      Size = 30
    end
    object ADOTable1COD_VIDDILU: TIntegerField
      FieldName = 'COD_VIDDILU'
    end
    object ADOTable1POSADA: TStringField
      FieldName = 'POSADA'
      Size = 30
    end
    object ADOTable1STAG: TSmallintField
      FieldName = 'STAG'
    end
    object ADOTable1TEL_WORK: TIntegerField
      FieldName = 'TEL_WORK'
    end
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'n'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 88
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'Select  * From kursova1.workers WHERE  COD_WORKERS=:n;')
    Left = 496
    Top = 48
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 336
    Top = 320
  end
  object WordDocument1: TWordDocument
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 336
    Top = 360
  end
  object WordFont1: TWordFont
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 336
    Top = 400
  end
end
