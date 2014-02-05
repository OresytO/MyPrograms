VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "NonClientMetrics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' NonClientMetrics class.
' Retrieve information about the non-client portion of standard windows.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Although this is optional, and 0 is the default,
' explicitly setting it could save some trouble because
' this code counts on it.
Option Base 0

Private Const SM_CYCAPTION = 4
Private Const SM_CYMENU = 15
Private Const SM_CYSMCAPTION = 51
Private Const SM_CXDLGFRAME = 7
Private Const SM_CYDLGFRAME = 8
Private Const SM_CXFIXEDFRAME = SM_CXDLGFRAME
Private Const SM_CYFIXEDFRAME = SM_CYDLGFRAME

Const LF_FACESIZE = 32
Private Type LogFont
    lfHeight As Long
    lfWidth As Long
    lfEscapement As Long
    lfOrientation As Long
    lfWeight As Long
    lfItalic As Byte
    lfUnderline As Byte
    lfStrikeOut As Byte
    lfCharSet As Byte
    lfOutPrecision As Byte
    lfClipPrecision As Byte
    lfQuality As Byte
    lfPitchAndFamily As Byte
    lfFaceName(0 To LF_FACESIZE - 1) As Byte
End Type

' SystemParametersInfo flags
Private Const SPIF_UPDATEINIFILE = &H1
Private Const SPIF_SENDWININICHANGE = &H2

' This is a made-up constant.
Private Const SPIF_TELLALL = SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE

Private Const SPI_GETNONCLIENTMETRICS = 41
Private Const SPI_SETNONCLIENTMETRICS = 42

Private Const LOGPIXELSY = 90        '  Logical pixels/inch in Y

Private Declare Function GetDeviceCaps _
 Lib "gdi32" _
 (ByVal hDC As Long, ByVal nIndex As Long) As Long
 
Private Declare Function CreateIC _
 Lib "gdi32" Alias "CreateICA" _
 (ByVal lpDriverName As String, ByVal lpDeviceName As String, _
 ByVal lpOutput As String, lpInitData As Any) As Long
 
Private Declare Function DeleteDC _
 Lib "gdi32" _
 (ByVal hDC As Long) As Long

Private Declare Function SystemParametersInfo _
 Lib "user32" Alias "SystemParametersInfoA" _
 (ByVal uAction As Long, ByVal uParam As Long, _
 lpvParam As Any, ByVal fuWinIni As Long) As Long
 
Private Declare Function GetSystemMetrics _
 Lib "user32" _
 (ByVal nIndex As Long) As Long

' NONCLIENTMETRICS Information
Private Type typNonClientMetrics
    cbSize As Long
    lngBorderWidth As Long
    lngScrollWidth As Long
    lngScrollHeight As Long
    lngCaptionWidth As Long
    lngCaptionHeight As Long
    lfCaptionFont As LogFont
    lngSMCaptionWidth As Long
    lngSMCaptionHeight As Long
    lfSMCaptionFont As LogFont
    lngMenuWidth As Long
    lngMenuHeight As Long
    lfMenuFont As LogFont
    lfStatusFont As LogFont
    lfMessageFont As LogFont
End Type

Private ncm As typNonClientMetrics
Private oCaptionFont As Font
Private oSMCaptionFont As Font
Private oMenuFont As Font
Private oStatusFont As Font
Private oMessageFont As Font

Private Function dhTrimNull(strValue As String) As String
    ' Borrowed from Chapter 1.
    Dim intPos As Integer
    intPos = InStr(strValue, vbNullChar)
    Select Case intPos
        Case 0
            dhTrimNull = strValue
        Case 1
            dhTrimNull = ""
        Case Else
            dhTrimNull = Left$(strValue, intPos - 1)
    End Select
End Function

Private Sub Class_Initialize()
    Dim lngLen As Long
    
    lngLen = Len(ncm)
    ncm.cbSize = lngLen
    Call SystemParametersInfo(SPI_GETNONCLIENTMETRICS, _
     lngLen, ncm, 0)
    
    Set oCaptionFont = New Font
    Set oSMCaptionFont = New Font
    Set oMenuFont = New Font
    Set oStatusFont = New Font
    Set oMessageFont = New Font
    
    Call SetFontInfo(ncm.lfCaptionFont, oCaptionFont)
    Call SetFontInfo(ncm.lfMenuFont, oMenuFont)
    Call SetFontInfo(ncm.lfMessageFont, oMessageFont)
    Call SetFontInfo(ncm.lfSMCaptionFont, oSMCaptionFont)
    Call SetFontInfo(ncm.lfStatusFont, oStatusFont)
