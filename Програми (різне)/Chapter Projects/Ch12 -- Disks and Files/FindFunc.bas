Attribute VB_Name = "basFindFunctions"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' Max size for a file path
Public Const MAX_PATH = 260

Type WIN32_FIND_DATA
    lngFileAttributes As Long           ' File attributes
    ftCreationTime As FILETIME          ' Creation time
    ftLastAccessTime As FILETIME        ' Last access time
    ftLastWriteTime As FILETIME         ' Last modified time
    lngFileSizeHigh As Long             ' Size (high word)
    lngFileSizeLow As Long              ' Size (low word)
    lngReserved0 As Long                ' reserved
    lngReserved1 As Long                ' reserved
    strFilename As String * MAX_PATH    ' File name
    strAlternate As String * 14         ' 8.3 name
End Type

' Functions for searching for files in a given directory
Private Declare Function FindFirstFile Lib "kernel32" _
 Alias "FindFirstFileA" (ByVal lpFileName As String, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindNextFile Lib "kernel32" _
 Alias "FindNextFileA" (ByVal hFindFile As Long, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindClose Lib "kernel32" _
 (ByVal hFindFile As Long) As Long

Sub dhFindFiles(strPath As String)

    ' Sample procedure demonstrating Windows API Find... functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Path to a directory containing files, plus a
    '       file specification.
    ' Out:
    '   Return Value:
    '       n/a
    ' Note:
    '   Prints the file name, size, and attributes to the Immediate window
    ' Example:
    '   Call dhFindFiles("C:\*.*")

    Dim fd As WIN32_FIND_DATA
    Dim hFind As Long
    
    ' Find the first file
    hFind = FindFirstFile(strPath, fd)
    
    ' If successful...
    If hFind > 0 Then
        Do
            ' Print file information
            With fd
                Debug.Print dhTrimNull(.strFilename), _
                 .lngFileSizeLow & " bytes", _
                 dhBuildAttrString(.lngFileAttributes)
            End With
            
        ' Find the next file and continue as long
        ' as they are files to be found
        Loop While CBool(FindNextFile(hFind, fd))
        
        ' Terminate the find operation
        Call FindClose(hFind)
    End If
End Sub

Function dhDir(Optional ByVal strPath As String = "", _
 Optional lngAttributes As VbFileAttribute = vbNormal, _
 Optional fExclusive As Boolean = True) As String

    ' Replacement for the VBA Dir function which lets you
    ' specify file attributes for a restrictive search.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath (Optional, default = "")
    '       Path and/or file specification to search.
    '   lngAttributes (Optional, default = vbNormal)
    '       File attributes.
    '   fExclusive (Optional, default = True)
    '       If True, only those files with the matching
    '       file attributes are returned.
    ' Out:
    '   Return Value:
    '       If called with a file specification, the first
    '       matching filename is returned. If called without
    '       a file specification, the next matching filename
    '       is returned. When no additional matching filenames
    '       are found, an empty string is returned.
    ' Example:
    '   Dim strDir As String
    '
    '   strDir = dhDir("C:\", vbDirectory)
    '   Do Until strDir = ""
    '       Debug.Print strDir
    '       strDir = dhDir()
    '   Loop
      
    Dim fd As WIN32_FIND_DATA
    Static hFind As Long
    Static lngAttr As Long
    Static fEx As Boolean
    Dim strOut As String
    
    ' If no path was passed, try to find the next file
    If strPath = "" Then
        If hFind > 0 Then
            If CBool(FindNextFile(hFind, fd)) Then
                strOut = dhFindByAttr(hFind, fd, lngAttr, fEx)
            End If
        Else
            Err.Raise 5 ' Invalid procedure call or argument
        End If
        
    ' Otherwise, start a new search
    Else
        ' Store the attributes and exclusive settings
        lngAttr = lngAttributes
        fEx = fExclusive
        
        ' If the path ends in a backslash, assume
        ' all files and append "*.*"
        If Right(strPath, 1) = "\" Then
            strPath = strPath & "*.*"
        End If
        
        ' Find the first file
        hFind = FindFirstFile(strPath, fd)
        If hFind > 0 Then
            strOut = dhFindByAttr(hFind, fd, lngAttr, fEx)
        End If
    End If
    
    ' If the search failed, close the Find handle.
    If Len(strOut) = 0 Then
        If hFind > 0 Then
            Call FindClose(hFind)
        End If
    End If

    dhDir = strOut
End Function

Function dhFindByAttr(hFind As Long, _
 fd As WIN32_FIND_DATA, lngAttr As VbFileAttribute, _
 fExclusive As Boolean) As String

    ' Determines if a file matches the specified attrbites.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   hFind
    '       Windows API Find handle.
    '   fd
    '       Pointer to populated WIN32_FIND_DATA structure.
    '   lngAttr
    '       Attributes to test for.
    '   fExclusive
    '       If True, only those files with the matching
    '       file attributes are returned.
    ' Out:
    '   Return Value:
    '       Next matching filename.
    ' Example:
    '   See dhDir for usage
 
    Dim fOk As Boolean
 
    ' Continue looking for files until one
    ' matches the given attributes exactly
    ' (if fExclusive is True) or just contains
    ' them (if fExclusive is False)
    Do
        If fExclusive Then
            fOk = fd.lngFileAttributes = lngAttr
        Else
            fOk = (fd.lngFileAttributes And lngAttr) = lngAttr
        End If
            
        If fOk Then
            dhFindByAttr = dhTrimNull(fd.strFilename)
            Exit Do
        End If
    Loop While FindNextFile(hFind, fd)
End Function

