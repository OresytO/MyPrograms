VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ScreenInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' ScreenInfo class.
' Set and retrieve information about the Windows screen.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Declare Function GetSystemMetrics _
 Lib "user32" _
 (ByVal nIndex As Long) As Long

Private Const SM_CXSCREEN = 0
Private Const SM_CYSCREEN = 1
Private Const SM_CYCAPTION = 4
Private Const SM_CXBORDER = 5
Private Const SM_CYBORDER = 6
Private Const SM_CXVSCROLL = 2
Private Const SM_CYHSCROLL = 3
Private Const SM_CXDLGFRAME = 7
Private Const SM_CYDLGFRAME = 8
Private Const SM_CXFIXEDFRAME = SM_CXDLGFRAME
Private Const SM_CYFIXEDFRAME = SM_CYDLGFRAME
Private Const SM_CYVTHUMB = 9
Private Const SM_CXHTHUMB = 10
Private Const SM_CXICON = 11
Private Const SM_CYICON = 12
Private Const SM_CYMENU = 15
Private Const SM_CXFULLSCREEN = 16
Private Const SM_CYFULLSCREEN = 17
Private Const SM_CYKANJIWINDOW = 18
Private Const SM_CYVSCROLL = 20
Private Const SM_CXHSCROLL = 21
Private Const SM_CXMIN = 28
Private Const SM_CYMIN = 29
Private Const SM_CXSIZE = 30
Private Const SM_CYSIZE = 31
Private Const SM_CXFRAME = 32
Private Const SM_CYFRAME = 33
Private Const SM_CXSIZEFRAME = SM_CXFRAME
Private Const SM_CYSIZEFRAME = SM_CYFRAME
Private Const SM_CXMINTRACK = 34
Private Const SM_CYMINTRACK = 35
Private Const SM_CXICONSPACING = 38
Private Const SM_CYICONSPACING = 39
Private Const SM_MENUDROPALIGNMENT = 40
Private Const SM_PENWINDOWS = 41
Private Const SM_CXEDGE = 45
Private Const SM_CYEDGE = 46
Private Const SM_CXMINSPACING = 47
Private Const SM_CYMINSPACING = 48
Private Const SM_CXSMICON = 49
Private Const SM_CYSMICON = 50
Private Const SM_CYSMCAPTION = 51
Private Const SM_CXSMSIZE = 52
Private Const SM_CYSMSIZE = 53
Private Const SM_CXMENUSIZE = 54
Private Const SM_CYMENUSIZE = 55
Private Const SM_ARRANGE = 56
Private Const SM_CXMINIMIZED = 57
Private Const SM_CYMINIMIZED = 58
Private Const SM_CXMAXTRACK = 59
Private Const SM_CYMAXTRACK = 60
Private Const SM_CXMAXIMIZED = 61
Private Const SM_CYMAXIMIZED = 62
Private Const SM_CXMENUCHECK = 71
Private Const SM_CYMENUCHECK = 72
Private Const SM_XVIRTUALSCREEN = 76
Private Const SM_YVIRTUALSCREEN = 77
Private Const SM_CXVIRTUALSCREEN = 78
Private Const SM_CYVIRTUALSCREEN = 79
Private Const SM_CMONITORS = 80
Private Const SM_SAMEDISPLAYFORMAT = 81

Private Declare Function SystemParametersInfo _
 Lib "user32" Alias "SystemParametersInfoA" _
 (ByVal uAction As Long, ByVal uParam As Long, _
 lpvParam As Any, ByVal fuWinIni As Long) As Long
 
' SystemParametersInfo flags
Private Const SPIF_UPDATEINIFILE = &H1
Private Const SPIF_SENDWININICHANGE = &H2

' This is a made-up constant.
Private Const SPIF_TELLALL = SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE

