Attribute VB_Name = "DateTime"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Functions and constants needed to get locale info.
Private Declare Function GetLocaleInfo _
 Lib "kernel32" Alias "GetLocaleInfoA" _
 (ByVal Locale As Long, ByVal LCType As Long, _
 ByVal lpLCData As String, ByVal cchData As Long) As Long

Private Declare Function GetSystemDefaultLCID _
 Lib "kernel32" () As Long

Private Const LOCALE_STIME = &H1E        '  time separator
 
Public Function dhFirstDayInMonth(Optional dtmDate As Date = 0) As Date
    ' Return the first day in the specified month.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       The specified date.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       The date of the first day in the specified month.
    ' Example:
    '   dhFirstDayInMonth(#5/7/70#) returns 5/1/70.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhFirstDayInMonth = DateSerial( _
     Year(dtmDate), Month(dtmDate), 1)
End Function

Public Function dhLastDayInMonth(Optional dtmDate As Date = 0) As Date
    ' Return the last day in the specified month.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       The specified date
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       The date of the last day in the specified month.
    ' Comments:
    '   This function counts on odd behavior of dateSerial. That is, each of the
    '   numeric values can be an expression containing a relative value. Here, the
    '   Day value becomes 1 - 1 (that is, the day before the first day of the month).
    ' Example:
    '   dhLastDayInMonth(#5/7/70#) returns 5/1/70.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhLastDayInMonth = DateSerial( _
     Year(dtmDate), Month(dtmDate) + 1, 0)
End Function

Public Function dhFirstDayInWeek(Optional dtmDate As Date = 0) As Date
    ' Returns the first day in the week specified by the
    ' date in dtmDate. Uses localized settings for the first
    ' day of the week.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       date specifying the week in which to work.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       First day of the specified week, taking into account the
    '       user's locale.
    ' Example:
    '   dhFirstDayInWeek(#5/12/2001#) returns 5/6/2001 in the US.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhFirstDayInWeek = dtmDate - _
     Weekday(dtmDate, vbUseSystemDayOfWeek) + 1
End Function

Public Function dhLastDayInWeek(Optional dtmDate As Date = 0) As Date
    ' Returns the last day in the week specified by the date in dtmDate.
    ' Uses localized settings for the first day of the week.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       date specifying the week in which to work.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       Last day of the specified week, taking into account the
    '       user's locale.
    ' Example:
    '   dhLastDayInWeek(#4/1/97#) returns 4/5/97 in the US.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhLastDayInWeek = dtmDate - _
     Weekday(dtmDate, vbUseSystemDayOfWeek) + 7
End Function

Public Function dhFirstDayInYear(Optional dtmDate As Date = 0) As Date
    ' Return the first day in the specified year.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       The specified date
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       The date of the first day in the specified year.
    ' Example:
    '   dhFirstDayInYear(#5/7/1970#) returns 1/1/1970.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhFirstDayInYear = DateSerial(Year(dtmDate), 1, 1)
End Function

Public Function dhLastDayInYear(Optional dtmDate As Date = 0) As Date
    ' Return the last day in the specified year.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate (Optional)
    '       The specified date
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       The date of the last day in the specified year.
    ' Example:
    '   dhLastDayInYear(#5/7/1970#) returns 12/31/1970.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhLastDayInYear = DateSerial(Year(dtmDate), 12, 31)
End Function

Public Function dhFirstDayInQuarter(Optional dtmDate As Date = 0) _
 As Date
    ' Returns the first day in the quarter specified by the
    ' date in dtmDate.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       date specifying the quarter in which to work.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       First day of the specified quarter.
    ' Example:
    '   dhFirstDayInQuarter(#4/15/2000#) returns 4/1/2000.
    
    Const dhcMonthsInQuarter As Integer = 3
    Dim intMonth As Integer
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    ' Calculate the first month in the quarter.
    intMonth = Int((Month(dtmDate) - 1) / dhcMonthsInQuarter) * _
       dhcMonthsInQuarter + 1
       
    dhFirstDayInQuarter = DateSerial(Year(dtmDate), intMonth, 1)
