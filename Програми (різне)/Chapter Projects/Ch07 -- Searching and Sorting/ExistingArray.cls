VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ExistingArray"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Option Compare Text

' ExistingArray Class
' Set the Data property to be an existing array,
' and then use this class to sort the array.
'
' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Implements ISortable

Private mvarItems As Variant
Private mlngCount As Long
Private mvarCompare As Variant

' ====================================================
' Local procedures ===================================
' ====================================================
Public Function Item(lngItem As Long) As Variant
    Item = mvarItems(lngItem)
End Function

Property Let Data(pvarData As Variant)
    ' Point the internal pointer to an external array
    ' (supplied by the caller)
    mvarItems = pvarData
End Property

Property Get Data() As Variant
    Data = mvarItems
End Property

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
        ' If numbering output, add the numbers now. We suggest
        ' you only number items if you're inserting
        ' CRLFs. It will look rather odd, otherwise.
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
    ' Return 0 if the items are equal
    ' Return 1 if varItems(lngItem) > varValue
    ' Return -1 if varItems(lngItem) < varValue
    If mvarItems(lngItem) = mvarCompare Then
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

Private Sub ISortable_Swap(lngItem1 As Long, lngItem2 As Long)
    Dim varTemp As Variant

    varTemp = mvarItems(lngItem2)
    mvarItems(lngItem2) = mvarItems(lngItem1)
    mvarItems(lngItem1) = varTemp
End Sub

Private Property Get ISortable_UpperBound() As Long
    ISortable_UpperBound = UBound(mvarItems)
End Property
