VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Accessibility"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Accessibility Class

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Const SPI_GETACCESSTIMEOUT = 60
Private Const SPI_SETACCESSTIMEOUT = 61
Private Const SPI_GETFILTERKEYS = 50
Private Const SPI_SETFILTERKEYS = 51
Private Const SPI_GETMOUSEKEYS = 54
Private Const SPI_SETMOUSEKEYS = 55
Private Const SPI_GETSOUNDSENTRY = 64
Private Const SPI_SETSOUNDSENTRY = 65
Private Const SPI_GETSTICKYKEYS = 58
Private Const SPI_SETSTICKYKEYS = 59
Private Const SPI_GETTOGGLEKEYS = 52
Private Const SPI_SETTOGGLEKEYS = 53
Private Const SPI_GETSHOWSOUNDS = 56
Private Const SPI_SETSHOWSOUNDS = 57
Private Const SPI_GETHIGHCONTRAST = 66
Private Const SPI_SETHIGHCONTRAST = 67

' SystemParametersInfo flags
Private Const SPIF_UPDATEINIFILE = &H1
Private Const SPIF_SENDWININICHANGE = &H2

' This is a made-up constant.
Private Const SPIF_TELLALL = SPIF_UPDATEINIFILE Or SPIF_SENDWININICHANGE

Private Declare Function SystemParametersInfo _
 Lib "user32" Alias "SystemParametersInfoA" _
 (ByVal uAction As Long, ByVal uParam As Long, _
 lpvParam As Any, ByVal fuWinIni As Long) As Long

' ACCESSTIMEOUT Information ===============
Private Type ACCESSTIMEOUT
    lngSize As Long
    lngFlags As Long
    lngTimeOutSecs As Long
End Type

' If this flag is set, you can set a time-out period for accessibility features.
' An application can retrieve this value, but cannot set it.
Private Const ATF_AVAILABLE = 0
' If this flag is set, a time-out period has been set for accessibility features.
' If this flag is not set, the features will not time out even though a time-out
' period is specified.
Private Const ATF_TIMEOUTON = 1
' If this flag is set, the operating system plays a descending siren sound when
' the time-out period elapses and the accessibility features are turned off.
Private Const ATF_ONOFFFEEDBACK = 2

' FILTERKEYS information ==================
Private Type FILTERKEYS  '  24  Bytes
     lngSize As Long
     lngFlags As Long
     lngWaitMSec As Long
     lngDelayMSec As Long
     lngRepeatMSec As Long
     lngBounceMSec As Long
End Type

' FILTERKEYS dwFlags value
Private Const FKF_AVAILABLE = &H2       ' FilterKeys features are available.
Private Const FKF_CLICKON = &H40        ' A click sounds each time a key is pressed or accepted.
Private Const FKF_FILTERKEYSON = &H1    ' FilterKeys features are on.
Private Const FKF_HOTKEYACTIVE = &H4    ' The FilterKeys feature is toggled by holding down the Shift key for 8 seconds.
Private Const FKF_HOTKEYSOUND = &H10    ' A siren sound is played when the FilterKeys feature is toggled using the hot key.
Private Const FKF_CONFIRMHOTKEY = &H8   ' Windows 9x, 2000 only: A confirmation dialog box appears when the the FilterKeys features are activated by using the hot key.
Private Const FKF_INDICATOR = &H20      ' Windows 9x, 2000 only: A visual indicator is displayed when the FilterKeys features are on.

' MOUSEKEYS Information ==================
Private Type MOUSEKEYS    '  28 Bytes
    lngSize As Long
    lngFlags As Long
    lngMaxSpeed As Long
    lngTimeToMaxSpeed As Long
    lngCtrlSpeed As Long
    lngReserved1 As Long
    lngReserved2 As Long
End Type

' MOUSEKEYS dwFlags field
Private Const MKF_MOUSEKEYSON = &H1
Private Const MKF_AVAILABLE = &H2
Private Const MKF_HOTKEYACTIVE = &H4
Private Const MKF_CONFIRMHOTKEY = &H8
Private Const MKF_HOTKEYSOUND = &H10
Private Const MKF_INDICATOR = &H20
Private Const MKF_MODIFIERS = &H40
Private Const MKF_REPLACENUMBERS = &H80
Private Const MKF_LEFTBUTTONSEL = &H10000000
Private Const MKF_RIGHTBUTTONSEL = &H20000000
Private Const MKF_LEFTBUTTONDOWN = &H1000000
Private Const MKF_RIGHTBUTTONDOWN = &H2000000
Private Const MKF_MOUSEMODE = &H80000000

' SOUNDSENTRY Information =================
Private Type SOUNDSENTRY    '  48 Bytes
    lngSize As Long
    lngFlags As Long
    lngFSTextEffect As Long
    lngFSTextEffectMSec As Long
    lngFSTextEffectColorBits As Long
    lngFSGraphicEffect As Long
    lngFSGraphicEffectMSec As Long
    lngFSGraphicEffectColor As Long
    lngWindowsEffect As Long
    lngWindowsEffectMSec As Long
    lpszWindowsEffectDLL As Long
    lngWindowsEffectOrdinal As Long
End Type

Private Const SSF_SOUNDSENTRYON = &H1   ' The SoundSentry feature is on.
Private Const SSF_AVAILABLE = &H2       ' The SoundSentry feature is available.

Private Const SSTF_NONE = 0         ' No visual indication is used.
Private Const SSTF_CHARS = 1        ' Flash characters in the corner of the screen.
Private Const SSTF_BORDER = 2       ' Flash the screen border (overscan area).
Private Const SSTF_DISPLAY = 3      ' Flash the entire display.

Private Const SSGF_NONE = 0         ' No visual indication is used.
Private Const SSGF_DISPLAY = 3      ' Flash the entire display.

Private Const SSWF_NONE = 0         ' No visual indication is displayed.
Private Const SSWF_TITLE = 1        ' Flash the caption of the active window.
Private Const SSWF_WINDOW = 2       ' Flash the active window.
Private Const SSWF_DISPLAY = 3      ' Flash the entire display.
Private Const SSWF_CUSTOM = 4       ' Windows 95 only. Call the SoundSentryProc function exported by the DLL specified by the lpszWindowsEffectDLL field.

' STICKYKEYS Information ==================
Private Type STICKYKEYS    '  8 Bytes
    lngSize As Long
    lngFlags As Long
End Type


