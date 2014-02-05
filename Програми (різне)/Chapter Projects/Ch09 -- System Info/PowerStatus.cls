VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PowerStatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' PowerStatus class.
' Set and retrieve information about the system power status.
' Nothing in here works under standard Windows NT 4.0.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Public Enum pwrACLineStatus
    AC_LINE_OFFLINE = &H0
    AC_LINE_ONLINE = &H1
    AC_LINE_BACKUP_POWER = &H2
    AC_LINE_UNKNOWN = &HFF
End Enum

Public Enum pwrBatteryFlag
    BATTERY_FLAG_HIGH = &H1
    BATTERY_FLAG_LOW = &H2
    BATTERY_FLAG_CRITICAL = &H4
    BATTERY_FLAG_CHARGING = &H8
    BATTERY_FLAG_NO_BATTERY = &H80
    BATTERY_FLAG_UNKNOWN = &HFF
End Enum

Private Const BATTERY_PERCENTAGE_UNKNOWN = &HFF

Public Enum pwrExecutionState
    ES_SYSTEM_REQUIRED = &H1
    ES_DISPLAY_REQUIRED = &H2
    ES_USER_PRESENT = &H4
    ES_CONTINUOUS = &H80000000
End Enum

Public Enum pwrLatencyTime
    LT_DONT_CARE = 0
    LT_LOWEST_LATENCY = 1
End Enum

Private Const BATTERY_LIFE_UNKNOWN = &HFFFFFFFF

Private Type SYSTEM_POWER_STATUS
    ACLineStatus As Byte
    BatteryFlag As Byte
    BatteryLifePercent As Byte
    Reserved1 As Byte
    BatteryLifeTime As Long
    BatteryFullLifeTime As Long
End Type

Private sps As SYSTEM_POWER_STATUS

Private Declare Function GetSystemPowerStatus _
 Lib "kernel32" _
 (lpSystemPowerStatus As SYSTEM_POWER_STATUS) As Long
 
Private Declare Function SetSystemPowerState _
 Lib "kernel32" _
 (ByVal fSuspend As Long, ByVal fForce As Long) As Long
 
Private Declare Function GetDevicePowerState _
 Lib "kernel32" _
 (ByVal hDevice As Long, pfOn As Long) As Long
 
Private Declare Function IsSystemResumeAutomatic _
 Lib "kernel32" () As Long
 
Private Declare Function RequestDeviceWakeup _
 Lib "kernel32" _
 (ByVal hHandle As Long) As Long
 
Private Declare Function CancelDeviceWakeupRequest _
 Lib "kernel32" _
 (ByVal hHandle As Long) As Long
 
Private Declare Function SetThreadExecutionState _
 Lib "kernel32" _
 (ByVal esFlags As pwrExecutionState) As Long

Private Declare Function RequestWakeupLatency _
 Lib "kernel32" _
 (ByVal latency As pwrLatencyTime) As Long
    
