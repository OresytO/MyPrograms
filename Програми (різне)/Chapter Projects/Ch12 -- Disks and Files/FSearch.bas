Attribute VB_Name = "basSearch"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' Windows API search function
Private Declare Function SearchPath Lib "kernel32" _
 Alias "SearchPathA" (ByVal lpPath As String, _
 ByVal lpFileName As String, ByVal lpExtension As String, _
 ByVal nBufferLength As Long, ByVal lpBuffer As String, _
 ByVal lpFilePart As String) As Long
 
Function dhSearch(strFile As String, _
 Optional strPath As String = vbNullString) As String

    ' Wrapper for Windows API SearchPath function. Accepts a
    ' path string (like the DOS PATH environmental variable) and
    ' looks for a file in those directories

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       File to search for.
    '   strPath (Optional, default = vbNullString)
    '       Path string (e.g. "C:\;C:\DOS;C:\WINDOWS") or
    '       an empty string to use the default search directories.
    ' Out:
    '   Return Value:
    '       Full path of file, if found, or empty string.
    ' Note:
    '       For files that exist in more than one specified
    '       directory, the first matching one is returned
    '       (search order is left to right in the list).
    ' Example:
    '   Debug.Print dhSearch("COMMAND.COM", "C:\;C:\DOS;C:\WINDOWS")

    Dim strBuffer As String
    Dim lngBytes As Long
    Dim strFilePart As String
    
    ' Create a buffer
    strBuffer = Space(MAX_PATH)
    
    ' Call search path
    lngBytes = SearchPath(strPath, strFile, vbNullString, _
     Len(strBuffer), strBuffer, strFilePart)
     
    ' If successful, parse out the file name
    If lngBytes > 0 Then
        dhSearch = Left(strBuffer, lngBytes)
    End If
End Function

Function dhFindAllFiles(strSpec As String, _
 ByVal strPath As String, colFound As Collection, _
 Optional lngAttr As Long = -1, _
 Optional fRecursive As Boolean = True, _
 Optional objCallback As IFileFindCallback) As Long

    ' Finds file(s) based on a specification in a directory
    ' plus (optionally) all subdirectories.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strSpec
    '       File specification to search for.
    '   strPath
    '       Starting path.
    '   colFound
    '       Pointer to VBA Collection object.
    '   lngAttr (Optional, default = -1)
    '       File attributes to search for (-1 for all files).
    '   fRecursive (Optional, default = True)
    '       If True, a recursive search of all subdirectories is made.
    '   objCallback (Optional)
    '       Optional pointer to a callback object (see chapter
    '       text for details).
    ' Out:
    '   colFound
    '       Contains one element for each matching filename,
    '       including complete path).
    '   Return Value:
    '       Number of files found.
    ' Example:
    '   See dhPrintFoundFiles for example

    Dim strFile As String
    Dim colSubDir As New Collection
    Dim varDir As Variant
    
    On Error GoTo HandleError
    
    ' Make sure strPath ends in a backslash
    If Right(strPath, 1) <> "\" Then
        strPath = strPath & "\"
    End If
    
    ' If the callback object was supplied
    ' call its Searching method
    If Not objCallback Is Nothing Then
        objCallback.Searching strPath
    End If
        
    ' Find all files in the directory--if no
    ' attributes were specified use a non-exclusive
    ' search for all files, otherwise use a
    ' restrictive search for the attributes
    If lngAttr = -1 Then
        strFile = dhDir(strPath & strSpec, , False)
    Else
        strFile = dhDir(strPath & strSpec, lngAttr)
    End If
     
    Do Until strFile = ""
    
        ' Add file to collection if attributes match
        ' (special case directories "." and ".."
        If ((GetAttr(strPath & strFile) And lngAttr) > 0) _
         And (strFile <> ".") And (strFile <> "..") Then
            colFound.Add strPath & strFile
        End If
        
        ' If the callback object was supplied
        ' call its Found method
        If Not objCallback Is Nothing Then
            objCallback.Found strPath, strFile
        End If
        
        ' Get the next file
        strFile = dhDir
    Loop
    
    ' If the recursive flag is set build a list
    ' of all the subdirectories
    If fRecursive Then
        
        strFile = dhDir(strPath, vbDirectory, False)
        Do Until strFile = ""
            ' Ignore "." and ".."
            If strFile <> "." And strFile <> ".." Then
            
                ' Add each to the directory collection
                colSubDir.Add strPath & strFile
            End If
            strFile = dhDir
        Loop
        
        ' Now recurse through each sub directory
        For Each varDir In colSubDir
            dhFindAllFiles strSpec, varDir, colFound, _
             lngAttr, fRecursive, objCallback
        Next
    End If
    
    ' Return the number of found files
    dhFindAllFiles = colFound.Count
ExitHere:
    Exit Function
HandleError:
    Select Case Err.Number
        Case 75 ' Path/file access error
            Resume Next
        Case Else
            MsgBox Err.Description, vbExclamation, "Error " & _
             Err.Number & " in dhFindAllFiles"
            Resume ExitHere
    End Select
End Function

Sub dhPrintFoundFiles(strPath As String, strSpec As String)

    ' Sample procedure demonstrating recursive file search function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Starting directory.
    '   strSpec
    '       File specification.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintFoundFiles("C:\", "*.BAK")
 
    Dim colFound As New Collection
    Dim lngFound As Long
    Dim varFound As Variant
    
    ' Test the file find logic
    Debug.Print "Starting search..."
    
    ' Call dhFindAllFiles
    lngFound = dhFindAllFiles(strSpec, strPath, colFound)
    
    ' Print the results
    Debug.Print "Done. Found: " & lngFound
      
    ' With the collection of filenames
    ' you can do something with them
    Debug.Print
    Debug.Print "What we found:"
    Debug.Print "=============="

    For Each varFound In colFound
        Debug.Print varFound
    Next
End Sub

Sub dhPrintFoundFilesWithFeedback(strPath As String, _
 strSpec As String)

    ' Sample procedure demonstrating recursive file search function.
    ' (Also uses a sample callback object)

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Starting directory.
    '   strSpec
    '       File specification.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintFoundFilesWithFeedback("C:\", "*.BAK")
 
    Dim colFound As New Collection
    Dim lngFound As Long
    Dim objCallback As New FileFindCallback
    
    ' Test the file find logic
    Debug.Print "Starting search..."
    
    ' Call dhFindAllFiles, passing a callback
    ' object--the callback object will print
    ' the filenames to the Immediate window
    ' as they are found
    lngFound = dhFindAllFiles(strSpec, strPath, _
     colFound, , , objCallback)
    
    ' Print the results
    Debug.Print "Done. Found: " & lngFound
End Sub

