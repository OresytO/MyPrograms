VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "List"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' List class.

Private liHead As ListItem

' This class maintains an ordered list of items
' It uses brute force (a linear search) to
' maintain the list.  A binary tree would be a better
' idea...

Public Sub Add(varValue As Variant)
    Dim liNew As ListItem
    Dim liCurrent As ListItem
    Dim liPrevious As ListItem
        
    Set liNew = New ListItem
    liNew.Value = varValue
    
    ' Find where to put the new item. This function call
    ' fills in liCurrent and liPrevious.
    Call Search(varValue, liCurrent, liPrevious)
    
    If Not liPrevious Is Nothing Then
        Set liNew.NextItem = liPrevious.NextItem
        Set liPrevious.NextItem = liNew
    Else
        ' Inserting at the head of the list:
        ' Set the new item to point to what liHead currently
        ' points to (which might just be Nothing). Then
        ' make liHead point to the new item.
        Set liNew.NextItem = liHead
        Set liHead = liNew
    End If
End Sub

Private Function Search(ByVal varItem As Variant, _
 ByRef liCurrent As ListItem, ByRef liPrevious As ListItem) As Boolean
    Dim blnFound As Boolean
    
    blnFound = False
    
    Set liPrevious = Nothing
    Set liCurrent = liHead
    
    Do Until liCurrent Is Nothing
        With liCurrent
            If varItem > .Value Then
                Set liPrevious = liCurrent
                Set liCurrent = .NextItem
            Else
                Exit Do
            End If
        End With
    Loop
    
    ' You can't compare the value in liCurrent to the sought
    ' value unless liCurrent points to something.
    If Not liCurrent Is Nothing Then
        blnFound = (liCurrent.Value = varItem)
    End If
    Search = blnFound
End Function

Public Function Delete(varItem As Variant) As Boolean
    Dim liCurrent As ListItem
    Dim liPrevious As ListItem
    Dim blnFound As Boolean
        
    ' Find the item. This function call
    ' fills in liCurrent and liPrevious.
    blnFound = Search(varItem, liCurrent, liPrevious)
    If blnFound Then
        If liPrevious Is Nothing Then
            ' Deleting from the head of the list.
            Set liHead = liHead.NextItem
        Else
            ' Deleting from the middle or end of the list.
            Set liPrevious.NextItem = liCurrent.NextItem
        End If
    End If
    Delete = blnFound
End Function

Public Sub DebugList()
    ' Print the list to the Debug Window.
    Dim liCurrent As ListItem
        
    Set liCurrent = liHead
    Do Until liCurrent Is Nothing
        Debug.Print liCurrent.Value
        Set liCurrent = liCurrent.NextItem
    Loop
End Sub

