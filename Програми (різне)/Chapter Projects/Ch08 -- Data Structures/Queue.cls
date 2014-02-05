VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Queue"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Queue class.

Private qFront As QueueItem
Private qRear As QueueItem

Public Sub Add(varNewItem As Variant)
    Dim qNew As QueueItem
    Set qNew = New QueueItem
    
    qNew.Value = varNewItem
    
    ' What if queue is empty? Better point
    ' both the front and rear pointers at the
    ' new item.
    If IsEmpty Then
        Set qFront = qNew
        Set qRear = qNew
    Else
        Set qRear.NextItem = qNew
        Set qRear = qNew
    End If
End Sub

Public Function Remove() As Variant
    ' Remove an item from the head of the
    ' list, and return its value.
    
    If IsEmpty Then
        Remove = Null
    Else
        Remove = qFront.Value
        ' If there's only one item
        ' in the queue, qFront and qRear
        ' will be pointing to the same node.
        ' Use the Is operator to test for that.
        If qFront Is qRear Then
            Set qFront = Nothing
            Set qRear = Nothing
        Else
            Set qFront = qFront.NextItem
        End If
    End If
End Function

Property Get IsEmpty() As Boolean
    ' Return True if the queue contains
    ' no items.
    
    IsEmpty = ((qFront Is Nothing) And (qRear Is Nothing))
End Property

Private Sub Class_Initialize()
    ' Make the queue appear empty.
    Set qFront = Nothing
    Set qRear = Nothing
End Sub

Private Sub Class_Terminate()
    ' Release memory used by the queue.
    Set qFront = Nothing
    Set qRear = Nothing
End Sub

