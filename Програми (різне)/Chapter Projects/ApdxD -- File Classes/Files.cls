VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Files"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Private variable for parent File
Private mobjParent As Folder

' Private collection variable
Private mcolFiles As Collection

' Functions for searching for files in a given directory
Private Declare Function FindFirstFile Lib "kernel32" _
 Alias "FindFirstFileA" (ByVal lpFileName As String, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindNextFile Lib "kernel32" _
 Alias "FindNextFileA" (ByVal hFindFile As Long, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindClose Lib "kernel32" _
 (ByVal hFindFile As Long) As Long

Public Function Add(Name As String) As File
    Dim objFile As File
    Set objFile = New File
    
    objFile.Name = Name
    Set objFile.Parent = mobjParent
    
    mcolFiles.Add objFile, objFile.ID
    Set Add = objFile
    Set objFile = Nothing
End Function

Public Property Get Item(ByVal ID As Variant) As File
    ' Return a pointer to the selected item
    Set Item = mcolFiles(ID)
End Property

Public Sub Remove(ByVal ID As Variant)
    
    With mcolFiles(ID)
        If .Exists Then
            Kill .FullPath
        End If
    End With
    
    mcolFiles.Remove ID
End Sub

Public Property Get Count() As Long
    ' Return the Collection object's Count property
    Count = mcolFiles.Count
End Property

Public Property Set Parent(objParent As Folder)
    ' Write once property for File's Parent File
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Public Property Get Parent() As Folder
    ' Return value of private variable
    Set Parent = mobjParent
End Property

Public Sub Refresh()
    Dim strDir As String
    Dim strFile As String
    
    strDir = dhFixPath(mobjParent.FullPath)
    
    strFile = dhDirLocal(strDir & "*.*", , False)
    Do Until strFile = vbNullString
        If strFile <> "." And strFile <> ".." And _
         (GetAttr(strDir & strFile) And vbDirectory) = 0 Then
            Call Add(strFile)
        End If
        strFile = dhDirLocal
    Loop
End Sub

Private Function dhDirLocal(Optional ByVal strPath As String = "", _
 Optional lngAttributes As Long = vbNormal, _
 Optional fExclusive As Boolean = True) As String
      
    Dim fd As WIN32_FIND_DATA
    Static hFind As Long
    Static lngAttr As Long
    Static fEx As Boolean
    
    ' If no path was passed, try to find the next file
    If strPath = "" Then
        If hFind > 0 Then
            If CBool(FindNextFile(hFind, fd)) Then
                dhDirLocal = dhFindByAttr(hFind, fd, lngAttr, fEx)
            End If
        End If
        
    ' Otherwise, start a new search
    Else
        ' Close the last find if there was one
        If hFind > 0 Then
            Call FindClose(hFind)
        End If
        
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
            dhDirLocal = dhFindByAttr(hFind, fd, lngAttr, fEx)
        End If
    End If
End Function

Private Sub Class_Initialize()
    Set mcolFiles = New Collection
End Sub

Private Sub Class_Terminate()
    Set mcolFiles = Nothing
End Sub
