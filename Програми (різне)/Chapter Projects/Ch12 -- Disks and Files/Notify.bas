Attribute VB_Name = "basNotification"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' File change notification functions
Private Declare Function FindFirstChangeNotification Lib "kernel32" _
 Alias "FindFirstChangeNotificationA" _
 (ByVal lpPathName As String, ByVal bWatchSubtree As Long, _
 ByVal dwNotifyFilter As Long) As Long
Private Declare Function FindNextChangeNotification Lib "kernel32" _
 (ByVal hChangeHandle As Long) As Long
Private Declare Function FindCloseChangeNotification Lib "kernel32" _
 (ByVal hChangeHandle As Long) As Long

' File change notification flags
Private Const FILE_NOTIFY_CHANGE_FILE_NAME = &H1
Private Const FILE_NOTIFY_CHANGE_DIR_NAME = &H2
Private Const FILE_NOTIFY_CHANGE_ATTRIBUTES = &H4
Private Const FILE_NOTIFY_CHANGE_SIZE = &H8
Private Const FILE_NOTIFY_CHANGE_LAST_WRITE = &H10
Private Const FILE_NOTIFY_CHANGE_SECURITY = &H100
Private Const INFINITE = &HFFFF      '  Infinite timeout

' Functions that wait for events
Private Declare Function WaitForSingleObject Lib "kernel32" _
 (ByVal hHandle As Long, ByVal dwMilliseconds As Long) _
 As Long
Private Declare Function WaitForMultipleObjects _
 Lib "kernel32" (ByVal nCount As Long, _
 lpHandles As Long, ByVal bWaitAll As Long, _
 ByVal dwMilliseconds As Long) As Long

' WaitFor... constants
Private Const WAIT_FAILED = -1&
Private Const WAIT_OBJECT_0 = 0
Private Const WAIT_ABANDONED = &H80&
Private Const WAIT_ABANDONED_0 = &H80&
Private Const WAIT_TIMEOUT = &H102&

' Function for building a temp file name
Private Declare Function GetTempFileName Lib "kernel32" _
 Alias "GetTempFileNameA" (ByVal lpszPath As String, _
 ByVal lpPrefixString As String, ByVal wUnique As Long, _
 ByVal lpTempFileName As String) As Long

Sub dhFunWithNotify(strPath As String, ByVal lngTimeout As Long)

    ' Sample procedure demonstrating Windows API Notify functions
    ' See chapter text for details.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Directory to monitor for changes.
    '   lngTimeout
    '       Initial timeout value.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhFunWithNotify("C:\WINDOWS\TEMP", 5000)

    Dim colPaths As New Collection
    Dim strFile As String
    Dim hChange As Long
    Dim lngStatus As Long
    Dim lngFlags As Long
    Dim fKeepGoing As Boolean
    Dim lngScore As Long
    Dim lngTotalScore As Long
    
    Const dhcBaseScore = 100000
    
    ' Build a list of subdirectories beneath strPath
    Debug.Print "Building directory list..."
    If dhGetSubdirectories(strPath, colPaths) = 0 Then
        Debug.Print "Could not build subdirectory list!"
        Exit Sub
    End If
    
    ' Set up flags
    lngFlags = FILE_NOTIFY_CHANGE_FILE_NAME
     
    ' Create the first file
    Debug.Print "Here we go!!!"
    strFile = dhCreateTempFile(dhGetRandomFile(colPaths), _
     "~DH")
    If strFile = "" Then
        Debug.Print "Error creating first file!"
        Exit Sub
    End If
    
    ' Create first change notification
    hChange = FindFirstChangeNotification(strPath, _
     1, lngFlags)
    
    ' Make sure it was successful
    If hChange > 0 Then
        
        ' Loop until timeout has occurred,
        ' the notification function fails,
        ' or our timeout reaches zero
        Do
        
            ' Print the relative file name
            Debug.Print "You have " & lngTimeout / 1000 & _
             " seconds to delete:"
            Debug.Print "..\" & Mid(strFile, Len(strPath) + 2)
            
            ' Wait for the change to happen
            lngStatus = WaitForSingleObject(hChange, _
             lngTimeout)
            
            ' What happened?
            Select Case lngStatus
                Case WAIT_OBJECT_0
                    ' A change happened! Check to see if
                    ' the right file was deleted
                    If Dir(strFile) = "" Then
                        
                        ' File is gone! Compute score
                        lngScore = CLng((dhcBaseScore * _
                         colPaths.Count) / lngTimeout)
                        lngTotalScore = lngTotalScore + _
                         lngScore
                        Debug.Print "Good job! Score " & _
                         lngScore & " points"
                         
                        ' Create next temp file
                        strFile = dhCreateTempFile( _
                         dhGetRandomFile(colPaths), "~DH")
                        fKeepGoing = CBool(Len(strFile))
                        
                        ' If successful...
                        If fKeepGoing Then
                        
                            ' Call FindNextChangeNotification
                            ' once to clear change handle
                            Call FindNextChangeNotification( _
                             hChange)
                             
                            ' Call it again to establish the
                            ' next change event
                            fKeepGoing = CBool( _
                             FindNextChangeNotification( _
                             hChange))
                             
                            ' Reduce timeout and wait again
                            lngTimeout = lngTimeout - 500
                            
                        Else
                            Debug.Print "Error creating file!"
                        End If
                    Else
                        ' The file's still there!
                        Debug.Print _
                         "Oh, no! You got the wrong file!"
                        fKeepGoing = False
                    End If
                Case WAIT_TIMEOUT
                    ' The wait timed out!
                    Debug.Print "Time's up! Timeout = " & _
                     lngTimeout & " ms"
                    fKeepGoing = False
                    
                Case WAIT_FAILED
                    ' This is bad, the wait didn't work
                    Debug.Print "Wait failed!"
                    fKeepGoing = False
            End Select
            
        Loop While fKeepGoing And (lngTimeout > 0)
        
        ' Close the change notification
        Call FindCloseChangeNotification(hChange)
        
        ' Print exit message
        Debug.Print "Total score: " & lngTotalScore
        Debug.Print "Thanks for playing"
    End If
