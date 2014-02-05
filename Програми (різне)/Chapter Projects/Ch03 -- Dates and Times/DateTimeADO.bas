Attribute VB_Name = "DateTimeADO"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' In order to use any of the public procedures in this module,
' your application must include a reference to ADO, or
' the code won't compile.
    
Private Function IsWeekend(dtmTemp As Date) As Boolean
    ' If your weekends aren't Saturday (day 7) and Sunday (day 1),
    ' change this routine to return True for whatever days
    ' you DO treat as weekend days.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Required by:
    '   SkipHolidays
    '   dhFirstWorkdayInMonth
    '   dbLastWorkdayInMonth
    '   dhNextWorkday
    '   dhPreviousWorkday
    '   dhCountWorkdays
    
    Select Case Weekday(dtmTemp)
        Case vbSaturday, vbSunday
            IsWeekend = True
        Case Else
            IsWeekend = False
    End Select
End Function

Private Function SkipHolidays( _
 rst As ADODB.Recordset, strField As String, _
 dtmTemp As Date, intIncrement As Integer) As Date
    ' Skip weekend days, and holidays in the recordset referred to by rst.
    ' Return dtmTemp + as many days as it takes to get to a day that's not
    ' a holiday or weekend.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Required by:
    '   dhFirstWorkdayInMonth
    '   dbLastWorkdayInMonth
    '   dhNextWorkday
    '   dhPreviousWorkday
    '   dhCountWorkdays
    
    ' Requires:
    '   IsWeekend
    
    Dim strCriteria As String
    Dim strFieldName As String
    On Error GoTo HandleErr
    
    ' Move up to the first Monday/last Friday, if the first/last
    ' of the month was a weekend date. Then skip holidays.
    ' Repeat this entire process until you get to a weekday.
    ' Unless rst contains a row for every day in the year (!)
    ' this should finally converge on a weekday.
    Do
        Do While IsWeekend(dtmTemp)
            dtmTemp = dtmTemp + intIncrement
        Loop
        If Not rst Is Nothing Then
            If Len(strField) > 0 Then
                strFieldName = strField
                If Left$(strField, 1) <> "[" Then
                    strFieldName = "[" & strFieldName & "]"
                End If
                rst.MoveFirst
                Do
                    strCriteria = strFieldName & " = " & _
                     "#" & Format(dtmTemp, "mm/dd/yyyy") & "#"
                    rst.Find strCriteria, , adSearchForward
                    If Not rst.EOF Then
                        dtmTemp = dtmTemp + intIncrement
                    End If
                Loop Until rst.EOF
            End If
        End If
    Loop Until Not IsWeekend(dtmTemp)
    
ExitHere:
    SkipHolidays = dtmTemp
    Exit Function
    
HandleErr:
    ' No matter what the error, just
    ' return without complaining.
    ' The worst that could happen is that we
    ' include a holiday as a real day, even if
    ' it's in the table.
    Resume ExitHere
End Function

