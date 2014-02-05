Attribute VB_Name = "BinarySearch"
Option Explicit
Option Compare Text

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Function dhBinarySearch(varItems As Variant, varSought As Variant) As Long
    ' Simple Binary search.
    ' Given an array, and an item to find, return either
    ' the position of the item within the array, or
    ' -1 to indicate failure. If the item appears
    ' more than once in the array, it's not determined
    ' which occurrence this code will find.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varItems:
    '       Array of items to be searched. Must be an array of simple
    '       items, not objects.
    '   varSought:
    '       Item to find in the array. Must be a simple data type
    '       (that is, not an object)
    ' Out:
    '   Return Value:
    '       If the item was found, a long representing its
    '       position in the array.
    '       If the item wasn't found, -1.
    '       This means, of course, that your arrays can't have a
    '       negative lower bound.
    '
    Dim lngLower As Long
    Dim lngMiddle As Long
    Dim lngUpper As Long
    
    lngLower = LBound(varItems)
    lngUpper = UBound(varItems)
    Do While lngLower < lngUpper
        ' Increase lower and decrease upper boundary,
        ' keeping varSought in range, if it's there at all.
        lngMiddle = (lngLower + lngUpper) \ 2
        If varSought > varItems(lngMiddle) Then
            lngLower = lngMiddle + 1
        Else
            lngUpper = lngMiddle
        End If
    Loop
    If varItems(lngLower) = varSought Then
        dhBinarySearch = lngLower
    Else
        dhBinarySearch = -1
    End If
End Function

