VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Mouse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Mouse class

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Const SM_CXCURSOR = 13
Private Const SM_CYCURSOR = 14
Private Const SM_MOUSEPRESENT = 19
Private Const SM_SWAPBUTTON = 23
Private Const SM_CXDOUBLECLK = 36
Private Const SM_CYDOUBLECLK = 37
Private Const SM_CMOUSEBUTTONS = 43
Private Const SM_CXDRAG = 68
Private Const SM_CYDRAG = 69
Private Const SM_MOUSEWHEELPRESENT = 75

Private Declare Function GetSystemMetrics _
 Lib "user32" _
 (ByVal nIndex As Long) As Long

Private Const SPI_GETMOUSE = 3
Private Const SPI_SETMOUSE = 4
Private Const SPI_SETDOUBLECLICKTIME = 32
Private Const SPI_SETDOUBLECLKWIDTH = 29
Private Const SPI_SETDOUBLECLKHEIGHT = 30
Private Const SPI_SETMOUSEBUTTONSWAP = 33
Private Const SPI_SETDRAGWIDTH = 76
Private Const SPI_SETDRAGHEIGHT = 77
Private Const SPI_SETMOUSETRAILS = 93
Private Const SPI_GETMOUSETRAILS = 94
Private Const SPI_GETSNAPTODEFBUTTON = 95
Private Const SPI_SETSNAPTODEFBUTTON = 96
Private Const SPI_GETWHEELSCROLLLINES = 104
Private Const SPI_SETWHEELSCROLLLINES = 105

Private Const SPI_GETACTIVEWINDOWTRACKING = &H1000
Private Const SPI_SETACTIVEWINDOWTRACKING = &H1001
Private Const SPI_GETACTIVEWNDTRKZORDER = &H100C
Private Const SPI_SETACTIVEWNDTRKZORDER = &H100D
Private Const SPI_GETCURSORSHADOW = &H101A
Private Const SPI_SETCURSORSHADOW = &H101B
Private Const SPI_GETACTIVEWNDTRKTIMEOUT = &H2002
Private Const SPI_SETACTIVEWNDTRKTIMEOUT = &H2003
Private Const SPI_GETCARETWIDTH = &H2006
Private Const SPI_SETCARETWIDTH = &H2007

Private Const SPI_GETMOUSEHOVERWIDTH = 98
Private Const SPI_SETMOUSEHOVERWIDTH = 99
Private Const SPI_GETMOUSEHOVERHEIGHT = 100
Private Const SPI_SETMOUSEHOVERHEIGHT = 101
Private Const SPI_GETMOUSEHOVERTIME = 102
Private Const SPI_SETMOUSEHOVERTIME = 103
Private Const SPI_GETMENUSHOWDELAY = 106
Private Const SPI_SETMENUSHOWDELAY = 107

' SystemParametersInfo flags
Private Const SPIF_UPDATEINIFILE = &H1
Private Const SPIF_SENDWININICHANGE = &H2

' This is a made-up constant.
Private Const SPIF_TELLALL = SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE

Private Declare Function SystemParametersInfo _
 Lib "user32" Alias "SystemParametersInfoA" _
 (ByVal uAction As Long, ByVal uParam As Long, _
 lpvParam As Any, ByVal fuWinIni As Long) As Long

Private Declare Function ShowCursor _
 Lib "user32" _
 (ByVal fShow As Long) As Long

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

' 5113 is arbitrary.
Private Const dhcErrBase = vbObjectError + 5113
Private Const ERR_STRING = "Invalid for this operating system."
Private Const ERR_INVALID_OS = dhcErrBase + 1

' Should this class raise errors if the
' operating system doesn't support the
' requested operation, or should it silently fail?
Public RaiseErrors As Boolean

Private mlngNT As Long
Private mlngWINDOWS As Long
Private mlngWINVER As Long
Private mblnIsWin95 As Boolean
Private mblnIsWin98 As Boolean