' STICKYKEYS dwFlags field
Private Const SKF_STICKYKEYSON = &H1
Private Const SKF_AVAILABLE = &H2
Private Const SKF_HOTKEYACTIVE = &H4
Private Const SKF_CONFIRMHOTKEY = &H8
Private Const SKF_HOTKEYSOUND = &H10
Private Const SKF_INDICATOR = &H20
Private Const SKF_AUDIBLEFEEDBACK = &H40
Private Const SKF_TRISTATE = &H80
Private Const SKF_TWOKEYSOFF = &H100
Private Const SKF_LALTLATCHED = &H10000000
Private Const SKF_LCTLLATCHED = &H4000000
Private Const SKF_LSHIFTLATCHED = &H1000000
Private Const SKF_RALTLATCHED = &H20000000
Private Const SKF_RCTLLATCHED = &H8000000
Private Const SKF_RSHIFTLATCHED = &H2000000
Private Const SKF_LWINLATCHED = &H40000000
Private Const SKF_RWINLATCHED = &H80000000
Private Const SKF_LALTLOCKED = &H100000
Private Const SKF_LCTLLOCKED = &H40000
Private Const SKF_LSHIFTLOCKED = &H10000
Private Const SKF_RALTLOCKED = &H200000
Private Const SKF_RCTLLOCKED = &H80000
Private Const SKF_RSHIFTLOCKED = &H20000
Private Const SKF_LWINLOCKED = &H400000
Private Const SKF_RWINLOCKED = &H800000

' TOGGLEKEYS Information ==================
Private Type TOGGLEKEYS     '  8 Bytes
    lngSize As Long
    lngFlags As Long
End Type

Private Const TKF_TOGGLEKEYSON = &H1
Private Const TKF_AVAILABLE = &H2
Private Const TKF_HOTKEYACTIVE = &H4
Private Const TKF_CONFIRMHOTKEY = &H8
Private Const TKF_HOTKEYSOUND = &H10
Private Const TKF_INDICATOR = &H20

Private Type HIGHCONTRAST
    cbSize As Long                      'the size, in bytes, of this structure
    dwFlags As Long
    lpszDefaultScheme As Long
End Type

Private Const HCF_HIGHCONTRASTON = &H1  'The high contrast feature is on.
Private Const HCF_AVAILABLE = &H2               'The high contrast feature is available.
Private Const HCF_HOTKEYACTIVE = &H4        'The user can turn the high contrast feature on and off by simultaneously pressing the left ALT, left SHIFT, and PRINT SCREEN keys.
Private Const HCF_CONFIRMHOTKEY = &H8      'A confirmation dialog appears when the high contrast feature is activated by using the hot key.
Private Const HCF_HOTKEYSOUND = &H10    'A siren is played when the user turns the high contrast feature on or off by using the hot key
Private Const HCF_INDICATOR = &H20              'ignored
Private Const HCF_HOTKEYAVAILABLE = &H40    'The hot key associated with the high contrast feature can be enabled. An application can retrieve this value, but cannot set it.

Private at As ACCESSTIMEOUT
Private fk As FILTERKEYS
Private mk As MOUSEKEYS
Private sk As STICKYKEYS
Private ss As SOUNDSENTRY
Private tk As TOGGLEKEYS
Private hc As HIGHCONTRAST

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

Private mblnIsWin2000 As Boolean
Private mblnIsWin95 As Boolean
Private mblnIsWin98 As Boolean
Private mblnIsWinNT As Boolean

' ------------------- HIGHCONTRAST ---------------------

Public Property Get hcAvailable() As Boolean
    ' The high contrast feature is available
    Call hcGetInfo
    hcAvailable = IsBitSet(hc.dwFlags, HCF_AVAILABLE)
End Property

Public Property Get hcConfirmHotKey() As Boolean
    ' A confirmation dialog appears when the high contrast feature is
    ' activated by using the hot key.
    Call hcGetInfo
    hcConfirmHotKey = IsBitSet(hc.dwFlags, HCF_CONFIRMHOTKEY)
End Property

Public Property Let hcConfirmHotKey(Value As Boolean)
    ' A confirmation dialog appears when the high contrast feature is
    ' activated by using the hot key.
    Call SetBit(hc.dwFlags, HCF_CONFIRMHOTKEY, Value)
    Call hcApplyChanges
End Property

Public Property Get hcHighContrastOn() As Boolean
    ' The high contrast feature is on
    Call hcGetInfo
    hcConfirmHotKey = IsBitSet(hc.dwFlags, HCF_HIGHCONTRASTON)
End Property

Public Property Let hcHighContrastOn(Value As Boolean)
    ' The high contrast feature is on
    Call SetBit(hc.dwFlags, HCF_HIGHCONTRASTON, Value)
    Call hcApplyChanges
End Property

Public Property Get hcHotKeyActive() As Boolean
    ' The user can turn the high contrast feature on and off by
    ' simultaneously pressing the left ALT, left SHIFT, and PRINT SCREEN keys.
    Call hcGetInfo
    hcHotKeyActive = IsBitSet(hc.dwFlags, HCF_HOTKEYACTIVE)
End Property

Public Property Let hcHotKeyActive(Value As Boolean)
    ' The high contrast feature is on
    Call SetBit(hc.dwFlags, HCF_HOTKEYACTIVE, Value)
    Call hcApplyChanges
End Property

Public Property Get hcHotKeyAvailable() As Boolean
    ' The hot key associated with the high contrast feature can be enabled.
    ' An application can retrieve this value, but cannot set it.
    Call hcGetInfo
    hcHotKeyAvailable = IsBitSet(hc.dwFlags, HCF_HOTKEYAVAILABLE)
End Property

Public Property Get hcHotKeySound() As Boolean
    ' A siren is played when the user turns the high contrast feature on or off by using the hot key.
    Call hcGetInfo
    hcHotKeySound = IsBitSet(hc.dwFlags, HCF_HOTKEYSOUND)
End Property

Public Property Let hcHotKeySound(Value As Boolean)
    ' A siren is played when the user turns the high contrast feature on or off by using the hot key.
    Call SetBit(hc.dwFlags, HCF_HOTKEYSOUND, Value)
    Call hcApplyChanges
End Property

Private Sub hcGetInfo()
    ' Retrieve current values for high contrast.
    hc.cbSize = Len(hc)
    Call SystemParametersInfo(SPI_GETHIGHCONTRAST, Len(hc), hc, 0)
End Sub

Private Sub hcApplyChanges()
    ' applies the changes
    Call SystemParametersInfo(SPI_SETHIGHCONTRAST, Len(hc), hc, SPIF_TELLALL)
End Sub

' ------------------- ACCESSTIMEOUT ---------------------

Public Property Get atTimeOutMilliseconds() As Long
    ' Set or retrieve the number of milliseconds idle
    ' time before Accessility turns off.
    Call atReset
    atTimeOutMilliseconds = at.lngTimeOutSecs