Public Function dhNextWorkday(Optional dtmDate As Date = 0, _
 Optional rst As ADODB.Recordset = Nothing, _
 Optional strField As String = "") As Date
    
    ' Return the next working day after the specified date.
    ' If you want to look up holidays in a table, pass in
    ' an ADO recordset object containing the rows.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   SkipHolidays
    '   IsWeekend
    
    ' In:
    '   dtmDate:
    '       date on which to start looking.
    '       Use the current date, if none was specified.
    '   rst (Optional):
    '       Reference to an open recordset containing
    '       information about the holidays for the year in question.
    '       If you supply this value, you must also supply
    '       strField, the name of the field containing date information.
    '       This recordset must be open using some CursorType besides
    '       the default, which doesn't allow searching.
    '   strField (Optional):
    '       If you supply rst, you must supply this parameter, the
    '       name of the field in rst containing information about
    '       the holidays.
    ' Out:
    '   Return Value:
    '       The date of the next working day, taking
    '       into account weekends and holidays.
    ' Example:
    '   ' Find the next working date after 5/30/97, given
    '   ' a an XML file named Holidays.XML that contains a
    '   ' persisted recordset based on a field named Date,
    '   ' containing the holiday information.
    
    '   Dim rst As ADODB.Recordset
    '   Set rst = New ADODB.Recordset
    '   rst.Open "Holidays.xml", , adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    '   dtmDate = dhNextWorkday(#5/23/1997#, rst, "Date")
    '   ' dtmDate should be 5/27/97, because 5/26/97 is Memorial day.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhNextWorkday = SkipHolidays(rst, strField, dtmDate + 1, 1)
End Function

Public Function dhPreviousWorkday(Optional dtmDate As Date = 0, _
 Optional rst As ADODB.Recordset = Nothing, _
 Optional strField As String = "") As Date
    
    ' Return the previous working day before the specified date.
    ' If you want to look up holidays in a table, pass in
    ' an ADO recordset object containing the rows.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   SkipHolidays
    '   IsWeekend
    
    ' In:
    '   dtmDate:
    '       date on which to start looking.
    '       Use the current date, if none was specified.
    '   rst (Optional):
    '       Reference to an open recordset containing
    '       information about the holidays for the year in question.
    '       If you supply this value, you must also supply
    '       strField, the name of the field containing date information.
    '       This recordset must be open using some CursorType besides
    '       the default, which doesn't allow searching.
    '   strField (Optional):
    '       If you supply rst, you must supply this parameter, the
    '       name of the field in rst containing information about
    '       the holidays.
    ' Out:
    '   Return Value:
    '       The date of the previous working day, taking
    '       into account weekends and holidays.
    ' Example:
    '   ' Find the next working date before 1/1/2000, given
    '   ' a an XML file named Holidays.XML that contains a
    '   ' persisted recordset based on a field named Date,
    '   ' containing the holiday information.
    
    '   Dim rst As ADODB.Recordset
    '   Set rst = New ADODB.Recordset
    '   rst.Open "Holidays.xml", , adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    '   dtmDate = dhPreviousWorkday(#1/1/2000#, rst, "Date")
    '   ' dtmDate should be 12/30/1999, because of the New Year's holidays.
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dhPreviousWorkday = SkipHolidays(rst, strField, dtmDate - 1, -1)
End Function

Public Function dhFirstWorkdayInMonth(Optional dtmDate As Date = 0, _
 Optional rst As ADODB.Recordset = Nothing, _
 Optional strField As String = "") As Date
    
    ' Return the first working day in the month specified.
    ' If you want to look up holidays in a table, pass in
    ' an ADO recordset object containing the rows.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   SkipHolidays
    '   IsWeekend
    
    ' In:
    '   dtmDate:
    '       date within the month of interest.
    '       Use the current date, if none was specified.
    '   rst (Optional):
    '       Reference to an open recordset containing
    '       information about the holidays for the year in question.
    '       If you supply this value, you must also supply
    '       strField, the name of the field containing date information.
    '       This recordset must be open using some CursorType besides
    '       the default, which doesn't allow searching.
    '   strField (Optional):
    '       If you supply rst, you must supply this parameter, the
    '       name of the field in rst containing information about
    '       the holidays.
    ' Out:
    '   Return Value:
    '       The date of the first working day in the month, taking
    '       into account weekends and holidays.
    ' Example:
    '   ' To find the first working day in 1999, given
    '   ' a table named tblHolidays in a Jet 4.0 database named
    '   ' Holidays. This table contains a column named Date,
    '   ' containing the holiday date information.
    '   Dim rst As ADODB.Recordset
    '   Set rst = New ADODB.Recordset
    '   rst.Open "tblHolidays", _
    '    "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Holidays.mdb", _
    '    adOpenKeyset, adLockReadOnly, Options:=adCmdTableDirect
    '   dtmDate = dhFirstWorkdayInMonth(#1/1/99#, rst, "Date")
    
    Dim dtmTemp As Date
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dtmTemp = DateSerial(Year(dtmDate), Month(dtmDate), 1)
    dhFirstWorkdayInMonth = SkipHolidays(rst, strField, dtmTemp, 1)
End Function

Public Function dhLastWorkdayInMonth(Optional dtmDate As Date = 0, _
 Optional rst As ADODB.Recordset = Nothing, _
 Optional strField As String = "") As Date
    
    ' Return the last working day in the month specified.
    ' If you want to look up holidays in a table, pass in
    ' an ADO recordset object containing the rows.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   SkipHolidays
    '   IsWeekend
    
    ' In:
    '   dtmDate:
    '       date within the month of interest.
    '       Use the current date, if none was specified.
    '   rst (Optional):
    '       Reference to an open recordset containing
    '       information about the holidays for the year in question.
    '       If you supply this value, you must also supply
    '       strField, the name of the field containing date information.
    '       This recordset must be open using some CursorType besides
    '       the default, which doesn't allow searching.
    '   strField (Optional):
    '       If you supply rst, you must supply this parameter, the
    '       name of the field in rst containing information about
    '       the holidays.
    ' Out:
    '   Return Value:
    '       The date of the last working day in the month, taking
    '       into account weekends and holidays.
    ' Example:
    '   ' To find the last working day in 1999, given
    '   ' a table named tblHolidays in a Jet 4.0 database named
    '   ' Holidays. This table contains a column named Date,
    '   ' containing the holiday date information.
    '   Dim rst As ADODB.Recordset
    '   Set rst = New ADODB.Recordset
    '   rst.Open "tblHolidays", _
    '    "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Holidays.mdb", _
    '    adOpenKeyset, adLockReadOnly, Options:=adCmdTableDirect
    '   dtmDate = dhLastWorkdayInMonth(#12/31/1999#, rst, "Date")
    
    Dim dtmTemp As Date
    
    ' Did the caller pass in a date? If not, use
    ' the current date.
    If dtmDate = 0 Then
        dtmDate = Date
    End If
    
    dtmTemp = DateSerial(Year(dtmDate), Month(dtmDate) + 1, 0)
    dhLastWorkdayInMonth = SkipHolidays(rst, strField, dtmTemp, -1)
End Function

Public Function dhCountWorkdays(ByVal dtmStart As Date, ByVal dtmEnd As Date, _
 Optional rst As ADODB.Recordset = Nothing, Optional strField As String = "") _
 As Integer

    ' Count the business days (not counting weekends/holidays) in
    ' a given date range.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Requires:
    '   SkipHolidays
    '   CountHolidays
    '   IsWeekend
    
    ' In:
    '   dteStart:
    '       Date specifying the start of the range (inclusive)
    '   dteEnd:
    '       Date specifying the end of the range (inclusive)
    '       (dates will be swapped if out of order)
    '   rst (Optional):
    '       Reference to an open recordset containing
    '       information about the holidays for the year in question.
    '       If you supply this value, you must also supply
    '       strField, the name of the field containing date information.
    '       This recordset must be open using some CursorType besides
    '       the default, which doesn't allow searching.
    '   strField (Optional):
    '       If you supply rst, you must supply this parameter, the
    '       name of the field in rst containing information about
    '       the holidays.
    ' Out:
    '   Return Value:
    '       Number of working days (not counting weekends and optionally, holidays)
    '       in the specified range.
    ' Example:
    '   Dim rst As ADODB.Recordset
    '   Set rst = New ADODB.Recordset
    '   rst.Open "Holidays.xml", , _
    '    adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    '   Debug.Print dhCountWorkdays(#7/2/2000#, #7/5/2000#, rst, "Date")
    '
    '   returns 2, because 7/2/2000 is Sunday, 7/4/2000 is a holiday,
    '   leaving 7/3 and 7/5 as workdays.
    
    Dim intDays As Integer
    Dim dtmTemp As Date
    Dim intSubtract As Integer
    
    ' Swap the dates if necessary.
    If dtmEnd < dtmStart Then
        dtmTemp = dtmStart
        dtmStart = dtmEnd
        dtmEnd = dtmTemp
    End If
    
    ' Get the start and end dates to be weekdays.
    dtmStart = SkipHolidays(rst, strField, dtmStart, 1)
    dtmEnd = SkipHolidays(rst, strField, dtmEnd, -1)
    If dtmStart > dtmEnd Then
        ' Sorry, no Workdays to be had. Just return 0.
        dhCountWorkdays = 0
    Else
        intDays = dtmEnd - dtmStart + 1
        
        ' Subtract off weekend days.  Do this by figuring out how
        ' many calendar weeks there are between the dates, and
        ' multiplying the difference by two (because there are two
        ' weekend days for each week). That is, if the difference
        ' is 0, the two days are in the same week. If the
        ' difference is 1, then we have two weekend days.
        intSubtract = (DateDiff("ww", dtmStart, dtmEnd) * 2)
        
        ' The answer to our quest is all the weekdays, minus any
        ' holidays found in the table.
        ' If rst is Nothing, this call won't subtract any dates.
        intSubtract = intSubtract + _
         CountHolidays(rst, strField, dtmStart, dtmEnd)
        
        dhCountWorkdays = intDays - intSubtract
    End If
End Function

Private Function CountHolidays( _
 rst As ADODB.Recordset, strField As String, _
 dtmStart As Date, dtmEnd As Date) As Integer
 
    ' Count holidays between two end dates.
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Required by:
    '   dhCountWorkdays
    
    ' Requires:
    '   IsWeekend
    
    Dim strFilter As String
    Dim varOldFilter As Variant
    Dim intRows As Integer
    Dim strFieldName As String
    
    On Error GoTo HandleErr
    If Not rst Is Nothing Then
        If Len(strField) > 0 Then
            strFieldName = strField
            If Left$(strField, 1) <> "[" Then
                strFieldName = "[" & strFieldName & "]"
            End If
            strFilter = strFieldName & " >= " & _
             "#" & Format(dtmStart, "mm/dd/yyyy") & "# AND " & _
             strFieldName & " <= " & _
             "#" & Format(dtmEnd, "mm/dd/yyyy") & "#"
            
            ' Store away the current recordset filter,
            ' just in case. Then assign the new one.
            varOldFilter = rst.Filter
            rst.Filter = strFilter
            
            rst.MoveFirst
            Do Until rst.EOF
                If Not IsWeekend(rst(strField)) Then
                    intRows = intRows + 1
                End If
                rst.MoveNext
            Loop
            ' Put the filter back the way it was.
            rst.Filter = varOldFilter
        End If
    End If

ExitHere:
    CountHolidays = intRows
    Exit Function
    
HandleErr:
    ' No matter what the error, just
    ' return without complaining.
    ' The worst that could happen is that the code
    ' include a holiday as a real day, even if
    ' it's in the table.
    Resume ExitHere
End Function