Private Declare Function CreateFile _
 Lib "kernel32" Alias "CreateFileA" _
 (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, _
 ByVal lpSecurityAttributes As Long, ByVal dwCreationDisposition As Long, _
 ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
 
Private Declare Function CloseHandle _
 Lib "kernel32" _
 (ByVal hObject As Long) As Long

Private Const GENERIC_READ = &H80000000
Private Const GENERIC_WRITE = &H40000000
Private Const FILE_SHARE_READ = &H1
Private Const FILE_SHARE_WRITE = &H2
Private Const OPEN_EXISTING = 3
Private Const INVALID_HANDLE_VALUE = -1
  
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
Private mblnIsWin95 As Boolean

Public Sub WakeUpLatency(TimeValue As pwrLatencyTime)
    ' function specifies roughly how quickly the computer
    ' should enter the working state.
    ' The function will return false if the device does not support
    ' wake-up operations or if the system is entering the sleeping state.
    If mlngWINVER >= 5& Then
        Call RequestWakeupLatency(TimeValue)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Sub

Public Sub RemainAwake(State As pwrExecutionState)
    ' function enables applications to inform the system that it is in use,
    ' thereby preventing the system from entering the sleeping power
    ' state while the application is running.
    If mlngWINVER >= 5& Then
        Call SetThreadExecutionState(State)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Sub

Public Sub RequestWakeup(ByVal DriveCharacter As String)
    ' issues a device wake-up request.
    ' Function returns false if the device does not support
    ' wake-up, the system is entering the sleeping state,
    ' or wake-up could not be enabled.
    Dim hDevice As Long
    
    If mlngWINVER >= 5& Then
        ' only one character, the drive letter, is required
        If Len(DriveCharacter) > 1 Then
            DriveCharacter = Left$(DriveCharacter, 1)
        End If
        hDevice = GetDeviceHandle("\\.\" & DriveCharacter & ":")
        Call RequestDeviceWakeup(hDevice)
        Call CloseHandle(hDevice)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Sub

Public Sub CancelWakeUpRequest(ByVal DriveCharacter As String)
    ' cancels a device wake-up request issued
    ' previously by RequestWakeUp.
    ' The function will return false if the device does not
    ' support wake-up or if the system is entering
    ' the sleeping state.
    ' The wake-up functionality may not be turned off immediately.
    Dim hDevice As Long
    
    If mlngWINVER >= 5& Then
        ' only one character, the drive letter, is required
        If Len(DriveCharacter) > 1 Then
            DriveCharacter = Left$(DriveCharacter, 1)
        End If
        hDevice = GetDeviceHandle("\\.\" & DriveCharacter & ":")
        Call CancelDeviceWakeupRequest(hDevice)
        Call CloseHandle(hDevice)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Sub

Public Property Get IsSystemResumeAuto() As Boolean
    ' If the system was restored to the working state automatically
    ' and the user is not active, the function returns True,
    ' otherwise false
    If mlngWINVER >= 5& Then
        IsSystemResumeAuto = CBool(IsSystemResumeAutomatic)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get DrivePowerState(ByVal DriveCharacter As String) As Boolean
    ' returns True if the device is fully on. Otherwise, False.
    Dim lngState As Long
    Dim hDevice As Long

    ' This Public Property is only valid on Win2000 and Win98
    If mlngWINVER >= 5& Then
        ' only one character, the drive letter, is required
        If Len(DriveCharacter) > 1 Then
            DriveCharacter = Left$(DriveCharacter, 1)
        End If

        hDevice = GetDeviceHandle("\\.\" & DriveCharacter & ":")
        ' pass the handle to the PowerState API
        If CBool(GetDevicePowerState(hDevice, lngState)) Then
            DrivePowerState = CBool(lngState)
            ' close the handle to the device
        End If
        Call CloseHandle(hDevice)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Private Function GetDeviceHandle(strDeviceName As String) As Long
    ' returns a handle to the specified device
    ' Make sure you close the handle with CloseHandle after use !
    Dim hDevice As Long
    
    ' get a handle to the device
    hDevice = CreateFile( _
     strDeviceName, 0, _
     FILE_SHARE_READ Or FILE_SHARE_WRITE, _
     0, OPEN_EXISTING, 0, 0)
    
    ' if a valid handle was returned
    If Not hDevice = INVALID_HANDLE_VALUE Then
        ' return the handle
        GetDeviceHandle = hDevice
    End If
End Function

Public Property Get ACLineStatus() As pwrACLineStatus
    ' AC power status. 0 = offline, 1 = online,
    ' BackupPower = 2, 255 = unknown.
    
    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            ACLineStatus = sps.ACLineStatus
        Else
            ACLineStatus = AC_LINE_UNKNOWN
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get BatteryState() As pwrBatteryFlag
    ' Battery charge status.
    ' 1 = High, 2 = Low, 4 = Critical, 128 = No system battery, 255 = Unknown.

    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            If sps.BatteryFlag = BATTERY_FLAG_UNKNOWN Then
                BatteryState = sps.BatteryFlag
            Else
                ' Return the battery flag, with the charging bit cleared.
                BatteryState = sps.BatteryFlag And Not BATTERY_FLAG_CHARGING
            End If
        Else
            BatteryState = BATTERY_FLAG_UNKNOWN
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get BatteryCharging() As Boolean
    ' Is the battery currently charging?
    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            BatteryCharging = _
             (sps.BatteryFlag And BATTERY_FLAG_CHARGING = BATTERY_FLAG_CHARGING)
        Else
            BatteryCharging = False
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get BatteryLifePercent() As Byte
    ' Percentage of battery charge remaining from 0 to 100, 255 if unknown.
    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            BatteryLifePercent = sps.BatteryLifePercent
        Else
            BatteryLifePercent = BATTERY_PERCENTAGE_UNKNOWN
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get BatteryLifeTime() As Long
    ' Number of seconds of battery life remaining, -1 if unknown.

    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            BatteryLifeTime = sps.BatteryLifeTime
        Else
            BatteryLifeTime = BATTERY_LIFE_UNKNOWN
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Property Get BatteryFullLifeTime() As Long
    ' Number of seconds of battery life available when the battery
    ' is at full charge, &HFFFFFFFF if unknown. This estimate
    ' is based on the BatteryLifeTime and BatteryLifePercent fields.
    If mlngWINVER >= 5& Or mblnIsWin95 Then
        If GetSystemPowerStatus(sps) Then
            BatteryFullLifeTime = sps.BatteryFullLifeTime
        Else
            BatteryFullLifeTime = BATTERY_LIFE_UNKNOWN
        End If
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Public Function Suspend() As Long
    ' Suspend the computer, if possible.
    ' If power has been suspended and subsequently
    ' restored, the return value is nonzero.
    If mlngWINVER >= 5& Or mblnIsWin95 Then
        Suspend = SetSystemPowerState(True, True)
     Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Function

Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, "PowerStatus", .Description, .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "PowerStatus", ERR_STRING
            End If
        End If
    End With
End Sub

Private Sub Class_Initialize()
    Dim blnIsWin2000 As Boolean
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
            ' if it's Win98 or Win2000 then
            ' Winver = 5
            blnIsWin2000 = (.dwPlatformId = VER_PLATFORM_WIN32_NT And .dwMajorVersion = 5)
            blnIsWin98 = (.dwMajorVersion = 4 And _
             (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS And .dwMinorVersion > 0))
            mblnIsWin95 = (.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS _
             And .dwMinorVersion = 0)
            If blnIsWin98 Or blnIsWin2000 Then
                mlngWINVER = 5&
            End If
        End With
    End If
End Sub


