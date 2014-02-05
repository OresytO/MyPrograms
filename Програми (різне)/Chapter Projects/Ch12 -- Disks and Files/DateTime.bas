Attribute VB_Name = "basDatesAndTimes"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

Type SYSTEMTIME
    intYear As Integer
    intMonth As Integer
    intDayOfWeek As Integer
    intDay As Integer
    intHour As Integer
    intMinute As Integer
    intSecond As Integer
    intMilliseconds As Integer
End Type

Type FILETIME
    lngLowDateTime As Long
    lngHighDateTime As Long
End Type

Type dhtypFileTimes
    datCreated As Date
    datAccessed As Date
    datModified As Date
End Type

Type TIME_ZONE_INFORMATION
    Bias As Long
    StandardName(32) As Integer
    StandardDate As SYSTEMTIME
    StandardBias As Long
    DaylightName(32) As Integer
    DaylightDate As SYSTEMTIME
    DaylightBias As Long
End Type

' Functions for system time
Private Declare Sub GetLocalTime Lib "kernel32" (lpSysTime As SYSTEMTIME)
Private Declare Sub GetSystemTime Lib "kernel32" (lpSysTime As SYSTEMTIME)
 
' Functions for time zone information
Private Declare Function GetTimeZoneInformation Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Long
Private Declare Function SetTimeZoneInformation Lib "kernel32" (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Long

' Routines to convert back and forth
' between system time and file time
Private Declare Function SystemTimeToFileTime Lib "kernel32" (lpSystemTime As SYSTEMTIME, lpFileTime As FILETIME) As Long
Private Declare Function FileTimeToLocalFileTime Lib "kernel32" (lpFileTime As FILETIME, lpLocalFileTime As FILETIME) As Long
Private Declare Function LocalFileTimeToFileTime Lib "kernel32" (lpLocalFileTime As FILETIME, lpFileTime As FILETIME) As Long
Private Declare Function FileTimeToSystemTime Lib "kernel32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Long

' Functions for getting/setting/comparing file times
Private Declare Function GetFileTime Lib "kernel32" _
 (ByVal hFile As Long, lpCreationTime As FILETIME, _
 lpLastAccessTime As FILETIME, _
 lpLastWriteTime As FILETIME) As Long
 
Private Declare Function SetFileTime Lib "kernel32" _
 (ByVal hFile As Long, lpCreationTime As FILETIME, _
 lpLastAccessTime As FILETIME, _
 lpLastWriteTime As FILETIME) As Long
 
Private Declare Function CompareFileTime Lib "kernel32" _
 (lpFileTime1 As FILETIME, lpFileTime2 As FILETIME) As Long

' Our own time constants
Public Const dhcFileTimeCreated = 1
Public Const dhcFileTimeAccessed = 2
Public Const dhcFileTimeModified = 4

Function dhSysTimeToVBATime(stSysTime As SYSTEMTIME) As Date

    ' Converts Windows SYSTEMTIME to VBA date/time.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   stSysTime
    '       Pointer to a SYSTEMTIME structure.
    ' Out:
    '   Return Value:
    '       Equivalent VBA date/time value.
    ' Example:
    '   Dim stCurrent As SYSTEMTIME
    '   Dim datTime As Date
    '
    '   With stCurrent
    '       .intYear = 1997
    '       .intMonth = 2
    '       .intDay = 23
    '   End With
    '   datTime = dhSysTimeToVBATime(stCurrent)

    ' Consrtuct a VBA date/time value using the
    ' DateSerial and TimeSerial functions
    With stSysTime
        dhSysTimeToVBATime = _
         DateSerial(.intYear, .intMonth, .intDay) + _
         TimeSerial(.intHour, .intMinute, .intSecond)
    End With
End Function

Sub dhVBATimeToSysTime(datTime As Date, stSysTime As SYSTEMTIME)

    ' Converts a VBA date/time to SYSTEMTIME.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   datTime
    '       VBA date/time value.
    '   stSysTime
    '       Pointer to SYSTEMTIME variable.
    ' Out:
    '   stSysTime
    '       Converted date/time.
    '   Return Value:
    '       n/a
    ' Example:
    '   Dim stCurrent As SYSTEMTIME
    '
    '   Call dhVBATimeToSysTime(Now, stCurrent)

    ' Fill in the structure with date and time parts
    With stSysTime
        .intMonth = Month(datTime)
        .intDay = Day(datTime)
        .intYear = Year(datTime)
        
        .intHour = Hour(datTime)
        .intMinute = Minute(datTime)
        .intSecond = Second(datTime)
    End With
End Sub

Function dhFileTimeToVBATime(ftFileTime As FILETIME, _
 Optional fLocal As Boolean = True) As Date

    ' Converts Windows FILETIME date/time value to VBA.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   ftFileTime
    '       Pointer to FILETIME variable.
    '   fLocal (Optional, default = True)
    '       If True, time is expressed in local time,
    '       otherwise time is expressed in GMT.
    ' Out:
    '   Return Value:
    '       VBA date/time value.
    ' Example:
    '   Dim ft As FILETIME
    '   Dim datTime as Date
    '
    '   Call GetFileTime(ft, ft, ft)
    '
    '   datTime = dhFileTimeToVBATime(ft)

 
    Dim stSystem As SYSTEMTIME
    Dim ftLocalFileTime As FILETIME
    
    ' If the user wants local time, convert the file
    ' time to local file time
    If fLocal Then
        Call FileTimeToLocalFileTime(ftFileTime, ftLocalFileTime)
        ftFileTime = ftLocalFileTime
    End If
    
    ' Convert the file time to system time then
    ' call our own function to convert to VBA time
    If CBool(FileTimeToSystemTime(ftFileTime, stSystem)) Then
        dhFileTimeToVBATime = dhSysTimeToVBATime(stSystem)
    End If
End Function

Sub dhVBATimeToFileTime(datTime As Date, ftTime As FILETIME, _
 Optional fLocal As Boolean = True)

    ' Converts VBA date/time value to FILETIME.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   datTime
    '       VBA date/time value.
    '   ftTime
    '       Pointer to FILETIME variable.
    '   fLocal (Optional, default = True)
    '       If True, time is expressed in local time,
    '       otherwise time is expressed in GMT.
    ' Out:
    '   ftTime
    '       Converted date/time information.
    '   Return Value:
    '       n/a
    ' Example:
    '   Dim ft As FILETIME
    '
    '   Call dhVBATimeToFileTime(Now, ft)

    Dim stSystem As SYSTEMTIME
    Dim ftSystem As FILETIME
    
    ' Call our function to convert the VBA time to
    ' system time
    Call dhVBATimeToSysTime(datTime, stSystem)
    
    ' Convert the system time to file time
    If CBool(SystemTimeToFileTime(stSystem, ftTime)) Then
    
        ' If the VBA time was local time, convert the
        ' local file time to system file time
        If fLocal Then
            Call LocalFileTimeToFileTime(ftTime, ftSystem)
            ftTime = ftSystem
        End If
    End If
End Sub

Function dhGetFileTimes(strFile As String, _
 dftTimes As dhtypFileTimes) As Boolean

    ' Retrieves file times (created, modified,
    ' accessed) for a given file.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   dftTimes
    '       Pointer to a dhtypFileTimes structure.
    ' Out:
    '   dftTimes
    '       All three file time values.
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Dim dft As dhtypFileTimes
    '
    '   Call dhGetFileTimes("C:\AUTOEXEC.BAT", dft)

    Dim ftCreate As FILETIME
    Dim ftAccess As FILETIME
    Dim ftWrite As FILETIME
    Dim hFile As Long
    Dim lngRet As Long
    
    ' Open the file
    hFile = dhQuickOpenFile(strFile)
    If hFile > 0 Then
    
        ' Call GetFileTime to fetch time information
        ' into the local FILETIME structures
        If CBool(GetFileTime(hFile, ftCreate, _
         ftAccess, ftWrite)) Then
         
            ' If successful, convert the values to
            ' VBA Date format and return them in
            ' the passed dhtypFileTimes structure
            With dftTimes
                .datCreated = dhFileTimeToVBATime(ftCreate)
                .datAccessed = dhFileTimeToVBATime(ftAccess)
                .datModified = dhFileTimeToVBATime(ftWrite)
            End With
            
            ' Return success
            dhGetFileTimes = True
        End If
        
        ' Close the file
        Call CloseHandle(hFile)
    End If
End Function

Function dhGetFileTimesEx(strFile As String, _
 Optional intTime As Integer = dhcFileTimeModified) _
 As Date

    ' Retrieves a single file time value for a given file.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   intTime (Optional, default = dhcFileTimeModified)
    '       Specifies which time value to retrieve. Value is
    '       one the following constants:
    '           dhcFileTimeCreated
    '           dhcFileTimeModified
    '           dhcFileTimeAccessed
    ' Out:
    '   Return Value:
    '       File time as a VBA date/time value.
    ' Example:
    '   Dim datTime As Date
    '
    '   datTime = dhGetFileTimesEx("C:\AUTOEXEC.BAT", _
    '    dhcFileTimeCreated)
 
    Dim ftCreate As FILETIME
    Dim ftAccess As FILETIME
    Dim ftWrite As FILETIME
    Dim hFile As Long
    Dim lngRet As Long
    
    ' Open the file
    hFile = dhQuickOpenFile(strFile)
    If hFile > 0 Then
    
        ' If successful, get the file times
        If CBool(GetFileTime(hFile, ftCreate, _
         ftAccess, ftWrite)) Then
                    
            ' Return the requested time
            Select Case intTime
                Case dhcFileTimeCreated
                    dhGetFileTimesEx = _
                     dhFileTimeToVBATime(ftCreate)
                Case dhcFileTimeAccessed
                    dhGetFileTimesEx = _
                     dhFileTimeToVBATime(ftAccess)
                Case dhcFileTimeModified
                    dhGetFileTimesEx = _
                     dhFileTimeToVBATime(ftWrite)
            End Select
        End If
        
        ' Close the file
        CloseHandle hFile
    End If
End Function

Function dhSetFileTimes(strFile As String, _
 dftTimes As dhtypFileTimes) As Boolean

    ' Sets file times for a specified file.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   dftTimes
    '       Pointer to dhtypFileTimes structure containing
    '       new file time information.
    ' Out:
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Dim dft As dhtypFileTimes
    '
    '   With dft
    '       .datCreated = #1/1/97#
    '       .datModified = #1/1/97#
    '       .datAccessed = #1/1/97#
    '   End With
    '
    '   Call dhSetFileTimes("C:\AUTOEXEC.BAT", dft)

    Dim ftCreated As FILETIME
    Dim ftAccessed As FILETIME
    Dim ftModified As FILETIME
    Dim hFile As Long
        
    ' Open the file for write access
    hFile = dhQuickOpenFile(strFile, GENERIC_WRITE)
    
    ' If successful then...
    If hFile > 0 Then
        
        ' Convert the passed time to a FILETIME
        With dftTimes
            Call dhVBATimeToFileTime(.datCreated, ftCreated)
            Call dhVBATimeToFileTime(.datAccessed, ftAccessed)
            Call dhVBATimeToFileTime(.datModified, ftModified)
        End With

        ' Set the times
        If CBool(SetFileTime(hFile, ftCreated, _
         ftAccessed, ftModified)) Then
         
            ' Return success
            dhSetFileTimes = True
        End If
            
        ' Close the file
        Call CloseHandle(hFile)
    End If
End Function

Function dhSetFileTimesEx(strFile As String, _
 datTime As Date, Optional intTimes As Integer = _
 (dhcFileTimeAccessed Or dhcFileTimeModified)) As Boolean

    ' Sets one or more file time values to a given value.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   datTime
    '       VBA date/time value.
    '   intTimes (Optional)
    '       Bitmask of flags specifying which file time value
    '       to change. Can be a combination of:
    '           dhcFileTimeCreated
    '           dhcFileTimeModified
    '           dhcFileTimeAccessed
    ' Out:
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Call dhSetFileTimesEx("C:\AUTOEXEC.BAT", _
    '    #1/1/97#, dhcFileTimeCreated)

    Dim ftIn As FILETIME
    Dim ftCreated As FILETIME
    Dim ftAccessed As FILETIME
    Dim ftModified As FILETIME
    Dim hFile As Long
        
    ' Open the file for write access
    hFile = dhQuickOpenFile(strFile, GENERIC_WRITE)
    
    ' If successful then...
    If hFile > 0 Then
        
        ' Convert the passed time to a FILETIME
        Call dhVBATimeToFileTime(datTime, ftIn)
        
        ' Get current values
        If CBool(GetFileTime(hFile, ftCreated, _
         ftAccessed, ftModified)) Then

            ' Check the times-to-set flags
            If (intTimes And dhcFileTimeCreated) <> 0 Then
                ftCreated = ftIn
            End If
            If (intTimes And dhcFileTimeAccessed) <> 0 Then
                ftAccessed = ftIn
            End If
            If (intTimes And dhcFileTimeModified) <> 0 Then
                ftModified = ftIn
            End If
    
            ' Set the times
            If CBool(SetFileTime(hFile, ftCreated, _
             ftAccessed, ftModified)) Then
                dhSetFileTimesEx = True
            End If
            
            ' Close the file
            Call CloseHandle(hFile)
        End If
    End If
End Function

Function dhCompareFileTime(strFile1 As String, _
 strFile2 As String, Optional intTime As _
 Integer = dhcFileTimeModified) As Long

    ' Compares a given file time for two files.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile1
    '       Path of first file.
    '   strFile2
    '       Path fo second file.
    '   intTime (Optional, default = dhcFileTimeModified)
    '       File time value to compare. Can be one of:
    '           dhcFileTimeCreated
    '           dhcFileTimeModified
    '           dhcFileTimeAccessed
    ' Out:
    '   Return Value:
    '       Will be one of the following:
    '           -2: Error
    '           -1: File 1 time value < file 2 time value
    '            0: File 1 time value = file 2 time value
    '            1: File 1 time value > file 2 time value
    ' Example:
    '   Select Case dhCompareFileTime("C:\AUTOEXEC.BAT", _
    '    "C:\AUTOEXEC.BAK")
    '       Case -1
    '           MsgBox "AUTOEXEC.BAT is newer"
    '       Case 1
    '           MsgBox "AUTOEXEC.BAT is older"
    '       Case 0
    '           MsgBox "File dates are the same"
    '       Case Else
    '           MsgBox "Error"
    '   End Select
    
    Dim ftCreate1 As FILETIME
    Dim ftAccess1 As FILETIME
    Dim ftWrite1 As FILETIME
    Dim hFile1 As Long
    Dim ftCreate2 As FILETIME
    Dim ftAccess2 As FILETIME
    Dim ftWrite2 As FILETIME
    Dim hFile2 As Long

    ' Set a return value in case things go wrong
    dhCompareFileTime = -2

    ' Open the first file
    hFile1 = dhQuickOpenFile(strFile1)
    If hFile1 > 0 Then
    
        ' Open the second file
        hFile2 = dhQuickOpenFile(strFile2)
        If hFile2 > 0 Then
        
            ' Get the file times
            If CBool(GetFileTime(hFile1, ftCreate1, _
             ftAccess1, ftWrite1)) Then
                If CBool(GetFileTime(hFile2, ftCreate2, _
                 ftAccess2, ftWrite2)) Then
                 
                    ' Call CompareFileTime for the
                    ' requested time and return the result
                    Select Case intTime
                        Case dhcFileTimeCreated
                            dhCompareFileTime = _
                             CompareFileTime(ftCreate1, ftCreate2)
                        Case dhcFileTimeAccessed
                            dhCompareFileTime = _
                             CompareFileTime(ftAccess1, ftAccess2)
                        Case dhcFileTimeModified
                            dhCompareFileTime = _
                             CompareFileTime(ftWrite1, ftWrite2)
                    End Select
                End If
            End If
            
            ' Close the second file
            Call CloseHandle(hFile2)
        End If
        
        ' Close the first file
        Call CloseHandle(hFile1)
    End If
End Function

