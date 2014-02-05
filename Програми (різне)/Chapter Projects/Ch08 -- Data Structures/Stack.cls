VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Stack"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Stack class.

Private siTop As StackItem

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
    Dim siNewTop As StackItem
    
    Set siNewTop = New StackItem
    siNewTop.Value = varText
    Set siNewTop.NextItem = siTop
    Set siTop = siNewTop
End Sub

Public Property Get StackTop() As Variant
    If StackEmpty Then
        StackTop = Null
    Else
        StackTop = siTop.Value
    End If
End Property

Public Property Get StackEmpty() As Boolean
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

