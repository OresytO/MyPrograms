Attribute VB_Name = "basNavigateFolders"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Public Sub IterateFolders( _
 fld As Scripting.Folder, _
 Optional Level As Integer = 0)
 
    ' Demo recursive procedure to iterate through
    ' folders, including subfolders.
    
    Dim fldSub As Scripting.Folder
    ' Print out the current folder, indented.
    Debug.Print Space(2 * Level); fld.Path
    
    ' Now loop through all the subfolders.
    For Each fldSub In fld.SubFolders
        Call IterateFolders(fldSub, Level + 1)
    Next fldSub
End Sub

Public Sub GetParentFolder(fld As Scripting.Folder)
    ' Demo procedure to work back through
    ' folders, up to the root.
        
    Do Until fld.IsRootFolder
        Debug.Print fld.Path
        Set fld = fld.ParentFolder
    Loop
    Debug.Print fld.Path
End Sub

Public Sub TestIterateFolders()
    Dim fso As Scripting.FileSystemObject
    Set fso = New Scripting.FileSystemObject
    Call IterateFolders(fso.GetFolder("C:\"))
    Set fso = Nothing
End Sub

Public Sub TestGetParent()
    Dim fso As Scripting.FileSystemObject
    Set fso = New Scripting.FileSystemObject
    ' Substitute your own folder for the hard-coded
    ' folder used in this example.
    Call GetParentFolder( _
     fso.GetFolder("C:\OPG\SAMPLES\CH02"))
    Set fso = Nothing
End Sub