End Property

Public Property Let atTimeOutMilliseconds(Value As Long)
    ' Only 5, 10, 15, 20, 25, and 30 minutes (each times
    ' 60000 to convert to millisecs) are allowed.
    at.lngTimeOutSecs = Value
    Call atApply
End Property

Public Property Get atAvailable() As Boolean
    ' Set or retrieve whether you can set a time-out period.
    Call atReset
    atAvailable = IsBitSet(at.lngFlags, ATF_AVAILABLE)
End Property

Public Property Get atActive() As Boolean
    ' Set or retrieve whether a timeout has been set.
    ' Unless set, the Timeout value will have no effect.
    Call atReset
    atActive = IsBitSet(at.lngFlags, ATF_TIMEOUTON)
End Property

Public Property Let atActive(Value As Boolean)
    ' Set or retrieve whether a timeout has been set.
    ' Unless set, the Timeout value will have no effect.
    Call SetBit(at.lngFlags, ATF_TIMEOUTON, Value)
    Call atApply
End Property

Public Property Get atFeedback() As Boolean
    ' Set or retrieve whether a sound effect is
    ' played when the timeout period elapses.
    Call atReset
    atFeedback = IsBitSet(at.lngFlags, ATF_ONOFFFEEDBACK)
End Property

Public Property Let atFeedback(Value As Boolean)
    ' Set or retrieve whether a sound effect is
    ' played when the timeout period elapses.
    Call SetBit(at.lngFlags, ATF_ONOFFFEEDBACK, Value)
    Call atApply
End Property

' ------------------- FILTERKEYS ---------------------

Private Sub fkReset()
    ' Retrieve current values.
    fk.lngSize = Len(fk)
    Call SystemParametersInfo(SPI_GETFILTERKEYS, fk.lngSize, fk, 0)
End Sub

Private Function fkApply() As Boolean
    fkApply = CBool(SystemParametersInfo(SPI_SETFILTERKEYS, fk.lngSize, fk, SPIF_TELLALL))
End Function

Public Property Get fkWaitMSec() As Long
    ' Specifies the length of time,
    ' in milliseconds, that the user must
    ' hold down a key before it is accepted by the computer.
    Call fkReset
    fkWaitMSec = fk.lngWaitMSec
End Property

Public Property Let fkWaitMSec(Value As Long)
    ' Specifies the length of time,
    ' in milliseconds, that the user must
    ' hold down a key before it is accepted by the computer.
    
    ' Only acceptable values are 0, 300, 500, 700,
    ' 1000, 1400, and 2000. All others will be rounded
    ' to the next larger value, within the range (values
    ' larger than 2000 are cut back to 1000, the default).
    fk.lngWaitMSec = Value
    Call fkApply
End Property

Public Property Get fkDelayMSec() As Long
    ' Specifies the length of time, in milliseconds,
    ' that the user must hold down a key before it
    ' begins to repeat.
    Call fkReset
    fkDelayMSec = fk.lngDelayMSec
End Property

Public Property Let fkDelayMSec(Value As Long)
    ' Specifies the length of time, in milliseconds,
    ' that the user must hold down a key before it
    ' begins to repeat.
    
    ' If you set fkDelayMSec, you must
    ' set fkBounceMSec to 0, or you can't set the value.
    ' They can both be 0, but they can't both be
    ' non-zero.
    If Value > 0 Then
        fk.lngBounceMSec = 0
    End If
    fk.lngDelayMSec = Value
    Call fkApply
End Property

Public Property Get fkRepeatMSec() As Long
    ' Specifies the length of time, in milliseconds,
    ' between each repetition of the keystroke.
    Call fkReset
    fkRepeatMSec = fk.lngRepeatMSec
End Property

Public Property Let fkRepeatMSec(Value As Long)
    ' Specifies the length of time, in milliseconds,
    ' between each repetition of the keystroke.
    fk.lngRepeatMSec = Value
    Call fkApply
End Property

Public Property Get fkBounceMSec() As Long
    ' Specifies the amount of time,
    ' in milliseconds, that must elapse after
    ' releasing a key before the computer will
    ' accept a subsequent press of the same key.
    Call fkReset
    fkBounceMSec = fk.lngBounceMSec
End Property

Public Property Let fkBounceMSec(Value As Long)
    ' Specifies the amount of time,
    ' in milliseconds, that must elapse after
    ' releasing a key before the computer will
    ' accept a subsequent press of the same key.
    
    ' If you set Bounce, you must
    ' set Delay to 0, or you can't set the value.
    ' They can both be 0, but they can't both be
    ' non-zero.
    If Value > 0 Then
        fk.lngDelayMSec = 0
    End If
    fk.lngBounceMSec = Value
    Call fkApply
End Property

Public Property Get fkAvailable() As Boolean
    ' Retrieve whether the FilterKeys features are available.
    Call fkReset
    fkAvailable = IsBitSet(fk.lngFlags, FKF_AVAILABLE)
End Property

Public Property Get fkClickOn() As Boolean
    ' Set or retrieve whether the computer makes a click
    ' sound when a key is pressed or accepted.
    Call fkReset
    fkClickOn = IsBitSet(fk.lngFlags, FKF_CLICKON)
End Property

Public Property Let fkClickOn(Value As Boolean)
    ' Set or retrieve whether the computer makes a click
    ' sound when a key is pressed or accepted.
    Call SetBit(fk.lngFlags, FKF_CLICKON, Value)
    Call fkApply
End Property

Public Property Get fkActive() As Boolean
    ' Set or retrieve whether the FilterKeys features are on.
    Call fkReset
    fkActive = IsBitSet(fk.lngFlags, FKF_FILTERKEYSON)
End Property

Public Property Let fkActive(Value As Boolean)
    ' Set or retrieve whether the FilterKeys features are on.
    Call SetBit(fk.lngFlags, FKF_FILTERKEYSON, Value)
    Call fkApply
End Property

Public Property Get fkHotkeyActive() As Boolean
    ' Set or retrieve whether the user can turn the FilterKeys
    ' feature on and off by holding down the SHIFT key for eight seconds.
    Call fkReset
    fkHotkeyActive = IsBitSet(fk.lngFlags, FKF_HOTKEYACTIVE)
End Property

Public Property Let fkHotkeyActive(Value As Boolean)
    ' Set or retrieve whether the user can turn the FilterKeys
    ' feature on and off by holding down the SHIFT key for eight seconds.
    Call SetBit(fk.lngFlags, FKF_HOTKEYACTIVE, Value)
    Call fkApply
End Property

