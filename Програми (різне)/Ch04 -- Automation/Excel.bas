Attribute VB_Name = "basExcel"
' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All Rights Reserved.
    
Option Explicit

Sub UpdateAirportStats()
    
    ' Updates the statistics in an Excel worksheet
    ' using Automation.
    '
    ' From Microsoft Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All Rights Reserved.
    '
    ' In:
    '     none
    ' Out:
    '     n/a
    
    On Error GoTo HandleError
    
    ' Object variables for Automation stuff
    Dim objXLApp As Excel.Application
    Dim objXLBook As Excel.Workbook
    Dim objQuerySheet As Excel.Worksheet
    Dim objResultsSheet As Excel.Worksheet
    Dim objXLRange As Excel.Range
    
    ' ADO and other variables
    Dim cnnLost As ADODB.Connection
    Dim cmdLost As ADODB.Command
    Dim rstLost As ADODB.Recordset
    Dim strSQL As String
    Dim varResults As Variant
    Dim varIATACode As Variant
    Dim varStart As Variant
    Dim varEnd As Variant
    Dim intCount As Integer
    
    ' Go ahead and create an object from the XLS file
    Set objXLBook = GetObject( _
     conPath & "STATREQ.XLS")
            
    ' We can use the Parent
    ' property of the workbook object
    ' to get a pointer to Excel's
    ' Application object
    Set objXLApp = objXLBook.Parent
    
    ' Set object references for the
    ' workbook's two worksheets
    Set objQuerySheet = objXLBook. _
     Worksheets("Query")
    Set objResultsSheet = objXLBook. _
     Worksheets("Results")
     
    ' Make sure both Excel and the
    ' workbook are visible (they won't
    ' be if Excel was launched by our
    ' Automation request)
    objXLApp.Visible = True
    objXLBook.Windows(1).Visible = True
     
    ' Get the airport code from the
    ' Query worksheet and the date
    ' from 1/1/99 and today's day
    varIATACode = objQuerySheet.Range("rngIATACode")
    varStart = #1/1/2000#
    varEnd = DateSerial(2000, 1, Day(Date))

    ' Run our query (note that it has
    ' parameters we need to set)
    strSQL = "SELECT tblLostCount.DateLost," _
     & " tblLostCount.LostCount" _
     & " FROM tblLostCount" _
     & " WHERE (((tblLostCount.DateLost)" _
     & " Between [pStart] And [pEnd]) AND ((" _
     & " tblLostCount.IATACode)=[pIATACode]))"
        
    Set cnnLost = New ADODB.Connection
    cnnLost.Open "Provider=Microsoft.Jet.OLEDB.4.0;" & _
     "Data Source=" & conPath & "AUTOMATE.MDB"
    
    Set cmdLost = New Command
    With cmdLost
        .ActiveConnection = cnnLost
        .CommandText = strSQL
        .Prepared = True
        
        .Parameters("[pIATACode]") = varIATACode
        .Parameters("[pStart]") = varStart
        .Parameters("[pEnd]") = varEnd
        
        Set rstLost = .Execute()
    End With
    
    ' Snag all the results into an array using GetRows
    ' and large (2 ^ 15) row count to get all rows
    varResults = rstLost.GetRows(2 ^ 15)
    rstLost.Close
     
    ' Let's start by clearing the data
    ' range on the results worksheet--
    ' we'll use the rngAllData range
    objResultsSheet.Range("rngDataAll").Clear
    
    ' Determine the range where the data
    ' will go based on the number of rows
    ' in the results
    Set objXLRange = objResultsSheet. _
     Range("B4:C" & 4 + UBound(varResults, 2))
    
    ' Slam the data in using the FormulaArray
    ' method (but we have to transpose it
    ' first because it's oriented wrong)
    objXLRange.FormulaArray = _
     objXLApp.Transpose(varResults)
    
    ' Now that the data is there let's
    ' reset the source range for the chart
    ' (this is pretty hefty Excel VBA code!)
    objResultsSheet.ChartObjects(1). _
     Chart.ChartWizard Source:=objXLApp. _
     Union(objResultsSheet.Range("B2:C2"), _
     objXLRange)
    
    ' Update the cells on the Query worksheet
    With objQuerySheet
        .Range("rngStart").Formula = varStart
        .Range("rngEnd").Formula = varEnd
        .Range("rngUpdate").Formula = Now
    End With
    
    ' Now lets save the workbook
    objXLBook.Save
            
ProcDone:
    On Error Resume Next
    
    ' Let's clean up our act
    Set objResultsSheet = Nothing
    Set objQuerySheet = Nothing
    Set objXLBook = Nothing
    Set objXLApp = Nothing
    
ExitHere:
    Exit Sub
HandleError:
    Select Case Err.Number
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number
    End Select
    Resume ProcDone
End Sub
