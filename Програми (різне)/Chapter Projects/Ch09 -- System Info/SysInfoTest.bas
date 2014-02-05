Attribute VB_Name = "SysInfoTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' These items are only here to make it easy to
' test the various classes. We don't recommend
' doing this, in general.
Public si As New SystemInfo
Public ncm As New NonClientMetrics
Public oAccess As New Accessibility
Public oMouse As New Mouse
Public kb As New Keyboard
Public sc As New SystemColors
Public osi As New SystemInfo
Public ps As New PowerStatus
Public oScreen As New ScreenInfo
Public oms As New MemoryStatus

Public Sub FixNCM(Optional Bigger As Boolean = True)
    Dim ncm As NonClientMetrics
    Dim dblFactor As Double
    
    Set ncm = New NonClientMetrics
    If Bigger Then
        dblFactor = 2
    Else
        dblFactor = 0.5
    End If
    ncm.BorderWidth = ncm.BorderWidth * dblFactor
    ncm.CaptionHeight = ncm.CaptionHeight * dblFactor
    ncm.CaptionWidth = ncm.CaptionWidth * dblFactor
    ncm.MenuButtonHeight = ncm.MenuButtonHeight * dblFactor
    ncm.MenuButtonWidth = ncm.MenuButtonWidth * dblFactor
    ncm.ScrollHeight = ncm.ScrollHeight * dblFactor
    ncm.ScrollWidth = ncm.ScrollWidth * dblFactor
    Set ncm = Nothing
End Sub

Public Sub FixMsgBox()
    Dim ncm As NonClientMetrics
    Dim strOldFont As String
    Dim intOldSize As Integer
    
    Set ncm = New NonClientMetrics
    With ncm
        With .MessageFont
            strOldFont = .FaceName
            intOldSize = .Size
            .FaceName = "Verdana"
            .Size = 24
        End With
        Call .SaveSettings
        MsgBox "This is a test"
        With .MessageFont
            .FaceName = strOldFont
            .Size = intOldSize
        End With
        Call .SaveSettings
        MsgBox "This is a test"
    End With
End Sub