End Function

Public Function dhLastDayInQuarter(Optional dtmDate As Date = 0) _
 As Date
    ' Returns the last day in the quarter specified by the
    ' date in dtmDate.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       date specifying the quarter in which to work.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       Last day of the specified quarter.
    ' Example:
    '   dhLastDayInQuarter(#4/1/2000#) returns 6/30/2000.
    
    Const dhcMonthsInQuarter As Integer = 3
    Dim intMonth As Integer
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    ' Calculate the last month in the quarter.
    intMonth = Int((Month(dtmDate) - 1) / dhcMonthsInQuarter) * _
       dhcMonthsInQuarter + (dhcMonthsInQuarter + 1)
       
    dhLastDayInQuarter = DateSerial(Year(dtmDate), intMonth, 0)
End Function

Public Function dhPreviousDOW(lngDOW As VbDayOfWeek, _
 Optional dtmDate As Date = 0) As Date
    ' Find the previous specified day of week before the specified date.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngDOW:
    '       The day of the week (vbSunday (1) through
    '       vbSaturday (7)) to search for.
    '   dtmDate:
    '       The starting date.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       date representing the prior occurrence of the specified day of week
    '       before dtmDate. If dtmDate falls on lngDOW, returns dtmDate - 7.
    ' Example:
    '   dhPreviousDOW(1, #5/1/97#) returns the Sunday prior to 5/1/97
    '       (that is, 4/27/97).
        
    Dim dtmTemp As Date
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dtmTemp = dtmDate - Weekday(dtmDate) + lngDOW
    If dtmTemp >= dtmDate Then
        dtmTemp = dtmTemp - 7
    End If
    dhPreviousDOW = dtmTemp
End Function

Public Function dhNextDOW(lngDOW As VbDayOfWeek, _
 Optional dtmDate As Date = 0) As Date
    ' Find the next specified day of week after the specified date.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngDOW:
    '       The day of the week (vbSunday (1) through
    '       vbSaturday (7)) to search for.
    '   dtmDate:
    '       The starting date.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       date representing the next occurrence of the specified day of week
    '       after dtmDate. If dtmDate falls on lngDOW, returns dtmDate.
    ' Example:
    '   dhNextDOW(1, #5/1/97#) returns the Sunday after 5/1/97
    '       (that is, 5/4/97).
            
    Dim dtmTemp As Date
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If

    dtmTemp = dtmDate - Weekday(dtmDate) + lngDOW
    If dtmTemp <= dtmDate Then
        dtmTemp = dtmTemp + 7
    End If
    dhNextDOW = dtmTemp
End Function

Public Function dhNextAnniversary(dtmDate As Date) As Date
    ' Given a date, find the next anniversary of that date.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       A date representing a birthdate or anniversary.
    ' Out:
    '   Return Value:
    '       The next occurence of the specified date. If the date hasn't
    '       occurred yet this year, return the date within the
    '       current year. Otherwise, return the date in the next
    '       year.
    ' Example:
    '   If the current date is 9/9/1999,
    '    dhNextAnniversary(#5/16/56#) will return 5/16/2000, the
    '   next time the anniversary occurs.
    
    Dim dtmThisYear As Date
    
    ' What's the corresponding date in the current year?
    dtmThisYear = DateSerial(Year(Now), Month(dtmDate), Day(dtmDate))
    
    ' If the anniversary has already occurred, then add 1 to the year.
    If dtmThisYear < Date Then
        dtmThisYear = DateAdd("yyyy", 1, dtmThisYear)
    End If
    dhNextAnniversary = dtmThisYear
End Function

