Attribute VB_Name = "basTempFiles"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' API functions for temporary file path and name
Private Declare Function GetTempPath Lib "kernel32" _
 Alias "GetTempPathA" (ByVal nBufferLength As Long, _
 ByVal lpBuffer As String) As Long
Private Declare Function GetTempFileName Lib "kernel32" _
 Alias "GetTempFileNameA" (ByVal lpszPath As String, _
 ByVal lpPrefixString As String, ByVal wUnique As Long, _
 ByVal lpTempFileName As String) As Long

Function dhTempFileName( _
 Optional strPrefix As String = "~DH") As String

    ' Returns the name of a temporary file given a prefix
    ' of up to three characters. Uses the Windows API
    ' GetTempPath function to determine the correct path.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPrefix (Optional, default = "~DH")
    '       Prefix for file name (must be 3 characters or less).
    ' Out:
    '   Return Value:
    '       Full path to a temporary file.
    ' Note:
    '       This function only gives you an unused filename.
    '       It does not create the file.
    ' Example:
    '   strFile = dhTempFileName("~xx")
 
    Dim strPath As String
    Dim strBuffer As String
    Dim lngBytes As Long
    
    ' Set up a buffer
    strBuffer = Space(MAX_PATH)
    
    ' Call GetTempPath
    lngBytes = GetTempPath(Len(strBuffer), strBuffer)
    
    ' If successful extract the path
    If lngBytes > 0 Then
        strPath = Left(strBuffer, lngBytes)
        
        ' Reset the buffer and call GetTempFileName
        strBuffer = Space(MAX_PATH)
        lngBytes = GetTempFileName(strPath, _
         strPrefix, 0, strBuffer)
        
        ' If successful extract the file name
        If lngBytes > 0 Then
            dhTempFileName = Left(strBuffer, lngBytes)
        End If
    End If
End Function

