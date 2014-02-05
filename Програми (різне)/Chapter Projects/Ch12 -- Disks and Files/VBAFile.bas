Attribute VB_Name = "basVBABuiltIn"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

Sub dhTestDir()

    ' Sample procedure to test the VBA Dir function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestDir

    Dim strFile As String
    
    ' Prints "WIN.INI" if the file exists
    Debug.Print Dir("C:\WINDOWS\WIN.INI")
    
    ' Prints the first file that starts with "W"
    Debug.Print Dir("C:\WINDOWS\W*")
    
    ' Prints the next file that starts with "W"
    Debug.Print Dir
    
    ' Prints all the files in the current directory
    strFile = Dir("*")
    Do Until strFile = ""
        Debug.Print strFile
        strFile = Dir
    Loop
End Sub

Function dhFileExists(strFile As String) As Boolean
    ' Call Dir with the passed filename--
    ' if the file exists Dir will return
    ' back the filename and the length
    ' of the string will be > 0
    On Error Resume Next
    dhFileExists = (Len(Dir(strFile)) > 0)
End Function

Function dhIsAttr(strFile As String, lngAttr As Long) _
 As Boolean

    ' Determines if the attributes of the given file exactly
    ' match those specified by lngAttr.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   lngAttr
    '       Bitmask of VBA file attribute constants.
    ' Out:
    '   Return Value:
    '       True if attributes match, False if not.
    ' Example:
    '   fMatch = dhIsAttr("C:\MSDOS.SYS", vbSystem + vbHidden)
    
    ' Check the attributes of the file against the
    ' specified attributes--return True if they match
    On Error Resume Next
     dhIsAttr = ((GetAttr(strFile) And lngAttr) = lngAttr)
End Function

Sub dhPrintAttr()

    ' Sample procedure that prints file attribute information
    ' to the Immediate window.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintAttr

    Dim strFile As String
    Dim lngAttr As Long
    Dim strAttr As String
    
    ' Use the root directory of the current drive
    Const dhcDir = "\"
    
    ' Look for all types of files
    strFile = Dir(dhcDir, _
     vbHidden + vbSystem + vbDirectory)
     
    ' Loop until no more files are found
    Do Until strFile = ""
    
        ' Use GetAttr to get the file's attributes
        lngAttr = GetAttr(dhcDir & strFile)
                
        ' Print the file with its attributes
        Debug.Print strFile, dhBuildAttrString(lngAttr)
        
        ' Get the next file and reset the attribute string
        strFile = Dir
        strAttr = ""
    Loop
End Sub

Function dhBuildAttrString(lngAttr As Long) As String

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

