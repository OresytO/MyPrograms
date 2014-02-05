VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Folders"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Private variable to store a pointer to the
' Key object that contains this collection
Private mobjParent As Folder

' Private collection variable
Private mcolFolders As Collection

' Functions for searching for files in a given directory
Private Declare Function FindFirstFile Lib "kernel32" _
 Alias "FindFirstFileA" (ByVal lpFileName As String, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindNextFile Lib "kernel32" _
 Alias "FindNextFileA" (ByVal hFindFile As Long, _
 lpFindFileData As WIN32_FIND_DATA) As Long
 
Private Declare Function FindClose Lib "kernel32" _
 (ByVal hFindFile As Long) As Long

Public Function Add(Name As String, _
 Optional fExisting As Boolean = False) As Folder
 
    ' Create new Folder instance
    Dim fld As Folder
    Set fld = New Folder
    
    ' Set the new Folder's Parent property
    ' to point to the collection's Parent
    Set fld.Parent = mobjParent
    
    ' If this is not an existing Folder, create one
    If Not fExisting Then
        MkDir dhFixPath(mobjParent.FullPath) & Name
    End If
    
    ' Set the requisite Name property--this, in turn,
    ' will add all of its subFolders
    fld.Name = Name
    
    ' Add new instance to the collection,
    ' using its ID as the unique key
    mcolFolders.Add fld, fld.ID
    
    ' Set the return Folder to reference the new object
    Set Add = fld
End Function

Public Property Get Item(ByVal ID As Variant) As Folder
    Set Item = mcolFolders(ID)
End Property

Public Sub Remove(ByVal ID As Variant)
    Dim lngCount As Long
    Dim objSubDir As Folder
    
    With mcolFolders(ID)
    
        ' Start by deleting the subFolders
        With .Subfolders
            For lngCount = 1 To .Count
                .Remove lngCount
            Next
        End With
        
        ' Now delete all the files
        With .Files
            For lngCount = 1 To .Count
                .Remove lngCount
            Next
        End With
        
        ' Remove the Folder from the collection
        mcolFolders.Remove ID
    End With
End Sub

Public Property Get Count() As Long
    Count = mcolFolders.Count
End Property

Public Property Set Parent(objParent As Folder)
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Public Property Get Parent() As Folder
    Set Parent = mobjParent
End Property

Public Sub Refresh()
    Dim strDir As String
    Dim strFile As String
    
    Set mcolFolders = New Collection
    
    strDir = dhFixPath(mobjParent.FullPath)
    
    strFile = dhDirLocal(strDir & "*.*", vbDirectory)
    Do Until strFile = vbNullString
        If strFile <> "." And strFile <> ".." Then
            Call Add(strFile, True)
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
    Set mcolFolders = New Collection
End Sub

Private Sub Class_Terminate()
    Set mcolFolders = Nothing
End Sub
