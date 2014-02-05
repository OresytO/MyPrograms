VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SystemColors"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' SystemColors class.
' Set and retrieve information about the Windows system colors.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Const COLOR_SCROLLBAR = 0           ' Scroll Bar
Private Const COLOR_BACKGROUND = 1          ' Windows desktop
Private Const COLOR_ACTIVECAPTION = 2       ' Caption of active window
Private Const COLOR_INACTIVECAPTION = 3     ' Caption of inactive window
Private Const COLOR_MENU = 4                ' Menu
Private Const COLOR_WINDOW = 5              ' Window background
Private Const COLOR_WINDOWFRAME = 6         ' Window frame
Private Const COLOR_MENUTEXT = 7            ' Menu text
Private Const COLOR_WINDOWTEXT = 8          ' Window text
Private Const COLOR_CAPTIONTEXT = 9         ' Text in window caption
Private Const COLOR_ACTIVEBORDER = 10       ' Border of active window
Private Const COLOR_INACTIVEBORDER = 11     ' Border of inactive window
Private Const COLOR_APPWORKSPACE = 12       ' Background of MDI desktop
Private Const COLOR_HIGHLIGHT = 13          ' Selected item background
Private Const COLOR_HIGHLIGHTTEXT = 14      ' Selected item text
Private Const COLOR_BTNFACE = 15            ' Button
Private Const COLOR_BTNSHADOW = 16          ' 3D shading of button
Private Const COLOR_GRAYTEXT = 17           ' Gray text, or zero if dithering is used
Private Const COLOR_BTNTEXT = 18            ' Button text
Private Const COLOR_INACTIVECAPTIONTEXT = 19    ' Text of inactive window
Private Const COLOR_BTNHIGHLIGHT = 20       ' 3D highlight of button

Private Const COLOR_3DDKSHADOW = 21         ' 3D dark shadow (Win95)
Private Const COLOR_3DLIGHT = 22            ' Light color for 3D shaded objects (Win95)
Private Const COLOR_INFOTEXT = 23           ' Tooltip text color (Win95)
Private Const COLOR_INFOBK = 24             ' Tooltip background color (Win95)

Private Const COLOR_HOTLIGHT = 26           ' Color for a hot-tracked item
Private Const COLOR_GRADIENTACTIVECAPTION = 27    ' Right side color in the color gradient of an active window's title bar.
Private Const COLOR_GRADIENTINACTIVECAPTION = 28    ' Right side color in the color gradient of an inactive window's title bar.

Private Const COLOR_DESKTOP = COLOR_BACKGROUND
Private Const COLOR_3DFACE = COLOR_BTNFACE  ' Face color for 3D shaded objects (Win95)
Private Const COLOR_3DSHADOW = COLOR_BTNSHADOW
Private Const COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT
Private Const COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT  ' 3D Highlight color (Win95)
Private Const COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT


Private Declare Function SetSysColors _
 Lib "user32" _
 (ByVal nChanges As Long, lpSysColor As Long, _
 lpColorValues As Long) As Long
 
Private Declare Function GetSysColor _
 Lib "user32" (ByVal nIndex As Long) As Long

' 5113 is arbitrary.
Private Const dhcErrBase = vbObjectError + 5113
Private Const ERR_STRING = "Invalid for this operating system."
Private Const ERR_INVALID_OS = dhcErrBase + 1

' Should this class raise errors if the
' operating system doesn't support the
' requested operation, or should it silently fail?
Public RaiseErrors As Boolean

Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type
Private osvi As OSVERSIONINFO

Private Declare Function GetVersionEx _
 Lib "kernel32" Alias "GetVersionExA" _
 (lpVersionInformation As Any) As Long

Private mlngWINVER As Long

Public Property Get InactiveGradientColor() As Long
    ' Windows 2000, Windows 98
    ' Left side color in the color gradient of an inactive window's title bar.
    ' COLOR_INACTIVECAPTION defines the left side color in the gradient
    If mlngWINVER >= 5& Then
        InactiveGradientColor = GetSysColor(COLOR_GRADIENTINACTIVECAPTION)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let InactiveGradientColor(Value As Long)
    ' Windows 2000, Windows 98
    ' Right side color in the color gradient of an inactive window's title bar.
    ' COLOR_INACTIVECAPTION defines the left side color in the gradient
    If mlngWINVER >= 5& Then
        Call SetColor(COLOR_GRADIENTINACTIVECAPTION, Value)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ActiveGradientColor() As Long
    ' Windows 2000, Windows 98
    ' Right side color in the color gradient of an active window's title bar.
    ' COLOR_ACTIVECAPTION defines the left side color in the gradient
    If mlngWINVER >= 5& Then
        ActiveGradientColor = GetSysColor(COLOR_GRADIENTACTIVECAPTION)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ActiveGradientColor(Value As Long)
    ' Windows 2000, Windows 98
    ' Right side color in the color gradient of an active window's title bar.
    ' COLOR_ACTIVECAPTION defines the left side color in the gradient
    If mlngWINVER >= 5& Then
        Call SetColor(COLOR_GRADIENTACTIVECAPTION, Value)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get HotTrackItem() As Long
    ' Windows 2000, Windows 98
    ' Color for a hot-tracked item
    If mlngWINVER >= 5& Then
        HotTrackItem = GetSysColor(COLOR_HOTLIGHT)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let HotTrackItem(Value As Long)
    ' Windows 2000, Windows 98
    ' Color for a hot-tracked item
    If mlngWINVER >= 5& Then
        Call SetColor(COLOR_HOTLIGHT, Value)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ScrollBar() As Long
    ' Scroll Bar system color.
    ScrollBar = GetSysColor(COLOR_SCROLLBAR)
