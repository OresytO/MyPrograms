VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TreeItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' TreeItem Class.

Public Value As Variant
Public LeftChild As TreeItem
Public RightChild As TreeItem

' The following procedures aren't truly necessary,
' they just state explicitly what happens when
' you instantiate a new element of the class.

Private Sub Class_Initialize()
    Set LeftChild = Nothing
    Set RightChild = Nothing
End Sub

Private Sub Class_Terminate()
    Set LeftChild = Nothing
    Set RightChild = Nothing
End Sub
