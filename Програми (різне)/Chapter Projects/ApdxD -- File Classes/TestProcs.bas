Attribute VB_Name = "basTestProcs"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Function dhCopyTree(strFrom As String, strTo As String) _
 As Boolean
    
    ' Copy an entire folder tree.
    ' The output folder must already exist.
    
    Dim fld As Folder
    Set fld = New Folder
    
    ' Set up Folder object
    fld.Name = strFrom
    ' Copy away!
    dhCopyTree = fld.Copy(strTo)
End Function


