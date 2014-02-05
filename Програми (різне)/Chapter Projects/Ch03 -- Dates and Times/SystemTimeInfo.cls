VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SystemTimeInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Class module handling system time (UTC) And
' local time/time zone issues.


' Raise an error if you can't set the time.
' The 9156 is an arbitrary, semi-random value.
Private Const dhcErrBase = vbObjectError + 9156
Private Const dhcErrCantSetTime = dhcErrBase + 0
Private Const dhcErrCantSetTZI = dhcErrBase + 1

' Functions and constants for working with the system
' time using the Windows API.
Private Type SYSTEMTIME
    Year As Integer
    Month As Integer
    DayOfWeek As Integer
    Day As Integer
    Hour As Integer
    Minute As Integer
    Second As Integer
    Milliseconds As Integer
End Type

Private Enum TimeZoneID
    TIME_ZONE_ID_UNKNOWN = 0
    TIME_ZONE_ID_STANDARD = 1
    TIME_ZONE_ID_DAYLIGHT = 2
End Enum

Private Type TIME_ZONE_INFORMATION
    Bias As Long
    StandardName(0 To 63) As Byte
    StandardDate As SYSTEMTIME
    StandardBias As Long
    DaylightName(0 To 63) As Byte
    DaylightDate As SYSTEMTIME
    DaylightBias As Long
End Type

Private Declare Sub GetSystemTime _
 Lib "kernel32" _
 (lpSystemTime As SYSTEMTIME)

Private Declare Function SetSystemTime _
 Lib "kernel32" _
 (lpSystemTime As SYSTEMTIME) As Long

