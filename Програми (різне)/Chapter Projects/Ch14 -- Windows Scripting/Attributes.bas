Attribute VB_Name = "basAttributes"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Public Function CheckAttributes( _
 lngValue As Scripting.FileAttribute, _
 lngAttribute As Scripting.FileAttribute) As Boolean
 
    ' Given a file attribute and one or more
    ' attributes to check, return True if all
    ' the requested attributes are set, and False
    ' otherwise.
    CheckAttributes = ((lngValue And lngAttribute) = lngAttribute)
End Function

Public Function SetAttributes( _
 lngValue As Scripting.FileAttribute, _
 lngAttribute As Scripting.FileAttribute) As Scripting.FileAttribute
    
    ' Given a file attribute and one or more
    ' attributes to set, return the modified
    ' file attribute.
    SetAttributes = lngValue Or lngAttribute
End Function

Public Function ClearAttributes( _
 lngValue As Scripting.FileAttribute, _
 lngAttribute As Scripting.FileAttribute) As Scripting.FileAttribute
    
    ' Given a file attribute and one or more
    ' attributes to clear, return the modified
    ' file attribute.
    ClearAttributes = lngValue And Not lngAttribute
End Function