Public Sub TestSystemInfo()
    ' Test out all the properties (except
    ' SpecialFolderLocation) of the SystemInfo class.
    Dim si As SystemInfo
    Dim lngWidth As Long
    Set si = New SystemInfo
    
    lngWidth = 60
    si.RaiseErrors = False
    Debug.Print Pad("ActiveProcessorMask: ", lngWidth), si.ActiveProcessorMask
    Debug.Print Pad("AllocationGranularity: ", lngWidth), si.AllocationGranularity
    Debug.Print Pad("Beep: ", lngWidth), si.Beep
    Debug.Print Pad("BootMethod: ", lngWidth), si.BootMethod
    Debug.Print Pad("ComputerName: ", lngWidth), si.ComputerName
    Debug.Print Pad("IsDBCS: ", lngWidth), si.IsDBCS
    Debug.Print Pad("IsIMMEnabled: ", lngWidth), si.IsIMMEnabled
    Debug.Print Pad("IsRemoteSession: ", lngWidth), si.IsRemoteSession
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_BACKOFFICE): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_BACKOFFICE)
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_DATACENTER): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_DATACENTER)
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_ENTERPRISE): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_ENTERPRISE)
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_SMALLBUSINESS): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_SMALLBUSINESS)
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_SMALLBUSINESS_RESTRICTED): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_SMALLBUSINESS_RESTRICTED)
    Debug.Print Pad("IsSuiteInstalled (VER_SUITE_TERMINAL): ", lngWidth), si.IsSuiteInstalled(VER_SUITE_TERMINAL)
    Debug.Print Pad("IsWin2000: ", lngWidth), si.IsWin2000
    Debug.Print Pad("IsWin95: ", lngWidth), si.IsWin95
    Debug.Print Pad("IsWin98: ", lngWidth), si.IsWin98
    Debug.Print Pad("IsWinNT: ", lngWidth), si.IsWinNT
    Debug.Print Pad("MaxAppAddress: ", lngWidth), si.MaxAppAddress
    Debug.Print Pad("MidEastEnabled: ", lngWidth), si.MidEastEnabled
    Debug.Print Pad("MinAppAddress: ", lngWidth), si.MinAppAddress
    Debug.Print Pad("NetworkPresent: ", lngWidth), si.NetworkPresent
    Debug.Print Pad("NumberOfProcessors: ", lngWidth), si.NumberOfProcessors
    Debug.Print Pad("OSBuild: ", lngWidth), si.OSBuild
    Debug.Print Pad("OSExtraInfo: ", lngWidth), si.OSExtraInfo
    Debug.Print Pad("OSMajorVersion: ", lngWidth), si.OSMajorVersion
    Debug.Print Pad("OSMinorVersion: ", lngWidth), si.OSMinorVersion
    Debug.Print Pad("OSVersion: ", lngWidth), si.OSVersion
    Debug.Print Pad("Pagesize: ", lngWidth), si.PageSize
    Debug.Print Pad("ProcessorArchitecture: ", lngWidth), si.ProcessorArchitecture
    Debug.Print Pad("ProcessorLevel: ", lngWidth), si.ProcessorLevel
    Debug.Print Pad("ProcessorRevision: ", lngWidth), si.ProcessorRevision
    Debug.Print Pad("ProcessorType: ", lngWidth), si.ProcessorType
    Debug.Print Pad("ProductType: ", lngWidth), si.ProductType
    Debug.Print Pad("RaiseErrors: ", lngWidth), si.RaiseErrors
    Debug.Print Pad("ScreenSaverActive: ", lngWidth), si.ScreenSaverActive
    Debug.Print Pad("ScreenSaverRunning: ", lngWidth), si.ScreenSaverRunning
    Debug.Print Pad("ScreenSaverTimeout: ", lngWidth), si.ScreenSaverTimeout
    Debug.Print Pad("Secure: ", lngWidth), si.Secure
    Debug.Print Pad("ServicePackMajorVersion: ", lngWidth), si.ServicePackMajorVersion
    Debug.Print Pad("ServicePackMinorVersion: ", lngWidth), si.ServicePackMinorVersion
    Debug.Print Pad("ShowSounds: ", lngWidth), si.ShowSounds
    Debug.Print Pad("SlowMachine: ", lngWidth), si.SlowMachine
    Debug.Print Pad("SystemDirectory: ", lngWidth), si.SystemDirectory
    Debug.Print Pad("TempPath: ", lngWidth), si.TempPath
    Debug.Print Pad("UserName: ", lngWidth), si.UserName
    Debug.Print Pad("WIN32_IE: ", lngWidth), si.WIN32_IE
    Debug.Print Pad("WIN32_WINDOWS: ", lngWidth), si.WIN32_WINDOWS
    Debug.Print Pad("WIN32_WINNT: ", lngWidth), si.WIN32_WINNT
    Debug.Print Pad("WindowsDirectory: ", lngWidth), si.WindowsDirectory
    Debug.Print Pad("WindowsExtension: ", lngWidth), si.WindowsExtension
    Debug.Print Pad("WINVER: ", lngWidth), si.WINVER
    Set si = Nothing
End Sub

