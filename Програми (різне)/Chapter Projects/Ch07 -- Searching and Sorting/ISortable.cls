VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ISortable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Base class for sortable objects. Used with dhQuickSortable.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Public Enum CompareResults
    crEqual = 0
    crLess = -1
    crGreater = 1
    crNull = 2
End Enum

Public Sub SetCompareValue(lngItem As Long)

End Sub

Public Property Get LowerBound() As Long

End Property

Public Property Get UpperBound() As Long

End Property

Public Sub Swap(lngItem1 As Long, lngItem2 As Long)

End Sub

Public Function Compare(lngItem As Long) As CompareResults
    
End Function

