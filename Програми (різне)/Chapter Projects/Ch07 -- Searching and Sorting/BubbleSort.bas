Attribute VB_Name = "BubbleSort"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Sub dhBubbleSort(varItems As Variant)
    ' Standard bubblesort.
    ' DON'T USE THIS unless you know the data is already
    ' almost sorted! It's incredibly slow for
    ' randomly sorted data.
    
    ' There are many variants on this algorithm.
    ' There may even be better ones than this.
    ' But it's not even going to win any
    ' speed prizes for random sorts.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varItems:
    '       Array of items to be sorted.
    ' Out:
    '   VarItems will be sorted.
    
    Dim blnSorted As Boolean
    Dim lngI As Long
    Dim lngJ As Long
    Dim lngItems As Long
    Dim varTemp As Variant
    Dim lngLBound As Long
        
    lngItems = UBound(varItems)
    lngLBound = LBound(varItems)
    
    ' Set lngI one lower than the lower bound.
    lngI = lngLBound - 1
    Do While (lngI < lngItems) And Not blnSorted
        blnSorted = True
        lngI = lngI + 1
        For lngJ = lngLBound To lngItems - lngI
            If varItems(lngJ) > varItems(lngJ + 1) Then
                varTemp = varItems(lngJ)
                varItems(lngJ) = varItems(lngJ + 1)
                varItems(lngJ + 1) = varTemp
                blnSorted = False
            End If
        Next lngJ
    Loop
End Sub
