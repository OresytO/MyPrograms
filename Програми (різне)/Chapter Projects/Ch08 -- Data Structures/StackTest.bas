Attribute VB_Name = "StackTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test for Stack class.

Private stkTest As Stack

Public Sub TestStacks()
        
    Set stkTest = New Stack
    
    ' Push some items, and then pop them.
    stkTest.Push "Hello"
    stkTest.Push "There"
    stkTest.Push "How"
    stkTest.Push "Are"
    stkTest.Push "You"
    Do Until stkTest.StackEmpty
        Debug.Print stkTest.Pop()
    Loop
    
    ' Now, call a bunch of procedures.
    ' For each procedure, push the proc name
    ' at the beginning, and pop it on the way out.
    Debug.Print
    Debug.Print "Testing Procs:"
    stkTest.Push "Main"
    Debug.Print stkTest.StackTop
    Call A
    Debug.Print stkTest.Pop
End Sub

Private Sub A()
    stkTest.Push "A"
    Debug.Print stkTest.StackTop
    Call B
    Debug.Print stkTest.Pop
End Sub

Private Sub B()
    stkTest.Push "B"
    Debug.Print stkTest.StackTop
    Call C
    Debug.Print stkTest.Pop
End Sub

Private Sub C()
    stkTest.Push "C"
    Debug.Print stkTest.StackTop
    ' You'd probably do something in here...
    Debug.Print stkTest.Pop
End Sub