Public Function dhNthWeekday(dtmDate As Date, intN As Integer, _
 lngDOW As VbDayOfWeek) As Date
    
    ' Find the date of the specified day within the month. For
    ' example, retrieve the 3rd Tuesday's date.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dtmDate:
    '       Starting date for the search. If this isn't the first
    '       day of the month, the code moves back to the first.
    '   intN:
    '       Number of the specific day, within the month. If larger
    '       than there are days of the specified type in the month,
    '       return the date of the requested day anyway. If you ask for
    '       the 10th Monday, the code will just find the first Monday
    '       in the specified month, and then add 10 weeks to that date.
    '   lngDOW:
    '       Day of the week to seek.
    ' Out:
    '   Return Value:
    '       The date of the nth specified day after the first day of the
    '       the specified month.
    ' Example:
    '   dhNthWeekday(#5/5/97#, 3, 3) returns the third Tuesday in 5/97,
    '   that is, #5/20/97#.
    
    Dim dtmTemp As Date
    
    If (lngDOW < vbSunday Or lngDOW > vbSaturday) _
     Or (intN < 1) Then
        ' Invalid parameter values. Just
        ' return the passed-in date.
        dhNthWeekday = dtmDate
        Exit Function
    End If
    
    ' Get the first of the month.
    dtmTemp = DateSerial(Year(dtmDate), Month(dtmDate), 1)
    
    ' Get to the first lngDOW including or after the first
    ' day of the month.
    dtmTemp = dtmTemp + ((lngDOW - Weekday(dtmTemp) + 7) Mod 7)
    
    ' Now you've found the first lngDOW in the month.
    ' Just add 7 for each intN after that.
    dhNthWeekday = dtmTemp + ((intN - 1) * 7)
End Function

Public Function dhDaysInMonth(Optional dtmDate As Date = 0) As Integer
    ' Return the number of days in the specified month.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dtmDate:
    '       date within the month in which you need the number of days.
    '       Use the current date, if none was specified.
    ' Out:
    '   Return Value:
    '       Number of days in the specified month.
    ' Example:
    '   dhDaysInMonth(#2/1/96#) returns 29.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhDaysInMonth = _
     DateSerial(Year(dtmDate), Month(dtmDate) + 1, 1) - _
     DateSerial(Year(dtmDate), Month(dtmDate), 1)
End Function

Public Function dhCountDOWInMonth(ByVal dtmDate As Date, _
 Optional lngDOW As VbDayOfWeek = 0) As Integer

    ' Calculate the number of specified days in
    ' the specified month.
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    '
    ' In:
    '   dtmDate:
    '       date value specifying the month and year
    '       If lngDOW is missing, this date also
    '       supplies the day of week to count.
    '   lngDOW: (Optional)
    '       If supplied, contains the day of week
    '       (vbSunday (1) - vbSaturday (7)) to be
    '       counted within the specified month/year.
    '       If not supplied, the function uses the
    '       day of week of the required date parameter.
    ' Out:
    '   Return value:
    '       The number of days matching lngDOW (or dtmDate)
    '       in the specified month/year.
    '
    ' Example:
    '   dhCountDOWInMonth(#11/96#, vbFriday) returns 5
    '       (there were 5 Fridays in November 1996)
    '   dhCountDOWInMonth(#11/3/96#) returns 4
    '       (11/3/96 was a Sunday, and there were 4 Sundays in the month)
    '   dhCountDOWInMonth(#11/3/96#, vbFriday) returns 5
    '       (the lngDOW parameter overrides the day portion of the date)
    
    Dim dtmFirst As Date
    Dim intCount As Integer
    Dim intMonth As Integer
    
    If (lngDOW < vbSunday Or lngDOW > vbSaturday) Then
        ' Caller must not have specified DOW, or it
        ' was an invalid number.
        lngDOW = Weekday(dtmDate)
    End If
    intMonth = Month(dtmDate)
    
    ' Find the first day of the month
    dtmFirst = DateSerial(Year(dtmDate), intMonth, 1)

    ' Get to the first lngDOW including or after the first
    ' day of the month.
    dtmFirst = dtmFirst + ((lngDOW - Weekday(dtmFirst) + 7) Mod 7)
    
    ' Now, dtmFirst is sitting on the first day
    ' of the requested number in the month.
    
    ' There are either 4 or 5 of each weekday in each month.
    ' Assume there are 5. If that gives you a date outside
    '  the month, there are only 4. If there are 5 of a
    ' given day within a month, the 5th one will be
    ' 28 days after the first.
    intCount = 5
    If (Month(dtmFirst + 28) <> Month(dtmFirst)) Then
        intCount = 4
    End If
    dhCountDOWInMonth = intCount
