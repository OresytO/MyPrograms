Attribute VB_Name = "basDictionary"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private mdct As Scripting.Dictionary

Public Sub TestDictionary()
        Dim dct As Scripting.Dictionary
        Set dct = New Scripting.Dictionary
            
        dct.Add "Butter", "Dairy"
        dct.Add "Carrots", "Vegetable"
        dct.Add "Beets", "Vegetable"
        dct.Add "Apple", "Fruit"
        dct.Add "Milk", "Dairy"
        dct.Add "Yogurt", "Dairy"
    
    Dim varItem As Variant
    
    ' Visit each key, and print out the value.
    For Each varItem In dct.Keys
        Debug.Print varItem
    Next varItem
        
    ' Visit each item, and print out the value.
    For Each varItem In dct.Items
        Debug.Print varItem
    Next varItem
    
    ' You can use a For...Next loop, as well.
    Dim i As Long
    For i = 0 To dct.Count - 1
        Debug.Print dct.Items(i)
    Next i
    
    ' Change the Key value of an item.
    dct.Key("Yogurt") = "Frozen Yogurt"
    Debug.Print dct.Item("Frozen Yogurt")
    
    ' Change the Item value of an item.
    dct.Item("Frozen Yogurt") = "Fruit"
    Debug.Print dct.Item("Frozen Yogurt")
    
    Set dct = Nothing
End Sub

Public Sub CountWords(strFileName As String)

    ' Given a text file name, add an item to
    ' mdct for each distinct word. Keep track
    ' of the number of times each word appears
    ' in the text file.
    
    Dim fso As Scripting.FileSystemObject
    Dim ts As Scripting.TextStream
    
    Dim strText As String
    Dim astrItems() As String
    Dim i As Long
    
    On Error GoTo HandleErrors
    
    Set fso = New Scripting.FileSystemObject
    Set mdct = New Scripting.Dictionary
    
    ' Open the text file, and read it all
    ' into a string.
    Set ts = fso.OpenTextFile(strFileName)
    strText = ts.ReadAll
    
    ' Replace all delimiters with spaces.
    ' Trim out all the extra white space, and
    ' then call the Split function to retrieve
    ' an array full of words from the file.
    ' dhTranslate and dhTrimAll are copied from the
    ' Chapter 1 samples for this book.
    strText = dhTranslate(strText, _
     " @()[]{},;:.-" & vbCrLf, " ")
    strText = dhTrimAll(strText)
    astrItems = Split(strText)
    
    mdct.CompareMode = TextCompare
    For i = LBound(astrItems) To UBound(astrItems)
        strText = astrItems(i)
        If mdct.Exists(strText) Then
            mdct.Item(strText) = mdct.Item(strText) + 1
        Else
            mdct.Item(strText) = 1
        End If
    Next i
    
ExitHere:
    ts.Close
    Set fso = Nothing
    Exit Sub
    
HandleErrors:
    Select Case Err.Number
        Case Else
            MsgBox "Error: " & Err.Desciption & _
             " (" & Err.Number & ")"
    End Select
End Sub

Public Sub ListItems()
    Dim i As Integer
    
    For i = 0 To mdct.Count - 1
        Debug.Print mdct.Keys(i), mdct.Items(i)
    Next i
End Sub