Public Property Get fkHotKeySound() As Boolean
    ' Set or retrieve whether the computer plays a siren
    ' sound when the user turns the FilterKeys feature
    ' on or off by using the hot key
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call fkReset
        fkHotKeySound = IsBitSet(fk.lngFlags, FKF_HOTKEYSOUND)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let fkHotKeySound(Value As Boolean)
    ' Set or retrieve whether the computer plays a siren
    ' sound when the user turns the FilterKeys feature
    ' on or off by using the hot key

    Call SetBit(fk.lngFlags, FKF_HOTKEYSOUND, Value)
    Call fkApply
End Property

Public Property Get fkHotKeyConfirm() As Boolean
    ' Win95, Win98, and Win2000 only.
    ' Set or retrieve whether a confirmation dialog box appears
    ' when the the FilterKeys features are activated by using
    ' the hot key.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call fkReset
        fkHotKeyConfirm = IsBitSet(fk.lngFlags, FKF_CONFIRMHOTKEY)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let fkHotKeyConfirm(Value As Boolean)
    ' Win95, Win98, and Win2000 only.
    ' Set or retrieve whether a confirmation dialog box appears
    ' when the the FilterKeys features are activated by using
    ' the hot key.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(fk.lngFlags, FKF_CONFIRMHOTKEY, Value)
        Call fkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get fkIndicator() As Boolean
    ' Win95, Win98, and Win2000 only.
    ' Set or retrieve whether a visual indicator is displayed
    ' when the FilterKeys features are on.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call fkReset
        fkIndicator = IsBitSet(fk.lngFlags, FKF_INDICATOR)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let fkIndicator(Value As Boolean)
    ' Win95, Win98, and Win2000 only.
    ' Set or retrieve whether a visual indicator is displayed
    ' when the FilterKeys features are on.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(fk.lngFlags, FKF_INDICATOR, Value)
        Call fkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

' ----------- MouseKeys-----------------

Public Property Get mkMaxSpeed() As Long
    ' Specifies the maximum speed the mouse cursor
    ' attains when an arrow key is held down.
    Call mkReset
    mkMaxSpeed = mk.lngMaxSpeed
End Property

Public Property Let mkMaxSpeed(Value As Long)
    ' Specifies the maximum speed the mouse cursor
    ' attains when an arrow key is held down.
    
    ' Must be a value between 10 and 360.
    ' 10, 20, 30, 40, 60, 80, 120, 180, and 360
    ' are the settings allowed. All others within
    ' the range are changed to the next higher
    ' setting. An invalid value causes
    ' the call to SystemParametersInfo to fail.
    mk.lngMaxSpeed = Value
    Call mkApply
End Property

Public Property Get mkTimeToMaxSpeed() As Long
    ' Specifies the length of time, in milliseconds,
    ' that it takes for the mouse cursor to reach
    ' maximum speed when an arrow key is held down.
    Call mkReset
    mkTimeToMaxSpeed = mk.lngTimeToMaxSpeed
End Property

Public Property Let mkTimeToMaxSpeed(Value As Long)
    ' Specifies the length of time, in milliseconds,
    ' that it takes for the mouse cursor to reach
    ' maximum speed when an arrow key is held down.
    
    ' Must be a value between 1000 and 5000, in
    ' milliseconds. Acceptable values in
    ' 500 millisecond intervals (5000, 4500,
    ' etc.) OThers in range rounded off.
    ' Values outside range cause the call
    ' to SystemParametersInfo to fail.
    mk.lngTimeToMaxSpeed = Value
    Call mkApply
End Property

Public Property Get mkCtrlSpeed() As Long
    ' Specifies the multiplier to apply to the mouse
    ' cursor speed when the user holds down the ctrl
    ' key while using the arrow keys to move the cursor.
    
    ' Documented as not working in NT. Works
    ' fine in NT 4.0. Only has an effect if
    ' MKF_MODIFIERS flag is also set.
    Call mkReset
    mkCtrlSpeed = mk.lngCtrlSpeed
End Property

Public Property Let mkCtrlSpeed(Value As Long)
    ' Specifies the multiplier to apply to the mouse
    ' cursor speed when the user holds down the ctrl
    ' key while using the arrow keys to move the cursor.
    
    ' Documented as not working in NT. Works
    ' fine in NT 4.0. Only has an effect if
    ' MKF_MODIFIERS flag is also set. Set
    ' that bit if the Value setting is
    ' greater than 0. Clear it, otherwise.
    Call SetBit(mk.lngFlags, MKF_MODIFIERS, Value > 0)
    mk.lngCtrlSpeed = Value
    Call mkApply
End Property

Public Property Get mkAvailable() As Boolean
    ' Retrieve whether the MouseKeys feature is available.
    Call mkReset
    mkAvailable = IsBitSet(mk.lngFlags, MKF_AVAILABLE)
End Property

Public Property Get mkConfirmHotKey() As Boolean
    ' Windows 95/98, Windows 2000: A confirmation dialog box appears
    ' when the MouseKeys feature is activated by using the hot key.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call mkReset
        mkConfirmHotKey = IsBitSet(mk.lngFlags, MKF_CONFIRMHOTKEY)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkConfirmHotKey(Value As Boolean)
    ' Windows 95/98, Windows 2000: A confirmation dialog box appears
    ' when the MouseKeys feature is activated by using the hot key.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_CONFIRMHOTKEY, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkHotKeyActive() As Boolean
    ' Set or retrieve whether the user can turn the MouseKeys
    ' feature on and off by using the hot key, which is
    ' LEFT ALT+LEFT SHIFT+NUM LOCK.
    Call mkReset
    mkHotKeyActive = IsBitSet(mk.lngFlags, MKF_HOTKEYACTIVE)
End Property

Public Property Let mkHotKeyActive(Value As Boolean)
    ' Set or retrieve whether the user can turn the MouseKeys
    ' feature on and off by using the hot key, which is
    ' LEFT ALT+LEFT SHIFT+NUM LOCK.
    Call SetBit(mk.lngFlags, MKF_HOTKEYACTIVE, Value)
    Call mkApply
End Property

Public Property Get mkHotKeySound() As Boolean
    ' Set or retrieve whether the system plays a siren
    ' sound when the user turns the MouseKeys feature
    ' on or off by using the hot key.
    Call mkReset
    mkHotKeySound = IsBitSet(mk.lngFlags, MKF_HOTKEYSOUND)
End Property

Public Property Let mkHotKeySound(Value As Boolean)
    ' Set or retrieve whether the system plays a siren
    ' sound when the user turns the MouseKeys feature
    ' on or off by using the hot key.
    Call SetBit(mk.lngFlags, MKF_HOTKEYSOUND, Value)
    Call mkApply
