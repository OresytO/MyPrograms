Attribute VB_Name = "ListTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test for List class.

Sub TestLists()
    Dim liTest As List
    Set liTest = New List
    
    With liTest
        .Add 5
        .Add 1
        .Add 6
        .Add 4
        .Add 9
        .Add 8
        .Add 7
        .Add 10
        .Add 2
        .Add 3
        Call .DebugList
        Debug.Print "====="
        .Delete 1
        .Delete 10
        .Delete 3
        .Delete 4
        Call .DebugList
    End With
End Sub
