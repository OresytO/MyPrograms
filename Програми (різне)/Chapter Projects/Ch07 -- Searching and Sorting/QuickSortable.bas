Attribute VB_Name = "QuickSortable"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' QuickSort to ISortable objects.

' Indicate that a parameter is missing.
Const dhcMissing = -2

Sub dhQuickSortable(oData As ISortable, _
 Optional lngLeft As Long = dhcMissing, _
 Optional lngRight As Long = dhcMissing)
    
    ' Entry point for sorting the data in oData. Note that
    ' this procedure knows nothing of the data that it's
    ' sorting. It can do that because it's passed an object
    ' of type ISortable -- by contract, that object supplies
    ' all the necessary code to be able to be sorted.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   oData:
    '       An instantiated object, containing data to be sorted, that
    '       implements ISortable (you must include the ISortable class
    '       in the project containing your data, of course.)
    '
    '       See ExistingArray, FileData, and SimpleArray for
    '       example classes.
    '
    '   lngLeft, lngRight:
    '       Lower and upper bounds of the array to be sorted.
    '       If you don't supply these values (and normally, you won't)
    '       the code uses the LowerBound and UpperBound properties
    '       of the class to get the information. In recursive calls
    '       to the sort, the caller will pass this information in.
    '       To allow for passing integers around (instead of
    '       larger, slower variants), the code uses -2 to indicate
    '       that you've not passed a value. This means that you won't
    '       be able to use this mechanism to sort arrays with negative
    '       indexes, unless you modify this code.
    ' Out:
    '       The data in oData will be sorted, based on your Compare
    '       method.
    
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
            Call dhQuickSortable(oData, lngLeft, j)
            Call dhQuickSortable(oData, i, lngRight)
        Else
            Call dhQuickSortable(oData, i, lngRight)
            Call dhQuickSortable(oData, lngLeft, j)
        End If
    End If
End Sub