End Sub

Private Function dhGetSubdirectories(strPath As String, _
 colList As Collection) As Long

    ' Retrieves a collection of subdirectories.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Directory to search.
    '   colList
    '       Pointer to VBA Collection object.
    ' Out:
    '   colList
    '       Contains one element for each subdirectory.
    '   Return Value:
    '       Number of subdirectories.
    ' Note:
    '       Used by dhFunWithNotify.
    ' Example:
    '   Dim colDir As New Collection
    '
    '   Call dhGetSubdirectories("C:\", colDir)
 
    ' Build a list of subdirectories beneath given path
    ' and return the number of them found
    dhGetSubdirectories = dhFindAllFiles("*.*", _
    strPath, colList, vbDirectory)
End Function

Private Function dhGetRandomFile(colFiles As Collection) As String

    ' Returns a random filename given a collection of names.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   colFiles
    '       VBA collection object containing filenames.
    ' Out:
    '   Return Value:
    '       Name of file selected at random.
    ' Note:
    '   Used by dhFunWithNotify
    ' Example:
    '   strFile = dhGetRandomFile(colFiles)

    Dim lngIndex As Long
    
    ' Get a random number between 1 and the number of files
    lngIndex = CLng(Int((colFiles.Count) * Rnd) + 1)
    
    ' Return the filename associated with that index
    dhGetRandomFile = colFiles(lngIndex)
End Function

Private Function dhCreateTempFile(strPath As String, _
 strPrefix As String) As String

    ' Creates a zero-byte file in a specific directory.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Path of directory to hold file.
    '   strPrefix
    '       Prefix for filename.
    ' Out:
    '   Return Value:
    '       Name of file created.
    ' Note:
    '       Used by dhFunWithNotify.
    ' Example:
    '   strFile = dhCreateTempFile("C:\TEMP", "~DH")
 
    Dim strFile As String
    Dim strBuffer As String
    Dim hFile As Long
    Dim lngNumber As Long
 
    ' Create a zero-byte file at the given location
    strBuffer = Space(255)
    lngNumber = GetTempFileName(strPath, strPrefix, 0, strBuffer)
    If lngNumber > 0 Then
        strFile = dhTrimNull(strBuffer)
        
        hFile = FreeFile
        
        Open strFile For Append Access Write As hFile
        
        Close hFile
        
        dhCreateTempFile = strFile
    End If
End Function

