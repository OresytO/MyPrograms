Attribute VB_Name = "QuickSortObjects"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Quicksort for simple data types.

' Indicate that a parameter is missing.
Const dhcMissing = -2

Sub dhQuickSortObjects(oData As Object, _
 Optional lngLeft As Long = dhcMissing, _
 Optional lngRight As Long = dhcMissing)
    
    ' DON'T USE THIS CODE!
    ' It's here only to prove a point: late
    ' binding is very slow.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    Dim i As Long
    Dim j As Long
    Dim lngMid As Long

    If lngLeft = dhcMissing Then
        lngLeft = oData.LowerBound
    End If
    If lngRight = dhcMissing Then
        lngRight = oData.UpperBound
    End If
    
    If lngLeft < lngRight Then
        lngMid = (lngLeft + lngRight) \ 2
        i = lngLeft
        j = lngRight
        
        ' Store away the value to be compared
        ' against, in the sortable object's code.
        Call oData.SetCompareValue(lngMid)
        Do
            Do While oData.Compare(i) < 0
                i = i + 1
            Loop
            Do While oData.Compare(j) > 0
                j = j - 1
            Loop
            If i <= j Then
                Call oData.Swap(i, j)
                i = i + 1
                j = j - 1
            End If
        Loop Until i > j
        ' To optimize the sort, always sort the
        ' smallest segment first.
        If j <= lngMid Then
            Call dhQuickSortObjects(oData, lngLeft, j)
            Call dhQuickSortObjects(oData, i, lngRight)
        Else
            Call dhQuickSortObjects(oData, i, lngRight)
            Call dhQuickSortObjects(oData, lngLeft, j)
        End If
    End If
End Sub