End Property

Public Property Get mkActive() As Boolean
    ' Set or retrieve whether the MouseKeys feature is on.
    Call mkReset
    mkActive = IsBitSet(mk.lngFlags, MKF_MOUSEKEYSON)
End Property

Public Property Get mkIndicator() As Boolean
    ' Windows 95/98, Windows 2000: A visual indicator is
    ' displayed when the MouseKeys feature is on.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call mkReset
        mkIndicator = IsBitSet(mk.lngFlags, MKF_INDICATOR)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkIndicator(Value As Boolean)
    ' Windows 95/98, Windows 2000: A visual indicator is
    ' displayed when the MouseKeys feature is on.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_INDICATOR, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkMouseKeysOn() As Boolean
    ' retrieve whether the MouseKeys feature is on.
    Call mkReset
    mkMouseKeysOn = IsBitSet(mk.lngFlags, MKF_MOUSEKEYSON)
End Property

Public Property Let mkMouseKeysOn(Value As Boolean)
    ' sets whether the MouseKeys feature is on.
    Call SetBit(mk.lngFlags, MKF_MOUSEKEYSON, Value)
    Call mkApply
End Property

Public Property Get mkModifiers() As Boolean
    ' Windows 95/98, Windows 2000:
    ' The CTRL key increases cursor speed by the value specified
    ' by the iCtrlSpeed member, and the SHIFT key causes the cursor
    ' to delay briefly after moving a single pixel, allowing fine positioning
    ' of the cursor. If this value is not specified, the CTRL and SHIFT keys
    ' are ignored while the user moves the mouse cursor using the arrow keys.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call mkReset
        mkModifiers = IsBitSet(mk.lngFlags, MKF_MODIFIERS)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkModifiers(Value As Boolean)
    '  The CTRL key increases cursor speed by the value specified
    ' by the iCtrlSpeed member, and the SHIFT key causes the cursor
    ' to delay briefly after moving a single pixel, allowing fine positioning
    ' of the cursor. If this value is not specified, the CTRL and SHIFT keys
    ' are ignored while the user moves the mouse cursor using the arrow keys.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_MODIFIERS, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkMouseMode() As Boolean
    '  Windows 98, Windows 2000: The system is processing numeric
    ' keypad input as mouse commands.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call mkReset
        mkMouseMode = IsBitSet(mk.lngFlags, MKF_MOUSEMODE)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkMouseMode(Value As Boolean)
    '  Windows 98, Windows 2000: The system is processing numeric
    ' keypad input as mouse commands.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_MOUSEMODE, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkReplaceNumbers() As Boolean
    ' Windows 95/98, Windows 2000: The numeric keypad moves the mouse
    ' when the NUM LOCK key is on. If this flag is not specified, the numeric
    ' keypad moves the mouse cursor when the NUM LOCK key is off.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call mkReset
        mkReplaceNumbers = IsBitSet(mk.lngFlags, MKF_REPLACENUMBERS)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkReplaceNumbers(Value As Boolean)
    ' Windows 95/98, Windows 2000: The numeric keypad moves the mouse
    ' when the NUM LOCK key is on. If this flag is not specified, the numeric
    ' keypad moves the mouse cursor when the NUM LOCK key is off.
    If (mblnIsWin2000 Or mblnIsWin95 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_REPLACENUMBERS, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkLeftButtonSel() As Boolean
    ' Windows 98, Windows 2000:
    ' The user has selected the left button for mouse-button actions.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call mkReset
        mkLeftButtonSel = IsBitSet(mk.lngFlags, MKF_LEFTBUTTONSEL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkLeftButtonSel(Value As Boolean)
    ' Windows 98, Windows 2000:
    ' The user has selected the left button for mouse-button actions.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_LEFTBUTTONSEL, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkRightButtonSel() As Boolean
    ' Windows 98, Windows 2000:
    ' The user has selected the right button for mouse-button actions.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call mkReset
        mkRightButtonSel = IsBitSet(mk.lngFlags, MKF_RIGHTBUTTONSEL)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkRightButtonSel(Value As Boolean)
    ' Windows 98, Windows 2000:
    ' The user has selected the right button for mouse-button actions.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_RIGHTBUTTONSEL, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkLeftButtonDown() As Boolean
    ' Windows 98, Windows 2000:
    ' The left button is in the "down" state.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call mkReset
        mkLeftButtonDown = IsBitSet(mk.lngFlags, MKF_LEFTBUTTONDOWN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkLeftButtonDown(Value As Boolean)
    ' Windows 98, Windows 2000:
    ' The left button is in the "down" state.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_LEFTBUTTONDOWN, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get mkRightButtonDown() As Boolean
    ' Windows 98, Windows 2000:
    ' The right button is in the "down" state.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call mkReset
        mkRightButtonDown = IsBitSet(mk.lngFlags, MKF_RIGHTBUTTONDOWN)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let mkRightButtonDown(Value As Boolean)
    ' Windows 98, Windows 2000:
    ' The right button is in the "down" state.
    If (mblnIsWin2000 Or mblnIsWin98) Then
        Call SetBit(mk.lngFlags, MKF_RIGHTBUTTONDOWN, Value)
        Call mkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Private Sub mkReset()
    ' Retrieve current values.
    mk.lngSize = Len(mk)
    Call SystemParametersInfo(SPI_GETMOUSEKEYS, mk.lngSize, mk, 0)
End Sub

Private Function mkApply()
    ' Retrieve current values.
    mkApply = CBool(SystemParametersInfo(SPI_SETMOUSEKEYS, mk.lngSize, mk, SPIF_TELLALL))
End Function

' ----------- SoundSentry-----------------

Public Property Get ssActive() As Boolean
    ' Set or retrieve whether the SoundSentry feature is on.
    Call ssReset
    ssActive = IsBitSet(ss.lngFlags, SSF_SOUNDSENTRYON)
End Property

Public Property Let ssActive(Value As Boolean)
    ' Set or retrieve whether the SoundSentry feature is on.
    Call SetBit(ss.lngFlags, SSF_SOUNDSENTRYON, Value)
    Call ssApply
End Property

Public Property Get ssAvailable() As Boolean
    ' Retrieve whether the SoundSentry feature is available.
    Call ssReset
    ssAvailable = IsBitSet(ss.lngFlags, SSF_AVAILABLE)
End Property

Public Property Get ssFSTextEffect() As Long
    ' Available only in Win95/Win98.
    ' Set or retrieve the visual signal to present when
    ' a text-mode application generates a sound while
    ' running in a full-screen virtual machine.
    ' 0 - No visual indication is used.
    ' 1 - Flash characters in the corner of the screen.
    ' 2 - Flash the screen border (overscan area).
    ' 3 - Flash the entire display.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSTextEffect = ss.lngFSTextEffect
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSTextEffect(Value As Long)
    ' Available only in Win95/Win98.
    ' Set or retrieve the visual signal to present when
    ' a text-mode application generates a sound while
    ' running in a full-screen virtual machine.
    ' Set to one of:
    ' 0 - No visual indication is used.
    ' 1 - Flash characters in the corner of the screen.
    ' 2 - Flash the screen border (overscan area).
    ' 3 - Flash the entire display.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSTextEffect = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssFSTextEffectMSec() As Long
    ' Windows 95/98: Specifies the duration, in milliseconds, of the visual
    ' signal that is displayed when a full-screen, text-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSTextEffectMSec = ss.lngFSTextEffectMSec
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSTextEffectMSec(Value As Long)
    ' Windows 95/98: Specifies the duration, in milliseconds, of the visual
    ' signal that is displayed when a full-screen, text-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSTextEffectMSec = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssFSTextEffectColorBits() As Long
    ' Windows 95/98: Specifies the RGB value of the color to be used
    ' when displaying the visual signal shown when a full-screen, text-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSTextEffectColorBits = ss.lngFSTextEffectColorBits
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSTextEffectColorBits(Value As Long)
    ' Windows 95/98: Specifies the RGB value of the color to be used
    ' when displaying the visual signal shown when a full-screen, text-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSTextEffectColorBits = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssFSGraphicEffect() As Long
    ' Windows 95/98: Specifies the visual signal to present when a graphics-mode
    ' application generates a sound while running in a full-screen virtual machine.
    ' This member can be one of the following values:
    ' 3 - No visual signal.
    ' 0 - Flash the entire display.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSGraphicEffect = ss.lngFSGraphicEffect
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSGraphicEffect(Value As Long)
    ' Windows 95/98: Specifies the RGB value of the color to be used
    ' when displaying the visual signal shown when a full-screen, text-mode
    ' application generates a sound.
    ' 3 - No visual signal.
    ' 0 - Flash the entire display.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSGraphicEffect = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssFSGraphicEffectMSec() As Long
    ' Windows 95/98: Specifies the duration, in milliseconds, of the visual
    ' signal that is displayed when a full-screen, graphics-mode application
    ' generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSGraphicEffectMSec = ss.lngFSGraphicEffectMSec
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSGraphicEffectMSec(Value As Long)
    ' Windows 95/98: Specifies the duration, in milliseconds, of the visual
    ' signal that is displayed when a full-screen, graphics-mode application
    ' generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSGraphicEffectMSec = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssFSGraphicEffectColor() As Long
    ' Windows 95/98: Specifies the RGB value of the color to be used when
    ' displaying the visual signal shown when a full-screen, graphics-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssFSGraphicEffectColor = ss.lngFSGraphicEffectColor
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssFSGraphicEffectColor(Value As Long)
    ' Windows 95/98: Specifies the RGB value of the color to be used when
    ' displaying the visual signal shown when a full-screen, graphics-mode
    ' application generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngFSGraphicEffectColor = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get ssWindowsEffect() As Long
    ' Specifies the visual signal to present when a
    ' graphics-mode application generates a sound
    ' while running in a full-screen virtual machine.
    ' Can be one of the following values:
    '
    ' 0 - No visual indication is used.
    ' 1 - Flash characters in the corner of the screen.
    ' 2 - Flash the screen border (overscan area).
    ' 3 - Flash the entire display.
    Call ssReset
    ssWindowsEffect = ss.lngWindowsEffect
End Property

Public Property Let ssWindowsEffect(Value As Long)
    ' Specifies the visual signal to present when a
    ' graphics-mode application generates a sound
    ' while running in a full-screen virtual machine.
    ' Can be one of the following values:
    '
    ' 0 - No visual indication is used.
    ' 1 - Flash characters in the corner of the screen.
    ' 2 - Flash the screen border (overscan area).
    ' 3 - Flash the entire display.
    ss.lngWindowsEffect = Value
    Call ssApply
End Property

Public Property Get ssWindowsEffectMSec() As Long
    ' Windows 95/98: Specifies the duration, in milliseconds, of the
    ' visual signal that is displayed when a Win32-based application
    ' (or an application running in a window) generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        Call ssReset
        ssWindowsEffectMSec = ss.lngWindowsEffectMSec
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let ssWindowsEffectMSec(Value As Long)
    ' Windows 95/98: Specifies the duration, in milliseconds, of the
    ' visual signal that is displayed when a Win32-based application
    ' (or an application running in a window) generates a sound.
    If mblnIsWin95 Or mblnIsWin98 Then
        ss.lngWindowsEffectMSec = Value
        Call ssApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

'---------------StickyKeys------------------

Public Property Get skAudibleFeedback() As Boolean
    ' Set or retrieve whether the system plays a
    ' sound when the user sets keys using the
    ' StickyKeys feature
    Call skReset
    skAudibleFeedback = IsBitSet(sk.lngFlags, SKF_AUDIBLEFEEDBACK)
End Property

Public Property Let skAudibleFeedback(Value As Boolean)
    ' Set or retrieve whether the system plays a
    ' sound when the user sets keys using theSKF_AVAILABLE
    ' StickyKeys feature
    Call SetBit(sk.lngFlags, SKF_AUDIBLEFEEDBACK, Value)
    Call skApply
End Property

Public Property Get skAvailable() As Boolean
    ' Retrieve whether the StickyKeys feature is available.
    Call skReset
    skAvailable = IsBitSet(sk.lngFlags, SKF_AVAILABLE)
End Property

Public Property Get skConfirmHotKey() As Boolean
    ' Windows 95/98, Windows 2000: A confirmation dialog appears when
    ' the StickyKeys feature is activated by using the hot key.
    If mblnIsWin95 Or mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skConfirmHotKey = IsBitSet(sk.lngFlags, SKF_CONFIRMHOTKEY)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skConfirmHotKey(Value As Boolean)
    ' Windows 95/98, Windows 2000: A confirmation dialog appears when
    ' the StickyKeys feature is activated by using the hot key.
    If mblnIsWin95 Or mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_CONFIRMHOTKEY, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skHotKeyActive() As Boolean
    ' Set or retrieve whether the user can turn the
    ' StickyKeys feature on and off by pressing the
    ' SHIFT key five times.
    Call skReset
    skHotKeyActive = IsBitSet(sk.lngFlags, SKF_HOTKEYACTIVE)
End Property

Public Property Let skHotKeyActive(Value As Boolean)
    ' Set or retrieve whether the user can turn the
    ' StickyKeys feature on and off by pressing the
    ' SHIFT key five times.
    Call SetBit(sk.lngFlags, SKF_HOTKEYACTIVE, Value)
    Call skApply
End Property

Public Property Get skHotKeySound() As Boolean
    ' Set or retrieve whether the system plays a
    ' siren sound when the user toggles
    ' StickyKeys feature using the hot key.
    Call skReset
    skHotKeySound = IsBitSet(sk.lngFlags, SKF_HOTKEYSOUND)
End Property

Public Property Let skHotKeySound(Value As Boolean)
    ' Set or retrieve whether the system plays a
    ' siren sound when the user toggles
    ' StickyKeys feature using the hot key.
    Call SetBit(sk.lngFlags, SKF_HOTKEYSOUND, Value)
    Call skApply
End Property

Public Property Get skIndicator() As Boolean
    ' Windows 95/98, Windows 2000: A visual indicator should be displayed
    ' when the StickyKeys feature is on.
    If mblnIsWin95 Or mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skIndicator = IsBitSet(sk.lngFlags, SKF_INDICATOR)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skIndicator(Value As Boolean)
    ' Windows 95/98, Windows 2000: A visual indicator should be displayed
    ' when the StickyKeys feature is on.
    If mblnIsWin95 Or mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_INDICATOR, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skActive() As Boolean
    ' Set or retrieve whether the StickyKeys feature is on.
    Call skReset
    skActive = IsBitSet(sk.lngFlags, SKF_STICKYKEYSON)
End Property

Public Property Let skActive(Value As Boolean)
    ' Set or retrieve whether the StickyKeys feature is on.
    Call SetBit(sk.lngFlags, SKF_STICKYKEYSON, Value)
    Call skApply
End Property


Public Property Get skTriState() As Boolean
    ' Set or retrieve whether pressing a modifier key
    ' twice in a row locks down the key until the
    ' user presses it a third time.
    Call skReset
    skTriState = IsBitSet(sk.lngFlags, SKF_TRISTATE)
End Property

Public Property Let skTriState(Value As Boolean)
    ' Set or retrieve whether pressing a modifier key
    ' twice in a row locks down the key until the
    ' user presses it a third time.
    Call SetBit(sk.lngFlags, SKF_TRISTATE, Value)
    Call skApply
End Property

Public Property Get skTwoKeysOff() As Boolean
    ' Set or retrieve whether releasing a
    ' modifier key that has been pressed in
    ' combination with any other key turns
    ' off the StickyKeys feature.
    Call skReset
    skTwoKeysOff = IsBitSet(sk.lngFlags, SKF_TWOKEYSOFF)
End Property

Public Property Let skTwoKeysOff(Value As Boolean)
    ' If this flag is set, releasing a
    ' modifier key that has been pressed in
    ' combination with any other key turns
    ' off the StickyKeys feature.
    Call SetBit(sk.lngFlags, SKF_TWOKEYSOFF, Value)
    Call skApply
End Property

Public Property Get skLeftAltLatched() As Boolean
    ' Windows 98, Windows 2000: The left ALT key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftAltLatched = IsBitSet(sk.lngFlags, SKF_LALTLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftCtlLatched() As Boolean
    ' Windows 98, Windows 2000: The left CTRL key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftCtlLatched = IsBitSet(sk.lngFlags, SKF_LCTLLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftShiftLatched() As Boolean
    ' Windows 98, Windows 2000: The left SHIFT key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftShiftLatched = IsBitSet(sk.lngFlags, SKF_LSHIFTLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightAltLatched() As Boolean
    ' Windows 98, Windows 2000: The right ALT key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightAltLatched = IsBitSet(sk.lngFlags, SKF_RALTLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightCtlLatched() As Boolean
    ' Windows 98, Windows 2000: The right CTRL key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightCtlLatched = IsBitSet(sk.lngFlags, SKF_RCTLLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightShiftLatched() As Boolean
    ' Windows 98, Windows 2000: The right SHIFT key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightShiftLatched = IsBitSet(sk.lngFlags, SKF_RSHIFTLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftAltLocked() As Boolean
    ' Windows 98, Windows 2000: The left ALT key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftAltLocked = IsBitSet(sk.lngFlags, SKF_LALTLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftCtlLocked() As Boolean
    ' Windows 98, Windows 2000: The left CTRL key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftCtlLocked = IsBitSet(sk.lngFlags, SKF_LCTLLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftShiftLocked() As Boolean
    ' Windows 98, Windows 2000: The left SHIFT key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftShiftLocked = IsBitSet(sk.lngFlags, SKF_LSHIFTLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightAltLocked() As Boolean
    ' Windows 98, Windows 2000: The right ALT key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightAltLocked = IsBitSet(sk.lngFlags, SKF_RALTLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightCtlLocked() As Boolean
    ' Windows 98, Windows 2000:  The right CTRL key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightCtlLocked = IsBitSet(sk.lngFlags, SKF_RCTLLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightShiftLocked() As Boolean
    ' Windows 98, Windows 2000:  The right SHIFT key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightShiftLocked = IsBitSet(sk.lngFlags, SKF_RSHIFTLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftWinLatched() As Boolean
    ' Windows 98, Windows 2000:  The left Windows key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftWinLatched = IsBitSet(sk.lngFlags, SKF_LWINLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skLeftWinLatched(Value As Boolean)
    ' Windows 98, Windows 2000: The left Windows key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_LWINLATCHED, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightWinLatched() As Boolean
    ' Windows 98, Windows 2000:  The right Windows key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightWinLatched = IsBitSet(sk.lngFlags, SKF_RWINLATCHED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skRightWinLatched(Value As Boolean)
    ' Windows 98, Windows 2000: The right Windows key is latched.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_RWINLATCHED, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skLeftWinLocked() As Boolean
    ' Windows 98, Windows 2000:  The left Windows key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skLeftWinLocked = IsBitSet(sk.lngFlags, SKF_LWINLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skLeftWinLocked(Value As Boolean)
    ' Windows 98, Windows 2000: The left Windows key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_LWINLOCKED, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get skRightWinLocked() As Boolean
    ' Windows 98, Windows 2000:  The right Windows key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call skReset
        skRightWinLocked = IsBitSet(sk.lngFlags, SKF_RWINLOCKED)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let skRightWinLocked(Value As Boolean)
    ' Windows 98, Windows 2000: The right Windows key is locked.
    If mblnIsWin98 Or mblnIsWin2000 Then
        Call SetBit(sk.lngFlags, SKF_RWINLOCKED, Value)
        Call skApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

' ---------------ToggleKeys------------------

Public Property Get tkActive() As Boolean
    ' Set or retrieve whether the ToggleKeys feature is on.
    Call tkReset
    tkActive = IsBitSet(tk.lngFlags, TKF_TOGGLEKEYSON)
End Property

Public Property Let tkActive(Value As Boolean)
    ' Set or retrieve whether the ToggleKeys feature is on.
    Call SetBit(tk.lngFlags, TKF_TOGGLEKEYSON, Value)
    Call tkApply
End Property

Public Property Get tkAvailable() As Boolean
    ' Retrieve whether the ToggleKeys feature is available.
    Call tkReset
    tkAvailable = IsBitSet(tk.lngFlags, TKF_AVAILABLE)
End Property

Public Property Get tkHotKeyActive() As Boolean
    ' Set or retrieve whether the user can turn the
    ' ToggleKeys feature on and off by holding the NumLock
    ' key for 5 seconds.
    Call tkReset
    tkHotKeyActive = IsBitSet(tk.lngFlags, TKF_HOTKEYACTIVE)
End Property

Public Property Let tkHotKeyActive(Value As Boolean)
    ' Set or retrieve whether the user can turn the
    ' ToggleKeys feature on and off by holding the NumLock
    ' key for 5 seconds.
    Call SetBit(tk.lngFlags, TKF_HOTKEYACTIVE, Value)
    Call tkApply
End Property

Public Property Get tkConfirmHotKey() As Boolean
    ' Windows 95/98, Windows 2000
    ' Set or retrieve whether a confirmation dialog
    ' appears when the ToggleKeys feature is activated
    ' by using the hot key.
    If mblnIsWin98 Or mblnIsWin95 Or mblnIsWin2000 Then
        Call tkReset
        tkConfirmHotKey = IsBitSet(tk.lngFlags, TKF_CONFIRMHOTKEY)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Let tkConfirmHotKey(Value As Boolean)
    ' Windows 95/98, Windows 2000
    ' Set or retrieve whether a confirmation dialog
    ' appears when the ToggleKeys feature is activated
    ' by using the hot key.
    If mblnIsWin98 Or mblnIsWin95 Or mblnIsWin2000 Then
        Call SetBit(tk.lngFlags, TKF_CONFIRMHOTKEY, Value)
        Call tkApply
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get tkHotKeySound() As Boolean
    ' Set or retrieve whether the system plays a
    ' siren sound when the user toggles
    ' ToggleKeys feature using the hot key.
    Call tkReset
    tkHotKeySound = IsBitSet(tk.lngFlags, TKF_HOTKEYSOUND)
End Property

Public Property Let tkHotKeySound(Value As Boolean)
    ' Set or retrieve whether the system plays a
    ' siren sound when the user toggles
    ' ToggleKeys feature using the hot key.
    Call SetBit(tk.lngFlags, TKF_HOTKEYSOUND, Value)
    Call tkApply
End Property

' STICKYKEYS Support =========================

Private Sub skReset()
    sk.lngSize = Len(sk)
    Call SystemParametersInfo(SPI_GETSTICKYKEYS, sk.lngSize, sk, 0)
End Sub

Private Function skApply()
    skApply = CBool(SystemParametersInfo(SPI_SETSTICKYKEYS, sk.lngSize, sk, SPIF_TELLALL))
End Function

' SHOWSOUNDS Support =========================

Public Property Get shActive() As Boolean
    ' Set or retrieve whether ShowSounds is active.
    Dim lngValue As Long
    Call SystemParametersInfo(SPI_GETSHOWSOUNDS, 0, lngValue, 0)
    shActive = CBool(lngValue)
End Property

Public Property Let shActive(Value As Boolean)
    ' Set or retrieve whether ShowSounds is active.
    ' ShowSounds requires 0 or 1, (not -1).
    Call SystemParametersInfo(SPI_SETSHOWSOUNDS, Abs(Value), 0, SPIF_TELLALL)
End Property


' SOUNDSENTRY Support ========================

Private Sub ssReset()
    ' Retrieve current values.
    ss.lngSize = Len(ss)
    Call SystemParametersInfo(SPI_GETSOUNDSENTRY, ss.lngSize, ss, 0)
End Sub

Private Function ssApply()
    ' Retrieve current values.
    ssApply = CBool(SystemParametersInfo(SPI_SETSOUNDSENTRY, ss.lngSize, ss, SPIF_TELLALL))
End Function


' TOGGLEKEYS Support =========================

Private Sub tkReset()
    tk.lngSize = Len(tk)
    Call SystemParametersInfo(SPI_GETTOGGLEKEYS, tk.lngSize, tk, 0)
End Sub

Private Function tkApply()
    tkApply = CBool(SystemParametersInfo(SPI_SETTOGGLEKEYS, tk.lngSize, tk, SPIF_TELLALL))
End Function

Private Function IsBitSet(lngFlags As Long, lngValue As Long) As Boolean
    ' Use logical AND to see if a particular bit within
    ' a long integer is set.
    IsBitSet = CBool((lngFlags And lngValue) = lngValue)
End Function

Private Sub SetBit(lngFlags As Long, lngValue As Long, fSet As Boolean)
    ' Use logical OR to set a particular bit.
    ' Use logical AND NOT to turn off a particular bit.
    If fSet Then
        lngFlags = lngFlags Or lngValue
    Else
        lngFlags = lngFlags And Not lngValue
    End If
End Sub

' ACCESSTIMEOUT Support ======================
Private Sub atReset()
    ' Retrieve current values.
    at.lngSize = Len(at)
    Call SystemParametersInfo(SPI_GETACCESSTIMEOUT, at.lngSize, at, 0)
End Sub

Private Function atApply() As Boolean
     atApply = CBool(SystemParametersInfo(SPI_SETACCESSTIMEOUT, at.lngSize, at, SPIF_TELLALL))
End Function

Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, "Accessibility", .Description, .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "Accessibility", ERR_STRING
            End If
        End If
    End With
End Sub

Private Sub Class_Initialize()
    
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
            ' if it's Win98 or Win2000 then
            ' Winver = 5
            mblnIsWin2000 = (.dwPlatformId = VER_PLATFORM_WIN32_NT And .dwMajorVersion = 5)
            mblnIsWin98 = (.dwMajorVersion = 4 And _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And .dwMinorVersion > 0))
            mblnIsWin95 = (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS _
             And .dwMinorVersion = 0)
            mblnIsWinNT = (.dwPlatformId = VER_PLATFORM_WIN32_NT _
             And .dwMajorVersion <= 4)
        End With
    End If
End Sub



