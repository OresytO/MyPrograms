Attribute VB_Name = "TestISortable"
Option Explicit


' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Declare Function GetTickCount _
 Lib "kernel32" () As Long

Sub TestSortSimpleArray(Optional intCount As Integer = 10)
    
    Dim lngI As Long
    Dim oData As SimpleArray
    
    Set oData = New SimpleArray
    
    ' Fill the array with ranumber numbers between
    ' 1 and 99.
    For lngI = 1 To intCount
        oData.Add Int(99 * Rnd + 1)
    Next lngI
    oData.DumpItems "Before   :"
    Call dhQuickSortable(oData)
    oData.DumpItems "After    :"
End Sub

Sub TestSortFileData(Optional strPath As String = "C:\")
    
    ' Get a list of all the files in a directory, and
    ' sort them first by extension, and then by file name.
    
    Dim strFile As String
    Dim oData As FileData
    
    Set oData = New FileData
    strFile = Dir(strPath)
    Do While Len(strFile) > 0
        Call oData.Add(strFile)
        strFile = Dir
    Loop
    
    ' Now the array's full of files.
    oData.DumpItems "Before:"
    Call dhQuickSortable(oData)
    oData.DumpItems "After:"
End Sub

Sub TestSortExistingArray(Optional intCount As Integer = 10)
    
    ' Test out ExistingArray sort class
    Dim lngI As Long
    Dim varData() As Variant
    Dim oData As New ExistingArray
    
    ReDim varData(1 To intCount)
    For lngI = 1 To intCount
        varData(lngI) = Int(99 * Rnd + 1)
    Next lngI
    
    ' Tell the sorting class where to find the data.
    oData.Data = varData
    oData.DumpItems "Before   :"
    Call dhQuickSortable(oData)
    oData.DumpItems "After    :"
    
End Sub

Sub TestTimes()
    Dim sw As StopWatch
    
    Dim lngI As Long
    Dim varData() As Variant
    Dim intCount As Integer
    Dim oData As ExistingArray
    
    ' Change this value to try different
    ' sized sorting sets.
    intCount = 30000
    
    Set sw = New StopWatch
    
    ReDim varData(1 To intCount)
    For lngI = 1 To intCount
        varData(lngI) = Format(Int(99 * Rnd + 1), "00")
    Next lngI
    
    sw.StartTimer
    Call dhQuickSort(varData)
    Debug.Print "QuickSort: " & sw.EndTimer
    
    For lngI = 1 To intCount
        varData(lngI) = Format(Int(99 * Rnd + 1), "00")
    Next lngI
    
    sw.StartTimer
    Set oData = New ExistingArray
    oData.Data = varData
    Call dhQuickSortable(oData)
    Debug.Print "OQuickSort: " & sw.EndTimer
End Sub
