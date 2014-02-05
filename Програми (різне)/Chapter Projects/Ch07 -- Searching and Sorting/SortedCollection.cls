VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SortedCollection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Create a replacement Collection class
' that sorts its data as you add it.

Private mcol As Collection

Private Sub Class_Initialize()
    Set mcol = New Collection
End Sub

Private Sub Class_Terminate()
    Set mcol = Nothing
End Sub

Public Function Count() As Long
    Count = mcol.Count
End Function

Public Sub Remove(Key As Variant)
    On Error GoTo HandleErrors
        
    mcol.Remove Key
    Exit Sub
    
HandleErrors:
    Err.Raise Err.Number, _
     "SortedCollection.Remove", Err.Description
End Sub

Public Function Item(Key As Variant)
Attribute Item.VB_UserMemId = 0
    On Error GoTo HandleErrors
        
    Item = mcol.Item(Key)
    Exit Function
    
HandleErrors:
    Err.Raise Err.Number, _
     "SortedCollection.Item", Err.Description
End Function

Public Function Enumerate() As IUnknown
Attribute Enumerate.VB_UserMemId = -4
    Set Enumerate = mcol.[_NewEnum]
End Function

Public Sub Add(varNewItem As Variant, Optional strKey As String = "")

    ' Add a value (and its associated key, if requested)
    ' to a collection.
    ' This is effectively performing an insertion sort, which
    ' isn't particularly effective. In general, you're going to
    ' look at n/2 elements to insert each element, so it's basically
    ' linear in speed.  Not good.  But it's certainly the simplest
    ' way to keep a collection sorted.
    
    ' FWIW, for simple items, it's faster to use an array,
    ' even using ReDim Preserve, and sort the array once
    ' you're done adding items. No kidding!
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varNewItem:
    '       New value to be added to the collection. This will
    '       need to be a simple value (not a structure or object)
    '   strKey:
    '       (Optional, default = "") Unique string identifier for
    '       this item. You'll need to specify a unique value here,
    '       or just leave it off.
    ' Out:
    '   Item is added to the collection, at the appropriate
    '   location.
    '   Return Value:
    '       True if successful, False otherwise.

    On Error GoTo HandleErrors
    
    Dim lngI As Long
    Dim blnAdded As Boolean
    Dim blnUseKey As Boolean
    
    blnUseKey = (Len(strKey) > 0)
    
    ' On the first time through here, this loop
    ' will just do nothing at all.
    For lngI = 1 To mcol.Count
        If varNewItem < mcol.Item(lngI) Then
            If blnUseKey Then
                mcol.Add varNewItem, strKey, lngI
            Else
                mcol.Add varNewItem, , lngI
            End If
            blnAdded = True
            Exit For
        End If
    Next lngI
    ' If the item hasn't been added, either because
    ' it goes past the end of the current list of items,
    ' or because there aren't currently any items to loop
    ' through, just add the item at the end of the
    ' collection.
    If Not blnAdded Then
        If blnUseKey Then
            mcol.Add varNewItem, strKey
        Else
            mcol.Add varNewItem
        End If
    End If
    Exit Sub
    
HandleErrors:
    Err.Raise Err.Number, "SortedCollection.Add", Err.Description
End Sub