End Function

Public Function dhIsLeapYear(Optional varDate As Variant) As Boolean
    ' Is the supplied year a leap year?
    ' Check the day number of the day
    ' after Feb 28 to find out.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varDate (Optional):
    '       If unspecified, use the current year.
    '       If a date, use the year of the specified date.
    '       If a valid integer (between 100 and 9999),
    '           use that value as the year, otherwise use the current year.
    '       If any other data type, act as if varDate wasn't specified
    '        (that is, use the current year).
    ' Out:
    '   Return value:
    '       Boolean indicating whether the specified year
    '       is a leap year.
    ' Example:
    '   If dhIsLeapYear() Then
    '     ' You know the current year is a leap year.
    '
    '   If dhIsLeapYear(1956) Then
    '     ' You know 1956 was a leap year.
    '
    '   If dhIsLeapYear(#12/1/92#) Then
    '     ' You know 1992 was a leap year.
    
    ' Missing? Use the current year.
    If IsMissing(varDate) Then
        varDate = Year(Date)
    
    ' Is it a date? Then use that year.
    ElseIf VarType(varDate) = vbDate Then
        varDate = Year(varDate)
        
    ' Is it an integer? Use that value, if it's value.
    ' Otherwise, use the current year.
    ElseIf VarType(varDate) = vbInteger Then
        ' Only years 100 through 9999 are allowed.
        If varDate < 100 Or varDate > 9999 Then
            varDate = Year(Date)
        End If
        
    ' If it's not a date or an integer, just use the
    ' current year.
    Else
        varDate = Year(Date)
    End If
    dhIsLeapYear = (Day(DateSerial(varDate, 2, 28) + 1) = 29)
End Function

Public Function dhRoundTime(dtmTime As Date, intInterval As Integer) As Date
    
    ' Round the time value in varTime to the nearest minute
    ' interval in intInterval
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dtmTime:
    '       The original time
    '   intInterval:
    '       Interval to which to round dtmTime, in minutes.
    '       Must be a divisor of 60 (2, 3, 4, 5, 6, 10, 12, 15,
    '       20, 30, or 60)
    ' Out:
    '   Return Value:
    '       The rounded time, to the nearest increment of intInterval.
    ' Example:
    '   dhRoundTime(#3/5/97 11:08 AM#, 15) returns
    '       #3/5/97 11:15:00 AM#
    
    Dim decTime As Variant
    Dim intHour As Integer
    Dim intMinute As Integer
    Dim lngdate As Long

    ' Get the date portion of the date/time value
    lngdate = DateValue(dtmTime)

    ' Get the time portion as a number like 11.5 for 11:30.
    decTime = CDec(TimeValue(dtmTime) * 24)

    ' Get the hour and store it away. Int truncates,
    ' CInt rounds, so use Int.
    intHour = Int(decTime)

    ' Get the number of minutes, and then round to the nearest
    ' occurrence of the interval specified.
    intMinute = CInt((decTime - intHour) * 60)
    intMinute = CInt(intMinute / intInterval) * intInterval

    ' Build back up the original date/time value,
    ' rounded to the nearest interval.
    dhRoundTime = CDate(lngdate + _
     ((intHour + intMinute / 60) / 24))
End Function

