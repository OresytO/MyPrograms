VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Procedure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Procedure class from Chapter 15

Private mstrName As String
Private mlngKind As Integer
Private mstrCode As String

Property Get Name() As String
    Name = mstrName
End Property
Property Let Name(strName As String)
    mstrName = strName
End Property

Property Get Kind() As Long
    Kind = mlngKind
End Property
Property Let Kind(lngKind As Long)
    Select Case lngKind
        Case vbext_pk_Proc To vbext_pk_Get
            mlngKind = lngKind
    End Select
End Property

Property Get KindName() As String
    Select Case mlngKind
        Case vbext_pk_Proc
            KindName = "Sub or Function"
        Case vbext_pk_Let
            KindName = "Property Let"
        Case vbext_pk_Set
            KindName = "Property Set"
        Case vbext_pk_Get
            KindName = "Property Get"
        Case Else
            KindName = "unknown type"
    End Select
End Property

Property Get Code() As String
    Code = mstrCode
End Property
Property Let Code(strCode As String)
    mstrCode = strCode
End Property

Property Get Lines() As Long
    Dim cb As Long
    Dim lngTemp As Long
    
    ' Find the first carriage return
    cb = InStr(mstrCode, vbCrLf)
    
    ' Loop until no more are found
    Do Until cb = 0
        ' If carriage return is the first
        ' character, don't count it, otherwise
        ' increment the count
        If cb > 1 Then
            lngTemp = lngTemp + 1
        End If
                
        ' Find the next one
        cb = InStr(cb + 1, mstrCode, vbCrLf)
    Loop
    
    ' Return the results plus one
    Lines = lngTemp + 1
End Property

