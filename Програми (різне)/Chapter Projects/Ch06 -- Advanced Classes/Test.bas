Attribute VB_Name = "basTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 6

Private Sub TestTF2()
    On Error GoTo HandleError
    
    Dim objFile As TextFile2
    Dim cLines As Long
    
    ' Create new instance of TextFile2 class
    ' and set the Path property
    Set objFile = New TextFile2
    objFile.Path = "C:\AUTOEXEC.BAT"
    
    ' Open the file and print each line
    ' using the Lines collection
    If objFile.FileOpen() Then
        For cLines = 1 To objFile.Lines.Count
            Debug.Print objFile.Lines.Item(cLines).Text
        Next
                       
        ' Close the file
        objFile.FileClose
    End If
    
ExitProc:
    Exit Sub
HandleError:
    MsgBox Err.Description, vbExclamation, Err.Number
    Resume ExitProc
End Sub

Sub TestFileEvents()
    Dim objEvents As TestEvents
    
    ' Create new instance--this will open a file
    Set objEvents = New TestEvents
    
    ' We're all done so just destroy the pointer
    Set objEvents = Nothing
End Sub

Sub TestCallback()
    Dim objFile As TextFile4
    Dim objCB As ImmWndCallback
    
    Set objFile = New TextFile4
    Set objCB = New ImmWndCallback
    
    Set objFile.Callback = objCB
    
    objFile.Path = "C:\AUTOEXEC.BAT"
    objFile.FileOpen
    
    Set objFile = Nothing
    Set objCB = Nothing
End Sub

Sub TestRef1()
    ' Both objects terminate at same time

    Dim objRef1 As Ref1
    Dim objRef2 As Ref2
    
    ' Instantiate variables
    Set objRef1 = New Ref1
    Set objRef2 = New Ref2
    
    ' Set a reference to one from the other
    Set objRef2.Link = objRef1
    
    ' Destroy the local references
    Set objRef1 = Nothing
    Set objRef2 = Nothing
End Sub

Sub TestRef2()
    ' No objects terminate!!

    Dim objRef1 As Ref1
    Dim objRef2 As Ref2
    
    ' Instantiate variables
    Set objRef1 = New Ref1
    Set objRef2 = New Ref2
    
    ' Set a reference to one from the other
    Set objRef1.Link = objRef2
    Set objRef2.Link = objRef1
    
    ' Destroy the local references
    Set objRef1 = Nothing
    Set objRef2 = Nothing
End Sub

Sub TestRef3()
    ' Objects terminate normally

    Dim objRef1 As Ref1
    Dim objRef2 As Ref2
    
    ' Instantiate variables
    Set objRef1 = New Ref1
    Set objRef2 = New Ref2
    
    ' Set a reference to one from the other
    Set objRef1.Link = objRef2
    Set objRef2.Link = objRef1
    
    ' Clean up internal reference
    objRef1.Cleanup
    objRef2.Cleanup
    
    ' Destroy the local references
    Set objRef1 = Nothing
    Set objRef2 = Nothing
End Sub

Public Function GetTextFileObject() As TextFile2
    ' Return a new class instance
    Set GetTextFileObject = New TextFile2
End Function