End Sub

Public Property Get BorderWidth() As Long
    ' Set or retrieve standard window borderwidth.
    BorderWidth = ncm.lngBorderWidth
End Property

Public Property Let BorderWidth(Value As Long)
    ' Set or retrieve standard window borderwidth.
    ncm.lngBorderWidth = Value
    Call SaveSettings
End Property

Public Property Get ScrollWidth() As Long
    ' Set or retrieve standard vertical scrollbar width.
    ScrollWidth = ncm.lngScrollWidth
End Property

Public Property Let ScrollWidth(Value As Long)
    ' Set or retrieve standard vertical scrollbar width.
    ncm.lngScrollWidth = Value
    Call SaveSettings
End Property

Public Property Get ScrollHeight() As Long
    ' Set or retrieve standard horizontal scrollbar height.
    ScrollHeight = ncm.lngScrollHeight
End Property

Public Property Let ScrollHeight(Value As Long)
    ' Set or retrieve standard horizontal scrollbar height.
    ncm.lngScrollHeight = Value
    Call SaveSettings
End Property

Public Property Get CaptionWidth() As Long
    ' Set or retrieve width of caption bar buttons.
    CaptionWidth = ncm.lngCaptionWidth
End Property

Public Property Let CaptionWidth(Value As Long)
    ' Set or retrieve width of caption bar buttons.
    ncm.lngCaptionWidth = Value
    Call SaveSettings
End Property

Public Property Get CaptionHeight() As Long
    ' Set or retrieve height of caption bar buttons.
    CaptionHeight = ncm.lngCaptionHeight
End Property

Public Property Let CaptionHeight(Value As Long)
    ' Set or retrieve height of caption bar buttons.
    ncm.lngCaptionHeight = Value
    Call SaveSettings
End Property

Public Property Get CaptionFont() As Font
    ' Retrieve caption bar font object.
    Set CaptionFont = oCaptionFont
End Property

Public Property Get SmallCaptionButtonWidth() As Long
    ' Set or retrieve width of small caption bar buttons.
    SmallCaptionButtonWidth = ncm.lngSMCaptionWidth
End Property

Public Property Let SmallCaptionButtonWidth(Value As Long)
    ' Set or retrieve width of small caption bar buttons.
    ncm.lngSMCaptionWidth = Value
    Call SaveSettings
End Property

Public Property Get SmallCaptionButtonHeight() As Long
    ' Set or retrieve height of small caption bar buttons.
    SmallCaptionButtonHeight = ncm.lngSMCaptionHeight
End Property

Public Property Let SmallCaptionButtonHeight(Value As Long)
    ' Set or retrieve height of small caption bar buttons.
    ncm.lngSMCaptionHeight = Value
    Call SaveSettings
End Property

Public Property Get SmallCaptionFont() As Font
    ' Retrieve small caption bar font object.
    Set SmallCaptionFont = oSMCaptionFont
End Property

Public Property Get MenuButtonWidth() As Long
    ' Set or retrieve the width of menu bar buttons.
    MenuButtonWidth = ncm.lngMenuWidth
End Property

Public Property Let MenuButtonWidth(Value As Long)
    ' Set or retrieve the width of menu bar buttons.
    ncm.lngMenuWidth = Value
    Call SaveSettings
End Property

Public Property Get MenuButtonHeight() As Long
    ' Set or retrieve the height of menu bar buttons.
    MenuButtonHeight = ncm.lngMenuHeight
End Property

Public Property Let MenuButtonHeight(Value As Long)
    ' Set or retrieve the height of menu bar buttons.
    ncm.lngMenuHeight = Value
    Call SaveSettings
End Property

Public Property Get MenuFont() As Font
    ' Retrieve menu font object.
    Set MenuFont = oMenuFont
End Property

Public Property Get StatusFont() As Font
    ' Retrieve status bar font object.
    Set StatusFont = oStatusFont
End Property

Public Property Get MessageFont() As Font
    ' Retrieve message box font object.
    Set MessageFont = oMessageFont
