VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Line"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Line class from Chapter 6

' Private variables for line of text
Private mstrText As String

' Private ID variable
Private mstrID As String

' Public variable for changed flag
Public Changed As Boolean

Property Get Text() As String
Attribute Text.VB_UserMemId = 0
    ' Return value of private variable
    Text = mstrText
End Property

Property Let Text(ByVal strText As String)
    ' Change private variable and set changed flag
    mstrText = strText
    Me.Changed = True
End Property

Property Get Length() As Long
    ' Use Len function to return string length
    Length = Len(mstrText)
End Property

Property Get ID() As String
    ' Return value of private variable
    ID = mstrID
End Property

Private Sub Class_Initialize()
    ' Set the object's ID property to a random string
    mstrID = TypeName(Me) & CLng(Rnd * (2 ^ 31))
End Sub
