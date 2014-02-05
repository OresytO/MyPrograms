VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Customer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Property varaiables
Private mstrFirstName As String
Private mstrLastName As String

' Parent property reference
Private mobjParent As Invoice

Property Get FirstName() As String
    FirstName = mstrFirstName
End Property
Property Let FirstName(strFirstName As String)
    mstrFirstName = strFirstName
End Property

Property Get LastName() As String
    LastName = mstrLastName
End Property
Property Let LastName(strLastName As String)
    mstrLastName = strLastName
End Property

Property Get Parent() As Invoice
    ' Return the pointer stored in mobjParent
    Set Parent = mobjParent
End Property

Property Set Parent(objParent As Invoice)
    ' If property hasn't been set yet, do so
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