Public Sub TestNames()
    Dim si As SystemInfo
    Dim lngWidth As Long
    
    Set si = New SystemInfo
    si.RaiseErrors = False
    
    lngWidth = 40
    Debug.Print Pad("ComputerNameDnsDomain: ", lngWidth), si.ComputerName(cnfComputerNameDnsDomain)
    Debug.Print Pad("ComputerNameDnsFullyQualified: ", lngWidth), si.ComputerName(cnfComputerNameDnsFullyQualified)
    Debug.Print Pad("ComputerNameDnsHostname: ", lngWidth), si.ComputerName(cnfComputerNameDnsHostname)
    Debug.Print Pad("ComputerNameMax: ", lngWidth), si.ComputerName(cnfComputerNameMax)
    Debug.Print Pad("ComputerNameNetBIOS: ", lngWidth), si.ComputerName(cnfComputerNameNetBIOS)
    Debug.Print Pad("ComputerNamePhysicalDnsDomain: ", lngWidth), si.ComputerName(cnfComputerNamePhysicalDnsDomain)
    Debug.Print Pad("ComputerNamePhysicalDnsFullyQualified: ", lngWidth), si.ComputerName(cnfComputerNamePhysicalDnsFullyQualified)
    Debug.Print Pad("ComputerNamePhysicalDnsHostname: ", lngWidth), si.ComputerName(cnfComputerNamePhysicalDnsHostname)
    Debug.Print Pad("ComputerNamePhysicalNetbios: ", lngWidth), si.ComputerName(cnfComputerNamePhysicalNetbios)
    
    Debug.Print Pad("NameCanonical: ", lngWidth), si.UserName(enfNameCanonical)
    Debug.Print Pad("NameCanonicalEx: ", lngWidth), si.UserName(enfNameCanonicalEx)
    Debug.Print Pad("NameDisplay: ", lngWidth), si.UserName(enfNameDisplay)
    Debug.Print Pad("NameFullyQualifiedDN: ", lngWidth), si.UserName(enfNameFullyQualifiedDN)
    Debug.Print Pad("NameSamCompatible: ", lngWidth), si.UserName(enfNameSamCompatible)
    Debug.Print Pad("NameServicePrincipal: ", lngWidth), si.UserName(enfNameServicePrincipal)
    Debug.Print Pad("NameUniqueId: ", lngWidth), si.UserName(enfNameUniqueId)
    Debug.Print Pad("NameUnknown: ", lngWidth), si.UserName(enfNameUnknown)
    Debug.Print Pad("NameUserPrincipal: ", lngWidth), si.UserName(enfNameUserPrincipal)
End Sub

