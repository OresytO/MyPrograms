VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Invoice"
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

' Reference to child object
Private mobjCustomer As Customer

Property Get Customer() As Customer
    ' Return reference to child object
    Set Customer = mobjCustomer
End Property

Property Get Number() As Long
    Number = mlngNumber
End Property

Private Sub Class_Initialize()
    ' Get dummy invoice number
    mlngNumber = CLng(Rnd * 2 ^ 15)
    
    ' Instantiate child object
    Set mobjCustomer = New Customer
    
    ' Set up child's parent reference
    Set mobjCustomer.Parent = Me
End Sub
