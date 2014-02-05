Attribute VB_Name = "basWord"
' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All Rights Reserved.
    
Option Explicit

Function CreateTableFromRecordset( _
 rngAny As Word.Range, _
 rstAny As ADODB.Recordset, _
 Optional fIncludeFieldNames As Boolean = False) _
 As Word.Table

    Dim objTable As Word.Table
    Dim fldAny As ADODB.Field
    Dim varData As Variant
    Dim strBookmark As String
    Dim cField As Long

    ' Get the data from the recordset
    varData = rstAny.GetString()
    
    ' Create the table
    With rngAny
    
        ' Creating the basic table is easy,
        ' just insert the tab-delimted text
        ' add convert it to a table
        .InsertAfter varData
        Set objTable = .ConvertToTable()
        
        ' Field names are more work since
        ' you must do them one at a time
        If fIncludeFieldNames Then
            With objTable
            
                ' Add a new row on top and make it a heading
                .Rows.Add(.Rows(1)).HeadingFormat = True
                
                ' Iterate through the fields and add their
                ' names to the heading row
                For Each fldAny In rstAny.Fields
                    cField = cField + 1
                    .Cell(1, cField).Range.Text = fldAny.Name
                Next
            End With
        End If
    End With
    Set CreateTableFromRecordset = objTable
End Function

Sub PrintInvoiceWithWord(lngOrderID As Long)
    Dim objWord As Word.Application
    Dim cnn As ADODB.Connection
    Dim rst As ADODB.Recordset
    Dim strSQL As String
    
    ' Launch Word and load the invoice template
    Set objWord = New Word.Application
    objWord.Documents.Add _
     conPath & "\Invoice.dot"
    objWord.Visible = True
    
    ' Process the invoice query
    Set cnn = New ADODB.Connection
    cnn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & _
     conPath & "AUTOMATE.MDB"
    strSQL = "SELECT * FROM [Orders Qry] WHERE OrderID = " & lngOrderID
    Set rst = New ADODB.Recordset
    rst.Open strSQL, cnn, adOpenKeyset, adLockPessimistic
    
    ' Add header information using predefined bookmarks
    With objWord.ActiveDocument.Bookmarks
        .Item("OrderID").Range.Text = rst!OrderID
        .Item("OrderDate").Range.Text = rst!OrderDate
        .Item("CompanyName").Range.Text = rst!CompanyName
        .Item("Address").Range.Text = rst!Address
        .Item("Address2").Range.Text = rst!City & ", " & _
         rst!Region & " " & rst!Country & " " & _
         rst!PostalCode
    End With
    
    ' Build SQL string for details
    strSQL = "SELECT [Product Name], [Unit Price], Quantity, " & _
     "Disc, Extended FROM [Order Details Formatted] " & _
     "WHERE OrderID = " & lngOrderID
    
    ' Get details from database and create a table
    ' in the document
    Set rst = New Recordset
    rst.Open strSQL, cnn
    With CreateTableFromRecordset( _
     objWord.ActiveDocument.Bookmarks("Details").Range, rst, True)
             
        ' Apply formatting
        .AutoFormat wdTableFormatProfessional
        .AutoFitBehavior wdAutoFitContent
        
        ' Fix up paragraph alignment
        .Range.ParagraphFormat.Alignment = wdAlignParagraphRight
        .Columns(1).Select
        objWord.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        objWord.Selection.MoveDown
    End With
    
    ' We're done
    Set objWord = Nothing
End Sub