Public Sub TestAccessibility()
    Dim acc As Accessibility
    Dim lngWidth As Long
    Set acc = New Accessibility
    
    lngWidth = 25
    acc.RaiseErrors = False
    Debug.Print "==== AccessTimeout"
    Debug.Print Pad("atActive:", lngWidth), acc.atActive
    Debug.Print Pad("atAvailable:", lngWidth), acc.atAvailable
    Debug.Print Pad("atFeedback:", lngWidth), acc.atFeedback
    Debug.Print Pad("atTimeOutMilliseconds:", lngWidth), acc.atTimeOutMilliseconds
    Debug.Print
    Debug.Print "==== FilterKeys"
    Debug.Print Pad("fkActive:", lngWidth), acc.fkActive
    Debug.Print Pad("fkAvailable:", lngWidth), acc.fkAvailable
    Debug.Print Pad("fkBounceMSec:", lngWidth), acc.fkBounceMSec
    Debug.Print Pad("fkClickOn:", lngWidth), acc.fkClickOn
    Debug.Print Pad("fkDelayMSec:", lngWidth), acc.fkDelayMSec
    Debug.Print Pad("fkHotkeyActive:", lngWidth), acc.fkHotkeyActive
    Debug.Print Pad("fkHotKeyConfirm:", lngWidth), acc.fkHotKeyConfirm
    Debug.Print Pad("fkHotKeySound:", lngWidth), acc.fkHotKeySound
    Debug.Print Pad("fkIndicator:", lngWidth), acc.fkIndicator
    Debug.Print Pad("fkRepeatMSec:", lngWidth), acc.fkRepeatMSec
    Debug.Print Pad("fkWaitMSec:", lngWidth), acc.fkWaitMSec
    Debug.Print
    Debug.Print "==== HighContrast"
    Debug.Print Pad("hcAvailable:", lngWidth), acc.hcAvailable
    Debug.Print Pad("hcConfirmHotKey:", lngWidth), acc.hcConfirmHotKey
    Debug.Print Pad("hcHighContrastOn:", lngWidth), acc.hcHighContrastOn
    Debug.Print Pad("hcHotKeyActive:", lngWidth), acc.hcHotKeyActive
    Debug.Print Pad("hcHotKeyAvailable:", lngWidth), acc.hcHotKeyAvailable
    Debug.Print Pad("hcHotKeySound:", lngWidth), acc.hcHotKeySound
    Debug.Print
    Debug.Print "==== MouseKeys"
    Debug.Print Pad("mkActive:", lngWidth), acc.mkActive
    Debug.Print Pad("mkAvailable:", lngWidth), acc.mkAvailable
    Debug.Print Pad("mkConfirmHotKey:", lngWidth), acc.mkConfirmHotKey
    Debug.Print Pad("mkCtrlSpeed:", lngWidth), acc.mkCtrlSpeed
    Debug.Print Pad("mkHotKeyActive:", lngWidth), acc.mkHotKeyActive
    Debug.Print Pad("mkHotKeySound:", lngWidth), acc.mkHotKeySound
    Debug.Print Pad("mkIndicator:", lngWidth), acc.mkIndicator
    Debug.Print Pad("mkLeftButtonDown:", lngWidth), acc.mkLeftButtonDown
    Debug.Print Pad("mkLeftButtonSel:", lngWidth), acc.mkLeftButtonSel
    Debug.Print Pad("mkMaxSpeed:", lngWidth), acc.mkMaxSpeed
    Debug.Print Pad("mkModifiers:", lngWidth), acc.mkModifiers
    Debug.Print Pad("mkMouseKeysOn:", lngWidth), acc.mkMouseKeysOn
    Debug.Print Pad("mkMouseMode:", lngWidth), acc.mkMouseMode
    Debug.Print Pad("mkReplaceNumbers:", lngWidth), acc.mkReplaceNumbers
    Debug.Print Pad("mkRightButtonDown:", lngWidth), acc.mkRightButtonDown
    Debug.Print Pad("mkRightButtonSel:", lngWidth), acc.mkRightButtonSel
    Debug.Print Pad("mkTimeToMaxSpeed:", lngWidth), acc.mkTimeToMaxSpeed
    Debug.Print
    Debug.Print "==== ShowSounds"
    Debug.Print Pad("shActive:", lngWidth), acc.shActive
    Debug.Print
    Debug.Print "==== StickyKeys"
    Debug.Print Pad("skActive:", lngWidth), acc.skActive
    Debug.Print Pad("skAudibleFeedback:", lngWidth), acc.skAudibleFeedback
    Debug.Print Pad("skAvailable:", lngWidth), acc.skAvailable
    Debug.Print Pad("skConfirmHotKey:", lngWidth), acc.skConfirmHotKey
    Debug.Print Pad("skHotKeyActive:", lngWidth), acc.skHotKeyActive
    Debug.Print Pad("skHotKeySound:", lngWidth), acc.skHotKeySound
    Debug.Print Pad("skIndicator:", lngWidth), acc.skIndicator
    Debug.Print Pad("skLeftAltLatched:", lngWidth), acc.skLeftAltLatched
    Debug.Print Pad("skLeftAltLocked:", lngWidth), acc.skLeftAltLocked
    Debug.Print Pad("skLeftCtlLatched:", lngWidth), acc.skLeftCtlLatched
    Debug.Print Pad("skLeftCtlLocked:", lngWidth), acc.skLeftCtlLocked
    Debug.Print Pad("skLeftShiftLatched:", lngWidth), acc.skLeftShiftLatched
    Debug.Print Pad("skLeftShiftLocked:", lngWidth), acc.skLeftShiftLocked
    Debug.Print Pad("skLeftWinLatched:", lngWidth), acc.skLeftWinLatched
    Debug.Print Pad("skLeftWinLocked:", lngWidth), acc.skLeftWinLocked
    Debug.Print Pad("skRightAltLatched:", lngWidth), acc.skRightAltLatched
    Debug.Print Pad("skRightAltLocked:", lngWidth), acc.skRightAltLocked
    Debug.Print Pad("skRightCtlLatched:", lngWidth), acc.skRightCtlLatched
    Debug.Print Pad("skRightCtlLocked:", lngWidth), acc.skRightCtlLocked
    Debug.Print Pad("skRightShiftLatched:", lngWidth), acc.skRightShiftLatched
    Debug.Print Pad("skRightShiftLocked:", lngWidth), acc.skRightShiftLocked
    Debug.Print Pad("skRightWinLatched:", lngWidth), acc.skRightWinLatched
    Debug.Print Pad("skRightWinLocked:", lngWidth), acc.skRightWinLocked
    Debug.Print Pad("skTriState:", lngWidth), acc.skTriState
    Debug.Print Pad("skTwoKeysOff:", lngWidth), acc.skTwoKeysOff
    Debug.Print
    Debug.Print "==== SoundSentry"
    Debug.Print Pad("ssActive:", lngWidth), acc.ssActive
    Debug.Print Pad("ssAvailable:", lngWidth), acc.ssAvailable
    Debug.Print Pad("ssFSGraphicEffect:", lngWidth), acc.ssFSGraphicEffect
    Debug.Print Pad("ssFSGraphicEffectColor:", lngWidth), acc.ssFSGraphicEffectColor
    Debug.Print Pad("ssFSGraphicEffectMSec:", lngWidth), acc.ssFSGraphicEffectMSec
    Debug.Print Pad("ssFSTextEffect:", lngWidth), acc.ssFSTextEffect
    Debug.Print Pad("ssFSTextEffectColorBits:", lngWidth), acc.ssFSTextEffectColorBits
    Debug.Print Pad("ssFSTextEffectMSec:", lngWidth), acc.ssFSTextEffectMSec
    Debug.Print Pad("ssWindowsEffect:", lngWidth), acc.ssWindowsEffect
    Debug.Print Pad("ssWindowsEffectMSec:", lngWidth), acc.ssWindowsEffectMSec
    Debug.Print
    Debug.Print "==== ToggleKeys"
    Debug.Print Pad("tkActive:", lngWidth), acc.tkActive
    Debug.Print Pad("tkAvailable:", lngWidth), acc.tkAvailable
    Debug.Print Pad("tkConfirmHotKey:", lngWidth), acc.tkConfirmHotKey
    Debug.Print Pad("tkHotKeyActive:", lngWidth), acc.tkHotKeyActive
    Debug.Print Pad("tkHotKeySound:", lngWidth), acc.tkHotKeySound