End Property
Public Sub SaveSettings()
    ' Save all changed settings.
    Dim lngLen As Long
    lngLen = Len(ncm)
    ncm.cbSize = lngLen
    
    ' Need to copy all the font values back into the
    ' LogFont structures.
    Call GetFontInfo(ncm.lfCaptionFont, oCaptionFont)
    Call GetFontInfo(ncm.lfMenuFont, oMenuFont)
    Call GetFontInfo(ncm.lfMessageFont, oMessageFont)
    Call GetFontInfo(ncm.lfSMCaptionFont, oSMCaptionFont)
    Call GetFontInfo(ncm.lfStatusFont, oStatusFont)
    
    ' Now save all the settings back to Windows.
    Call SystemParametersInfo(SPI_SETNONCLIENTMETRICS, _
     lngLen, ncm, SPIF_TELLALL)
End Sub

Private Sub SetFontInfo(lf As LogFont, oFont As Font)
    ' Get font info from a LOGFONT structure into a Font class.
    With oFont
        .Weight = lf.lfWeight
        .StrikeOut = CBool(lf.lfStrikeOut)
        
        .Underline = CBool(lf.lfUnderline)
        .Italic = CBool(lf.lfItalic)
        
        .FaceName = dhTrimNull(StrConv(lf.lfFaceName, vbUnicode))
        .Size = CalcSize(lf.lfHeight, fToPoints:=True)
    End With
End Sub
    
Private Sub GetFontInfo(lf As LogFont, oFont As Font)
    ' Get font info from a Font class back into a LOGFONT structure.
    With oFont
        lf.lfWeight = .Weight
        lf.lfStrikeOut = .StrikeOut
        
        lf.lfUnderline = .Underline
        lf.lfItalic = .Italic
        
        lf.lfHeight = CalcSize(.Size, fToPoints:=False)
        Call SetFaceName(lf, .FaceName)
    End With
End Sub

Private Function CalcSize(lngHeight As Long, _
 fToPoints As Boolean) As Long
    Dim lngLogPixelsY As Long
    Dim hDC As Long
    
    hDC = CreateIC("DISPLAY", "", "", 0&)
    lngLogPixelsY = GetDeviceCaps(hDC, LOGPIXELSY)
    Call DeleteDC(hDC)
    If fToPoints Then
        CalcSize = -Int(lngHeight * 72 / lngLogPixelsY)
    Else
        CalcSize = -Int(lngHeight * lngLogPixelsY / 72)
    End If
End Function

Private Sub SetFaceName(lf As LogFont, strValue As String)
    ' Given a string, get it back into the ANSI byte array
    ' contained within a LOGFONT structure.
    Dim intLen As String
    Dim intI As Integer
    Dim varName As Variant
    Dim abytTemp() As Byte
    
    abytTemp = StrConv(strValue, vbFromUnicode)
    intLen = UBound(abytTemp) + 1
    
    ' Make sure the string isn't too long.
    If intLen > LF_FACESIZE - 1 Then
        intLen = LF_FACESIZE - 1
    End If
    For intI = 0 To intLen - 1
        lf.lfFaceName(intI) = abytTemp(intI)
    Next intI
    lf.lfFaceName(intI) = 0
End Sub

Private Sub Class_Terminate()
    Set oCaptionFont = Nothing
    Set oSMCaptionFont = Nothing
    Set oMenuFont = Nothing
    Set oStatusFont = Nothing
    Set oMessageFont = Nothing
End Sub

Public Property Get Caption() As Long
    ' Height, in pixels, of normal caption bar.
    Caption = GetSystemMetrics(SM_CYCAPTION)
End Property

Public Property Get MenuHeight() As Long
    ' Height, in pixels, of normal single-line menu.
    MenuHeight = GetSystemMetrics(SM_CYMENU)
End Property

Public Property Get SmallCaption() As Long
    ' Height, in pixels, of a small caption bar.
    SmallCaption = GetSystemMetrics(SM_CYSMCAPTION)
End Property

Public Property Get FixedBorderX() As Long
    ' Retrieve the width in pixels, of the frame
    ' around the perimeter of a window that has a caption
    ' but is not sizable.
    FixedBorderX = GetSystemMetrics(SM_CXFIXEDFRAME)
End Property

Public Property Get FixedBorderY() As Long
    ' Retrieve the height, in pixels, of the frame
    ' around the perimeter of a window that has a caption
    ' but is not sizable.
    FixedBorderY = GetSystemMetrics(SM_CYFIXEDFRAME)
End Property

