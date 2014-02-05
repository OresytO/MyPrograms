object Form5: TForm5
  Left = 711
  Top = 429
  Width = 935
  Height = 655
  Caption = 'Form5'
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
    Left = 56
    Top = 16
    Width = 485
    Height = 46
    Caption = #1030#1060#1054#1056#1052#1040#1062#1030#1071' '#1055#1056#1054' '#1042#1030#1044#1044#1030#1051#1048
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 528
    Top = 128
    Width = 266
    Height = 25
    Caption = #1055#1086#1096#1091#1082' '#1074#1110#1076#1076#1110#1083#1091' '#1079#1072' '#1081#1086#1075#1086' '#1082#1086#1076#1086#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 128
    Width = 441
    Height = 169
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 64
    Top = 80
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 56
    Top = 320
    Width = 113
    Height = 57
    Caption = #1047#1072#1082#1088#1080#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 528
    Top = 160
    Width = 121
    Height = 24
    TabOrder = 3
  end
  object Button2: TButton
    Left = 528
    Top = 216
    Width = 89
    Height = 41
    Caption = #1055#1086#1096#1091#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 312
    Top = 80
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=root;Persist Security Info=True;User' +
      ' ID=root;Data Source=Kursova1;Initial Catalog=kursova1'
    LoginPrompt = False
    Left = 368
    Top = 80
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'viddilu'
    Left = 408
    Top = 80
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'n'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 16
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'Select * From viddilu where cod_viddilu = :n;')
    Left = 448
    Top = 80
  end
end