End Sub

Public Sub TestMemoryStatus()
    Dim ms As MemoryStatus
    Dim lngWidth As Long
    
    Set ms = New MemoryStatus
    
    lngWidth = 25
    ms.RaiseErrors = False
    Debug.Print Pad("AvailableExtendedVirtual:", lngWidth), Pad(Format(ms.AvailableExtendedVirtual, "#,##0"), 15, False)
    Debug.Print Pad("AvailablePageFile:", lngWidth), Pad(Format(ms.AvailablePageFile, "#,##0"), 15, False)
    Debug.Print Pad("AvailablePhysical:", lngWidth), Pad(Format(ms.AvailablePhysical, "#,##0"), 15, False)
    Debug.Print Pad("AvailableVirtual:", lngWidth), Pad(Format(ms.AvailableVirtual, "#,##0"), 15, False)
    Debug.Print Pad("MemoryLoad:", lngWidth), Pad(Format(ms.MemoryLoad, "#,##0"), 15, False)
    Debug.Print Pad("TotalPageFile:", lngWidth), Pad(Format(ms.TotalPageFile, "#,##0"), 15, False)
    Debug.Print Pad("TotalPhysical:", lngWidth), Pad(Format(ms.TotalPhysical, "#,##0"), 15, False)
    Debug.Print Pad("TotalVirtual:", lngWidth), Pad(Format(ms.TotalVirtual, "#,##0"), 15, False)
    Set ms = Nothing