Private Declare Function GetTimeZoneInformation _
 Lib "kernel32" _
 (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Long

Private Declare Function SetTimeZoneInformation _
 Lib "kernel32" _
 (lpTimeZoneInformation As TIME_ZONE_INFORMATION) As Long

Public Property Get SystemDateTime() As Date
    ' Requires
    '   SystemTimeToVBADate
    Dim st As SYSTEMTIME
    Call GetSystemTime(st)
    SystemDateTime = SystemTimeToVBADate(st)
End Property

Public Property Let SystemDateTime(dtm As Date)
    Dim st As SYSTEMTIME
    st = VBADateToSYSTEMTIME(dtm)
    If SetSystemTime(st) = 0 Then
        ' Unable to change system time.
        ' Most likely, you've not got the
        ' correct permissions.
        Err.Raise dhcErrCantSetTime, _
         "SystemTimeInfo.SystemDateTime", _
         "Unable to set system time."
    End If
End Property

Public Property Get Bias() As Long
    Dim lngBias As Long
    Dim lngTZID As TimeZoneID
    Dim tzi As TIME_ZONE_INFORMATION
    
    lngTZID = GetTimeZoneInformation(tzi)
    Select Case lngTZID
        Case TIME_ZONE_ID_UNKNOWN
            lngBias = tzi.Bias
        Case TIME_ZONE_ID_STANDARD
            lngBias = tzi.Bias + tzi.StandardBias
        Case TIME_ZONE_ID_DAYLIGHT
            lngBias = tzi.Bias + tzi.DaylightBias
    End Select
    Bias = lngBias
End Property

Public Property Get CurrentTimeZoneName() As String
    Dim tzi As TIME_ZONE_INFORMATION
    Dim lngTZID As TimeZoneID
    Dim abytName() As Byte
    
    lngTZID = GetTimeZoneInformation(tzi)
    
    Select Case lngTZID
        Case TIME_ZONE_ID_UNKNOWN
            abytName = tzi.StandardName
        Case TIME_ZONE_ID_STANDARD
            abytName = tzi.StandardName
        Case TIME_ZONE_ID_DAYLIGHT
            abytName = tzi.DaylightName
    End Select
    CurrentTimeZoneName = GetTZName(abytName())
End Property

Public Property Get StandardTimeZoneName() As String
    Dim tzi As TIME_ZONE_INFORMATION
    
    Call GetTimeZoneInformation(tzi)
    StandardTimeZoneName = GetTZName(tzi.StandardName)
End Property

Public Property Let StandardTimeZoneName(strName As String)
    Dim tzi As TIME_ZONE_INFORMATION
    
    Call GetTimeZoneInformation(tzi)
    Call SetTZName(strName, tzi.StandardName)
    If SetTimeZoneInformation(tzi) = 0 Then
        Err.Raise dhcErrCantSetTZI, _
         "SystemTimeInfo.StandardTimeZoneName", _
         "Unable to set standard time zone name."
    End If
End Property

Public Property Get DaylightTimeZoneName() As String
    Dim tzi As TIME_ZONE_INFORMATION
    
    Call GetTimeZoneInformation(tzi)
    DaylightTimeZoneName = GetTZName(tzi.DaylightName)
End Property

Public Property Let DaylightTimeZoneName(strName As String)
    Dim tzi As TIME_ZONE_INFORMATION
    
    Call GetTimeZoneInformation(tzi)
    Call SetTZName(strName, tzi.DaylightName)
    If SetTimeZoneInformation(tzi) = 0 Then
        Err.Raise dhcErrCantSetTZI, _
         "SystemTimeInfo.DaylightTimeZoneName", _
         "Unable to set daylight time zone name."
    End If
End Property

Public Property Get DaylightBias() As Long
    Dim lngTZID As TimeZoneID
    Dim tzi As TIME_ZONE_INFORMATION
    
    lngTZID = GetTimeZoneInformation(tzi)
    DaylightBias = tzi.DaylightBias
End Property

Public Property Let DaylightBias(lngValue As Long)
    Dim lngTZID As TimeZoneID
    Dim tzi As TIME_ZONE_INFORMATION
    
    lngTZID = GetTimeZoneInformation(tzi)
    tzi.DaylightBias = lngValue
    If SetTimeZoneInformation(tzi) = 0 Then
        Err.Raise dhcErrCantSetTZI, _
         "SystemTimeInfo.DaylightBias", _
         "Unable to set daylight bias."
    End If
End Property

Public Property Get StandardBias() As Long
    Dim lngTZID As TimeZoneID
    Dim tzi As TIME_ZONE_INFORMATION
    
    lngTZID = GetTimeZoneInformation(tzi)
    StandardBias = tzi.StandardBias
End Property

Public Property Let StandardBias(lngValue As Long)
    Dim lngTZID As TimeZoneID
    Dim tzi As TIME_ZONE_INFORMATION
    
    lngTZID = GetTimeZoneInformation(tzi)
    tzi.StandardBias = lngValue
    If SetTimeZoneInformation(tzi) = 0 Then
        Err.Raise dhcErrCantSetTZI, _
         "SystemTimeInfo.StandardBias", _
         "Unable to set standard bias."
    End If
End Property

Private Function VBADateToSYSTEMTIME(Optional dtm As Date = 0) As SYSTEMTIME
    ' Convert a VBA date/time value
    Dim st As SYSTEMTIME
        
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtm = 0 Then
        dtm = Date
    End If
    
    With st
        .Day = Day(dtm)
        .DayOfWeek = Weekday(dtm)
        .Hour = Hour(dtm)
        .Milliseconds = 0
        .Minute = Minute(dtm)
        .Month = Month(dtm)
        .Second = Second(dtm)
        .Year = Year(dtm)
    End With
    VBADateToSYSTEMTIME = st
End Function

Private Function SystemTimeToVBADate(st As SYSTEMTIME) As Date
    Dim dtm As Date
    
    With st
        dtm = DateSerial(.Year, .Month, .Day) + _
         TimeSerial(.Hour, .Minute, .Second)
    End With
    SystemTimeToVBADate = dtm
End Function

Private Function GetTZName(abytName() As Byte) As String
    ' Convert from a 64-element array of bytes
    ' containing character values into a string.
    Dim lngPos As Long
    Dim strTemp As String
    
    strTemp = CStr(abytName)
    
    ' Set the length of the string, looking for
    ' the final vbNullChar.
    lngPos = InStr(1, strTemp, vbNullChar)
    If lngPos > 0 Then
        strTemp = Left$(strTemp, lngPos - 1)
    End If
    GetTZName = strTemp
End Function

Private Sub SetTZName(strName As String, abytName() As Byte)
    ' Convert from string to array of bytes.
    ' You must pass in the fixed-sized array of bytes,
    ' and then code here copies the bytes into that array.
    ' You can never put a fixed-sized array on the left
    ' hand side of an assignment, so you must copy this
    ' array in, byte by byte.
    Dim i As Integer
    Dim abyt() As Byte
    
    abyt = strName
    For i = LBound(abyt) To UBound(abyt)
        abytName(i) = abyt(i)
    Next i
    abytName(i) = 0
End Sub
