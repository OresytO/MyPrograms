Attribute VB_Name = "basTestAttributes"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Public Sub ClearAllAttributes(strPath As String)
    ' Given a full file name, clear
    ' all the modifiable attributes:
    ' Archive, ReadOnly, System, and Hidden.
    
    Dim fso As Scripting.FileSystemObject
    Dim fil As Scripting.File
    
    Set fso = New Scripting.FileSystemObject
    Set fil = fso.GetFile(strPath)
    
    ' Clear all modifiable attributes.
    fil.Attributes = ClearAttributes(fil.Attributes, _
     Archive + System + Hidden + ReadOnly)
    
    Set fil = Nothing
    Set fso = Nothing
End Sub

Public Sub SetReadOnly(strPath As String)
    ' Given a full file name, set the
    ' ReadOnly attribute for the file.
    
    Dim fso As Scripting.FileSystemObject
    Dim fil As Scripting.File
    
    Set fso = New Scripting.FileSystemObject
    Set fil = fso.GetFile(strPath)
    
    ' Set read-only attribute.
    fil.Attributes = SetAttributes(fil.Attributes, ReadOnly)
    
    Set fil = Nothing
    Set fso = Nothing
End Sub

Public Function CopyIfArchived( _
 strInPath As String, strOutPath As String) As Boolean
 
    ' If the selected file has its Archive bit set,
    ' copy it to the output path.
    
    ' Return True if the file was copied,
    ' False otherwise.
    
    Dim fso As Scripting.FileSystemObject
    Dim fil As Scripting.File
    
    ' Assume the file won't be copied.
    CopyIfArchived = False
        
    Set fso = New Scripting.FileSystemObject
    Set fil = fso.GetFile(strInPath)
    
    ' Set read-only attribute.
    If CheckAttributes(fil.Attributes, Archive) Then
        fso.CopyFile strInPath, strOutPath, True
        CopyIfArchived = True
    End If
    
    Set fil = Nothing
    Set fso = Nothing
End Function

