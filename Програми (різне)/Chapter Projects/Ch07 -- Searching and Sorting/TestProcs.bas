Attribute VB_Name = "TestProcs"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Declare Function GetTickCount Lib "kernel32" () As Long

Public Sub CompareTimers()
    Dim lngMax As Long
    Dim sw As New StopWatch
    Dim lngI As Long
    Dim lngResult As Long
    
    lngMax = 100000
    sw.StartTimer
    For lngI = 1 To lngMax
        lngResult = Timer
    Next lngI
    Debug.Print "Timer: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To lngMax
        lngResult = GetTickCount
    Next lngI
    Debug.Print "GetTickCount: " & sw.EndTimer
End Sub

Public Sub TestSortTimes(intCount As Integer)
    
    Dim sw As StopWatch
    Dim lngI As Long
    Dim varData() As Variant
    
    ' Have Quicksort sort random numbers.
    ReDim varData(1 To intCount)
    For lngI = 1 To intCount
        varData(lngI) = Format(Int(99 * Rnd + 1), "00")
    Next lngI
    
    Set sw = New StopWatch
    sw.StartTimer
    Call dhQuickSort(varData)
    Debug.Print "Using simple quicksort: " & sw.EndTimer
    
    ' Have Bubblesort sort random numbers.
    ReDim varData(1 To intCount)
    For lngI = 1 To intCount
        varData(lngI) = Format(Int(99 * Rnd + 1), "00")
    Next lngI
    
    sw.StartTimer
    Call dhBubbleSort(varData)
    Debug.Print "Using bubble sort: " & sw.EndTimer
    
    ' Generate sorted values.
    For lngI = 1 To intCount
        varData(lngI) = lngI
    Next lngI
    
    ' Have Quicksort sort sequential numbers.
    sw.StartTimer
    Call dhQuickSort(varData)
    Debug.Print "Using simple quicksort (ordered): " & sw.EndTimer
    
    ' Have Bubblesort sort sequential numbers.
    sw.StartTimer
    Call dhBubbleSort(varData)
    Debug.Print "Using bubble sort (Ordered): " & sw.EndTimer
End Sub

Public Sub CompareSearch(Optional intSize As Integer = 1000)
    Dim lngItems() As Integer
    Dim lngI As Long
    Dim intTempItems() As Integer
    Dim sw As New StopWatch
    
    Const conLoops = 1000
    
    ReDim lngItems(1 To intSize)
    ReDim intTempItems(1 To intSize)
    
    ' Get a list of all the numbers.
    ' This'll be sorted, of course.
    For lngI = 1 To intSize
        lngItems(lngI) = lngI
    Next lngI
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhBinarySearch(lngItems, lngItems(0.1 * intSize))
    Next lngI
    Debug.Print "Binary search early item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhBinarySearch(lngItems, lngItems(0.9 * intSize))
    Next lngI
    Debug.Print "Binary search late item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhBinarySearch(lngItems, lngItems(0.5 * intSize))
    Next lngI
    Debug.Print "Binary search middle item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhBinarySearch(lngItems, -1)
    Next lngI
    Debug.Print "Binary search not found: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhLinearSearch(lngItems, lngItems(0.1 * intSize))
    Next lngI
    Debug.Print "Linear search early item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhLinearSearch(lngItems, lngItems(0.9 * intSize))
    Next lngI
    Debug.Print "Linear search late item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhLinearSearch(lngItems, lngItems(0.5 * intSize))
    Next lngI
    Debug.Print "Linear search middle item: " & sw.EndTimer
    
    sw.StartTimer
    For lngI = 1 To conLoops
        Call dhLinearSearch(lngItems, -1)
    Next lngI
    Debug.Print "Linear search not found: " & sw.EndTimer
End Sub

Public Sub SillySearch()
    ' Generate a series of 100 random integers
    ' between 1 and 100. Obviously, there'll be
    ' some repeats, and some numbers missing.
    ' Ask the caller for a value, and keep
    ' asking, as long as they entered a value
    ' in the list. If the caller enters
    ' a value that wasn't in the list,
    ' pop up a msgbox telling how many correct
    ' values were selected.
    Dim alngItems(1 To 100) As Integer
    Dim lngI As Long
    Dim intPos As Integer
    Dim intCount As Integer
    
    For lngI = 1 To 100
        alngItems(lngI) = Int(Rnd * 100) + 1
    Next lngI
    Call dhQuickSort(alngItems)
    Do
        lngI = Val(InputBox("Choose a number between 1 and 100"))
        intPos = dhBinarySearch(alngItems, lngI)
        If intPos > 0 Then
            intCount = intCount + 1
        End If
    Loop Until intPos < 0
    MsgBox "You guessed " & intCount & " correct values!"
End Sub

Sub TestSortedCollection()
    Dim sc As SortedCollection
    Dim lngI As Integer
    Dim intCount As Integer
    Dim varItem As Variant
    
    Set sc = New SortedCollection
    
    intCount = 1000
    For lngI = 1 To intCount
        sc.Add Format(Int(99 * Rnd + 1), "00")
    Next lngI
    
    For Each varItem In sc
        Debug.Print varItem & " ";
    Next varItem
    
    Set sc = Nothing
End Sub

Sub TestQuickSortObjects()
    Dim fdo As FileDataObject
    Dim strFile As String
    
    Set fdo = New FileDataObject
    
    strFile = Dir("C:\*.*")
    Do While Len(strFile) > 0
        Call fdo.Add(strFile)
        strFile = Dir
    Loop
    Call dhQuickSortObjects(fdo)
    Call fdo.DumpItems("After:")
End Sub
