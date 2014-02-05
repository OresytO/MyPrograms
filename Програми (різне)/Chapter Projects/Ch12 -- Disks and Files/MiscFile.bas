Attribute VB_Name = "basMiscDeclares"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' These declarations are mentioned but not used in the examples
Private Declare Function GetFileType Lib "kernel32" (ByVal hFile As Long) As Long

Private Declare Function SetFileAttributes Lib "kernel32" Alias "SetFileAttributesA" (ByVal lpFileName As String, ByVal dwFileAttributes As Long) As Long
Private Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" (ByVal lpFileName As String) As Long
Private Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Long

Private Declare Function MoveFile Lib "kernel32" Alias "MoveFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String) As Long
Private Declare Function MoveFileEx Lib "kernel32" Alias "MoveFileExA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal dwFlags As Long) As Long

Private Declare Function CreateDirectoryEx Lib "kernel32" Alias "CreateDirectoryExA" (ByVal lpTemplateDirectory As String, ByVal lpNewDirectory As String, lpSecurityAttributes As Any) As Long
Private Declare Function RemoveDirectory Lib "kernel32" Alias "RemoveDirectoryA" (ByVal lpPathName As String) As Long

Private Declare Function GetBinaryType Lib "kernel32" _
 Alias "GetBinaryTypeA" _
 (ByVal lpApplicationName As String, _
 lpBinaryType As Long) As Long

Public Const SCS_32BIT_BINARY = 0
Public Const SCS_DOS_BINARY = 1
Public Const SCS_WOW_BINARY = 2
Public Const SCS_PIF_BINARY = 3
Public Const SCS_POSIX_BINARY = 4
Public Const SCS_OS216_BINARY = 5

