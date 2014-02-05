VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IFileFindCallback"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' IFileFindCallback interface class from Chapter 12

' This gets called each time a
' matching file is found
Public Sub Found(Path As String, File As String)

End Sub

' This gets called each time a new
' directory is searched
Public Sub Searching(Path As String)

End Sub

