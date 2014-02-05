Attribute VB_Name = "basTest"
' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All Rights Reserved.

Option Explicit

Sub TestTextFile()
    Dim objFile As TextFile
        
    ' Create new instance of TextFile class
    Set objFile = New TextFile
    
    ' Set the Path property
    objFile.Path = "C:\AUTOEXEC.BAT"
    
    ' Try to open the file--if successful,
    ' read until the end of the file,
    ' printing each line
    If objFile.FileOpen() Then
      Do Until objFile.EOF
        Debug.Print objFile.Text
        objFile.ReadNext
      Loop
      objFile.FileClose
    End If
    
    ' Destroy class instance
    Set objFile = Nothing
End Sub

Sub TestClip()
    Dim objClip As Clipboard
    
    ' Instantiate the object
    Set objClip = New Clipboard
    
    ' Put some text on the clipboard
    objClip.Text = "Test String"
    
    ' Take it off
    Debug.Print objClip.Text
End Sub
