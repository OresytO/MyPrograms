VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ProcStackItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Keep track of the next stack item,
' and the text of this item.

Public Value As Variant
Public NextItem As ProcStackItem

Private mdatTimeEntered As Date

Private Sub Class_Initialize()
    Set NextItem = Nothing
    mdatTimeEntered = Now
End Sub

Private Sub Class_Terminate()
    Set NextItem = Nothing
End Sub

Property Get TimeEntered() As Date
    TimeEntered = mdatTimeEntered
End Property
