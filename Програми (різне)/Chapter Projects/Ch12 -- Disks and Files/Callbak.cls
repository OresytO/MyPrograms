VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FileFindCallback"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' FileFindCallback class from Chapter 12

Implements IFileFindCallback

Private Sub IFileFindCallback_Found(Path As String, File As String)
    Debug.Print "Found: " & Path & File
End Sub

Private Sub IFileFindCallback_Searching(Path As String)
    Debug.Print "Searching: " & Path
    Debug.Print "--------------------------------------"
End Sub
