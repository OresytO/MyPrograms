Attribute VB_Name = "TreeTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test for Tree class.

Sub TestTrees()
    Dim tHead As Tree
    Set tHead = New Tree
    With tHead
        .Add "f"
        .Add "b"
        .Add "a"
        .Add "d"
        .Add "c"
        .Add "e"
        .Add "i"
        .Add "h"
        .Add "g"
        .Add "k"
        .Add "j"
        Debug.Print "InOrder: "
        Call .WalkInOrder
        Debug.Print
        
        Debug.Print "PreOrder: "
        Call .WalkPreOrder
        Debug.Print
        
        Debug.Print "PostOrder: "
        Call .WalkPostOrder
        Debug.Print
    End With
    
    Set tHead = New Tree
    With tHead
        .AddUnique "Hello"
        .AddUnique "Hello"
        .AddUnique "Hello"
        .AddUnique "Hello"
        .AddUnique "There"
        .AddUnique "My"
        .AddUnique "Name"
        .AddUnique "Is"
        .AddUnique "Ken"
        Debug.Print "====="
        Call .WalkInOrder
        Debug.Print
        Debug.Print "====="
        .TreeDelete "Hello"
        Call .WalkInOrder
        Debug.Print
        Debug.Print "====="
        .TreeDelete "Is"
        Call .WalkInOrder
        Debug.Print
    End With
    
End Sub