End Sub

Public Sub TestMouse()
    Dim ms As Mouse
    Dim lngWidth As Long
    
    Set ms = New Mouse
    lngWidth = 25
    ms.RaiseErrors = False
    Debug.Print Pad("ActiveWindowTracking:", lngWidth), ms.ActiveWindowTracking
    Debug.Print Pad("ActiveWindowTrackingTimeOut:", lngWidth), ms.ActiveWindowTrackingTimeOut
    Debug.Print Pad("Buttons:", lngWidth), ms.Buttons
    Debug.Print Pad("CaretWidth:", lngWidth), ms.CaretWidth
    Debug.Print Pad("CursorShadow:", lngWidth), ms.CursorShadow
    Debug.Print Pad("CursorX:", lngWidth), ms.CursorX
    Debug.Print Pad("CursorY:", lngWidth), ms.CursorY
    Debug.Print Pad("DoubleClickX:", lngWidth), ms.DoubleClickX
    Debug.Print Pad("DoubleClickY:", lngWidth), ms.DoubleClickY
    Debug.Print Pad("DragX:", lngWidth), ms.DragX
    Debug.Print Pad("DragY:", lngWidth), ms.DragY
    Debug.Print Pad("HoverDelay:", lngWidth), ms.HoverDelay
    Debug.Print Pad("HoverX:", lngWidth), ms.HoverX
    Debug.Print Pad("HoverY:", lngWidth), ms.HoverY
    Debug.Print Pad("MenuDelay:", lngWidth), ms.MenuDelay
    Debug.Print Pad("MouseButtonSwap:", lngWidth), ms.MouseButtonSwap
    Debug.Print Pad("MousePresent:", lngWidth), ms.MousePresent
    Debug.Print Pad("MouseSpeed:", lngWidth), ms.MouseSpeed
    Debug.Print Pad("MouseThreshHold1:", lngWidth), ms.MouseThreshHold1
    Debug.Print Pad("MouseThreshHold2:", lngWidth), ms.MouseThreshHold2
    Debug.Print Pad("MouseTrails:", lngWidth), ms.MouseTrails
    Debug.Print Pad("SnapToDefault:", lngWidth), ms.SnapToDefault
    Debug.Print Pad("TrackedWindowToTop:", lngWidth), ms.TrackedWindowToTop
    Debug.Print Pad("WheelPresent:", lngWidth), ms.WheelPresent
    Debug.Print Pad("WheelScrollLines:", lngWidth), ms.WheelScrollLines
    
    
    Set ms = Nothing
End Sub

Public Sub TestPowerStatus()
    Dim ps As PowerStatus
    Set ps = New PowerStatus
    Dim strOut As String
    ps.RaiseErrors = False
    Select Case ps.ACLineStatus
        Case AC_LINE_OFFLINE
            strOut = "Batteries"
        Case AC_LINE_ONLINE
            strOut = "Plugged in"
        Case AC_LINE_BACKUP_POWER
            strOut = "Using backup power"
        Case AC_LINE_UNKNOWN
            strOut = "Unknown"
    End Select
    Debug.Print strOut
    
        Select Case ps.BatteryState
            Case BATTERY_FLAG_HIGH
                strOut = "Full charge"
            Case BATTERY_FLAG_LOW
                strOut = "Low charge"
            Case BATTERY_FLAG_CRITICAL
                strOut = "Critical"
            Case BATTERY_FLAG_NO_BATTERY
                strOut = "No battery"
            Case BATTERY_FLAG_UNKNOWN
                strOut = "Unknown"
        End Select
    Debug.Print strOut
    Debug.Print ps.DrivePowerState("C")
    ps.Suspend
