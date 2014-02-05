VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Tree"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Tree class.

Private tiHead As TreeItem

' These private variables are used when
' adding new nodes.
Private mblnAddDupes As Boolean
Private mvarItemToAdd As Variant

Public Sub Add(varNewItem As Variant)
    ' Add a new node, allowing duplicates.
    ' Use module variables to place as little as
    ' possible on the stack in recursive procedure calls.
    
    mblnAddDupes = True
    mvarItemToAdd = varNewItem
    Call AddNode(tiHead)
End Sub

Public Sub AddUnique(varNewItem As Variant)
    ' Add a new node, skipping duplicate values.
    ' Use module variables to place as little as
    ' possible on the stack in recursive procedure calls.
   
    mblnAddDupes = False
    mvarItemToAdd = varNewItem
    Call AddNode(tiHead)
End Sub

Private Function AddNode(ti As TreeItem) As TreeItem
    
    ' Add a node to the tree pointed to by ti.
    ' Module variables used:
    '    mvarItemToAdd: the value to add to the tree.
    '    mblnAddDupes: Boolean indicating whether to add items
    '      that already exist, or to skip them.
    
    If ti Is Nothing Then
        Set ti = New TreeItem
        ti.Value = mvarItemToAdd
    Else
        If mvarItemToAdd < ti.Value Then
            Set ti.LeftChild = AddNode(ti.LeftChild)
        ElseIf mvarItemToAdd > ti.Value Then
            Set ti.RightChild = AddNode(ti.RightChild)
        Else
            ' You're adding a node that already exists.
            ' You could add it to the left or to the right,
            ' but this code arbitrarily adds it to the right.
            If mblnAddDupes Then
                Set ti.RightChild = AddNode(ti.RightChild)
            End If
        End If
    End If
    Set AddNode = ti
End Function

Public Sub WalkInOrder()
    Call InOrder(tiHead)
End Sub

Public Sub WalkPreOrder()
    Call PreOrder(tiHead)
End Sub

Public Sub WalkPostOrder()
    Call PostOrder(tiHead)
End Sub

Private Sub InOrder(ti As TreeItem)
    If Not ti Is Nothing Then
        Call InOrder(ti.LeftChild)
        Debug.Print ti.Value; " ";
        Call InOrder(ti.RightChild)
    End If
End Sub

Private Sub PreOrder(ti As TreeItem)
    If Not ti Is Nothing Then
        Debug.Print ti.Value; " ";
        Call PreOrder(ti.LeftChild)
        Call PreOrder(ti.RightChild)
    End If
End Sub

Private Sub PostOrder(ti As TreeItem)
    If Not ti Is Nothing Then
        Call PostOrder(ti.LeftChild)
        Call PostOrder(ti.RightChild)
        Debug.Print ti.Value; " ";
    End If
End Sub

' The following two procedures aren't necessary: they
' simply state explicitly what VBA does implicitly when
' you instantiate or destroy a member of the class.

Private Sub Class_Initialize()
    ' Make the tree appear empty.
    Set tiHead = Nothing
End Sub

Private Sub Class_Terminate()
    ' Release memory used by the tree.
    Set tiHead = Nothing
End Sub

' Note: all the code following this point is beyond the
' scope of this chapter. Feel free to study and use the code
' that allows you to delete a node from the tree, given
' its value, but deleting nodes from trees is an art unto
' itself, and would take far more explanation than can be
' covered in a chapter like this.

' Call the TreeDelete method of the Tree class, given a value to
' delete. See the code in TreeTest.bas for an example.

Private Function TreeSearch(varItem As Variant, tiCurrent As TreeItem, _
 tiPrevious As TreeItem)
    If tiCurrent Is Nothing Then
        TreeSearch = False
    Else
        If tiCurrent.Value = varItem Then
            TreeSearch = True
        Else
            ' Item wasn't found. Walk down to the next level:
            ' Make tiPrevious point to the current node,
            ' and make tiCurrent point to the left or
            ' right child node.
            Set tiPrevious = tiCurrent
            If varItem < tiCurrent.Value Then
                Set tiCurrent = tiCurrent.LeftChild
            Else
                Set tiCurrent = tiCurrent.RightChild
            End If
            TreeSearch = TreeSearch(varItem, tiCurrent, tiPrevious)
        End If
    End If
