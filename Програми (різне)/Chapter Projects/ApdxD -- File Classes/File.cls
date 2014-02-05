VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "File"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Private variables to hold property values
Private mstrID As String
Private mstrName As String
Private mobjParent As Folder

Private Type FILETIME
    dwLowDateTime As Long
    dwHighDateTime As Long
End Type

' Type and function for fetching detailed information
Private Type BY_HANDLE_FILE_INFORMATION
    lngFileAttributes As Long       ' File attributes
    ftCreationTime As FILETIME      ' Creation time
    ftLastAccessTime As FILETIME    ' Last access time
    ftLastWriteTime As FILETIME     ' Last write time
    lngVolumeSerialNumber As Long   ' Serial number
    lngFileSizeHigh As Long         ' File size high order word
    lngFileSizeLow As Long          ' File size low order word
    lngNumberOfLinks As Long        ' Links to file (1 for FAT)
    lngFileIndexHigh As Long        ' Unique ID high order word
    lngFileIndexLow As Long         ' Unique ID low order word
End Type

' Private structure for attributes
Private hfi As BY_HANDLE_FILE_INFORMATION

Private Declare Function GetFileInformationByHandle _
 Lib "kernel32" _
 (ByVal hfile As Long, _
 lpFileInformation As BY_HANDLE_FILE_INFORMATION) As Long

Private Declare Function CopyFile _
 Lib "kernel32" Alias "CopyFileA" _
 (ByVal lpExistingFileName As String, _
 ByVal lpNewFileName As String, _
 ByVal bFailIfExists As Long) As Long

Public Property Get Name() As String
    Name = mstrName
End Property

Public Property Let Name(ByVal strName As String)
    mstrName = strName
End Property

Public Property Set Parent(objParent As Folder)
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Public Property Get Parent() As Folder
    Set Parent = mobjParent
End Property

Public Property Get FullPath() As String
    Dim objParent As Folder
    Dim strTemp As String
    
    ' Set starting point
    Set objParent = mobjParent
    
    ' Loop until objParent is Nothing (at the root)
    Do Until objParent Is Nothing
        strTemp = dhFixPath(objParent.Name) & strTemp
        Set objParent = objParent.Parent
    Loop
    
    ' Add this key's name
    strTemp = strTemp & mstrName

    ' Set return value
    FullPath = strTemp
End Property

Private Sub Class_Initialize()
    mstrID = "F" & CLng(Timer * 1000 * Rnd)
End Sub

Public Property Get ID() As String
    ID = mstrID
End Property

Public Property Get Exists() As Boolean
    Exists = (Len(Dir(FullPath(), vbHidden + vbSystem)) > 0)
End Property

Private Function RefreshAttributes() As Boolean
    Dim hfile As Long
    
    ' Update the information in the private
    ' BY_HANDLE_FILE_INFORMATION structure
    hfile = dhQuickOpenFile(FullPath())
    If hfile > 0 Then
        RefreshAttributes = CBool( _
         GetFileInformationByHandle(hfile, hfi))
         
        Call dhCloseHandle(hfile)
    ElseIf Not Exists() Then
        mobjParent.Files.Remove mstrID
    End If
End Function

Public Property Get Attributes() As Long
    If RefreshAttributes() Then
        Attributes = hfi.lngFileAttributes
    Else
        Attributes = -1
    End If
End Property

Public Property Get Size() As Long
    If RefreshAttributes() Then
        Size = hfi.lngFileSizeLow
    Else
        Size = -1
    End If
End Property

Public Function Copy(Path As String, _
 Optional Overwrite As Boolean = True) As Boolean
    
    ' Call the CopyFile API function and return the result
    Copy = CBool(CopyFile(FullPath, _
     Path, Abs(Not Overwrite)))
End Function
