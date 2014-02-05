VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Keyboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Keyboard support functions.
' NOTE: Setting the toggle states will NOT affect the
' keyboard lights. These changes merely affect the current
' process, not the entire machine.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Not all VBA implementations include this constant!
Private Const vbKeyScrollLock = 145

Private Const SPI_GETKEYBOARDDELAY = 22
Private Const SPI_SETKEYBOARDDELAY = 23
Private Const SPI_GETKEYBOARDSPEED = 10
Private Const SPI_SETKEYBOARDSPEED = 11

' SystemParametersInfo flags
Private Const SPIF_UPDATEINIFILE = &H1
Private Const SPIF_SENDWININICHANGE = &H2

Private Const KEYEVENTF_EXTENDEDKEY = &H1
Private Const KEYEVENTF_KEYUP = &H2

Private Declare Function SystemParametersInfo Lib "user32" _
 Alias "SystemParametersInfoA" (ByVal uAction As Long, _
 ByVal uParam As Long, lpvParam As Any, ByVal fuWinIni As Long) As Long

' This is a made-up constant.
Private Const SPIF_TELLALL = SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE

Private Declare Function HideCaret _
 Lib "user32" _
 (ByVal hwnd As Long) As Long
 
Private Declare Function ShowCaret _
 Lib "user32" _
 (ByVal hwnd As Long) As Long
 
Private Declare Function GetCaretBlinkTime _
 Lib "user32" _
 () As Long

Private Declare Function SetCaretBlinkTime _
 Lib "user32" _
 (ByVal wMSeconds As Long) As Long
 
Private Declare Function GetKeyState _
 Lib "user32" _
 (ByVal nVirtKey As Long) As Integer
 
Private Declare Function GetKeyboardState _
 Lib "user32" _
 (pbKeyState As Byte) As Long
 
Private Declare Function SetKeyboardState _
 Lib "user32" _
 (lppbKeyState As Byte) As Long
 
Private Declare Function GetKeyboardType _
 Lib "user32" _
 (ByVal nTypeFlag As Long) As Long

Private Declare Sub keybd_event Lib "user32" _
 (ByVal bVk As Byte, _
  ByVal bScan As Byte, _
  ByVal dwFlags As Long, ByVal dwExtraInfo As Long)

Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type

Private Declare Function GetVersionEx _
 Lib "kernel32" Alias "GetVersionExA" _
 (lpVersionInformation As Any) As Long

Private Const VER_PLATFORM_WIN32_NT = 2
Private Const VER_PLATFORM_WIN32_WINDOWS = 1
Private mblnIsWinNT As Boolean


Public Property Get KeyboardType() As Long
    ' Determine the type of keyboard on the system.
    ' 1   IBM PC/XT or compatible (83-key) keyboard
    ' 2   Olivetti "ICO" (102-key) keyboard
    ' 3   IBM PC/AT (84-key) or similar keyboard
    ' 4   IBM enhanced (101- or 102-key) keyboard
    ' 5   Nokia 1050 and similar keyboards
    ' 6   Nokia 9140 and similar keyboards
    ' 7   Japanese keyboard
    KeyboardType = GetKeyboardType(0)
End Property

Public Property Get FunctionKeys() As Long
    ' Determine the number of function keys on the keyboard.
    ' 1   10
    ' 2   12 (sometimes 18)
    ' 3   10
    ' 4   12
    ' 5   10
    ' 6   24
    ' 7   Hardware dependent and specified by the OEM
    FunctionKeys = GetKeyboardType(2)
End Property

Public Property Get Capslock() As Boolean
    ' Return or set the Capslock toggle.
    Capslock = CBool(GetKeyState(vbKeyCapital) And 1)
End Property

Public Property Get Numlock() As Boolean
    ' Return or set the Numlock toggle.
    Numlock = CBool(GetKeyState(vbKeyNumlock) And 1)
End Property

Public Property Get ScrollLock() As Boolean
    ' Return or set the ScrollLock toggle.
    ScrollLock = CBool(GetKeyState(vbKeyScrollLock) And 1)
End Property