Private Const SPI_GETBORDER = 5
Private Const SPI_SETBORDER = 6
Private Const SPI_GETANIMATION = 72
Private Const SPI_SETANIMATION = 73
Private Const SPI_SETDESKPATTERN = 21
Private Const SPI_SETDRAGFULLWINDOWS = 37
Private Const SPI_GETDRAGFULLWINDOWS = 38
Private Const SPI_GETGRIDGRANULARITY = 18
Private Const SPI_SETGRIDGRANULARITY = 19
Private Const SPI_ICONHORIZONTALSPACING = 13
Private Const SPI_ICONVERTICALSPACING = 24
Private Const SPI_GETICONTITLEWRAP = 25
Private Const SPI_SETICONTITLEWRAP = 26
Private Const SPI_GETICONTITLELOGFONT = 31
Private Const SPI_GETICONMETRICS = 45
Private Const SPI_SETICONMETRICS = 46
Private Const SPI_SETICONTITLELOGFONT = 34
Private Const SPI_GETMENUDROPALIGNMENT = 27
Private Const SPI_SETMENUDROPALIGNMENT = 28
Private Const SPI_SETWORKAREA = 47
Private Const SPI_GETWORKAREA = 48
Private Const SPI_GETDESKWALLPAPER = 115
Private Const SPI_SETDESKWALLPAPER = 20
Private Const SPI_GETMENUANIMATION = &H1002
Private Const SPI_SETMENUANIMATION = &H1003
Private Const SPI_GETMENUFADE = &H1012
Private Const SPI_SETMENUFADE = &H1013
Private Const SPI_GETCOMBOBOXANIMATION = &H1004
Private Const SPI_SETCOMBOBOXANIMATION = &H1005
Private Const SPI_GETLISTBOXSMOOTHSCROLLING = &H1006
Private Const SPI_SETLISTBOXSMOOTHSCROLLING = &H1007
Private Const SPI_GETGRADIENTCAPTIONS = &H1008
Private Const SPI_SETGRADIENTCAPTIONS = &H1009
Private Const SPI_GETKEYBOARDCUES = &H100A
Private Const SPI_SETKEYBOARDCUES = &H100B
Private Const SPI_GETMENUUNDERLINES = SPI_GETKEYBOARDCUES
Private Const SPI_SETMENUUNDERLINES = SPI_SETKEYBOARDCUES
Private Const SPI_GETHOTTRACKING = &H100E
Private Const SPI_SETHOTTRACKING = &H100F
Private Const SPI_GETSELECTIONFADE = &H1014
Private Const SPI_SETSELECTIONFADE = &H1015
Private Const SPI_GETTOOLTIPANIMATION = &H1016
Private Const SPI_SETTOOLTIPANIMATION = &H1017
Private Const SPI_GETTOOLTIPFADE = &H1018
Private Const SPI_SETTOOLTIPFADE = &H1019
Private Const SPI_GETUIEFFECTS = &H103E
Private Const SPI_SETUIEFFECTS = &H103F
Private Const SPI_GETFOREGROUNDLOCKTIMEOUT = &H2000
Private Const SPI_SETFOREGROUNDLOCKTIMEOUT = &H2001
Private Const SPI_GETFOREGROUNDFLASHCOUNT = &H2004
Private Const SPI_SETFOREGROUNDFLASHCOUNT = &H2005

' ICONMETRICS Information
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

Private Type ICONMETRICS
       cbSize As Long
       iHorzSpacing As Long
       iVertSpacing As Long
       iTitleWrap As Long
       lfFont As LogFont
End Type

Private Type RECT   '  16  Bytes
     Left As Long
     top As Long
     right As Long
     bottom As Long
End Type

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

Private Type ANIMATIONINFO
    cbSize As Long
    iMinAnimate As Long
End Type

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
Private mblnIsWin2000 As Boolean

Public Property Get DesktopWallpaper() As String
    ' Windows 2000: Retrieves the full path of the bitmap file for the desktop wallpaper.
    Dim strPath As String
    If mblnIsWin2000 Then
        strPath = String$(260, vbNullChar)
        Call SystemParametersInfo(SPI_GETDESKWALLPAPER, Len(strPath), ByVal strPath, 0)
        DesktopWallpaper = dhTrimNull(strPath)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let DesktopWallpaper(BitmapFileName As String)
    Call SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, ByVal BitmapFileName, SPIF_TELLALL)
End Property

