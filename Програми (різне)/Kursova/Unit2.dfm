object Form2: TForm2
  Left = 1001
  Top = 170
  Width = 1338
  Height = 1018
  Caption = 'XXX'
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
  object Label1: TLabel
    Left = 448
    Top = 32
    Width = 502
    Height = 36
    Caption = #1044#1054#1044#1040#1058#1050#1054#1042#1030' '#1044#1040#1053#1030'  '#1055#1056#1054' '#1055#1045#1056#1057#1054#1053#1051
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 496
    Width = 157
    Height = 25
    Caption = #1055#1086#1096#1091#1082' '#1056#1086#1073#1110#1090#1085#1080#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 48
    Top = 136
    Width = 1249
    Height = 345
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
  object Edit1: TEdit
    Left = 40
    Top = 536
    Width = 121
    Height = 24
    TabOrder = 2
  end
  object Button1: TButton
    Left = 32
    Top = 584
    Width = 113
    Height = 49
    Caption = #1055#1086#1096#1091#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 640
    Width = 113
    Height = 49
    Caption = #1047#1072#1082#1088#1080#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=root;Data' +
      ' Source=Kursova1'
    LoginPrompt = False
    Left = 320
    Top = 80
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'info'
    Left = 360
    Top = 80
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'n'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 160
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'Select * From Kursova1.info WHERE PRIZV =:n;')
    Left = 432
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 400
    Top = 80
  end
end