Public Function dhcNumDate(ByVal lngdate As Long, _
 ByVal strFormat As String) As Variant
    ' Convert numbers to dates, depending on the specified format
    ' and the incoming number. In this case, the number and the
    ' format must match, or the output will be useless.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngdate:
    '       Number representing the date to be returned. Because numbers don't
    '       have leading 0's, that situation will never occur.
    '   strFormat:
    '       String expression containing the format of the value in lngdate.
    '       Must be one of the following:
    '           "MMDDYY"'
    '           "MMDDYYYY"
    '           "DDMMYY"
    '           "DDMMYYYY"
    '           "YYMMDD"
    '           "YYYYMMDD"
    ' Out:
    '   The value in lngdate, converted to a date, given the format specified
    '   in strFormat.
    ' Example:
    '   dhcNumDate(19560516, "YYYYMMDD") will return the date 5/16/56.
    '   dhcNumDate(51656, "MMDDYY") will return the date 5/16/56
    '   dhcNumDate(51620, "MMDDYY") will return the date 5/16/2020
    
    Dim intYear As Integer
    Dim intMonth As Integer
    Dim intDay As Integer
    
    Select Case strFormat
        Case "MMDDYY"
            intYear = lngdate Mod 100
            intMonth = lngdate \ 10000
            intDay = (lngdate \ 100) Mod 100
            
        Case "MMDDYYYY"
            intYear = lngdate Mod 10000
            intMonth = lngdate \ 1000000
            intDay = (lngdate \ 10000) Mod 100
        
        Case "DDMMYY"
            intYear = lngdate Mod 100
            intMonth = (lngdate \ 100) Mod 100
            intDay = lngdate \ 10000
        
        Case "DDMMYYYY"
            intYear = lngdate Mod 10000
            intMonth = (lngdate \ 10000) Mod 100
            intDay = lngdate \ 1000000
        
        Case "YYMMDD", "YYYYMMDD"
            intYear = lngdate \ 10000
            intMonth = (lngdate \ 100) Mod 100
            intDay = lngdate Mod 100
        
        Case Else
            ' Raise an error and get out.
            ' Error 5 normally indicates an invalid parameter.
            Err.Raise 5, "dhcNumDate", "Invalid parameter"
    End Select
    dhcNumDate = DateSerial(intYear, intMonth, intDay)
End Function

Public Function dhcStrDate(strDate As String, Optional strFormat As String = "") As Date
    
    ' Given a string containing a date value, and a format
    ' string describing the information in the date string,
    ' convert the string into a real date value.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strDate:
    '       String expression containing a date to be converted.
    '   strFormat (Optional):
    '       String expression containing a format specifier for the
    '       string in strdate. If omitted, the function uses "", which
    '       will cause it to use the Cdate function to attempt to
    '       conversion, just as it will if any other unknown format
    '       string is passed in.
    '
    '       Allowable formats:
    '           "MMDDYY", "MMDDYYYY"
    '           "DDMMYY", "DDMMYYYY"
    '           "YYMMDD", "YYYYMMDD"
    '           "DD/MM/YY", "DD/MM/YYYY" ("/" stands for any delimiter in the date string)
    '           "YY/MM/DD", "YYYY/MM/DD"
    ' Out:
    '   Return Value:
    '       The value in strDate, converted to a date, if possible.
    ' Example:
    '   dhcStrDate("59/04/22", "YY/MM/DD") returns the real date #4/22/1959#
    '   dhcStrDate("19590522", "YYYYMMDD") returns the real date #5/22/1959#
    '
    Dim strYear As String
    Dim strMonth As String
    Dim strDay As String
    
    Select Case strFormat
        Case "MMDDYY", "MMDDYYYY"
            strYear = Mid$(strDate, 5)
            strMonth = Left$(strDate, 2)
            strDay = Mid$(strDate, 3, 2)
        
        Case "DDMMYY", "DDMMYYYY"
            strYear = Mid$(strDate, 5)
            strMonth = Mid$(strDate, 3, 2)
            strDay = Left$(strDate, 2)
            
        Case "YYMMDD"
            strYear = Left$(strDate, 2)
            strMonth = Mid$(strDate, 3, 2)
            strDay = Right$(strDate, 2)
        
        Case "YYYYMMDD"
            strYear = Left$(strDate, 4)
            strMonth = Mid$(strDate, 5, 2)
            strDay = Right$(strDate, 2)
        
        Case "DD/MM/YY", "DD/MM/YYYY"
            strYear = Mid$(strDate, 7)
            strMonth = Mid$(strDate, 4, 2)
            strDay = Left$(strDate, 2)
            
        Case "YY/MM/DD"
            strYear = Left$(strDate, 2)
            strMonth = Mid$(strDate, 4, 2)
            strDay = Right$(strDate, 2)
            
        Case "YYYY/MM/DD"
            strYear = Left$(strDate, 4)
            strMonth = Mid$(strDate, 6, 2)
            strDay = Right$(strDate, 2)
        
        Case Else
            ' If none of the other formats were matched, raise
            ' an error and get out.
            Err.Raise 5, "dhcStrDate", "Invalid parameter"
    End Select
    dhcStrDate = DateSerial(Val(strYear), Val(strMonth), Val(strDay))