Public Property Get MenuAnimation() As Boolean
    ' Windows 98, Windows 2000: Indicates whether the menu animation feature is enabled.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETMENUANIMATION, 0, lngState, 0)
        MenuAnimation = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let MenuAnimation(State As Boolean)
    ' Windows 98, Windows 2000: Enables or disables menu animation.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETMENUANIMATION, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get MenuFade() As Boolean
    ' Windows 2000: Indicates whether menu fade animation is enabled.
    Dim lngState As Long
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_GETMENUFADE, 0, lngState, 0)
        MenuFade = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let MenuFade(State As Boolean)
    ' Windows 2000: Enables or disables menu fade animation.
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_SETMENUFADE, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ComboBoxAnimation() As Boolean
    ' Windows 98, Windows 2000: Indicates whether the slide-open effect for combo boxes is enabled.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETCOMBOBOXANIMATION, 0, lngState, 0)
        ComboBoxAnimation = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ComboBoxAnimation(State As Boolean)
    ' Windows 98, Windows 2000: : Enables or disables the slide-open effect for combo boxes
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETCOMBOBOXANIMATION, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ListboxSmoothScrolling() As Boolean
    ' Windows 98, Windows 2000: Indicates whether the smooth-scrolling effect for list boxes is enabled.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETLISTBOXSMOOTHSCROLLING, 0, lngState, 0)
        ListboxSmoothScrolling = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ListboxSmoothScrolling(State As Boolean)
    ' Windows 98, Windows 2000: Enables or disables the the smooth-scrolling effect for list boxes
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETLISTBOXSMOOTHSCROLLING, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get GradientCaptions() As Boolean
    ' Windows 98, Windows 2000: Indicates whether the gradient effect for window title bars is enabled.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETGRADIENTCAPTIONS, 0, lngState, 0)
        GradientCaptions = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let GradientCaptions(State As Boolean)
    ' Windows 98, Windows 2000: Enables or disables the gradient effect for window title bars.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETGRADIENTCAPTIONS, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get MenuKeysAlwaysUnderlined() As Boolean
    ' Windows 98, Windows 2000: Indicates whether menu access keys are always underlined.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETKEYBOARDCUES, 0, lngState, 0)
        MenuKeysAlwaysUnderlined = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let MenuKeysAlwaysUnderlined(State As Boolean)
    ' Windows 98, Windows 2000: Enables or disables the underlining of menu access keys.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETKEYBOARDCUES, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get HotTracking() As Boolean
    ' Windows 98, Windows 2000: Indicates whether hot tracking of user-interface elements,
    ' such as menu names on menu bars, is enabled.
    ' Hot tracking means that when the cursor moves over an item, it is highlighted but not selected.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETHOTTRACKING, 0, lngState, 0)
        HotTracking = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let HotTracking(State As Boolean)
    ' Windows 98, Windows 2000: Enables or disables the hot tracking of user-interface elements
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETHOTTRACKING, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property
 
 Public Property Get SelectionFade() As Boolean
    ' Windows 2000: Indicates whether the selection fade effect is enabled.
    ' The selection fade effect causes the menu item selected by the user to remain on the screen
    ' briefly while fading out after the menu is dismissed.
    Dim lngState As Long
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_GETSELECTIONFADE, 0, lngState, 0)
        SelectionFade = CBool(lngState)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let SelectionFade(State As Boolean)
    ' Windows 2000: Enables or disables the selection fade effect
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_SETSELECTIONFADE, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property
 
Public Property Get TooltipAnimation() As Boolean
    ' Windows 2000: Indicates whether ToolTip animation is enabled.
    Dim lngState As Long
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_GETTOOLTIPANIMATION, 0, lngState, 0)
        TooltipAnimation = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let TooltipAnimation(State As Boolean)
    ' Windows 2000: Enables or disables Tooltip Animation effect
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_SETTOOLTIPANIMATION, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property
 
Public Property Get TooltipFade() As Boolean
    ' Windows 2000: indicates whether ToolTip animation uses a fade effect or a slide effect.
    Dim lngState As Long
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_GETTOOLTIPFADE, 0, lngState, 0)
        TooltipFade = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let TooltipFade(State As Boolean)
    ' Windows 2000: Enables or disables fade effect or slide effect of  ToolTip animation
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_SETTOOLTIPFADE, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get UIEffects() As Boolean
    ' Windows 2000: Indicates whether all UI effects are disabled or not.
    Dim lngState As Long
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_GETUIEFFECTS, 0, lngState, 0)
        UIEffects = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let UIEffects(State As Boolean)
    ' Windows 2000: Enables or disables all UI effects
    If mblnIsWin2000 Then
        Call SystemParametersInfo(SPI_SETUIEFFECTS, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property
 
Public Property Get ForegroundLockTimeOut() As Long
    ' Windows 98, Windows 2000: Indicates the amount of time following user input, in milliseconds,
    ' during which the system will not allow applications to force themselves into the foreground.
    Dim lngDelay As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, lngDelay, 0)
        ForegroundLockTimeOut = lngDelay
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ForegroundLockTimeOut(MilliSecs As Long)
    ' Windows 2000: Sets the amount of time following user input, in milliseconds, during which
    ' the system will not allow applications to force themselves into the foreground.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, ByVal MilliSecs, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ForegroundFlashCount() As Long
    ' Windows 98, Windows 2000: Indicates the number of times SetForegroundWindow will flash
    ' the taskbar button when rejecting a foreground switch request.
    Dim lngCount As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETFOREGROUNDFLASHCOUNT, 0, lngCount, 0)
        ForegroundFlashCount = lngCount
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ForegroundFlashCount(Count As Long)
    ' Windows 98, Windows 2000: Sets the number of times SetForegroundWindow will flash the
    ' taskbar button when rejecting a foreground switch request.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETFOREGROUNDFLASHCOUNT, 0, ByVal Count, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property
 
 Public Property Get ScreenX() As Long
    ' Width of the screen, in pixels.
    ScreenX = GetSystemMetrics(SM_CXSCREEN)
