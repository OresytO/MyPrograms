Attribute VB_Name = "QuickSort"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Quicksort for simple data types.

' Indicate that a parameter is missing.
Private Const dhcMissing = -2

Public Sub dhQuickSort(varArray As Variant, _
 Optional lngLeft As Long = dhcMissing, _
 Optional lngRight As Long = dhcMissing)

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Entry point for sorting the array.
    
    ' This technique uses the recursive Quicksort
    ' algorithm to perform its sort.
    
    ' In:
    '   varArray:
    '       A variant polngIng to an array to be sorted.
    '       This had better actually be an array, or the
    '       code will fail, miserably. You could add
    '       a test for this:
    '       If Not IsArray(varArray) Then Exit Sub
    '       but hey, that would slow this down, and it's
    '       only YOU calling this procedure.
    '       Make sure it's an array. It's your problem.
    '   lngLeft:
    '   lngRight:
    '       Lower and upper bounds of the array to be sorted.
    '       If you don't supply these values (and normally, you won't)
    '       the code uses the LBound and UBound functions
    '       to get the information. In recursive calls
    '       to the sort, the caller will pass this information in.
    '       To allow for passing integers around (instead of
    '       larger, slower variants), the code uses -2 to indicate
    '       that you've not passed a value. This means that you won't
    '       be able to use this mechanism to sort arrays with negative
    '       indexes, unless you modify this code.
    ' Out:
    '       The data in varArray will be sorted.
    
    Dim i As Long
    Dim j As Long
    Dim varTestVal As Variant
    Dim lngMid As Long

    If lngLeft = dhcMissing Then lngLeft = LBound(varArray)
    If lngRight = dhcMissing Then lngRight = UBound(varArray)
   
    If lngLeft < lngRight Then
        lngMid = (lngLeft + lngRight) \ 2
        varTestVal = varArray(lngMid)
        i = lngLeft
        j = lngRight
        Do
            Do While varArray(i) < varTestVal
                i = i + 1
            Loop
            Do While varArray(j) > varTestVal
                j = j - 1
            Loop
            If i <= j Then
                Call SwapElements(varArray, i, j)
                i = i + 1
                j = j - 1
            End If
        Loop Until i > j
        ' To optimize the sort, always sort the
        ' smallest segment first.
        If j <= lngMid Then
            Call dhQuickSort(varArray, lngLeft, j)
            Call dhQuickSort(varArray, i, lngRight)
        Else
            Call dhQuickSort(varArray, i, lngRight)
            Call dhQuickSort(varArray, lngLeft, j)
        End If
    End If
End Sub

Private Sub SwapElements(varItems As Variant, _
 lngItem1 As Long, lngItem2 As Long)
    Dim varTemp As Variant

    varTemp = varItems(lngItem2)
    varItems(lngItem2) = varItems(lngItem1)
    varItems(lngItem1) = varTemp
End Sub


