Attribute VB_Name = "basPathFun"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' Windows API path functions
Private Declare Function GetFullPathName Lib "kernel32" _
 Alias "GetFullPathNameA" _
 (ByVal lpFileName As String, ByVal nBufferLength As Long, _
 ByVal lpBuffer As String, ByVal lpFilePart As String) As Long

Private Declare Function GetShortPathName Lib "kernel32" _
 Alias "GetShortPathNameA" _
 (ByVal lpszLongPath As String, _
 ByVal lpszShortPath As String, _
 ByVal cchBuffer As Long) As Long

Sub dhParsePath(ByVal strFullPath As String, _
 ByRef strPath As String, ByRef strFile As String, _
 Optional ByRef varExt As Variant, _
 Optional strPathSep = "\")

    ' Parses a path into its components.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFullPath
    '       Complete path.
    '   strPath
    '       Output variable for path.
    '   strFile
    '       Output variable for filename.
    '   varExt (Optional)
    '       Output variable for file extension.
    '   strPathSep
    '       If passed, the path separator
    ' Out:
    '   strPath
    '       Contains path without filename.
    '   strFile
    '       Contains filename and extension if varExt was
    '       not passed.
    '   varExt
    '       If passed, contains file extension.
    '   Return Value:
    '       n/a
    ' Note:
    '       Uses string functions from chapter 1.
    ' Example:
    '   See dhTestParsePath for an example

    Dim lngPos As Long
    Dim lngPos2 As Long

    ' If varExt was passed, get the file extension
    If Not IsMissing(varExt) Then
        ' Find the last "."
        lngPos = InStrRev(strFullPath, ".")
        ' If this is a web address find the last "/"
        If strPathSep = "/" Then
            lngPos2 = InStrRev(strFullPath, strPathSep)
        End If
        ' If theres a "." after the last "/" assume it's
        ' the file extension
        If lngPos > 0 And lngPos > lngPos2 Then
            varExt = Mid(strFullPath, lngPos + 1)
        Else
            varExt = ""
        End If
    Else
        varExt = ""
    End If
    
    ' Now get the file name, removing the extension
    ' if necessary
    lngPos = InStrRev(strFullPath, strPathSep)
    If lngPos > 0 Then
        strFile = Mid(strFullPath, lngPos + 1, _
         Len(strFullPath) - lngPos - Len(varExt))
        If Len(varExt) Then
            strFile = Left(strFile, Len(strFile) - 1)
        End If
        strPath = Left(strFullPath, lngPos - 1)
    End If
End Sub

Function dhGetPathParts(strPath As String, _
 colParts As Collection, _
 Optional strPathSep = "\") As Long

    ' Breaks apart a path into its components and adds each to a collection.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Complete path.
    '   colParts
    '       Pointer to VBA Collection object.
    ' Out:
    '   colParts
    '       Contains one element for each part of a path. E.g.:
    '           C:
    '           WINDOWS
    '           TEMP
    '           ~DH&723A.TMP
    '   Return Value:
    '       Number of parts.
    ' Note:
    '       Uses string functions from chapter 1.
    ' Example:
    '   Dim colParts As Collection
    '   Dim varPart As Variant
    '
    '   If dhGetPathParts(Dir(CurDir & "\*.*"), colParts) > 0 Then
    '       For Each varPart In colParts
    '           Debug.Print varPart
    '       Next
    '   End If
 
    Dim varParts As Variant
    Dim lngPos As Long
    
    Set colParts = New Collection
    
    ' For UNC paths treat "\\" as the drive letter
    If InStr(strPath, "\\") = 1 Then
        colParts.Add "\\"
        lngPos = 2
    End If
    
    ' Strip off web protcols
    lngPos = InStr(strPath, "//")
    If lngPos > 0 Then
        colParts.Add Left(strPath, lngPos - 1)
        lngPos = 2
    End If
    
    ' Split the path on the backslash
    varParts = Split(strPath, strPathSep)
    For lngPos = lngPos To UBound(varParts)
        colParts.Add varParts(lngPos)
    Next
    
    ' Return the number of parts
    dhGetPathParts = colParts.Count
End Function

Function dhFullPath(strPath As String) As String

    ' Wrapper function for GetFullPath API function. Resolves
    ' a partial path to a complete path based on the current
    ' directory.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Partial path.
    ' Out:
    '   Return Value:
    '       Complete path relative to current directory.
    ' Example:
    '   Debug.Print dhFullPath(Dir("*.*"))

    Dim strBuffer As String
    Dim strFilePart As String
    Dim lngBytes As Long
    
    ' Set up the buffer
    strBuffer = Space(MAX_PATH)
    
    ' Call GetFullPathName
    lngBytes = GetFullPathName(strPath, Len(strBuffer), _
     strBuffer, strFilePart)
    
    ' If successful, parse the buffer
    If lngBytes > 0 Then
        dhFullPath = Left(strBuffer, lngBytes)
    End If
End Function

Function dhShortPath(strPath As String) As String

    ' Wrapper function for Windows API GetShortPathName function.
    ' Returns the short (8.3) name for a file given its full path.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Path containing a long file name.
    ' Out:
    '   Return Value:
    '       Short path name.
    ' Example:
    '   Debug.Print dhShortPath(Dir("*.*"))

    Dim strBuffer As String
    Dim lngBytes As Long
    
    ' Set up a buffer
    strBuffer = Space(MAX_PATH)
    
    ' Call GetShortPathName
    lngBytes = GetShortPathName(strPath, strBuffer, _
     Len(strBuffer))
     
    ' If succcessful parse the buffer
    If lngBytes > 0 Then
        dhShortPath = Left(strBuffer, lngBytes)
    End If
End Function

Sub dhTestParsePath()

    ' Sample procedure demonstrating path functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestParsePath

    Dim strCurrFile As String
    Dim strFullPath As String
    Dim strShortPath As String
    Dim strPath As String
    Dim strFile As String
    Dim varExt As Variant
    Dim lngParts As Long
    Dim colParts As New Collection
    Dim varPart As Variant
    
    ' Get first file from current directory
    strCurrFile = Dir("*.*")
    
    ' Get the full path name
    strFullPath = dhFullPath(strCurrFile)
    
    ' Get the short path name
    strShortPath = dhShortPath(strFullPath)
    
    ' Parse the path into its parts
    Call dhParsePath(strFullPath, strPath, strFile, varExt)
    
    ' Decompose the entire path
    lngParts = dhGetPathParts(strFullPath, colParts)
    
    ' Print the information
    Debug.Print "File:", strCurrFile
    Debug.Print "Full path:", strFullPath
    Debug.Print "Short path:", strShortPath
    Debug.Print "Path:", strPath
    Debug.Print "Filename:", strFile
    Debug.Print "Extension:", varExt
    Debug.Print "Path parts:", lngParts
    lngParts = 2
    For Each varPart In colParts
        Debug.Print Space(lngParts) & varPart
        lngParts = lngParts + 2
    Next
End Sub

Sub dhTestParseWebPath()

    ' Sample procedure demonstrating path functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestParsePath

    Dim strFullPath As String
    Dim strPath As String
    Dim strFile As String
    Dim varExt As Variant
    Dim lngParts As Long
    Dim colParts As New Collection
    Dim varPart As Variant
    
    ' Pick any web address
    strFullPath = "http://www.microsoft.com/officedev/articles/movs101.htm"
    
    ' Parse the path into its parts
    Call dhParsePath(strFullPath, strPath, strFile, varExt, "/")
    
    ' Decompose the entire path
    lngParts = dhGetPathParts(strFullPath, colParts, "/")
    
    ' Print the information
    Debug.Print "Full path:", strFullPath
    Debug.Print "Path:", strPath
    Debug.Print "Filename:", strFile
    Debug.Print "Extension:", varExt
    Debug.Print "Path parts:", lngParts
    lngParts = 2
    For Each varPart In colParts
        Debug.Print Space(lngParts) & varPart
        lngParts = lngParts + 2
    Next
End Sub

Function dhIsValidFileName(strFile As String) As Boolean

    ' Determines if a filename is valid.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Candidate filename (must not include path).
    ' Out:
    '   Return Value:
    '       True if filename is valid, False if not.
    ' Note:
    '       Uses string functions from chapter 1.
    ' Example:
    '   Debug.Print dhIsValidFileName("NO*GOOD.TXT")

    ' Make sure strFile:
    '  is not an empty string,
    '  is less than MAX_PATH
    '  does not start or end with a space,
    '  does not end with a period, and
    '  does not contain special characters
    If Len(strFile) > 0 And Len(strFile) < MAX_PATH Then
        dhIsValidFileName = _
         (Left(strFile, 1) <> " ") And _
         (Right(strFile, 1) <> " ") And _
         (Right(strFile, 1) <> ".") And _
         (dhCountTokens(strFile, "?*\:/<>|") = 1)
    End If
End Function

Function dhIsValidPath(ByVal strPath As String) As Boolean

    ' Determines if a path name is valid.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Candidate path name.
    ' Out:
    '   Return Value:
    '       True if valid, False if not.
    ' Note:
    '       Uses string functions from chapter 1 and
    '       dhIsValidFileName function from this module.
    ' Example:
    '   Debug.Print dhIsValidPath("C:\NO*WAY\TEMP")

    Dim colParts As New Collection
    Dim varPart As Variant
    
    ' Figure out what's on the front end--if
    ' it's "x:" or "\\server", trim it
    If (UCase(strPath) Like "[A-Z]*" And _
     InStr(strPath, ":") = 2) Or _
     (InStr(strPath, "\\") = 1 And _
     InStr(strPath, "\\\") = 0) Then
     
        strPath = Mid(strPath, 3)
    End If
    
    ' Trim leading/trailing backslash if there is one
    If Left(strPath, 1) = "\" Then
        strPath = Mid(strPath, 2)
    End If
    If Right(strPath, 1) = "\" Then
        strPath = Left(strPath, Len(strPath) - 1)
    End If
        
    ' Break the path into parts so we can
    ' look at them individually
    If dhGetPathParts(strPath, colParts) > 0 Then
    
        ' The beginning is okay, so check each part
        For Each varPart In colParts
        
            ' If a part is invalid, the whole thing
            ' must be so bail out
            If Not dhIsValidFileName(CStr(varPart)) Then
                Exit Function
            End If
        Next
        
        ' We made it to here, so it must be okay
        dhIsValidPath = True
    End If
End Function