End Property

Public Property Get ScreenY() As Long
    ' Height of the screen, in pixels.
    ScreenY = GetSystemMetrics(SM_CYSCREEN)
End Property

Public Property Get IconSizeX() As Long
    ' Default width, in pixels, fo an icon.
    IconSizeX = GetSystemMetrics(SM_CXICON)
End Property

Public Property Get IconSizeY() As Long
    ' Default height, in pixels, fo an icon.
    IconSizeY = GetSystemMetrics(SM_CYICON)
End Property

Public Property Get CaptionBarButtonX() As Long
    ' Width in pixels, of a button in a window's caption or title bar.
    CaptionBarButtonX = GetSystemMetrics(SM_CXSIZE)
End Property

Public Property Get CaptionBarButtonY() As Long
    ' height, in pixels, of a button in a window's caption or title bar.
    CaptionBarButtonY = GetSystemMetrics(SM_CYSIZE)
End Property

Public Property Get FullScreenX() As Long
    ' Width of the inside area of a full-screen window.
    ' Use spi.GetWorkArea to get the portion of the screen
    ' not obscured by docked trays.
    FullScreenX = GetSystemMetrics(SM_CXFULLSCREEN)
End Property

Public Property Get FullScreenY() As Long
    ' Height of the inside area of a full-screen window.
    ' Use spi.GetWorkArea to get the portion of the screen
    ' not obscured by docked trays.
    FullScreenY = GetSystemMetrics(SM_CYFULLSCREEN)
End Property

Public Property Get IconSpacingX() As Long
    ' Width, in pixels, of grid cells for items in large icon view.
    IconSpacingX = GetSystemMetrics(SM_CXICONSPACING)
End Property

Public Property Get IconSpacingY() As Long
    ' Height, in pixels, of grid cells for items in large icon view.
    IconSpacingY = GetSystemMetrics(SM_CYICONSPACING)
End Property

Public Property Get MaximizedX() As Long
    ' Width, in pixels, of a maximized top-level window.
    MaximizedX = GetSystemMetrics(SM_CXMAXIMIZED)
End Property

Public Property Get MaximizedY() As Long
    ' Height, in pixels, of a maximized top-level window.
    MaximizedY = GetSystemMetrics(SM_CYMAXIMIZED)
End Property

Public Property Get MaxTrackX() As Long
    ' Default maximum width, in pixels,
    ' of a window that has a caption and sizing borders.
    MaxTrackX = GetSystemMetrics(SM_CXMAXTRACK)
End Property

Public Property Get MaxTrackY() As Long
    ' Default maximum height, in pixels, of a window
    ' that has a caption and sizing borders.
    MaxTrackY = GetSystemMetrics(SM_CYMAXTRACK)
End Property

Public Property Get MenuCheckX() As Long
    ' Width, in pixels, of the default menu check-mark bitmap.
    MenuCheckX = GetSystemMetrics(SM_CXMENUCHECK)
End Property

Public Property Get MenuCheckY() As Long
    ' Height, in pixels, of the default menu check-mark bitmap.
    MenuCheckY = GetSystemMetrics(SM_CYMENUCHECK)
End Property

Public Property Get MinimumX() As Long
    ' Minimum width, in pixels, of a window.
    MinimumX = GetSystemMetrics(SM_CXMIN)
End Property

Public Property Get MinimumY() As Long
    ' Minimum height, in pixels, of a window.
    MinimumY = GetSystemMetrics(SM_CYMIN)
End Property

Public Property Get MinimizedX() As Long
    ' Width, in pixels, of a normal, minimized window.
    MinimizedX = GetSystemMetrics(SM_CXMINIMIZED)
