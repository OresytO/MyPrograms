Attribute VB_Name = "VQuickSort"
Option Explicit
Option Base 1

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Display steps of simple quicksort as it's executing.
' Call TestSortDemo with the number of items
' to test (or pass nothing to use a standard
' 10-element array.

' This demo requires the "Option Base 1" at the top.
' Otherwise, the Array function will use 0 as its base,
' and the code that lays out the items will fail in that case.

Sub TestSortDemo(Optional lngCount As Long = 0)
    
    Dim aintList As Variant
    Dim lngI As Long

    If lngCount = 0 Then
        ' Run the canned example.
        aintList = Array(79, 30, 24, 48, 26, 34, 5, 48, 21, 86)
        lngCount = 10
    Else
        ' Get up to 20 random numbers.
        If lngCount <= 0 Then Exit Sub
        If lngCount > 20 Then lngCount = 20
    
        ReDim aintList(1 To lngCount)
        For lngI = LBound(aintList) To UBound(aintList)
            aintList(lngI) = Int(99 * Rnd + 1)
        Next lngI
    End If
    
    DumpItems "Before   :", aintList, 1, lngCount
    VisSortItems aintList
    DumpItems "After    :", aintList, 1, lngCount
End Sub

Private Sub DumpItems(strText As String, Items As Variant, lngLeft As Long, lngRight As Long)

    Dim lngI As Long
    Dim strOut As String

    For lngI = lngLeft To lngRight
        strOut = strOut & Format$(Items(lngI), "00  ")
    Next lngI
    strOut = Space(4 * (lngLeft - 1)) & strOut
    Debug.Print strText; strOut
End Sub

Private Sub ShowSwap(lngItem1 As Long, lngItem2 As Long)
    
    Dim lngMin As Long
    Dim lngMax As Long
    Dim strFiller As String

    If lngItem1 < lngItem2 Then
        lngMin = lngItem1
        lngMax = lngItem2
    Else
        lngMin = lngItem2
        lngMax = lngItem1
    End If
    strFiller = Space((lngMin - 1) * 4) & "^i  "
    If lngMax > lngMin Then
        strFiller = strFiller & Space((lngMax - lngMin - 1) * 4) & "^j  "
    End If
    Debug.Print "Swap     :" & strFiller
End Sub

Private Sub SwapElements(Items As Variant, lngItem1 As Long, lngItem2 As Long)
    Dim intTemp As Integer

    intTemp = Items(lngItem2)
    Items(lngItem2) = Items(lngItem1)
    Items(lngItem1) = intTemp
End Sub

Private Sub VisQuickSort(varItems As Variant, lngLeft As Long, lngRight As Long)
    
    ' ******
    ' For demo only. In real use, remove this routine.
    ' ******
    
    Dim i As Long
    Dim j As Long
    Dim varTestVal As Variant
    Dim lngMid As Long

    If lngLeft < lngRight Then
        i = lngLeft
        j = lngRight
        lngMid = (lngLeft + lngRight) \ 2
        varTestVal = varItems(lngMid)
        
        Debug.Print "--------"
        DumpItems Left(lngLeft & "-" & lngRight & ")        ", 10), varItems, lngLeft, lngRight
        Debug.Print Left("Value: " & Space(10), 10);
        Debug.Print Space(4 * (lngMid - 1)) & Format(varTestVal, "00")
        Debug.Print "Sorting Items " & lngLeft & "->" & lngRight
        DumpItems Left(lngLeft & "-" & lngRight & ")        ", 10), varItems, lngLeft, lngRight
        
        Do
            Do While varItems(i) < varTestVal
                i = i + 1
            Loop
            Do While varItems(j) > varTestVal
                j = j - 1
            Loop
            If i <= j Then
                ShowSwap i, j
                SwapElements varItems, i, j
                i = i + 1
                j = j - 1
            End If
            DumpItems "          ", varItems, lngLeft, lngRight
        Loop Until i > j
        ' To optimize the sort, always sort the
        ' smallest segment first.
        If j <= lngMid Then
            VisQuickSort varItems, lngLeft, j
            VisQuickSort varItems, i, lngRight
        Else
            VisQuickSort varItems, i, lngRight
            VisQuickSort varItems, lngLeft, j
        End If
    End If
End Sub

Private Sub VisSortItems(Items As Variant)
    
    ' ******
    ' For demo only. In real use, remove this routine.
    ' ******
    
    VisQuickSort Items, LBound(Items), UBound(Items)
End Sub
