object Form4: TForm4
  Left = 910
  Top = 129
  Width = 779
  Height = 783
  HorzScrollBar.Position = 559
  Caption = 'Form4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object QuickRep1: TQuickRep
    Left = -111
    Top = 32
    Width = 1020
    Height = 1320
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = TDep
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = Letter
    Page.Values = (
      100
      2794
      100
      2159
      100
      100
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object QRLabel1: TQRLabel
      Left = 294
      Top = 80
      Width = 425
      Height = 39
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        82.55
        622.3
        169.333333333333
        899.583333333333)
      Alignment = taCenter
      AlignToBand = True
      AutoSize = True
      AutoStretch = False
      Caption = #1050#1072#1076#1088#1086#1074#1080#1081' '#1089#1082#1083#1072#1076' '#1086#1088#1075#1072#1085#1110#1079#1072#1094#1110#1111
      Color = clWhite
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 16
    end
    object QRSysData1: TQRSysData
      Left = 400
      Top = 192
      Width = 167
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        52.9166666666667
        846.666666666667
        406.4
        353.483333333333)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = True
      Color = clWhite
      Data = qrsDate
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Text = #1055#1086' '#1089#1090#1072#1085#1110' '#1085#1072
      Transparent = False
      FontSize = 10
    end
    object QRLabel2: TQRLabel
      Left = 440
      Top = 408
      Width = 125
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = True
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        42.3333333333333
        931.333333333333
        863.6
        264.583333333333)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = #1050#1072#1076#1088#1086#1074#1080#1081' '#1089#1082#1083#1072#1076
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRSysData2: TQRSysData
      Left = 208
      Top = 280
      Width = 48
      Height = 20
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        42.3333333333333
        440.266666666667
        592.666666666667
        101.6)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      Color = clWhite
      Data = qrsTime
      Transparent = False
      FontSize = 10
    end
  end
  object TDep: TTable
    Active = True
    DatabaseName = 'Kursova1'
    TableName = 'workers'
    Left = 328
    Top = 152
  end
  object DSDep: TDataSource
    DataSet = TDep
    Left = 328
    Top = 200
  end
  object TPers: TTable
    Active = True
    DatabaseName = 'Kursova1'
    IndexFieldNames = 'COD_VIDDILU;POSADA;STAG'
    MasterFields = 'COD_VIDDILU;POSADA;STAG'
    MasterSource = DSDep
    TableName = 'workers'
    Left = 328
    Top = 248
  end
end