End Property

Public Property Get MinimizedY() As Long
    ' Height, in pixels, of a normal, minimized window.
    MinimizedY = GetSystemMetrics(SM_CYMINIMIZED)
End Property

Public Property Get MinSpacingX() As Long
    ' Width, in pixels, of a grid cell for minimized windows.
    MinSpacingX = GetSystemMetrics(SM_CXMINSPACING)
End Property

Public Property Get MinSpacingY() As Long
    ' Height, in pixels, of a grid cell for minimized windows.
    MinSpacingY = GetSystemMetrics(SM_CYMINSPACING)
End Property

Public Property Get MinTrackX() As Long
    ' Minimum tracking width, in pixels, of a window.
    MinTrackX = GetSystemMetrics(SM_CXMINTRACK)
End Property

Public Property Get MinTrackY() As Long
    ' Minimum tracking height, in pixels, of a window.
    MinTrackY = GetSystemMetrics(SM_CYMINTRACK)
End Property

Public Property Get PenWindows() As Boolean
    ' True if Microsoft Windows for Pen computing extensions are installed
    ' False otherwise
    PenWindows = CBool(GetSystemMetrics(SM_PENWINDOWS))
End Property

Public Property Get VirtualScreenX() As Long
    ' Windows 98, Windows 2000:
    ' Coordinates for the left side of the virtual screen.
    ' The virtual screen is the bounding rectangle of all display monitors.
    If mlngWINVER >= 5& Then
        VirtualScreenX = GetSystemMetrics(SM_XVIRTUALSCREEN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get VirtualScreenY() As Long
    ' Windows 98, Windows 2000:
    ' Coordinates for the top of the virtual screen.
    ' The virtual screen is the bounding rectangle of all display monitors.
    If mlngWINVER >= 5& Then
        VirtualScreenY = GetSystemMetrics(SM_CYVIRTUALSCREEN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get VirtualScreenWidth() As Long
    ' Windows 98, Windows 2000:
    ' Width, in pixels, of the virtual screen. The virtual screen
    ' is the bounding rectangle of all display monitors
    If mlngWINVER >= 5& Then
        VirtualScreenWidth = GetSystemMetrics(SM_CXVIRTUALSCREEN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get VirtualScreenHeight() As Long
    ' Windows 98, Windows 2000:
    ' Height, in pixels, of the virtual screen. The virtual screen
    ' is the bounding rectangle of all display monitors
    If mlngWINVER >= 5& Then
        VirtualScreenHeight = GetSystemMetrics(SM_CYVIRTUALSCREEN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get MonitorCount() As Long
    ' Windows 98, Windows 2000:
    ' Number of display monitors on the desktop.
    If mlngWINVER >= 5& Then
        MonitorCount = GetSystemMetrics(SM_CMONITORS)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get SameDisplayFormat() As Boolean
    ' Windows 98, Windows 2000:
    ' True if all the display monitors have the same color format, False otherwise.
    ' Note that two displays can have the same bit depth, but different color formats.
    ' For example, the red, green, and blue pixels can be encoded with different
    ' numbers of bits, or those bits can be located in different places
    ' in a pixel's color value.
    If mlngWINVER >= 5& Then
        SameDisplayFormat = CBool(GetSystemMetrics(SM_SAMEDISPLAYFORMAT))
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

 Public Property Get SmallIconX() As Long
    ' Recommended width for a small icon.
    SmallIconX = GetSystemMetrics(SM_CXSMICON)
End Property

Public Property Get SmallIconY() As Long
    ' Recommended height for a small icon.
    SmallIconY = GetSystemMetrics(SM_CYSMICON)
End Property

Public Property Get KanjiWindow() As Long
    ' For DBCS versions of Windows, height in pixels of the
    ' Kanji window.
    KanjiWindow = GetSystemMetrics(SM_CYKANJIWINDOW)
End Property

Public Property Get CaptionHeight() As Long

    ' Height, in pixels, of normal caption bar.
    CaptionHeight = GetSystemMetrics(SM_CYCAPTION)
End Property

Public Property Get WindowBorderX() As Long
    ' Width in pixels, of a window border
    WindowBorderX = GetSystemMetrics(SM_CXBORDER)
End Property

Public Property Get WindowBorderY() As Long
    ' Height in pixels, of a window border
    WindowBorderY = GetSystemMetrics(SM_CYBORDER)
End Property

Public Property Get VerticalScrollX() As Long
    ' Width, in pixels, of a vertical scroll bar
    VerticalScrollX = GetSystemMetrics(SM_CXVSCROLL)
End Property

Public Property Get VerticalScrollY() As Long
    ' height, in pixels, of the arrow bitmap on a vertical scroll bar.
    VerticalScrollY = GetSystemMetrics(SM_CYVSCROLL)
End Property

Public Property Get HorizontalScrollX() As Long
    ' Width, in pixels, of the arrow bitmap on a horizontal scroll bar
    HorizontalScrollX = GetSystemMetrics(SM_CXHSCROLL)
End Property

Public Property Get HorizontalScrollY() As Long
    ' height, in pixels, of a horizontal scroll bar
    HorizontalScrollY = GetSystemMetrics(SM_CYHSCROLL)
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

Public Property Get ThumbX() As Long
    ' Width, in pixels, of the thumb box in a horizontal scroll bar.
    ThumbX = GetSystemMetrics(SM_CXHTHUMB)
End Property

Public Property Get ThumbY() As Long
    ' Height, in pixels, of the thumb box in a vertical scroll bar.
    ThumbY = GetSystemMetrics(SM_CYVTHUMB)
End Property

Public Property Get MenuHeight() As Long
    ' Height, in pixels, of normal single-line menu.
    MenuHeight = GetSystemMetrics(SM_CYMENU)
End Property

Public Property Get SizingBorderX() As Long
    ' width of the horizontal border, in pixels, around the
    ' perimeter of a window that can be resized.
    SizingBorderX = GetSystemMetrics(SM_CXSIZEFRAME)
End Property

Public Property Get SizingBorderY() As Long
    ' height of the vertical border, in pixels, around the
    ' perimeter of a window that can be resized.
    SizingBorderY = GetSystemMetrics(SM_CYSIZEFRAME)
End Property

Public Property Get Border3DX() As Long
    ' Width, in pixels, of a 3-D border.
    Border3DX = GetSystemMetrics(SM_CXEDGE)
End Property

Public Property Get Border3DY() As Long
    ' Height, in pixels, of a 3-D border.
    Border3DY = GetSystemMetrics(SM_CYEDGE)
End Property

Public Property Get SmallCaption() As Long
    ' Height, in pixels, of a small caption bar.
    SmallCaption = GetSystemMetrics(SM_CYSMCAPTION)
End Property

Public Property Get CaptionButtonX() As Long
    ' Width, in pixels, of small caption buttons
    CaptionButtonX = GetSystemMetrics(SM_CXSMSIZE)
End Property

Public Property Get CaptionButtonY() As Long
    ' Height, in pixels, of small caption buttons
    CaptionButtonY = GetSystemMetrics(SM_CYSMSIZE)
End Property

Public Property Get MenuBarButtonsX() As Long
    '  Width, in pixels, of menu bar buttons, such as the
    '  child window close button.
    MenuBarButtonsX = GetSystemMetrics(SM_CXMENUSIZE)
End Property

Public Property Get MenuBarButtonsY() As Long
    '  Height, in pixels, of menu bar buttons, such as the
    '  child window close button.
    MenuBarButtonsY = GetSystemMetrics(SM_CYMENUSIZE)
End Property

Public Property Get BorderMultiplier() As Long
    ' Retrieves the border multiplier factor that determines the width
    ' of a window's sizing border.
    Dim lngFactor As Long
    Call SystemParametersInfo(SPI_GETBORDER, 0, lngFactor, 0)
    BorderMultiplier = lngFactor
End Property

Public Property Let BorderMultiplier(Value As Long)
    ' Sets the border multiplier factor that determines the width
    ' of a window's sizing border. The uiParam parameter specifies the new value.
    Call SystemParametersInfo(SPI_SETBORDER, Value, ByVal 0&, SPIF_TELLALL)
End Property

Public Property Get MinAnimation() As Boolean
    ' Sets or returns the state of minimize animation.
    Dim ai As ANIMATIONINFO
    
    ai.cbSize = Len(ai)
    Call SystemParametersInfo( _
     SPI_GETANIMATION, ai.cbSize, ai, 0)
    MinAnimation = ai.iMinAnimate
End Property

Public Property Let MinAnimation(Animate As Boolean)
    ' Sets or returns the state of minimize animation.
    Dim ai As ANIMATIONINFO
    
    ai.cbSize = Len(ai)
    ai.iMinAnimate = CLng(Animate)
    Call SystemParametersInfo(SPI_SETANIMATION, ai.cbSize, ai, SPIF_TELLALL)
End Property

Public Sub SetDeskPattern()
    ' Sets the current desktop pattern by causing Windows to read the
    ' Pattern= setting from the WIN.INI file. To get desktop pattern, look in:
    ' HKCU\Control Panel\Desktop\Pattern
    Call SystemParametersInfo(SPI_SETDESKPATTERN, 0, 0, 0)
End Sub

Public Property Get DragFullWindows() As Boolean
    ' Determines whether dragging of full windows is enabled.
    Dim fDragOn As Boolean
    Call SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, fDragOn, 0)
    DragFullWindows = fDragOn
End Property

Public Property Let DragFullWindows(DragOn As Boolean)
    ' Determines whether dragging of full windows is enabled.
    Call SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, DragOn, 0, SPIF_TELLALL)
End Property

Public Property Let GridGranularity(Value As Long)
    ' Set the current granularity value of the desktop sizing grid.
    Call SystemParametersInfo(SPI_SETGRIDGRANULARITY, Value, 0, SPIF_TELLALL)
End Property

Public Property Get GridGranularity() As Long
    ' Get the current granularity value of the desktop sizing grid.
    Dim lngValue As Integer
    
    Call SystemParametersInfo(SPI_GETGRIDGRANULARITY, 0, lngValue, 0)
    GridGranularity = lngValue
End Property

Public Property Get IconHorizontalSpacing() As Long
    ' Gets the width of an icon cell.
    IconHorizontalSpacing = GetSystemMetrics(SM_CXICONSPACING)
End Property

Public Property Let IconHorizontalSpacing(Value As Long)
    ' Sets the width of an icon cell.
    Call SystemParametersInfo(SPI_ICONHORIZONTALSPACING, Value, 0, SPIF_TELLALL)
End Property

Public Property Get IconVerticalSpacing() As Long
    ' Gets the height of an icon cell.
    IconVerticalSpacing = GetSystemMetrics(SM_CYICONSPACING)
End Property

Public Property Let IconVerticalSpacing(Value As Long)
    ' Sets the height of an icon cell.
    Call SystemParametersInfo(SPI_ICONVERTICALSPACING, Value, 0, SPIF_TELLALL)
End Property

Public Property Get IconTitleWrap() As Boolean
    ' Turns icon-title wrapping on or off.
    Dim lngValue As Long
    Call SystemParametersInfo(SPI_GETICONTITLEWRAP, 0, lngValue, 0)
    IconTitleWrap = CBool(lngValue)
End Property

Public Property Let IconTitleWrap(Value As Boolean)
    ' Returns True if icon title-wrapping is on.
    Call SystemParametersInfo(SPI_SETICONTITLEWRAP, Value, 0, SPIF_TELLALL)
End Property

Public Property Get IconFontName() As String
    ' Retrieves the font name for icons.
    Dim lf As LogFont
    Dim varFont As Variant
    
    Call SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, lf, 0)
    ' lf.lfFaceName is a byte array. You need it converted
    ' into a string. Copy it to a variant, and
    ' then convert that ANSI string back to Unicode, cutting
    ' it off at the first Null character.
    varFont = lf.lfFaceName
    IconFontName = dhTrimNull(StrConv(varFont, vbUnicode))
End Property

Public Property Let IconFontName(Value As String)
    ' Sets the font name for icons.
    Dim im As ICONMETRICS
    Dim strFont As String
    Dim intI As Integer
    Dim intLen As Integer
    Dim abytTemp() As Byte
    
    intLen = Len(im)
    im.cbSize = intLen
    Call SystemParametersInfo(SPI_GETICONMETRICS, intLen, im, 0)
    abytTemp = StrConv(Value, vbFromUnicode)
    intLen = UBound(abytTemp) + 1
    
    ' Make sure the string isn't too long.
    If intLen > LF_FACESIZE - 1 Then
        intLen = LF_FACESIZE - 1
    End If
    For intI = 0 To intLen - 1
        im.lfFont.lfFaceName(intI) = abytTemp(intI)
    Next intI
    im.lfFont.lfFaceName(intI) = 0
    Call SystemParametersInfo(SPI_SETICONTITLELOGFONT, Len(im.lfFont), im.lfFont, SPIF_TELLALL)
End Property

Public Property Get IconFontSize() As Integer
    ' Retrieve the icon font size.
    Dim lf As LogFont
    Dim hDC As Long
    Dim lngLogPixelsY As Long
    
    hDC = CreateIC("DISPLAY", vbNullString, vbNullString, 0&)
    lngLogPixelsY = GetDeviceCaps(hDC, LOGPIXELSY)
    Call DeleteDC(hDC)
    
    Call SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, lf, 0)
    IconFontSize = -Int(lf.lfHeight * 72 / lngLogPixelsY)