End Function

Private Sub DeleteRightSubTree(tiCurrent As TreeItem, tiPrevious As TreeItem, tiRoot As TreeItem)
    Dim tiNewCurrent As TreeItem
    Dim tiNewPrevious As TreeItem
    
    Set tiNewPrevious = tiPrevious
    Set tiNewCurrent = tiCurrent.RightChild
    
    ' Link predecessor node of the current node to its right subtree.
    ' That is, link around the current node which you're trying to delete.
    If tiPrevious Is Nothing Then
        Set tiRoot = tiCurrent.RightChild
    Else
        Set tiPrevious.RightChild = tiCurrent.RightChild
    End If
    ' Find leftmost node in right subtree of predecessor node
    Do Until tiNewCurrent Is Nothing
        Set tiNewPrevious = tiNewCurrent
        Set tiNewCurrent = tiNewCurrent.LeftChild
    Loop
    If tiCurrent.RightChild Is Nothing Then
        ' No right subtree, so left subtree becomes right subtree of
        ' predecessor node
        If tiPrevious Is Nothing Then
            Set tiRoot = tiCurrent.LeftChild
        Else
            Set tiPrevious.RightChild = tiCurrent.LeftChild
        End If
    Else
        ' Left subtree of current node becomes left subtree
        ' of leftmost node in right subtree
        If tiNewPrevious Is Nothing Then
            Set tiRoot = tiCurrent.LeftChild
        Else
            Set tiNewPrevious.LeftChild = tiCurrent.LeftChild
        End If
    End If
    Set tiCurrent = Nothing
End Sub

Private Sub DeleteLeftSubTree(tiCurrent As TreeItem, tiPrevious As TreeItem, tiRoot As TreeItem)
    Dim tiNewCurrent As TreeItem
    Dim tiNewPrevious As TreeItem
    
    Set tiNewPrevious = tiPrevious
    Set tiNewCurrent = tiCurrent.LeftChild
    
    ' Link predecessor node of the current node to its Left subtree.
    ' That is, link around the current node which you're trying to delete.
    If tiPrevious Is Nothing Then
        Set tiRoot = tiCurrent.LeftChild
    Else
        Set tiPrevious.LeftChild = tiCurrent.LeftChild
    End If
    ' Find Rightmost node in Left subtree of predecessor node
    Do Until tiNewCurrent Is Nothing
        Set tiNewPrevious = tiNewCurrent
        Set tiNewCurrent = tiNewCurrent.RightChild
    Loop
    If tiCurrent.LeftChild Is Nothing Then
        ' No Left subtree, so Right subtree becomes Left subtree of
        ' predecessor node
        If tiPrevious Is Nothing Then
            Set tiRoot = tiCurrent.RightChild
        Else
            Set tiPrevious.LeftChild = tiCurrent.RightChild
        End If
    Else
        ' Right subtree of current node becomes Right subtree
        ' of Rightmost node in Left subtree
        If tiNewPrevious Is Nothing Then
            Set tiRoot = tiCurrent.RightChild
        Else
            Set tiNewPrevious.RightChild = tiCurrent.RightChild
        End If
    End If
    Set tiCurrent = Nothing
End Sub

Public Function TreeDelete(varValue As Variant) As Boolean
    ' Delete the selected item, if it's found, from the
    ' tree pointed to by tiRoot
    
    Dim tiCurrent As TreeItem
    Dim tiPrevious As TreeItem
    Dim blnFound As Boolean
    
    Set tiCurrent = tiHead
    Set tiPrevious = Nothing
    
    blnFound = TreeSearch(varValue, tiCurrent, tiPrevious)
    If blnFound Then
        If Not tiPrevious Is Nothing Then
            If varValue < tiPrevious.Value Then
                Call DeleteLeftSubTree(tiCurrent, tiPrevious, tiHead)
            Else
                Call DeleteRightSubTree(tiCurrent, tiPrevious, tiHead)
            End If
        Else
            Call DeleteRightSubTree(tiCurrent, tiPrevious, tiHead)
        End If
    End If
    TreeDelete = blnFound
End Function