End Function

Public Function dhAge(dtmBD As Date, Optional dtmDate As Date = 0) _
 As Integer
 
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
        
    ' Thanks to Peter Mundy, on comp.databases.ms-access
    ' for fixing up a flaw in the original logic of this
    ' procedure.
    
    Dim intAge As Integer
    
    If dtmDate = 0 Then
        ' Did the caller pass in a date? If not, use
        ' the current date.
        dtmDate = Date
    End If
    intAge = DateDiff("yyyy", dtmBD, dtmDate)
    If dtmDate < DateAdd("yyyy", intAge, dtmBD) Then
        intAge = intAge - 1
    End If
    dhAge = intAge
End Function

Public Function dhAge1(dtmBD As Date, _
 Optional dtmDate As Date = 0) As Integer
 
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
        
    ' Thanks to Peter Mundy, on comp.databases.ms-access
    ' for fixing up a flaw in the original logic of this
    ' procedure.
    
    ' A shorter version of dhAge.
    
    Dim intAge As Integer
    
    If dtmDate = 0 Then
        ' Did the caller pass in a date? If not, use
        ' the current date.
        dtmDate = Date
    End If
    intAge = DateDiff("yyyy", dtmBD, dtmDate)
    dhAge1 = intAge + _
     (dtmDate < DateAdd("yyyy", intAge, dtmBD))
End Function