End Property

Public Property Let IconFontSize(Value As Integer)
    ' Set the icon font size.
    Dim lf As LogFont
    Dim hDC As Long
    Dim lngLogPixelsY As Long
    Dim intSize As Integer
    
    hDC = CreateIC("DISPLAY", vbNullString, vbNullString, ByVal 0&)
    lngLogPixelsY = GetDeviceCaps(hDC, LOGPIXELSY)
    Call DeleteDC(hDC)
    
    Call SystemParametersInfo(SPI_GETICONTITLELOGFONT, 0, lf, 0)
    lf.lfHeight = -Int(Value * lngLogPixelsY / 72)
    Call SystemParametersInfo(SPI_SETICONTITLELOGFONT, Len(lf), lf, SPIF_TELLALL)
End Property

Public Property Let MenuDropAlignment(Value As Boolean)
    ' Sets the alignment value of pop-up menus. Specify
    ' TRUE for right alignment, or FALSE for left alignment.
   Call SystemParametersInfo(SPI_SETMENUDROPALIGNMENT, Value, 0, SPIF_TELLALL)
End Property

Public Property Get MenuDropAlignment() As Boolean
    ' Gets the alignment value of pop-up menus. The value will be
    ' TRUE for right alignment, or FALSE for left alignment.
    Dim lngValue As Long
    Call SystemParametersInfo(SPI_GETMENUDROPALIGNMENT, 0, lngValue, 0)
    MenuDropAlignment = lngValue
