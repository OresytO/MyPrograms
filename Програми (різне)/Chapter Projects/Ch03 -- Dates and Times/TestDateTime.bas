Attribute VB_Name = "TestDateTime"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test procedures for the other procedures provided in this chapter.

Sub CreateHolidayXML()
    ' Create an XML file from the tblHolidays table.
    Dim rst As ADODB.Recordset
    Set rst = New ADODB.Recordset
    rst.Open "tblHolidays", _
     "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & App.Path & "\Holidays.mdb"
    
    ' Need to delete the file, if it's already there.
    On Error Resume Next
    Kill App.Path & "\Holidays.xml"
    On Error GoTo 0
    
    ' Now save the XML file, based on the recordset.
    rst.Save App.Path & "\Holidays.xml", adPersistXML
    rst.Close
    Set rst = Nothing
End Sub

Sub TestInterval()
    Dim dtmStart As Date
    Dim dtmEnd As Date
    
    dtmStart = #1/1/1999 12:00:00 PM#
    dtmEnd = #1/4/1999 2:45:45 PM#
    
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D H")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D H M")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D H M S")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D H:MM")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D HH:MM")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "D HH:MM:SS")
    
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "H M")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "H:MM")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "H:MM:SS")
    
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "M S")
    Debug.Print dhFormatInterval(dtmStart, dtmEnd, "M:SS")

End Sub

Sub TestCountWorkdays()
    Dim rst As ADODB.Recordset
    
    ' You'll need to modify the path in the next line, to point
    ' to your sample database.
    Set rst = New ADODB.Recordset
    rst.Open App.Path & "\Holidays.xml", , _
    adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    
    Debug.Print dhCountWorkdays(#7/2/2000#, #7/5/2000#, rst, "Date")
    Debug.Print dhCountWorkdays(#7/2/2000#, #7/5/2000#)
    
    Debug.Print dhCountWorkdays(#12/27/1999#, #1/2/2000#, rst, "Date")
    Debug.Print dhCountWorkdays(#12/27/1999#, #1/2/2000#)
End Sub

Sub TestSkipHolidays()
    Dim rst As ADODB.Recordset
    
    Set rst = New ADODB.Recordset
    ' You'll need to modify the path in the next line, to point
    ' to your sample XML file. Use the CreateHolidayXML
    ' procedure to create the necessary XML file.
    rst.Open App.Path & "\Holidays.xml", , _
    adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    
    Debug.Print dhFirstWorkdayInMonth(#8/1/1999#, rst, "Date")
    Debug.Print dhLastWorkdayInMonth(#12/31/1999#, rst, "Date")
    Debug.Print dhNextWorkday(#12/30/1999#, rst, "Date")
    Debug.Print dhNextWorkday(#5/27/1999#, rst, "Date")
    Debug.Print dhPreviousWorkday(#1/1/2000#, rst, "Date")
    Debug.Print dhPreviousWorkday(#5/23/1999#, rst, "Date")
End Sub

Sub TestSystemTimeInfo()
    Dim sti As SystemTimeInfo
    Set sti = New SystemTimeInfo
    
    Debug.Print "Current time zone name is : " & _
     sti.CurrentTimeZoneName
    Debug.Print "Current time zone bias is : " & _
     sti.Bias
    
    Debug.Print "Daylight time zone name is: " & _
     sti.DaylightTimeZoneName
    Debug.Print "Daylight time zone bias is: " & _
     sti.DaylightBias
    
    Debug.Print "Standard time zone name is: " & _
     sti.StandardTimeZoneName
    Debug.Print "Standard time zone bias is: " & _
     sti.StandardBias
    
    Debug.Print "System date/time (UTC) is : " & _
     sti.SystemDateTime
    
    Set sti = Nothing
End Sub