Public Property Let Capslock(Value As Boolean)
    ' Return or set the Capslock toggle.
    If mblnIsWinNT Then
        ' Under NT/2000, you must send keystrokes
        ' through the keyboard buffer to toggle
        ' Capslock.
        
        ' Simulate Key Press
        keybd_event vbKeyCapital, 0, KEYEVENTF_EXTENDEDKEY, 0
        ' Simulate Key Release
        keybd_event vbKeyCapital, 0, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0
    Else
        Call SetKeyState(vbKeyCapital, Value)
    End If
End Property

Public Property Let Numlock(Value As Boolean)
    ' Return or set the Numlock toggle.
    
    If mblnIsWinNT Then
        ' Under NT/2000, you must send keystrokes
        ' through the keyboard buffer to toggle
        ' NumLock.
        
        ' Simulate Key Press
        keybd_event vbKeyNumlock, 0, _
         KEYEVENTF_EXTENDEDKEY, 0
        ' Simulate Key Release
        keybd_event vbKeyNumlock, 0, _
         KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0
    Else
        ' Under Win95/98, simply set the value in the keyboard.
        Call SetKeyState(vbKeyNumlock, Value)
    End If
End Property

Public Property Let ScrollLock(Value As Boolean)
    ' Return or set the ScrollLock toggle.
    If mblnIsWinNT Then
        ' Under NT/2000, you must send keystrokes
        ' through the keyboard buffer to toggle
        ' ScrollLock.
        
        ' Simulate Key Press
        keybd_event vbKeyScrollLock, 0, KEYEVENTF_EXTENDEDKEY, 0
        ' Simulate Key Release
        keybd_event vbKeyScrollLock, 0, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0
    Else
        Call SetKeyState(vbKeyScrollLock, Value)
    End If
End Property

Private Sub SetKeyState(intKey As Integer, fTurnOn As Boolean)
    ' Retrieve the keyboard state, set the particular
    ' key in which you're interested, and then set
    ' the entire keyboard state back the way it
    ' was, with the one key altered.
    Dim abytBuffer(0 To 255) As Byte
    GetKeyboardState abytBuffer(0)
    If fTurnOn Then
        abytBuffer(intKey) = abytBuffer(intKey) Or 1
    Else
        abytBuffer(intKey) = abytBuffer(intKey) And Not 1
    End If
    SetKeyboardState abytBuffer(0)
End Sub

Public Property Let Delay(Value As Long)
    ' Sets the keyboard repeat-delay setting.
    ' Only values 0 through 3 are acceptable. Others will be
    ' set back to 0.
    Call SystemParametersInfo(SPI_SETKEYBOARDDELAY, Value, 0, SPIF_TELLALL)
End Property

Public Property Get Delay() As Long
    Dim lngValue As Long
    Call SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, lngValue, 0)
    Delay = lngValue
End Property

Public Property Let Speed(Value As Long)
    ' Sets the keyboard repeat-speed setting.
    ' Only values 0 through 31 are acceptable. Others will be
    ' set back to 0.
    Call SystemParametersInfo(SPI_SETKEYBOARDSPEED, Value, 0, SPIF_TELLALL)
End Property

Public Property Get Speed() As Long
    Dim lngValue As Long
    Call SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, lngValue, 0)
    Speed = lngValue
End Property

Public Property Get CaretBlinkTime() As Long
    ' Set or retrieve the number of milliseconds
    ' between blinks of the caret.
    ' SYSTEM RESOURCE. Change this with care.
    CaretBlinkTime = GetCaretBlinkTime()
End Property

Public Property Let CaretBlinkTime(Value As Long)
    ' Set or retrieve the number of milliseconds
    ' between blinks of the caret.
    ' SYSTEM RESOURCE. Change this with care.
    ' Allowable values: 200 to 1200 (multiples of 100)
    Call SetCaretBlinkTime(Value)
End Property

Public Property Let CaretOn(Value As Boolean)
    ' Show or hide the caret. Most apps control the
    ' caret themselves, and this call will have
    ' little or no effect except in limited
    ' circumstances. Passing 0 for the hWnd
    ' parameter to Show/HideCaret makes the effect
    ' apply for the current application.
    If Value Then
        Call ShowCaret(0)
    Else
        Call HideCaret(0)
    End If
End Property

Private Sub Class_Initialize()
    Dim osvi As OSVERSIONINFO
    osvi.dwOSVersionInfoSize = Len(osvi)
    Call GetVersionEx(osvi)
    mblnIsWinNT = (osvi.dwPlatformId = VER_PLATFORM_WIN32_NT)
End Sub
