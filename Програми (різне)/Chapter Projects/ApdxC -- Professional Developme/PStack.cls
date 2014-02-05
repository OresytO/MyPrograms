VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ProcStack"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Dim siTop As ProcStackItem

Public Function Pop() As Variant
    If Not StackEmpty Then
        ' Get the value from the current top stack element.
        ' Then, get a reference to the new stack top.
        Pop = siTop.Value
        Set siTop = siTop.NextItem
    End If
End Function

Public Sub Push(ByVal varText As Variant)
    ' Add a new item to the top of the stack.
    Dim siNewTop As New ProcStackItem
        
    siNewTop.Value = varText
    Set siNewTop.NextItem = siTop
    Set siTop = siNewTop
End Sub

Property Get StackTop() As ProcStackItem
    If siTop Is Nothing Then
        Set StackTop = Nothing
    Else
        Set StackTop = siTop
    End If
End Property

Property Get StackEmpty() As Boolean
    ' Is the stack empty?  It can
    ' only be empty if siTop is Nothing.
    StackEmpty = (siTop Is Nothing)
End Property

Private Sub Class_Initialize()
    Set siTop = Nothing
End Sub

Private Sub Class_Terminate()
    Set siTop = Nothing
End Sub