Public Function dhFormatInterval(dtmStart As Date, datend As Date, _
 Optional strFormat As String = "H:MM:SS") As String
    ' Return the difference between two times,
    ' formatted as specified in strFormat.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   GetTimeDelimiter
    
    ' In:
    '   dtmStart:
    '       starting date for the interval, including a time portion
    '   datend:
    '       ending date for the interval, including a time portion
    '   strFormat (optional):
    '       format specifier, as shown below. (Default: "H:MM:SS")
    ' Out:
    '   Return Value:
    '       The formatted time difference.
    ' Comment:
    '   Due to the way the calculations are performed, the largest interval
    '   is 68 years or so.
    ' Example:
    '   Using #1/1/97 12:00 PM# and #1/4/97 2:45:45 PM# as the dates, and one
    '   of the following format templates,
    '   dhFormatInterval(#1/1/97 12:00 PM#, #1/4/97 2:45:45 PM#, "<format>")
    '      will return (using each of the following format strings):
    '           D H         3 Days 3 Hours
    '           D H M       3 Days 2 Hours 46 Minutes
    '           D H M S     3 Days 2 Hours 45 Minutes 45 Seconds
    '           D H:MM      3 Days 2:46
    '           D HH:MM     3 Days 02:46
    '           D HH:MM:SS  3 Days 02:45:45
    
    '           H M         74 Hours 46 Minutes
    '           H:MM        74:46 (leading 0 on minutes, if necessary)
    '           H:MM:SS     74:45:45
    
    '           M S         4485 Minutes 45 Seconds
    '           M:SS        4485:45 (leading 0 on seconds, if necessary)
    
    Dim lngSeconds As Long
    Dim decMinutes As Variant
    Dim decHours As Variant
    Dim decDays As Variant
    
    Dim intSeconds As Integer
    Dim intMinutes As Integer
    Dim intHours As Integer
    
    Dim intRoundedHours As Integer
    Dim intRoundedMinutes As Integer
    
    Dim strDay As String
    Dim strHour As String
    Dim strMinute As String
    Dim strSecond As String
    Dim strOut As String
    
    Dim lngFullDays As Long
    Dim lngFullHours As Long
    Dim lngFullMinutes As Long
    
    Dim strDelim As String
    
    Const dhcDays As String = "Days"
    Const dhcHours As String = "Hours"
    Const dhCMinutes As String = "Minutes"
    Const dhcSeconds As String = "Seconds"
    
    Const dhcDay As String = "Day"
    Const dhcHour As String = "Hour"
    Const dhcMinute As String = "Minute"
    Const dhcSecond As String = "Second"
    
    
    ' If you don't want to use the local delimiter,
    ' but a specific one, replace the next line with
    ' this:
    ' strDelim = ":"
    strDelim = GetTimeDelimiter()
    
    ' Calculate the full number of seconds in the interval.
    ' This limits the calculation to 2 billion seconds (68 years
    ' or so), but that's not too bad. Then calculate the
    ' difference in minutes, hours, and days, as well.
    lngSeconds = DateDiff("s", dtmStart, datend)
    decMinutes = CDec(lngSeconds / 60)
    decHours = CDec(decMinutes / 60)
    decDays = CDec(decHours / 24)
    
    ' Get the full hours and minutes, for later display.
    lngFullDays = Int(decDays)
    lngFullHours = Int(decHours)
    lngFullMinutes = Int(decMinutes)
    
    ' Get the incremental amount of each unit.
    intHours = Int((decDays - lngFullDays) * 24)
    intMinutes = Int((decHours - lngFullHours) * 60)
    intSeconds = CInt((decMinutes - lngFullMinutes) * 60)
    
    ' In some instances, time values must be rounded.
    ' The next two lines depend on the fact that a true statement
    ' has a value of -1, and a false statement has a value of 0.
    ' The code needs to add 1 to the value if the following expression
    ' is true, and 0 if not.
    intRoundedHours = intHours - (intMinutes > 30)
    intRoundedMinutes = intMinutes - (intSeconds > 30)
    
    ' Assume all units are plural, until you find otherwise.
    strDay = dhcDays
    strHour = dhcHours
    strMinute = dhCMinutes
    strSecond = dhcSeconds
    
    If lngFullDays = 1 Then strDay = dhcDay
    Select Case strFormat
        Case "D H"
            If intRoundedHours = 1 Then strHour = dhcHour
            strOut = _
             lngFullDays & " " & strDay & " " & _
             intRoundedHours & " " & strHour
        
        Case "D H M"
            If intHours = 1 Then strHour = dhcHour
            If intRoundedMinutes = 1 Then strMinute = dhcMinute
            strOut = _
             lngFullDays & " " & strDay & " " & _
             intHours & " " & strHour & " " & _
             intRoundedMinutes & " " & strMinute
        
        Case "D H M S"
            If intHours = 1 Then strHour = dhcHour
            If intMinutes = 1 Then strMinute = dhcMinute
            If intSeconds = 1 Then strSecond = dhcSecond
            strOut = _
             lngFullDays & " " & strDay & " " & _
             intHours & " " & strHour & " " & _
             intMinutes & " " & strMinute & " " & _
             intSeconds & " " & strSecond
            
        Case "D H:MM"      ' 3 Days 2:46"
            strOut = lngFullDays & " " & strDay & " " & _
             intHours & strDelim & Format(intRoundedMinutes, "00")
        
        Case "D HH:MM"     ' 3 Days 02:46"
            strOut = lngFullDays & " " & strDay & " " & _
             Format(intHours, "00") & strDelim & _
             Format(intRoundedMinutes, "00")
        
        Case "D HH:MM:SS"  ' 3 Days 02:45:45"
            strOut = lngFullDays & " " & strDay & " " & _
             Format(intHours, "00") & strDelim & _
             Format(intMinutes, "00") & strDelim & _
             Format(intSeconds, "00")
        
        Case "H M"         ' 74 Hours 46 Minutes"
            If lngFullHours = 1 Then strHour = dhcHour
            If intRoundedMinutes = 1 Then strMinute = dhcMinute
            strOut = lngFullHours & " " & strHour & " " & _
             intRoundedMinutes & " " & strMinute
        
        Case "H:MM"        ' 74:46 (leading 0 on minutes, if necessary)
            strOut = lngFullHours & strDelim & Format(intRoundedMinutes, "00")
        
        Case "H:MM:SS"     ' 74:45:45"
            strOut = lngFullHours & strDelim & _
             Format(intMinutes, "00") & strDelim & _
             Format(intSeconds, "00")
        
        Case "M S"         ' 4485 Minutes 45 Seconds
            If lngFullMinutes = 1 Then strMinute = dhcMinute
            If intSeconds = 1 Then strSecond = dhcSecond
            strOut = lngFullMinutes & " " & strMinute & " " & _
             intSeconds & " " & strSecond
        Case "M:SS"        ' 4485:45 (leading 0 on seconds, if necessary)"
            strOut = lngFullMinutes & strDelim & _
             Format(intSeconds, "00")
        
        Case Else
            strOut = vbNullString
    End Select
    dhFormatInterval = strOut