Public Property Get ActiveWindowTracking() As Boolean
    ' Windows 98, Windows 2000
    ' Indicates whether active window tracking
    ' (activating the window the mouse is on) is on or off.
    Dim lngState As Long
    
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETACTIVEWINDOWTRACKING, 0, lngState, 0)
        ActiveWindowTracking = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ActiveWindowTracking(State As Boolean)
    ' Windows 98, Windows 2000
    ' Sets active window tracking (activating the window the mouse is on)
    ' either on or off.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETACTIVEWINDOWTRACKING, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get TrackedWindowToTop() As Boolean
    ' Windows 98, Windows 2000
    ' Indicates whether windows activated through active window tracking
    ' will be brought to the top.
    Dim lngState As Long
    
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETACTIVEWNDTRKZORDER, 0, lngState, 0)
        TrackedWindowToTop = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let TrackedWindowToTop(State As Boolean)
    ' Windows 98, Windows 2000
    ' Enables or disables whether windows activated through active window tracking
    ' will be brought to the top.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETACTIVEWNDTRKZORDER, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ActiveWindowTrackingTimeOut() As Long
    ' Windows 98, Windows 2000
    ' Indicates the active window tracking delay, in milliseconds
    Dim lngDelay As Long
    
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETACTIVEWNDTRKTIMEOUT, 0, lngDelay, 0)
        ActiveWindowTrackingTimeOut = lngDelay
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ActiveWindowTrackingTimeOut(MilliSecs As Long)
    ' Windows 98, Windows 2000
    ' Sets the active window tracking delay.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETACTIVEWNDTRKTIMEOUT, 0, ByVal MilliSecs, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get CursorShadow() As Boolean
    ' Windows 98, Windows 2000
    ' Indicates whether the cursor has a shadow around it.
    Dim lngState As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETCURSORSHADOW, 0, lngState, 0)
        CursorShadow = CBool(lngState)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let CursorShadow(State As Boolean)
    ' Windows 98, Windows 2000
    ' Enables or disables a shadow around the cursor.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETCURSORSHADOW, 0, ByVal CLng(State), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get CaretWidth() As Long
    ' Windows 98, Windows 2000
    ' Indicates the caret width in edit controls.
    Dim lngWidth As Long
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_GETCARETWIDTH, 0, lngWidth, 0)
        CaretWidth = lngWidth
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let CaretWidth(PixelWidth As Long)
    ' Windows 98, Windows 2000
    ' Sets the caret width in edit controls.
    If mlngWINVER >= 5& Then
        Call SystemParametersInfo(SPI_SETCARETWIDTH, 0, ByVal CLng(PixelWidth), SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get HoverX() As Long
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Gets the width, in pixels, of the rectangle within
    ' which the mouse pointer has to stay for a Hover
    ' event to occur
    Dim lngWidth As Long
    If mlngNT >= 4& Or mlngWINDOWS > 4& Then
        Call SystemParametersInfo(SPI_GETMOUSEHOVERWIDTH, 0, lngWidth, 0)
        HoverX = lngWidth
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let HoverX(PixelWidth As Long)
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Sets the width, in pixels, of the rectangle  within
    ' which the mouse pointer has to stay for a Hover
    ' event to occur
    If mlngNT >= 4& Or mlngWINDOWS > 4& Then
        Call SystemParametersInfo(SPI_SETMOUSEHOVERWIDTH, PixelWidth, ByVal 0&, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get HoverY() As Long
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Gets the height, in pixels, of the rectangle within
    ' which the mouse pointer has to stay for a Hover
    ' event to occur
    Dim lngHeight As Long
    If mlngNT >= 4& Or mlngWINDOWS > 4& Then
        Call SystemParametersInfo(SPI_GETMOUSEHOVERHEIGHT, 0, lngHeight, 0)
        HoverY = lngHeight
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let HoverY(PixelHeight As Long)
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Sets the Height, in pixels, of the rectangle  within
    ' which the mouse pointer has to stay for a Hover
    ' event to occur
    If mlngNT >= 4& Or mlngWINDOWS > 4& Then
        Call SystemParametersInfo(SPI_SETMOUSEHOVERHEIGHT, PixelHeight, ByVal 0&, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get HoverDelay() As Long
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Gets the time, in milliseconds, that the mouse pointer has to stay
    ' in the hover rectangle for a Hover event to occur
    Dim lngDelay As Long
    If Not mblnIsWin95 Then
        Call SystemParametersInfo(SPI_GETMOUSEHOVERTIME, 0, lngDelay, 0)
        HoverDelay = lngDelay
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let HoverDelay(MilliSecs As Long)
    ' Windows NT 4.0, Windows 98, Windows 2000
    ' Sets the time, in milliseconds, that the mouse pointer has to stay
    ' in the hover rectangle for a Hover event to occur
    If Not mblnIsWin95 Then
        Call SystemParametersInfo(SPI_SETMOUSEHOVERTIME, MilliSecs, ByVal 0&, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get MenuDelay() As Long
    ' Indicates the time, in milliseconds, that the system waits before
    ' displaying a shortcut menu when the mouse cursor is over a submenu item.
    Dim lngDelay As Long
    Call SystemParametersInfo(SPI_GETMENUSHOWDELAY, 0, lngDelay, 0)
    MenuDelay = lngDelay
End Property

Public Property Let MenuDelay(MilliSecs As Long)
    ' Indicates the time, in milliseconds, that the system waits before
    ' displaying a shortcut menu when the mouse cursor is over a submenu item.
    Dim lngDelay As Long
    Call SystemParametersInfo(SPI_SETMENUSHOWDELAY, MilliSecs, ByVal 0&, 0)
End Property

Public Property Let CursorOn(Value As Boolean)
    ' Show or hide the mouse cursor.
    Call ShowCursor(Value)
End Property

Public Property Get MousePresent() As Boolean
    ' Returns True if a mouse is installed.
    MousePresent = CBool(GetSystemMetrics(SM_MOUSEPRESENT))
End Property

Public Property Get WheelPresent() As Boolean
    ' Only available on WinNT 4.x/Win98 or later
    ' Returns True if a wheel with a mouse is present.
    If Not mblnIsWin95 Then
        WheelPresent = CBool(GetSystemMetrics(SM_MOUSEWHEELPRESENT))
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get Buttons() As Long
    ' Retrieve the number of mouse buttons.
    Buttons = GetSystemMetrics(SM_CMOUSEBUTTONS)
End Property

Public Property Get CursorX() As Long
    ' Retrieve the width, in pixels, of a cursor.
    CursorX = GetSystemMetrics(SM_CXCURSOR)
End Property

Public Property Get CursorY() As Long
    ' Retrieve the height, in pixels, of a cursor.
    CursorY = GetSystemMetrics(SM_CYCURSOR)
End Property

Public Property Get DoubleClickX() As Long
     ' Width, in pixels, of the rectangle enclosing the
     ' location of the first mouse click in a double-click sequence.
     ' Second click must occur within the boundaries
     ' of this rectangle.
    DoubleClickX = GetSystemMetrics(SM_CXDOUBLECLK)
End Property

Public Property Let DoubleClickX(Width As Long)
     ' Width, in pixels, of the rectangle enclosing the
     ' location of the first mouse click in a double-click sequence.
     ' Second click must occur within the boundaries
     ' of this rectangle.
    Call SystemParametersInfo( _
     SPI_SETDOUBLECLKWIDTH, Width, 0, SPIF_TELLALL)
End Property

Public Property Get DoubleClickY() As Long
     ' Height, in pixels, of the rectangle enclosing the
     ' location of the first mouse click in a double-click sequence.
     ' Second click must occur within the boundaries
     ' of this rectangle.
    DoubleClickY = GetSystemMetrics(SM_CYDOUBLECLK)
End Property

Public Property Let DoubleClickY(Height As Long)
     ' Height, in pixels, of the rectangle enclosing the
     ' location of the first mouse click in a double-click sequence.
     ' Second click must occur within the boundaries
     ' of this rectangle.
    Call SystemParametersInfo(SPI_SETDOUBLECLKHEIGHT, Height, 0, SPIF_TELLALL)
End Property

Public Property Let DoubleClickTime(MilliSecs As Long)
    ' Number of milliseconds between clicks,
    ' indicating to Windows that you've double-clicked.
    ' Normal value is around 450 - 500
    ' To read double click time, look in:
    ' HKCU\Control Panel\Mouse\DoubleClickSpeed
    Call SystemParametersInfo(SPI_SETDOUBLECLICKTIME, MilliSecs, 0, SPIF_TELLALL)
End Property

Public Property Get DragX() As Long
    ' Width, in pixels, of a rectangle centered on a drag point
    ' to allow for limited movement of the mouse before the drag begins.
    DragX = GetSystemMetrics(SM_CXDRAG)
End Property

Public Property Let DragX(Width As Long)
    ' Width, in pixels, of a rectangle centered on a drag point
    ' to allow for limited movement of the mouse before the drag begins.
    Call SystemParametersInfo(SPI_SETDRAGWIDTH, Width, 0, SPIF_TELLALL)
End Property

Public Property Get DragY() As Long
    ' Height, in pixels, of a rectangle centered on a drag point
    ' to allow for limited movement of the mouse before the drag begins.
    DragY = GetSystemMetrics(SM_CYDRAG)
End Property

Public Property Let DragY(Height As Long)
    ' Height, in pixels, of a rectangle centered on a drag point
    ' to allow for limited movement of the mouse before the drag begins.
    Call SystemParametersInfo(SPI_SETDRAGHEIGHT, Height, 0, SPIF_TELLALL)
End Property

Public Property Get MouseSpeed() As Long
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    MouseSpeed = aintValues(2)
End Property

Public Property Let MouseSpeed(Value As Long)
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    ' Get the values, so you can set just one of them.
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    aintValues(2) = Value
    Call SystemParametersInfo(SPI_SETMOUSE, 0, aintValues(0), SPIF_TELLALL)
End Property

Public Property Get MouseThreshHold1() As Long
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    MouseThreshHold1 = aintValues(0)
End Property

Public Property Let MouseThreshHold1(Value As Long)
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    ' Get the values, so you can set just one of them.
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    aintValues(0) = Value
    Call SystemParametersInfo(SPI_SETMOUSE, 0, aintValues(0), SPIF_TELLALL)
End Property

Public Property Get MouseThreshHold2() As Long
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    MouseThreshHold2 = aintValues(1)
End Property

Public Property Let MouseThreshHold2(Value As Long)
    ' MouseSpeed, combined with MouseThreshHold1 and
    ' MouseThreshHold2, creates the real mouse speed.
    
    Dim aintValues(0 To 2) As Long
    ' Get the values, so you can set just one of them.
    Call SystemParametersInfo(SPI_GETMOUSE, 0, aintValues(0), 0)
    aintValues(1) = Value
    Call SystemParametersInfo(SPI_SETMOUSE, 0, aintValues(0), SPIF_TELLALL)
End Property

Public Property Get MouseButtonSwap() As Boolean
    ' Set or retrieve the swapped mouse buttons state
    ' (button1 is on the right).
    MouseButtonSwap = CBool(GetSystemMetrics(SM_SWAPBUTTON))
End Property

Public Property Let MouseButtonSwap(Value As Boolean)
    ' Set or retrieve the swapped mouse buttons state
    ' (button1 is on the right).
    Call SystemParametersInfo(SPI_SETMOUSEBUTTONSWAP, Value, 0, SPIF_TELLALL)
End Property

Public Property Get MouseTrails() As Long
    ' Control mouse trails. If the value is
    ' greater than 1, MouseTrails are on,
    ' and the higher the value, the more trails
    ' you get.
    ' Works only in Win95 and Win98.
    Dim lngValue As Long
    If mblnIsWin95 Or mblnIsWin98 Then
        Call SystemParametersInfo(SPI_GETMOUSETRAILS, 0, lngValue, 0)
        MouseTrails = lngValue
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let MouseTrails(Value As Long)
    ' Control mouse trails. If the value is
    ' greater than 1, MouseTrails are on,
    ' and the higher the value, the more trails
    ' you get.
    ' Works only in Win95 and Win98.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call SystemParametersInfo(SPI_SETMOUSETRAILS, Value, 0, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get SnapToDefault() As Boolean
    ' Works in Windows NT 4.0, Windows 98, Windows 2000
    ' Determines whether the snap-to-default-button
    ' feature is enabled. If enabled, the mouse cursor
    ' automatically moves to the default button,
    ' such as "OK" or "Apply", of a dialog box.
    Dim lngValue As Long
    If mlngWINDOWS >= 410& Or mlngNT >= 4& Then
        Call SystemParametersInfo(SPI_GETSNAPTODEFBUTTON, 0, lngValue, 0)
        SnapToDefault = CBool(lngValue)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let SnapToDefault(Value As Boolean)
    ' Works in Windows NT 4.0, Windows 98, Windows 2000
    ' Determines whether the snap-to-default-button
    ' feature is enabled. If enabled, the mouse cursor
    ' automatically moves to the default button,
    ' such as "OK" or "Apply", of a dialog box.
    If mlngWINDOWS >= 410& Or mlngNT >= 4& Then
        Call SystemParametersInfo(SPI_SETSNAPTODEFBUTTON, Value, 0, SPIF_TELLALL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get WheelScrollLines() As Long
    ' Works in Windows NT 4.0, Windows 98, Windows 2000
    ' Determine the number of lines scrolled with each
    ' click of the mouse wheel.
    Dim lngValue As Long
    If mlngWINDOWS >= 410& Or mlngNT >= 4& Then
        Call SystemParametersInfo( _
         SPI_GETWHEELSCROLLLINES, 0, lngValue, 0)
        WheelScrollLines = lngValue
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let WheelScrollLines(Value As Long)
    ' Works in Windows NT 4.0, Windows 98, Windows 2000
    ' Determine the number of lines scrolled with each
    ' click of the mouse wheel.
    ' Set to 0 to disable wheel scrolling.
    ' Set to -1 to cause a scroll to act
    ' like a click in the PageUp or PageDown regions of the
    ' scroll bar.
    If mlngWINDOWS >= 410& Or mlngNT >= 4& Then
        Call SystemParametersInfo( _
         SPI_SETWHEELSCROLLLINES, Value, 0, SPIF_TELLALL)
    End If
End Property

Private Sub Class_Initialize()
    Dim blnIsWin2000 As Boolean
    Dim blnIsWinNT As Boolean
    
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
            blnIsWin2000 = (.dwPlatformId = VER_PLATFORM_WIN32_NT And .dwMajorVersion = 5)
            mblnIsWin98 = (.dwMajorVersion = 4 And _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And .dwMinorVersion > 0))
            
            blnIsWinNT = (.dwPlatformId = VER_PLATFORM_WIN32_NT And .dwMajorVersion <= 4)
            mblnIsWin95 = (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And .dwMinorVersion = 0)
            
            If blnIsWinNT Then
                mlngNT = 4&
            End If
            If blnIsWin2000 Then
                mlngNT = 5&
            End If
            
            If mblnIsWin98 Then
                mlngWINDOWS = 410&
            End If
            
            If mblnIsWin95 Or blnIsWinNT Then
                mlngWINVER = 4&
            End If
            If mblnIsWin98 Or blnIsWin2000 Then
                mlngWINVER = 5&
            End If
        End With
    End If
        
End Sub


Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, "Mouse", .Description, .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "Mouse", ERR_STRING
            End If
        End If
    End With
End Sub



