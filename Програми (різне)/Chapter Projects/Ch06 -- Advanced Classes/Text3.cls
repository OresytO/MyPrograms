VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TextFile3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' TextFile3 class from Chapter 6

' Private variables for properties implemented
' using property procedures
Private mstrPath As String
Private mhFile As Long
Private mlngOpenMode As Long
Private mfIsOpen As Boolean

' Class constants
' Enumeration for file open mode
Public Enum TextFileOpenMode3
    tfOpenReadOnly
    tfOpenReadWrite
    tfOpenAppend
End Enum
Private Const conErrInvalidProcCall = 5

' Event declarations
Public Event ReadLine(ByVal Text As String)
Public Event WriteLine(Text As String, Skip As Boolean)
Public Event AfterOpen()
Public Event BeforeClose(Cancel As Boolean)

' Class object variables
Private mobjLines As Lines

Property Get Lines() As Lines
    ' Return pointer to Lines collection class
    Set Lines = mobjLines
End Property

Public Function FileOpen( _
 Optional CreateIfNotExist As Boolean = False) _
 As Boolean
 
    On Error GoTo HandleError
    
    Dim strLine As String
    
    ' If a file is already open, close it
    If Me.IsOpen Then
        If Not Me.FileClose Then Exit Function
    End If
    
    ' Get next available file handle
    mhFile = FreeFile
    
    ' Open file based on file open mode property
    Select Case Me.OpenMode
        Case tfOpenReadOnly
            If CreateIfNotExist Then
                Open Me.Path For Binary Access Read As mhFile
            Else
                Open Me.Path For Input Access Read As mhFile
            End If
        Case tfOpenReadWrite
            Open Me.Path For Binary Access Read Write As mhFile
        Case tfOpenAppend
            Open Me.Path For Append Access Read Write As mhFile
    End Select
    
    ' Set IsOpen property variable and return value
    mfIsOpen = True
    FileOpen = True
    
    ' Read all lines into the Lines collection
    Set mobjLines = New Lines
    If LOF(mhFile) > 0 Then
        Do Until EOF(mhFile)
            Line Input #mhFile, strLine
            
            ' Raise ReadLine event
            RaiseEvent ReadLine(strLine)
            
            Me.Lines.Add strLine
        Loop
    End If
    
    ' Reset the changed property of all lines
    Me.Lines.Changed = False
    
    ' Fire event
    RaiseEvent AfterOpen

ExitProc:
    Exit Function
HandleError:
    Select Case Err.Number
        Case 62 ' Input passed EOF
                ' Just ignore this
        Case Else
            FileOpen = False
            Err.Raise Err.Number, Err.Source, Err.Description
    End Select
    Resume ExitProc
End Function

Public Function FileClose(Optional Force As Boolean = False) As Boolean
    Dim fCancel As Boolean
    
    FileClose = True
    
    ' If we have a valid handle then close the file
    If Me.Handle <> 0 Then
        
        ' Fire BeforeClose event
        RaiseEvent BeforeClose(fCancel)
        
        If fCancel And Not Force Then
            FileClose = False
        Else
            Close Me.Handle
            mfIsOpen = False
            mhFile = 0
        End If
    End If
End Function

Property Get Path() As String
    ' Return the path of the file from the
    ' Private class variable
    Path = mstrPath
End Property

Property Let Path(ByVal strPath As String)
    ' Set the path property of the file--
    ' If a file is already open, close it
    If Me.IsOpen Then
        If Not Me.FileClose Then Exit Property
    End If
    mstrPath = strPath
End Property

Property Get Handle() As Long
    ' Get the OS file handle if a file
    ' is open
    If Me.IsOpen Then
        Handle = mhFile
    End If
End Property

Property Get OpenMode() As TextFileOpenMode3
    ' Retrieve the open mode of the file
    OpenMode = mlngOpenMode
End Property

Property Let OpenMode(ByVal lngMode As TextFileOpenMode3)
    If Not Me.IsOpen Then
        Select Case lngMode
            Case tfOpenReadOnly, tfOpenReadWrite, tfOpenAppend
                mlngOpenMode = lngMode
            Case Else
                Err.Raise conErrInvalidProcCall
        End Select
    End If
End Property

Property Get IsOpen() As Boolean
    ' Return value of private variable indicating
    ' whether a fiile is currently open
    IsOpen = mfIsOpen
End Property

Private Sub Class_Initialize()
    ' Set default file open mode property
    Me.OpenMode = tfOpenReadOnly
End Sub

Private Sub Class_Terminate()
    ' If a file is still open then close it
    ' before terminating
    If Me.IsOpen Then
        Me.FileClose Force:=True
    End If
End Sub

Public Function FileSave(Optional ByVal varNewPath As Variant) As Boolean
    Dim strPath As String
    Dim strRename As String
    Dim hFile As Long
    Dim cLine As Long
    Dim strText As String
    Dim fSkip As Boolean
    Dim objFile As TextFile3
    
    ' Make sure file is open in read/write mode
    If Me.IsOpen And Me.OpenMode = tfOpenReadWrite Then
        
        ' Close the file
        If Not Me.FileClose Then Exit Function
        
        ' Get the path to save the file to
        If IsMissing(varNewPath) Then
            strPath = Me.Path
        Else
            strPath = varNewPath
        End If
        
        ' Compute name to rename file to temporarily
        strRename = Left(strPath, Len(strPath) - 1) & "~"
        Set objFile = New TextFile3
        objFile.Path = strRename
        If objFile.Exists Then
            Kill strRename
        End If
        
        ' Rename existing file
        Name Me.Path As strRename
        
        ' Write Lines collection to new file
        hFile = FreeFile
        Open strPath For Output Access Write As hFile
        For cLine = 1 To Me.Lines.Count
            strText = Me.Lines.Item(cLine).Text
    
            ' Raise WriteLine event
            fSkip = False
            RaiseEvent WriteLine(strText, fSkip)
            
            If Not fSkip Then
                Print #hFile, strText
            End If
        Next
        Close hFile
        
        ' Write was successful do delete original
        If objFile.Exists Then
            Kill strRename
        End If
    
        ' Re-open the file
        Me.FileOpen
        
        FileSave = True
    End If
End Function

Public Function Exists() As Boolean
    ' Return existance of file based on
    ' a directory search
    Exists = (Len(Dir$(Me.Path)) > 0)
End Function