End Property

Public Sub GetWorkarea(ByRef Left As Long, ByRef top As Long, _
 ByRef right As Long, ByRef bottom As Long)
    ' Gets the size of the work area. The work area is the
    ' portion of the screen not obscured by the taskbar.
    Dim rct As RECT
    Call SystemParametersInfo(SPI_GETWORKAREA, 0, rct, 0)
    With rct
        Left = .Left
        top = .top
        right = .right
        bottom = .bottom
    End With
End Sub

Public Sub SetWorkArea( _
 Optional ByVal Left As Variant, _
 Optional ByVal top As Variant, _
 Optional ByVal right As Variant, _
 Optional ByVal bottom As Variant)
    ' Sets the size of the work area. The work area
    ' is the portion of the screen not obscured by the taskbar.
 
    Dim rct As RECT
    Call SystemParametersInfo(SPI_GETWORKAREA, 0, rct, 0)
    If Not IsMissing(Left) Then rct.Left = Left
    If Not IsMissing(top) Then rct.top = top
    If Not IsMissing(right) Then rct.right = right
    If Not IsMissing(bottom) Then rct.bottom = bottom
    Call SystemParametersInfo(SPI_SETWORKAREA, 0, rct, SPIF_TELLALL)
 End Sub

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

Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, "Screen", .Description, .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "Screen", ERR_STRING
            End If
        End If
    End With
