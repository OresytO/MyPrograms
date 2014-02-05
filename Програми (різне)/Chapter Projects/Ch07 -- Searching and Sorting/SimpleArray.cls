VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SimpleArray"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Option Compare Text

' SimpleArray Class, for dhQuickSortable.
' Class used by sorting code to performing
' any actions that work directly with the data being
' sorted.
'
' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Implements ISortable

Private mvarItems() As Variant
Private mlngCount As Long
Private mvarCompare As Variant

' ====================================================
' Local procedures ===================================
' ====================================================
Public Sub Add(varItem As Variant)
    mlngCount = mlngCount + 1
    ReDim Preserve mvarItems(1 To mlngCount)
    mvarItems(mlngCount) = varItem
End Sub

Public Property Get Count() As Long
    Count = mlngCount
End Property

Public Function Item(lngItem As Long) As Variant
    ' This will raise an error if you
    ' attempt to retrieve a value out of
    ' range. Make sure and use the LowerBound
    ' and UpperBound properties to determine
    ' the correct range of values.
    Item = mvarItems(lngItem)
End Function

Public Sub DumpItems(strText As String, _
 Optional lngStart As Long = -1, _
 Optional lngEnd As Long = -1, _
 Optional blnCrLf As Boolean = False, _
 Optional blnNumber As Boolean = False)
 
    Dim lngI As Long
    Dim strOut As String
    
    If lngStart = -1 Then
        lngStart = LBound(mvarItems)
    End If
    If lngEnd = -1 Then
        lngEnd = UBound(mvarItems)
    End If
    
    For lngI = lngStart To lngEnd
        If blnNumber Then
            strOut = strOut & Right$(Space(4) & lngI, 4) & ": "
        End If
        strOut = strOut & Format(mvarItems(lngI), "00 ")
        If blnCrLf Then
            strOut = strOut & vbCrLf
        End If
    Next lngI
    Debug.Print strText;
    If blnCrLf Then
        Debug.Print
    End If
    Debug.Print strOut
End Sub

' ====================================================
' ISortable procedures ===============================
' ====================================================
Private Function ISortable_Compare(lngItem As Long) As CompareResults
    If mvarCompare = mvarItems(lngItem) Then
        ISortable_Compare = crEqual
    ElseIf mvarItems(lngItem) < mvarCompare Then
        ISortable_Compare = crLess
    Else
        ISortable_Compare = crGreater
    End If
End Function

Private Property Get ISortable_LowerBound() As Long
    ISortable_LowerBound = LBound(mvarItems)
End Property

Private Sub ISortable_SetCompareValue(lngItem As Long)
    mvarCompare = mvarItems(lngItem)
End Sub

Private Sub ISortable_Swap( _
 lngItem1 As Long, lngItem2 As Long)
    Dim varTemp As Variant

    varTemp = mvarItems(lngItem2)
    mvarItems(lngItem2) = mvarItems(lngItem1)
    mvarItems(lngItem1) = varTemp

End Sub

Private Property Get ISortable_UpperBound() As Long
    ISortable_UpperBound = UBound(mvarItems)
End Property
