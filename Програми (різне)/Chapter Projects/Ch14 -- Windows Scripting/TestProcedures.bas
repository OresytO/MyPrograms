Attribute VB_Name = "basTestProcedures"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test procedures for the Scripting objects.

Public Sub ListRootFolders()
    Dim fso As Scripting.FileSystemObject
    Dim drv As Scripting.Drive
    Dim fld As Scripting.Folder
    
    Set fso = New Scripting.FileSystemObject
    Set drv = fso.GetDrive("C:")
    
    Debug.Print "There are " & drv.RootFolder.SubFolders.Count & " folders."
    
    ' This loop doesn't work, and it would
    ' be the slowest solution, even if it DID work.
    'Dim i As Integer
    'With drv.RootFolder.SubFolders
    '    For i = 1 To .Count
    '        Debug.Print .Item(i).Name
    '    Next i
    'End With
    
    For Each fld In drv.RootFolder.SubFolders
        Debug.Print fld.Name
    Next fld
End Sub

Public Sub ListFiles()
    Dim fso As Scripting.FileSystemObject
    Dim fld As Scripting.Folder
    Dim fil As Scripting.File
    
    Set fso = New Scripting.FileSystemObject
    Set fld = fso.GetFolder("C:\")
    
    Debug.Print "There are " & fld.Files.Count & " files."
    
    ' This loop doesn't work, and it would
    ' be the slowest solution, even if it DID work.
    'Dim i As Integer
    'For i = 1 To fld.Files.Count
    '    Debug.Print fld.Files.Item(i).Name
    'Next i
    
    For Each fil In fld.Files
        Debug.Print fil.Name
    Next fil
End Sub

Public Sub GetAFile1()
    ' Get a reference to a file, the hard way.
    Dim fso As Scripting.FileSystemObject
    Dim drv As Scripting.Drive
    Dim fld As Scripting.Folder
    Dim fil As Scripting.File
    
    Set fso = New Scripting.FileSystemObject
    Set drv = fso.Drives("J:")
    Set fld = drv.RootFolder.SubFolders("WINNT")
    Set fil = fld.Files("WIN.INI")
    Debug.Print fil.Size
End Sub

Public Sub GetAFile2()
    ' Get a reference to a file, the easy way.
    Dim fso As Scripting.FileSystemObject
    Dim fil As Scripting.File
    
    Set fso = New Scripting.FileSystemObject
    Set fil = fso.GetFile("J:\WINNT\WIN.INI")
    Debug.Print fil.Size
End Sub

Public Sub AddLineNumbers( _
 strInFile As String, _
 strOutFile As String, _
 Optional Start As Long = 1, _
 Optional Increment As Long = 1, _
 Optional Width = 6)
    
    Dim fso As Scripting.FileSystemObject
    Dim tsIn As Scripting.TextStream
    Dim tsOut As Scripting.TextStream
    Dim lngCount As Long
    Dim strLead As String
    Dim strText As String
    Dim strNumber As String
    
    On Error GoTo HandleErrors
    
    Set fso = New Scripting.FileSystemObject
    Set tsIn = fso.OpenTextFile(strInFile)
    ' Accept all the defaults: Overwrite, use ASCII.
    Set tsOut = fso.CreateTextFile(strOutFile)
    
    ' Create the leader text, by default: "000000"
    If Width < 0 Then Width = 0
    If Width > 10 Then Width = 10
    strLead = String(Width, "0")
    lngCount = Start
    
    Do Until tsIn.AtEndOfStream
        strText = tsIn.ReadLine
        ' Add the line number to the piece of text.
        If Width = 0 Then
            strNumber = CStr(lngCount)
        Else
            strNumber = Right$(strLead & lngCount, Width)
        End If
        strText = strNumber & " " & strText
        tsOut.WriteLine strText
        lngCount = lngCount + Increment
    Loop

ExitHere:
    tsIn.Close
    tsOut.Close
    Set tsIn = Nothing
    Set tsOut = Nothing
    Set fso = Nothing
    Exit Sub
    
HandleErrors:
    Select Case Err.Number
        ' Handle all errors the same.
        Case Else
            MsgBox "Error: " & Err.Description & _
             " (" & Err.Number & ")"
    End Select
    Resume ExitHere
End Sub