End Property

Public Property Let ScrollBar(Value As Long)
    ' Scroll Bar system color.
    Call SetColor(COLOR_SCROLLBAR, Value)
End Property

Public Property Get Background() As Long
    ' Windows desktop system color.
    Background = GetSysColor(COLOR_BACKGROUND)
End Property

Public Property Let Background(Value As Long)
    ' Windows desktop system color.
    Call SetColor(COLOR_BACKGROUND, Value)
End Property

Public Property Get ActiveCaption() As Long
    ' Caption of active window system color.
    ' Windows 98, Windows 2000: Specifies the left side color in
    ' the color gradient of an active window's title bar
    ' if the gradient effect is enabled.
    ActiveCaption = GetSysColor(COLOR_ACTIVECAPTION)
End Property

Public Property Let ActiveCaption(Value As Long)
    ' Caption of active window system color.
    Call SetColor(COLOR_ACTIVECAPTION, Value)
End Property

Public Property Get InactiveCaption() As Long
    ' Caption of inactive window system color.
    InactiveCaption = GetSysColor(COLOR_INACTIVECAPTION)
End Property

Public Property Let InactiveCaption(Value As Long)
    ' Caption of inactive window system color.
    ' Windows 98, Windows 2000: Specifies the left side
    ' color in the color gradient of an inactive window's
    ' title bar if the gradient effect is enabled.
    Call SetColor(COLOR_INACTIVECAPTION, Value)
End Property

Public Property Get Menu() As Long
    ' Menu system color.
    Menu = GetSysColor(COLOR_MENU)
End Property

Public Property Let Menu(Value As Long)
    ' Menu system color.
    Call SetColor(COLOR_MENU, Value)
End Property

Public Property Get Window() As Long
    ' Window background system color.
    Window = GetSysColor(COLOR_WINDOW)
End Property

Public Property Let Window(Value As Long)
    ' Window background system color.
    Call SetColor(COLOR_WINDOW, Value)
End Property

Public Property Get WindowFrame() As Long
    ' Window frame system color.
    WindowFrame = GetSysColor(COLOR_WINDOWFRAME)
End Property

Public Property Let WindowFrame(Value As Long)
    ' Window frame system color.
    Call SetColor(COLOR_WINDOWFRAME, Value)
End Property

Public Property Get MenuText() As Long
    ' Menu text system color.
    MenuText = GetSysColor(COLOR_MENUTEXT)
End Property

Public Property Let MenuText(Value As Long)
    ' Menu text system color.
    Call SetColor(COLOR_MENUTEXT, Value)
End Property

Public Property Get WindowText() As Long
    ' Window text system color.
    WindowText = GetSysColor(COLOR_WINDOWTEXT)
End Property

Public Property Let WindowText(Value As Long)
    ' Window text system color.
    Call SetColor(COLOR_WINDOWTEXT, Value)
End Property

Public Property Get CaptionText() As Long
    ' Text in window caption system color.
    CaptionText = GetSysColor(COLOR_CAPTIONTEXT)
End Property

Public Property Let CaptionText(Value As Long)
    ' Text in window caption system color.
    Call SetColor(COLOR_CAPTIONTEXT, Value)
End Property

Public Property Get ActiveBorder() As Long
    ' Border of active window system color.
    ActiveBorder = GetSysColor(COLOR_ACTIVEBORDER)
End Property

Public Property Let ActiveBorder(Value As Long)
    ' Border of active window system color.
    Call SetColor(COLOR_ACTIVEBORDER, Value)
End Property

Public Property Get InactiveBorder() As Long
    ' Border of inactive window system color.
    InactiveBorder = GetSysColor(COLOR_INACTIVEBORDER)
End Property

Public Property Let InactiveBorder(Value As Long)
    ' Border of inactive window system color.
    Call SetColor(COLOR_INACTIVEBORDER, Value)
End Property

Public Property Get AppWorkspace() As Long
    ' Background of MDI desktop system color.
    AppWorkspace = GetSysColor(COLOR_APPWORKSPACE)
End Property

Public Property Let AppWorkspace(Value As Long)
    ' Background of MDI desktop system color.
    Call SetColor(COLOR_APPWORKSPACE, Value)
End Property

Public Property Get Highlight() As Long
    ' Selected item background system color.
    Highlight = GetSysColor(COLOR_HIGHLIGHT)
End Property