End Sub

Public Sub TestScreen()
    Dim sc As ScreenInfo
    Dim lngWidth As Long
    
    Set sc = New ScreenInfo
    
    lngWidth = 25
    sc.RaiseErrors = False
    Debug.Print Pad("Border3DX:", lngWidth), sc.Border3DX
    Debug.Print Pad("Border3DY:", lngWidth), sc.Border3DY
    Debug.Print Pad("BorderMultiplier:", lngWidth), sc.BorderMultiplier
    Debug.Print Pad("CaptionBarButtonX:", lngWidth), sc.CaptionBarButtonX
    Debug.Print Pad("CaptionBarButtonY:", lngWidth), sc.CaptionBarButtonY
    Debug.Print Pad("CaptionButtonX:", lngWidth), sc.CaptionButtonX
    Debug.Print Pad("CaptionButtonY:", lngWidth), sc.CaptionButtonY
    Debug.Print Pad("CaptionHeight:", lngWidth), sc.CaptionHeight
    Debug.Print Pad("ComboBoxAnimation:", lngWidth), sc.ComboBoxAnimation
    Debug.Print Pad("DesktopWallpaper:", lngWidth), sc.DesktopWallpaper
    Debug.Print Pad("DragFullWindows:", lngWidth), sc.DragFullWindows
    Debug.Print Pad("FixedBorderX:", lngWidth), sc.FixedBorderX
    Debug.Print Pad("FixedBorderY:", lngWidth), sc.FixedBorderY
    Debug.Print Pad("ForegroundFlashCount:", lngWidth), sc.ForegroundFlashCount
    Debug.Print Pad("ForegroundLockTimeOut:", lngWidth), sc.ForegroundLockTimeOut
    Debug.Print Pad("FullScreenX:", lngWidth), sc.FullScreenX
    Debug.Print Pad("FullScreenY:", lngWidth), sc.FullScreenY
    Debug.Print Pad("GradientCaptions:", lngWidth), sc.GradientCaptions
    Debug.Print Pad("GridGranularity:", lngWidth), sc.GridGranularity
    Debug.Print Pad("HorizontalScrollX:", lngWidth), sc.HorizontalScrollX
    Debug.Print Pad("HorizontalScrollY:", lngWidth), sc.HorizontalScrollY
    Debug.Print Pad("HotTracking:", lngWidth), sc.HotTracking
    Debug.Print Pad("IconFontName:", lngWidth), sc.IconFontName
    Debug.Print Pad("IconFontSize:", lngWidth), sc.IconFontSize
    Debug.Print Pad("IconHorizontalSpacing:", lngWidth), sc.IconHorizontalSpacing
    Debug.Print Pad("IconSizeX:", lngWidth), sc.IconSizeX
    Debug.Print Pad("IconSizeY:", lngWidth), sc.IconSizeY
    Debug.Print Pad("IconSpacingX:", lngWidth), sc.IconSpacingX
    Debug.Print Pad("IconSpacingY:", lngWidth), sc.IconSpacingY
    Debug.Print Pad("IconTitleWrap:", lngWidth), sc.IconTitleWrap
    Debug.Print Pad("IconVerticalSpacing:", lngWidth), sc.IconVerticalSpacing
    Debug.Print Pad("KanjiWindow:", lngWidth), sc.KanjiWindow
    Debug.Print Pad("ListboxSmoothScrolling:", lngWidth), sc.ListboxSmoothScrolling
    Debug.Print Pad("MaximizedX:", lngWidth), sc.MaximizedX
    Debug.Print Pad("MaximizedY:", lngWidth), sc.MaximizedY
    Debug.Print Pad("MaxTrackX:", lngWidth), sc.MaxTrackX
    Debug.Print Pad("MaxTrackY:", lngWidth), sc.MaxTrackY
    Debug.Print Pad("MenuAnimation:", lngWidth), sc.MenuAnimation
    Debug.Print Pad("MenuBarButtonsX:", lngWidth), sc.MenuBarButtonsX
    Debug.Print Pad("MenuBarButtonsY:", lngWidth), sc.MenuBarButtonsY
    Debug.Print Pad("MenuCheckX:", lngWidth), sc.MenuCheckX
    Debug.Print Pad("MenuCheckY:", lngWidth), sc.MenuCheckY
    Debug.Print Pad("MenuDropAlignment:", lngWidth), sc.MenuDropAlignment
    Debug.Print Pad("MenuFade:", lngWidth), sc.MenuFade
    Debug.Print Pad("MenuHeight:", lngWidth), sc.MenuHeight
    Debug.Print Pad("MenuKeysAlwaysUnderlined:", lngWidth), sc.MenuKeysAlwaysUnderlined
    Debug.Print Pad("MinAnimation:", lngWidth), sc.MinAnimation
    Debug.Print Pad("MinimizedX:", lngWidth), sc.MinimizedX
    Debug.Print Pad("MinimizedY:", lngWidth), sc.MinimizedY
    Debug.Print Pad("MinimumX:", lngWidth), sc.MinimumX
    Debug.Print Pad("MinimumY:", lngWidth), sc.MinimumY
    Debug.Print Pad("MinSpacingX:", lngWidth), sc.MinSpacingX
    Debug.Print Pad("MinSpacingY:", lngWidth), sc.MinSpacingY
    Debug.Print Pad("MinTrackX:", lngWidth), sc.MinTrackX
    Debug.Print Pad("MinTrackY:", lngWidth), sc.MinTrackY
    Debug.Print Pad("MonitorCount:", lngWidth), sc.MonitorCount
    Debug.Print Pad("PenWindows:", lngWidth), sc.PenWindows
    Debug.Print Pad("SameDisplayFormat:", lngWidth), sc.SameDisplayFormat
    Debug.Print Pad("ScreenX:", lngWidth), sc.ScreenX
    Debug.Print Pad("ScreenY:", lngWidth), sc.ScreenY
    Debug.Print Pad("SelectionFade:", lngWidth), sc.SelectionFade
    Debug.Print Pad("SizingBorderX:", lngWidth), sc.SizingBorderX
    Debug.Print Pad("SizingBorderY:", lngWidth), sc.SizingBorderY
    Debug.Print Pad("SmallCaption:", lngWidth), sc.SmallCaption
    Debug.Print Pad("SmallIconX:", lngWidth), sc.SmallIconX
    Debug.Print Pad("SmallIconY:", lngWidth), sc.SmallIconY
    Debug.Print Pad("ThumbX:", lngWidth), sc.ThumbX
    Debug.Print Pad("ThumbY:", lngWidth), sc.ThumbY
    Debug.Print Pad("TooltipAnimation:", lngWidth), sc.TooltipAnimation
    Debug.Print Pad("TooltipFade:", lngWidth), sc.TooltipFade
    Debug.Print Pad("UIEffects:", lngWidth), sc.UIEffects
    Debug.Print Pad("VerticalScrollX:", lngWidth), sc.VerticalScrollX
    Debug.Print Pad("VerticalScrollY:", lngWidth), sc.VerticalScrollY
    Debug.Print Pad("VirtualScreenHeight:", lngWidth), sc.VirtualScreenHeight
    Debug.Print Pad("VirtualScreenWidth:", lngWidth), sc.VirtualScreenWidth
    Debug.Print Pad("WindowBorderX:", lngWidth), sc.WindowBorderX
    Debug.Print Pad("WindowBorderY:", lngWidth), sc.WindowBorderY
    
End Sub

Private Function Pad(strValue As String, lngWidth As Long, _
 Optional OnRight As Boolean = True) As String
    If OnRight Then
        Pad = Left$(strValue & Space(lngWidth), lngWidth)
    Else
        Pad = right$(Space(lngWidth) & strValue, lngWidth)
    End If
End Function
    
