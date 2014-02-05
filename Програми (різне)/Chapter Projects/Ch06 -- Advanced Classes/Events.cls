VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TestEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' WithEvents declaration to establish event hook
Private WithEvents mobjFile As TextFile3
Attribute mobjFile.VB_VarHelpID = -1

Private Sub Class_Initialize()
    ' Create a new instance of TextFile3 and open a file
    Set mobjFile = New TextFile3
    mobjFile.Path = "C:\AUTOEXEC.BAT"
    mobjFile.FileOpen
End Sub

Private Sub Class_Terminate()
    ' Close the file
    If mobjFile.IsOpen Then
        mobjFile.FileClose
    End If

    ' Destroy the object pointer
    Set mobjFile = Nothing
End Sub

Private Sub mobjFile_ReadLine(ByVal Text As String)
    ' Write the text to the immediate window
    Debug.Print Text
End Sub