End Sub

Private Sub Class_Initialize()
    Dim blnIsWinNT As Boolean
    Dim blnIsWin95 As Boolean
    Dim blnIsWin98 As Boolean
    
    Const VER_PLATFORM_WIN32_WINDOWS = 1
    Const VER_PLATFORM_WIN32_NT = 2
    
    ' Set the flag to true so that an error is raised
    ' if a non-applicable Public Property is used for a particular
    ' operating system
    RaiseErrors = True
    
    ' First find out the version of the OS
    osvi.dwOSVersionInfoSize = Len(osvi)
    If CBool(GetVersionEx(osvi)) Then
        With osvi
            mblnIsWin2000 = _
             (.dwPlatformId = VER_PLATFORM_WIN32_NT And _
             .dwMajorVersion = 5)
            blnIsWin98 = (.dwMajorVersion = 4 And _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And _
             .dwMinorVersion > 0))
            
            blnIsWinNT = _
             (.dwPlatformId = VER_PLATFORM_WIN32_NT And _
             .dwMajorVersion <= 4)
            blnIsWin95 = _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And _
             .dwMinorVersion = 0)
            
            If blnIsWin95 Or blnIsWinNT Then
                mlngWINVER = 4&
            ElseIf blnIsWin98 Or mblnIsWin2000 Then
                mlngWINVER = 5&
            End If
        End With
    End If
        
End Sub