End Function

Public Function dhCMinutes(dtmTime As Date) As Long
    ' Convert a date/time value to the number of
    ' minutes since midnight (that is, remove the date
    ' portion, and just work with the time part.) The
    ' return value can be used to calculate sums of
    ' elapsed time.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dtmTime:
    '       A date/time value
    ' Out:
    '   Return Value:
    '       Time portion of the input value, converted to minutes.
    
    ' Subtract off the whole portion of the date/time value
    ' and then convert from a fraction of a day to minutes.
    dhCMinutes = TimeValue(dtmTime) * 24 * 60
End Function

Public Function dhCTimeStr(lngMinutes As Long) As String
    ' Convert from a number of minutes to a string
    ' that looks like a time value.
    ' This function is not aware of international settings.
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   GetTimeDelimiter
    
    ' In:
    '   lngMinutes:
    '       A quantity of minutes to be converted to an h:mm string
    ' Out:
    '   Return Value:
    '       The number of minutes, converted to h:mm format.
    
    dhCTimeStr = Format(lngMinutes \ 60, "0") & _
     GetTimeDelimiter() & Format(lngMinutes Mod 60, "00")
End Function

Private Function GetTimeDelimiter() As String
    ' Retrieve the time delimiter. Use the GetLocaleInfo
    ' API function to return information about the current
    ' user's settings.
        
    ' Used by:
    '   dhCTimeStr
    '   dhFormatInterval
    
    ' Requires:
    '   GetSystemDefaultLCID declaration
    '   GetLocaleInfo declaration
    '   LOCALE_STIME declaration
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    Dim lngLCID As Long
    Dim lngLen As Long
    Dim strBuffer As String
    Const MAX_CHARS = 4
    
    lngLCID = GetSystemDefaultLCID()
    strBuffer = Space(MAX_CHARS + 1)
    lngLen = GetLocaleInfo(lngLCID, LOCALE_STIME, _
     strBuffer, Len(strBuffer))
    ' lngLen includes the trailing Null character.
    GetTimeDelimiter = Left$(strBuffer, lngLen - 1)
End Function



