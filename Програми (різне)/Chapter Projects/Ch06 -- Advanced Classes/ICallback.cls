VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ITextFileCallback"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Called when a line of text is read
Public Function ReadLine(Text As String) As Boolean

End Function

' Called before a line of text is written
Public Function WriteLine(Text As String) As Boolean
 
End Function

' Called after a file is opened
Public Sub AfterOpen()

End Sub

' Called before a file is closed
Public Function BeforeClose() As Boolean

End Function

