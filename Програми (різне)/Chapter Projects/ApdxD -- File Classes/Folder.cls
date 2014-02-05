VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Folder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Private variables for property values
Private mstrID As String
Private mobjParent As Folder
Private mstrName As String

' Collections for files and subfolders
Private mobjFiles As Files
Private mflds As Folders
 
Private Declare Function CreateDirectory _
 Lib "kernel32" Alias "CreateDirectoryA" _
 (ByVal lpPathName As String, lpSecurityAttributes As Any) As Long

Public Property Get Subfolders() As Folders
    Set Subfolders = mflds
End Property

Public Property Get Files() As Files
    Set Files = mobjFiles
End Property

Public Property Get Name() As String
    Name = mstrName
End Property

Public Property Let Name(ByVal strName As String)
    On Error GoTo HandleError

    Dim fFirstTime As Boolean
    Dim strOldName As String
    Dim strOldPath As String
    
    ' Is the the first time?
    If mstrName = vbNullString Then
        fFirstTime = True
    End If
    
    ' If it is the first time, refresh the collections
    If fFirstTime Then
        ' Store the new name
        mstrName = strName
        
        ' Refresh files and Folders
        mobjFiles.Refresh
        mflds.Refresh
    Else
    
        ' If not we will rename the direcory
        ' so make sure it still exists
        If Exists() Then
        
            ' Store the current name and path
            strOldName = mstrName
            strOldPath = FullPath()
            
            ' Change error handler
            On Error GoTo RenameError
            
            ' Store the new name
            mstrName = strName
        
            ' Rename the Folder
            Name strOldPath As FullPath()
        Else
            ' Otherwise, remove it from the parent
            ' Folder if it has one
            If Not mobjParent Is Nothing Then
                mobjParent.Subfolders.Remove mstrID
            End If
        End If
    End If
    
ExitHere:
    Exit Property
RenameError:
    ' Reset old name
    mstrName = strOldName
HandleError:
    Err.Raise Err.Number + vbObjectError, _
     "Folder.Name (Let)", Err.Description
End Property

Public Property Get Parent() As Folder
    Set Parent = mobjParent
End Property

Public Property Set Parent(objParent As Folder)
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
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
    
    ' Add name
    strTemp = strTemp & mstrName

    ' Set return value
    FullPath = strTemp
End Property

Private Sub Class_Initialize()
    mstrID = "D" & CLng(Timer * 1000 * Rnd)
    Set mflds = New Folders
    Set mflds.Parent = Me
    Set mobjFiles = New Files
    Set mobjFiles.Parent = Me
End Sub

Public Property Get ID() As String
    ID = mstrID
End Property

Public Property Get Exists() As Boolean
    Exists = (Len(dhDir(FullPath(), vbDirectory)) > 0)
End Property

Public Function Copy(ByVal Path As String, _
 Optional CopyFiles As Boolean = True) As Boolean
 
    Dim lngCount As Long
    
    ' The output path must already exist for this
    ' function to succeed.
    
    ' Fix up the path
    Path = dhFixPath(Path)
    
    ' If requested, copy the files
    If CopyFiles Then
        With mobjFiles
            For lngCount = 1 To .Count
                With .Item(lngCount)
                    If Not .Copy(Path & .Name) Then
                        GoTo ExitHere
                    End If
                End With
            Next
        End With
    End If
    
    ' Now copy the subfolders
    With mflds
        For lngCount = 1 To .Count
            With .Item(lngCount)
                ' Create the Folder
                If Not CBool(CreateDirectory(Path & .Name, 0&)) Then
                    GoTo ExitHere
                End If
                ' Copy the files
                If Not .Copy(Path & .Name, CopyFiles) Then
                    GoTo ExitHere
                End If
            End With
        Next
    End With
        
    ' Set return value
    Copy = True
ExitHere:
End Function

