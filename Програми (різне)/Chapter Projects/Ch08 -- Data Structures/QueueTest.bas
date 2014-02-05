Attribute VB_Name = "QueueTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test for Queue class.


Sub TestQueues()
    Dim qTest As Queue
    
    Set qTest = New Queue
    With qTest
        .Add "Hello"
        .Add "There"
        .Add "How"
        .Add "Are"
        .Add "You"
        Do Until .IsEmpty
            Debug.Print .Remove()
        Loop
    End With
End Sub

