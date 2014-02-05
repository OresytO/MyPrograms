Attribute VB_Name = "basFolderAndFile"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' File open mode constants
Public Enum OpenMode
    GENERIC_READ = &H80000000
    GENERIC_WRITE = &H40000000
    GENERIC_EXECUTE = &H20000000
    GENERIC_ALL = &H10000000
End Enum

Private Const FILE_SHARE_READ = &H1
Private Const FILE_SHARE_WRITE = &H2
Private Const OPEN_EXISTING = 3
Private Const FILE_ATTRIBUTE_NORMAL = &H80
Private Const FILE_FLAG_RANDOM_ACCESS = &H10000000

' Max size for a file path
Private Const MAX_PATH = 260

Private Type FILETIME
    dwLowDateTime As Long
    dwHighDateTime As Long
End Type

Public Type WIN32_FIND_DATA
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
Private Declare Function CloseHandle Lib "kernel32" _
 (ByVal hObject As Long) As Long

Private Declare Function FindFirstFile Lib "kernel32" _
 Alias "FindFirstFileA" (ByVal lpFileName As String, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindNextFile Lib "kernel32" _
 Alias "FindNextFileA" (ByVal hFindFile As Long, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindClose Lib "kernel32" _
 (ByVal hFindFile As Long) As Long

' API CreateFile function creates and opens files
Private Declare Function CreateFile Lib "kernel32" _
 Alias "CreateFileA" _
 (ByVal lpFileName As String, _
 ByVal dwDesiredAccess As Long, _
 ByVal dwShareMode As Long, _
 lpSecurityAttributes As Any, _
 ByVal dwCreationDisposition As Long, _
 ByVal dwFlagsAndAttributes As Long, _
 ByVal hTemplateFile As Long) As Long

Function dhDir(Optional ByVal strPath As String = "", _
 Optional lngAttributes As Long = vbNormal, _
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
        End If
        
    ' Otherwise, start a new search
    Else
        ' Store the attributes and exclusive settings
        lngAttr = lngAttributes
        fEx = fExclusive
        
        ' If the path ends in a backslash, assume
        ' all files and append "*.*"
        If Right$(strPath, 1) = "\" Then
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

Public Function dhFindByAttr(hFind As Long, _
 fd As WIN32_FIND_DATA, lngAttr As Long, _
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

Public Function dhTrimNull(ByVal strValue As String) As String
    ' Find the first vbNullChar in a string, and return
    ' everything prior to that character. Extremely
    ' useful when combined with the Windows API function calls.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strValue:
    '       Input text, possibly containing a null character
    '       (chr$(0), or vbNullChar)
    ' Out:
    '   Return Value:
    '       strValue trimmed on the right, at the location
    '       of the null character, if there was one.
    
    Dim intPos As Integer
    
    intPos = InStr(strValue, vbNullChar)
    Select Case intPos
        Case 0
            ' Not found at all, so just
            ' return the original value.
            dhTrimNull = strValue
        Case 1
            ' Found at the first position, so return
            ' an empty string.
            dhTrimNull = vbNullString
        Case Is > 1
            ' Found in the string, so return the portion
            ' up to the null character.
            dhTrimNull = Left$(strValue, intPos - 1)
    End Select
End Function

Public Function dhBuildAttrString(lngAttr As Long) As String

    ' Builds up a string representing the attributes of
    ' a given file..

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   lngAttr
    '       File attributes.
    ' Out:
    '   Return Value:
    '       String representing attributes. For example,
    '       for a read-only, hidden directory, the result
    '       would be "RH  D"
    ' Example:
    '   Debug.Print dhBuildAttrString(lngAttr)

    Dim strAttr As String
    
    ' Build up an attribute string
    dhBuildAttr strAttr, lngAttr, vbReadOnly, "R"
    dhBuildAttr strAttr, lngAttr, vbHidden, "H"
    dhBuildAttr strAttr, lngAttr, vbSystem, "S"
    dhBuildAttr strAttr, lngAttr, vbArchive, "A"
    dhBuildAttr strAttr, lngAttr, vbDirectory, "D"
    
    ' Return attribute string
    dhBuildAttrString = strAttr
End Function

Public Sub dhBuildAttr(strAttr As String, lngAttr As Long, _
 lngMask As Long, strSymbol As String)

    ' Used by the dhBuildAttrFunction to test for one
    ' attribute.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strAttr
    '       Current attribute string.
    '   lngAttr
    '       Bitmask of file attributes.
    '   lngMask
    '       Attribute to test for (e.g. vbReadOnly).
    '   strSymbol
    '       Symbol to use for string (e.g. "R").
    ' Out:
    '   strAttr
    '       Attribute string with new symbol appended.
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhBuildAttr(strAttr, lngAttr, vbHidden, "H")

    ' Compare the passed attributes with the
    ' mask--if it matches append the passed
    ' symbol to the string
    If (lngAttr And lngMask) = lngMask Then
        strAttr = strAttr & strSymbol
    Else
        strAttr = strAttr & " "
    End If
End Sub

Public Function dhFixPath(strPath As String) As String
    ' Make sure path name includes a trailing backslash.
    
    ' Get rid of any extraneous spaces
    strPath = Trim$(strPath)
    ' Stick a backslash on the end of the path
    If Right$(strPath, 1) <> "\" Then
        dhFixPath = strPath & "\"
    Else
        dhFixPath = strPath
    End If
End Function

Function dhQuickOpenFile(strFile As String, _
 Optional lngMode As OpenMode = GENERIC_READ) As Long

    ' Returns a Windows API file handle for use in other
    ' API functions that require them.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to a file.
    '   lngMode (Optional, default = GENERIC_READ)
    '       Open mode. See constants in the declaration
    '       section.
    ' Out:
    '   Return Value:
    '       Value handle or -1 if error.
    ' Note:
    '   Make sure you close open files using the
    '   CloseHandle API function
    ' Example:
    '   Dim hFile As Long
    '
    '   hFile = dhQuickOpenFile("C:\AUTOEXEC.BAT")
    '   If hFile > 0 Then
    '       Call CloseHandle(hFile)
    '   End If
 
    ' Call CreateFile to open the file in
    ' read-only, shared mode unless the user
    ' has passed a different access method--
    ' return the resulting file handle
    dhQuickOpenFile = CreateFile(strFile, lngMode, _
     FILE_SHARE_READ Or FILE_SHARE_WRITE, _
     ByVal 0&, OPEN_EXISTING, _
     FILE_ATTRIBUTE_NORMAL Or _
     FILE_FLAG_RANDOM_ACCESS, 0&)
         
End Function

Public Sub dhCloseHandle(hfile As Long)
    ' A wrapper around the CloseHandle API function.
    Call CloseHandle(hfile)
End Sub

