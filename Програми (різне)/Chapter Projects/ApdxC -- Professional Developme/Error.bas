Attribute VB_Name = "basErrorRoutines"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Conditional compilation constant for dhMsgBox
#Const fDebug = True

Function dhError( _
 Optional strProc As String = "<unknown>", _
 Optional fRespond As Boolean = False, _
 Optional objErr As ErrObject) _
 As Boolean
    ' Generic error handling routine that displays
    ' the error information in a dialog box
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strProc: Name of the procedure calling this function
    '   fRespond: If True the dialog includes OK and Cancel buttons
    '   objErr: VBA ErrObject containing error information (optional)
    ' Out:
    '   Return Value: True if the user clicks the OK button,
    '       False otherwise
    ' Example:
    '   Call dhError("ThisProc", True)
 
    Dim strMessage As String
    Dim strTitle As String
    Dim intStyle As Integer
    
    ' If the user didn't pass an ErrObject, use Err
    If objErr Is Nothing Then
        Set objErr = Err
    End If
    
    ' If there is an error, process it
    ' otherwise just return True
    If objErr.Number = 0 Then
        dhError = True
    Else
        ' Build title and message
        strTitle = "Error " & objErr.Number & _
         " in " & strProc
        strMessage = "The following error has occurred:" & _
         vbCrLf & vbCrLf & objErr.Description
        
        ' Set the icon and buttons for MsgBox
        intStyle = vbExclamation
        If fRespond Then
            intStyle = intStyle Or vbOKCancel
        End If
        
        ' Display message and return result
        dhError = (MsgBox(strMessage, _
         intStyle, strTitle) = vbOK)
    End If
End Function

Function dhMsgBox(ByVal varMessage As Variant, _
 Optional strCaller As String = "<unknown>") As Integer

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Set return value in case fDebug is False
    dhMsgBox = True

    #If fDebug Then
        dhMsgBox = (MsgBox(CStr(varMessage), _
         vbOKCancel Or vbQuestion, "Procedure: " & strCaller) _
         = vbOK)
    #End If

End Function

Sub dhAssert(fCondition As Boolean, Optional _
 strMessage As String = "Assertion failed.")
 
    ' Halts execution if a given condition is False
 
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   fCondition: A logical condition
    '   strMessage: Error message if condition is False
    ' Out:
    '   Return Value: n/a
    ' Example:
    '   call dhAssert(x > y, "X is greater than Y.")
    
    ' If condition is False, display error
    ' message and halt execution
    If Not fCondition Then
        MsgBox strMessage, vbCritical
        Debug.Assert False
    End If
End Sub