Sub dhBuildAttr(strAttr As String, lngAttr As Long, _
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

Sub dhListSubDirs(strPath As String)

    ' Lists all the subdirectories beneath the given directory.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strPath
    '       Directory to look in.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhListSubDirs("C:\")

    Dim strFile As String
    
    ' Make sure strPath is a directory
    If Right(strPath, 1) <> "\" Then
        strPath = strPath & "\"
    End If
    If dhIsAttr(strPath, vbDirectory) Then
        
        ' Find all the files, including directories
        strFile = Dir(strPath, vbDirectory)
        Do Until strFile = ""
            
            ' If the file is a directory, print it
            If dhIsAttr(strPath & strFile, vbDirectory) Then
             
                ' Ignore "." and ".."
                If strFile <> "." And _
                 strFile <> ".." Then
                
                    Debug.Print strFile
                End If
            End If
            
            ' Get the next file
            strFile = Dir
        Loop
    End If
End Sub

Function dhDelTree(ByVal Directory As String, _
 Optional RemoveRoot As Boolean = True, _
 Optional ByVal Level As Integer = 1) As Boolean

    ' Deletes an entire directory tree (including all
    ' files and subdirectories). Calls itself recursively.

    ' From "VBA Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 1997; Sybex, Inc. All rights reserved.

    ' In:
    '   Directory
    '       Directory to delete.
    '   RemoveRoot
    '       True if you want to remove the top-level folder.
    '       False if you want to remove contents, but leave
    '         the top-level folder intact.
    '   Level
    '       Used by the procedure. Do not specify a value.
    
    ' Out:
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Call dhDelTree("C:\")   ' Ha! Ha! Just kidding
    '   Call dhDelTree("C:\DATA\MYDIR")

    On Error GoTo HandleErrors

    Dim strFilename As String
    Dim strDirectory As String

    strDirectory = dhFixPath(Directory)
    
    ' Check to make sure the directory actually exists.
    ' If not, we don't have to do a thing.
    If Len(Dir(strDirectory, vbDirectory)) = 0 Then
        GoTo ExitHere
    End If
    
    If dhFixPath(CurDir) = strDirectory Then
        MsgBox "Unable to delete the current directory. " & _
         "Move to a different directory, and try again."
        GoTo ExitHere
    End If
    
    ' Delete all the files in the current directory
    strFilename = Dir(strDirectory & "*.*")
    Do Until strFilename = ""
        Kill strDirectory & strFilename
        strFilename = Dir
    Loop
    
    ' Now build a list of subdirectories
    Do
        strFilename = Dir(strDirectory & "*.*", vbDirectory)
        
        ' Skip "." and ".."
        Do While strFilename = "." Or strFilename = ".."
            strFilename = Dir
        Loop
    
        ' If there are no more files, exit the loop.
        ' Otherwise call dhDelTree again to wipe
        ' out the subdirectory.
        If strFilename = "" Then
            Exit Do
        Else
            ' Call dhDelTree recursively. Pass True for RemoveRoot,
            ' because you'll always want to remove subfolders.
            ' Indicate the level by passing Level + 1.
            If Not dhDelTree(strDirectory & strFilename, True, Level + 1) Then
                GoTo ExitHere
            End If
        End If
    Loop
    
    ' Finally, remove the target directory
    ' The following expression returns True unless
    ' the first factor is True and the
    ' second factor is False -- that is,
    ' it always removes the folder unless
    ' you're at level 1 (the root level) and you've
    ' been told not to remove the root.
    If Level = 1 Imp RemoveRoot Then
        RmDir strDirectory
    End If
    
    dhDelTree = True
    
ExitHere:
    Exit Function
    
HandleErrors:
    Select Case Err.Number
        Case 75 ' Path or file access
            ' If a file or folder can't be deleted,
            ' just keep going.
            Resume Next
        Case Else
            dhDelTree = False
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number & " in dhDelTree"
            Resume ExitHere
    End Select
End Function

Sub dhCopyRenameDelete()

    ' Sample procedure demonstrating the VBA functions for
    ' copying, deleting, and renaming files.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhCopyRenameDelete

    ' Copy WIN.INI to root directory
    FileCopy "C:\WINDOWS\WIN.INI", "C:\WIN.INI"

    ' Rename to WIN.TMP
    Name "C:\WIN.INI" As "C:\WIN.TMP"
    
    ' Delete the renamed file
    Kill "C:\WIN.TMP"
End Sub

Sub dhMoreFileInfo()

    ' Sample procedure demonstrating VBA functions for
    ' retrieving file size and last modified time.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhMoreFileInfo

    ' How big is WIN.INI?
    Debug.Print FileLen("C:\WINDOWS\WIN.INI") & " bytes"
    
    ' When was it last modified?
    Debug.Print FileDateTime("C:\WINDOWS\WIN.INI")
End Sub

Sub dhTestCurrent()

    ' Sample procedure demonstrating the VBA functions
    ' for chaning the current drive and directory.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestCurrent

    ' Print the first file in the current directory
    Debug.Print Dir("*.*"), "in " & CurDir
    
    ' Try to change to the D drive using ChDir
    ChDir "D:\SOMEDIR"
    
    ' Print the first file again--it's still on C!
    Debug.Print Dir("*.*"), "in " & CurDir
    
    ' Now use ChDrive to switch drives
    ChDrive "D"
    
    ' Print the first file again--this time it's D!
    Debug.Print Dir("*.*"), "in " & CurDir
End Sub

