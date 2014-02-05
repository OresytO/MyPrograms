VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Ref1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Property variables
Private mlngNumber As Long

' Self-reference
Private mobjLink As Ref2

Property Get Number() As Long
    Number = mlngNumber
End Property

Property Get Link() As Ref2
    Set Link = mobjLink
End Property
Property Set Link(objLink As Ref2)
    ' Print message
    Debug.Print "Referencing " & _
     objLink.Number & " from " & _
     mlngNumber
     
    Set mobjLink = objLink
End Property

Private Sub Class_Initialize()
    ' Get number property
    mlngNumber = CLng(Timer * 100)
    
    ' Print message
    Debug.Print "Initializing " & mlngNumber
End Sub

Private Sub Class_Terminate()
    ' Print message
    Debug.Print "Terminating " & mlngNumber
End Sub

Public Sub Cleanup()
    ' Destroy all object references
    If Not mobjLink Is Nothing Then
        Set mobjLink = Nothing
    End If
End Sub
