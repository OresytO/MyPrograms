Attribute VB_Name = "LinearSearch"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Function dhLinearSearch(varItems As Variant, _
 varSought As Variant) As Long
    ' An alternative to the binary search, use a linear
    ' search to find a value in an array.
    
    ' Given an array, and an item to find, return either
    ' the position of the item within the array, or
    ' -1 to indicate failure. If the item appears
    ' more than once in the array, this will find the first
    ' occurrence.
    
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
    
    Dim lngPos As Long
    Dim blnFound As Boolean
    
    blnFound = False
    For lngPos = LBound(varItems) To UBound(varItems)
        If varSought = varItems(lngPos) Then
            blnFound = True
            Exit For
        End If
    Next lngPos
    If blnFound Then
        dhLinearSearch = lngPos
    Else
        dhLinearSearch = -1
    End If
End Function

Function ReturnArray() As String()
    Dim astrValues() As String
    ReDim astrValues(1 To 100)
    ' Put some data into the array.
    astrValues(1) = "Hello"
    astrValues(2) = "There"
    ReturnArray = astrValues()
End Function

Sub TestReturnArray()
    Dim astrValues() As String
    astrValues = ReturnArray()
    Debug.Print astrValues(1)
End Sub


