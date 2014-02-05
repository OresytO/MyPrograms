Attribute VB_Name = "basFileHandles"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' Security attributes for CreateFile, but we don't use them
Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Boolean
End Type

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

Declare Function CloseHandle Lib "kernel32" _
 (ByVal hObject As Long) As Long

' File open mode constants
Public Const GENERIC_READ = &H80000000
Public Const GENERIC_WRITE = &H40000000
Public Const GENERIC_EXECUTE = &H20000000
Public Const GENERIC_ALL = &H10000000

Public Const FILE_SHARE_READ = &H1
Public Const FILE_SHARE_WRITE = &H2

' File attributes
Public Const FILE_ATTRIBUTE_READONLY = &H1
Public Const FILE_ATTRIBUTE_HIDDEN = &H2
Public Const FILE_ATTRIBUTE_SYSTEM = &H4
Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
Public Const FILE_ATTRIBUTE_NORMAL = &H80
Public Const FILE_ATTRIBUTE_TEMPORARY = &H100
Public Const FILE_ATTRIBUTE_COMPRESSED = &H800

Public Const CREATE_NEW = 1
Public Const CREATE_ALWAYS = 2
Public Const OPEN_EXISTING = 3
Public Const OPEN_ALWAYS = 4
Public Const TRUNCATE_EXISTING = 5

Public Const FILE_BEGIN = 0
Public Const FILE_CURRENT = 1
Public Const FILE_END = 2

Public Const FILE_FLAG_WRITE_THROUGH = &H80000000
Public Const FILE_FLAG_OVERLAPPED = &H40000000
Public Const FILE_FLAG_NO_BUFFERING = &H20000000
Public Const FILE_FLAG_RANDOM_ACCESS = &H10000000
Public Const FILE_FLAG_SEQUENTIAL_SCAN = &H8000000
Public Const FILE_FLAG_DELETE_ON_CLOSE = &H4000000
Public Const FILE_FLAG_BACKUP_SEMANTICS = &H2000000
Public Const FILE_FLAG_POSIX_SEMANTICS = &H1000000

' API for getting file sizes
Private Declare Function GetFileSize Lib "kernel32" _
 (ByVal hFile As Long, lpFileSizeHigh As Long) As Long

' API for getting file sizes (Windows NT/2000 only)
Private Declare Function GetFileSizeEx Lib "kernel32" _
 (ByVal fhile As Long, curFileSize As Currency) As Long


Function dhQuickOpenFile(strFile As String, _
 Optional lngMode As Long = GENERIC_READ) As Long

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
    '       Call dhapi_CloseHandle(hFile)
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

Sub dhPrintSizeAPI(strFile As String)

    ' Sample procedure demonstrating the GetFileSize API function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintSizeAPI("C:\AUTOEXEC.BAT")

    Dim hFile As Long
    Dim lngSizeLower As Long
    Dim lngSizeUpper As Long
    
    ' Open the file and get the handle
    hFile = dhQuickOpenFile(strFile)
    
    ' If successful, print the size--
    ' if not, print the DLL error code
    If hFile > 0 Then
    
      ' Get the file size
      lngSizeLower = GetFileSize(hFile, lngSizeUpper)
    
      ' Print the results
      Debug.Print lngSizeLower & " bytes"
    
      ' Close the file
      Call CloseHandle(hFile)
    Else
      Debug.Print "Error calling CreateFile: " & _
       Err.LastDllError
    End If
End Sub
