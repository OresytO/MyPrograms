Attribute VB_Name = "basExamples"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Declare global instance of Stack class
Global gProcStack As New ProcStack

' Declare an instance of the Log class
Global gLog As Log

' Logging constants
Private Const conLogDateTime = 1
Private Const conLogSeverity = 2

Sub FileInfo(strPath As String)
    Dim strDir As String
    
    ' Trim file name off, leaving the directory name
    strDir = TrimFileName(strPath)
    
    ' Display message box
    MsgBox "The file " & strPath & _
     " is located in " & strDir, _
     vbInformation, "File Info"
End Sub

Function TrimFileName(strPath As String) As String
    Dim cb As Long
    
    ' Trim characters from right end of string
    ' until we find a backslash or run out of letters
    Do
        strPath = Left(strPath, Len(strPath) - 1)
    Loop Until Right(strPath, 1) = "\" Or _
     Len(strPath) = 0
     
    ' Return result
    TrimFileName = strPath
End Function

Sub GenericProcWithErrorTrap()
    ' Stub showing standard way to construct an error handler

    ' Set the error trap
    On Error GoTo HandleError

    ' Some code that might generate a run-time error
    ' would go here

ExitHere:
    ' Important! Exit proc before error handler
    Exit Sub
HandleError:
    ' Error handling goes here!
    Resume ExitHere
End Sub

Sub DeleteFile(ByVal strFileName As String)
    ' Example showing an On Error Resume Next
    ' Deletes a file if it exists

    On Error Resume Next

    Kill strFileName
End Sub

Sub CopyToFloppy(strFile As String)
    Dim strDest As String

    ' Set the error trap
    On Error GoTo HandleError
    
    ' Construct destination file path
    strDest = "A:\" & TrimDirectory(strFile)

    ' Delete file from the floppy
    Kill strDest

    ' Attempt to copy the file
    FileCopy strFile, strDest
    
ExitProc:
    Exit Sub
HandleError:
    Select Case Err.Number
        Case 53 ' File not found
            MsgBox "Cannot find the file '" & strFile & _
             "'.", vbExclamation, "CopyToFloppy"
        Case 71 ' Drive not ready
            
            If MsgBox("Please place a floppy disk in the " & _
             "drive.", vbExclamation + vbOKCancel, _
             "Load Diskette") = vbOK Then
                Resume
            Else
                Resume ExitProc
            End If
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number & " in CopyToFloppy"
            Resume ExitProc
    End Select
End Sub

Function TrimDirectory(strPath As String) As String
    Dim cb As Long
    
    cb = Len(strPath)
    Do
        cb = cb - 1
        If cb = 0 Then
            Exit Do
        End If
    Loop Until Mid(strPath, cb, 1) = "\" Or _
     Mid(strPath, cb, 1) = ":"
    
    TrimDirectory = Mid(strPath, cb + 1)
End Function

Function ComputeValue(dblAmount As Double, _
 sngRate As Single) As Double

    ' Demonstrates how to use the Raise method

    If sngRate < 0 Or sngRate > 1 Then
        Err.Raise vbObjectError + 12345, "ComputeValue", _
         "Argument must be between 0 and 1."
    End If

    ComputeValue = dblAmount * sngRate
End Function

Sub ForceError()
    On Error GoTo HandleError
    
    Debug.Print 1 / 0
    
ExitHere:
    Exit Sub
HandleError:
    If Not dhError("ForceError", True) Then
        Debug.Assert False
    End If
    Resume ExitHere
End Sub

Function InvoiceTotal(lngInvoiceID As Long, _
 sngTax As Single) As Double
 
    ' Use dhAssert to validate data
     Call dhAssert((sngTax >= 0) And (sngTax <= 1), _
      "Invalid tax rate: " & sngTax)

    ' Other statements
    ' ...
End Function

Sub EnterAndExitExample()
    ' Call Push to place proc name onto the stack
    Call gProcStack.Push("EnterAndExitExample")

    ' Call PrintCallStack which will print call stack
    ' to the Immediate window so you can see that it works!
    Call PrintCallStack

    ' Make sure to call Pop!!
    Call gProcStack.Pop
End Sub

Private Sub PrintCallStack()
    Dim objProc As ProcStackItem

    ' Call Push to place proc name onto the stack
    Call gProcStack.Push("PrintCallStack")

    ' Print it out by walking the stack
    Set objProc = gProcStack.StackTop
    Do Until objProc Is Nothing
        Debug.Print "Entered procedure '" & objProc.Value & _
         "' at " & objProc.TimeEntered
        Set objProc = objProc.NextItem
    Loop

    ' Make sure to call Pop!!
    Call gProcStack.Pop
End Sub

Sub Main()
    ' Initialize the log
    Set gLog = New Log

    ' Set the file name
    gLog.File = "C:\APP.LOG"

    ' Set logging options
    gLog.SeverityLevel = 5
    gLog.Options = conLogDateTime

    ' Other startup code
    ' ...
End Sub

Sub ProcessFileName(strFile As String)
    gLog.Output "Entering ProcessFile", 5
    
    Dim strErrText As String
    
    gLog.Output "Before: strFile = " & strFile, 6
    
    ' Do some processing here
    
    gLog.Output "After:  strFile = " & strFile, 6
    
ExitHere:
    gLog.Output "Exiting ProcessFile", 5
    Exit Sub
HandleError:
    strErrText = "(" & Err.Number & ") " & _
     Err.Description
    
    Call dhError("ProcessFile")
    
    gLog.Output "Error in ProcessFile: " & _
     strErrText, 9
    
    Resume ExitHere
End Sub

Sub ShowHelpInfo()
    On Error GoTo HandleError
    
    Err.Raise vbObjectError + 12345, "Sub ShowHelpInfo", _
     "This error is by design.", "MAINAPP.HLP", 100
    
ExitHere:
    Exit Sub
HandleError:
    Debug.Print Err.HelpFile, Err.HelpContext
    Resume ExitHere
End Sub