Public Property Let Highlight(Value As Long)
    ' Selected item background system color.
    Call SetColor(COLOR_HIGHLIGHT, Value)
End Property

Public Property Get HighlightText() As Long
    ' Selected item text system color.
    HighlightText = GetSysColor(COLOR_HIGHLIGHTTEXT)
End Property

Public Property Let HighlightText(Value As Long)
    ' Selected item text system color.
    Call SetColor(COLOR_HIGHLIGHTTEXT, Value)
End Property

Public Property Get ButtonFace() As Long
    ' Button system color.
    ButtonFace = GetSysColor(COLOR_BTNFACE)
End Property

Public Property Let ButtonFace(Value As Long)
    ' Button system color.
    Call SetColor(COLOR_BTNFACE, Value)
End Property

Public Property Get ButtonShadow() As Long
    ' 3D shading of button system color.
    ButtonShadow = GetSysColor(COLOR_BTNSHADOW)
End Property

Public Property Let ButtonShadow(Value As Long)
    ' 3D shading of button system color.
    Call SetColor(COLOR_BTNSHADOW, Value)
End Property

Public Property Get GrayText() As Long
    ' Gray text, or zero if dithering is used system color.
    GrayText = GetSysColor(COLOR_GRAYTEXT)
End Property

Public Property Let GrayText(Value As Long)
    ' Gray text, or zero if dithering is used system color.
    Call SetColor(COLOR_GRAYTEXT, Value)
End Property

Public Property Get ButtonText() As Long
    ' Button text system color.
    ButtonText = GetSysColor(COLOR_BTNTEXT)
End Property

Public Property Let ButtonText(Value As Long)
    ' Button text system color.
    Call SetColor(COLOR_BTNTEXT, Value)
End Property

Public Property Get InactiveCaptionText() As Long
    ' Text of inactive window system color.
    InactiveCaptionText = GetSysColor(COLOR_INACTIVECAPTIONTEXT)
End Property

Public Property Let InactiveCaptionText(Value As Long)
    ' Text of inactive window system color.
    Call SetColor(COLOR_INACTIVECAPTIONTEXT, Value)
End Property

Public Property Get ButtonHighlight() As Long
    ' 3D highlight of button system color.
    ButtonHighlight = GetSysColor(COLOR_BTNHIGHLIGHT)
End Property

Public Property Let ButtonHighlight(Value As Long)
    ' 3D highlight of button system color.
    Call SetColor(COLOR_BTNHIGHLIGHT, Value)
End Property

Public Property Get DarkShadow3D() As Long
    ' 3D dark shadow  system color.
    DarkShadow3D = GetSysColor(COLOR_3DDKSHADOW)
End Property

Public Property Let DarkShadow3D(Value As Long)
    ' 3D dark shadow  system color.
    Call SetColor(COLOR_3DDKSHADOW, Value)
End Property

Public Property Get Light3D() As Long
    ' Light color for 3D shaded objects.
    Light3D = GetSysColor(COLOR_3DLIGHT)
End Property

Public Property Let Light3D(Value As Long)
    ' Light color for 3D shaded objects .
    Call SetColor(COLOR_3DLIGHT, Value)
End Property

Public Property Get TooltipText() As Long
    ' Tooltip text system color.
    TooltipText = GetSysColor(COLOR_INFOTEXT)
End Property

Public Property Let TooltipText(Value As Long)
    ' Tooltip text system color.
    Call SetColor(COLOR_INFOTEXT, Value)
End Property

Public Property Get TooltipBackground() As Long
    ' Tooltip background color system color.
    TooltipBackground = GetSysColor(COLOR_INFOBK)
End Property

Public Property Let TooltipBackground(Value As Long)
    ' Tooltip background color system color.
    Call SetColor(COLOR_INFOBK, Value)
End Property

Private Sub SetColor(lngID As Long, lngValue As Long)
    Call SetSysColors(1, lngID, lngValue)
End Sub

Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, "SystemColors", .Description, .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "SystemColors", ERR_STRING
            End If
        End If
    End With
End Sub

Private Sub Class_Initialize()
    Dim blnIsWin2000 As Boolean
    Dim blnIsWin98 As Boolean

    Const VER_PLATFORM_WIN32_NT = 2
    Const VER_PLATFORM_WIN32_WINDOWS = 1
      
    ' Set the flag to true so that an error is raised
    ' if a non-applicable Public Property is used for a particular
    ' operating system
    RaiseErrors = True
    
    ' First find out the version of the OS
    osvi.dwOSVersionInfoSize = Len(osvi)
    If CBool(GetVersionEx(osvi)) Then
        With osvi
            ' if it's Win98 or Win2000 then
            ' Winver = 5
            blnIsWin2000 = (.dwPlatformId = VER_PLATFORM_WIN32_NT And .dwMajorVersion = 5)
            blnIsWin98 = (.dwMajorVersion = 4 And _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And .dwMinorVersion > 0))
            If blnIsWin98 Or blnIsWin2000 Then
                mlngWINVER = 5&
            End If
        End With
    End If
        
End Sub


