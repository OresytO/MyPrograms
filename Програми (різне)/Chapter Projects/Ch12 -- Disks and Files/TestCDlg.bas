Attribute VB_Name = "basTestCommonDlg"
Option Explicit

' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All rights reserved.

' Support information, and demonstration
' callback functions, for the CommonDlg class.

' All of the following declarations, types,
' and constants are used in the callback functions,
' not in the CommonDlg class directly.

' Required by:
'   CommonDlg (if you want to use these
'       particular callback functions)

' ================
' GetSystemMetrics Info
' ================
Private Const SM_CXSCREEN = 0
Private Const SM_CYSCREEN = 1

Private Declare Function GetSystemMetrics _
 Lib "user32" _
 (ByVal nIndex As Long) As Long

' ================
' GetWindowRect Info
' ================
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Declare Function GetWindowRect _
 Lib "user32" _
 (ByVal hWnd As Long, lpRect As RECT) As Long

' ================
' SetWindowPos Info
' ================
Private Enum SWPValues
    SWP_SHOWWINDOW = &H40
    SWP_NOSIZE = &H1
    SWP_NOZORDER = &H4
End Enum

Private Declare Function SetWindowPos _
 Lib "user32" _
 (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, _
 ByVal X As Long, ByVal y As Long, _
 ByVal cx As Long, ByVal cy As Long, _
 ByVal wFlags As Long) As Long
 
' ================
' Other API Declarations
' ================
Private Declare Function GetParent _
 Lib "user32" _
 (ByVal hWnd As Long) As Long
 
Private Declare Function SendMessageText _
 Lib "user32" Alias "SendMessageA" _
 (ByVal hWnd As Long, ByVal wMsg As Long, _
 ByVal wParam As Long, ByVal lParam As String) As Long

Private Declare Function SendMessageLong _
 Lib "user32" Alias "SendMessageA" _
 (ByVal hWnd As Long, ByVal wMsg As Long, _
 ByVal wParam As Long, ByVal lParam As Long) As Long

' Message the code's reacting to.
Private Const WM_INITDIALOG = &H110

' Used to get a window handle to parent dialog from
Private Declare Function GetActiveWindow _
 Lib "user32" () As Long
 
Public Function CDCallback( _
 ByVal hWnd As Long, ByVal uiMsg As Long, _
 ByVal wParam As Long, ByVal lParam As Long) As Long
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' Callback function for Font and Color dialogs. The
    ' parameters for this function are defined and
    ' dictated by the API functions. You may not
    ' alter anything in the declaration besides the
    ' names, or this code will not work.
    
    Select Case uiMsg
        Case WM_INITDIALOG
            ' On initialization, center the dialog.
            Call CenterWindow(hWnd)
            ' You could get many other messages here, too.
            ' All the normal window messages get
            ' filtered through here, and you can
            ' react to any that you like.
    End Select
    ' Tell the original code to handle the message, too.
    ' Otherwise, things get pretty ugly.
    ' To do that, return 0.
    CDCallback = 0
End Function

Public Function GFNCallback(ByVal hWnd As Long, ByVal uiMsg As Long, _
 ByVal wParam As Long, ByVal lParam As Long) As Long
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' Callback function for Get File Open/Save Name dialogs.
    ' The parameters for this function are defined and
    ' dictated by the API functions. You may not
    ' alter anything in the declaration besides the
    ' names, or this code will not work.
    
    Dim hWndParent As Long
    
    Select Case uiMsg
        Case WM_INITDIALOG
            ' In this case, hWnd is the handle
            ' of the child dialog box. You need to
            ' call GetParent to get the handle of the main
            ' dialog box. Go figure.
            hWndParent = GetParent(hWnd)
            If hWndParent <> 0 Then
                
                ' On initialization, center the dialog.
                Call CenterWindow(hWndParent)
            End If

        #If False Then
            ' Now THIS is cool. You can send a message
            ' to the File Open/Save dialog box, and either change
            ' text or hide a control. Check out the
            ' CDM_* messages, and the fos* enum in the
            ' CommonDlg class for all the options.
            Call SendMessageText(hWndParent, CDM_SETCONTROLTEXT, _
             fosOKButton, "&Select")
            Call SendMessageLong(hWndParent, CDM_HIDECONTROL, _
             fosFilterListLabel, 0)
        #End If
            
            ' You could get many other messages here, as well.
            ' All the normal window messages get
            ' filtered through here, and you can
            ' react to any that you like.
    End Select
    ' Tell the original code to handle the message, too.
    ' Otherwise, things get pretty ugly.
    ' To do that, return 0.
    GFNCallback = 0
End Function

Public Sub CenterWindow(hWnd As Long)
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' Given the hWnd, center any window on the screen.
    
    ' In:
    '   hWnd:
    '       Window handle for the window to be centered.
    ' Out:
    '   Nothing
    
    ' Passes any VBA error back up to the caller.
    
    Dim lngScreenWidth As Long
    Dim lngScreenHeight As Long
    
    Dim rct As RECT
    Dim lngWidth As Long
    Dim lngHeight As Long
    
    On Error GoTo HandleErrors
    
    ' Get the screen width and height.
    lngScreenWidth = GetSystemMetrics(SM_CXSCREEN)
    lngScreenHeight = GetSystemMetrics(SM_CYSCREEN)
        
    ' Get the coordinates for the requested
    ' window, and then calculate its
    ' width and height.
    Call GetWindowRect(hWnd, rct)
    lngWidth = rct.Right - rct.Left
    lngHeight = rct.Bottom - rct.Top
    
    ' Set the position, but don't resize
    ' or change the z-order.
    Call SetWindowPos( _
     hWnd, hWndInsertAfter:=0, _
     X:=(lngScreenWidth - lngWidth) \ 2, _
     y:=(lngScreenHeight - lngHeight) \ 2, _
     cx:=0, cy:=0, _
     wFlags:=SWP_NOSIZE Or SWP_NOZORDER)
    
ExitHere:
    Exit Sub
    
HandleErrors:
    ' Raise the error and get out.
    Err.Raise Err.Number, Err.Source, Err.Description
End Sub

Public Function dhChooseColor( _
 Optional lngColor As Long = 0, _
 Optional fRaiseErrorOnCancel As Boolean = False, _
 Optional hWndOwner As Long = -1) As Long
    ' Use the color chooser common dialog to
    ' select a color. This wrapper raises an
    ' error if you press Cancel on the color dialog.
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' Simple wrapper around the Color common dialog.
    
    ' In:
    '   lngColor (optional):
    '       Color to be selected when the dialog opens.
    '       The default color is Black (0).
    '   fRaiseErrorOnCancel (optional):
    '       Raise an error if the user cancels?
    '       The default is False (no error raised).
    '   hWndOwner (optional):
    '       hWnd of the window to use as the dialog's
    '       owner. The default is -1, indicating
    '       that the procedure should use Access'
    '       window handle.
    ' Out:
    '   The selected color (or 0, if the user presses Cancel).
    
    On Error GoTo HandleErrors
    
    Dim cdl As CommonDlg
    Set cdl = New CommonDlg
    
    ' Handle optional parameters.
    cdl.CancelError = fRaiseErrorOnCancel
    If hWndOwner = -1 Then
        cdl.hWndOwner = Application.hWndAccessApp
    End If
    
    cdl.ColorFlags = cdlCCRGBInit
    cdl.Color = lngColor
    cdl.ShowColor
    dhChooseColor = cdl.Color
    
ExitHere:
    Set cdl = Nothing
    Exit Function
    
HandleErrors:
    Select Case Err.Number
        Case Else
            Set cdl = Nothing
            Err.Raise Err.Number, Err.Source, Err.Description
    End Select
End Function

Sub dhTestFileOpen()
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' Test the CommonDlg class' FileOpen common dialog.
    
    Dim cdl As CommonDlg
    Set cdl = New CommonDlg
    
    cdl.hWndOwner = GetActiveWindow()
    cdl.CancelError = True
    
    On Error GoTo HandleErrors
    
    ' Set three pairs of values for the Filter.
    cdl.Filter = _
     "Text files (*.txt)|" & _
     "*.txt|" & _
     "Database files (*.mdb, *.mde, *.mda)|" & _
     "*.mdb;*.mde;*.mda|" & _
     "All files (*.*)|" & _
     "*.*"
    
    ' Select filter 2 (Database files) when
    ' the dialog opens.
    cdl.FilterIndex = 2
    
    ' Indicate that you want to use a callback function,
    ' change back to the original directory when
    ' you're done, and require that the selected
    ' file actually exist.
    cdl.OpenFlags = cdlOFNEnableHook Or _
     cdlOFNNoChangeDir Or cdlOFNFileMustExist

    ' Select the callback function.
    cdl.CallBack = dhFnPtrToLong(AddressOf GFNCallback)
    
    ' Set up miscellaneous properties.
    cdl.InitDir = "C:\"
    cdl.FileName = "autoexec.bat"
    cdl.DefaultExt = "bat"
    
    ' Open the file open dialog box,
    ' and wait for it to be dismissed.
    cdl.ShowOpen
    
    ' Retrieve the selected file name
    Debug.Print cdl.FileName
    
    ' Check the OpenFlags (or Flags) property to
    ' see if the selected extension is different than
    ' the default extension.
    If (cdl.OpenFlags And _
     cdlOFNExtensionDifferent) <> 0 Then
        MsgBox "You chose a different extension!"
    End If
    
ExitHere:
    Set cdl = Nothing
    Exit Sub
    
HandleErrors:
    Select Case Err.Number
        Case cdlCancel
            ' Cancelled!
            Resume ExitHere
        Case Else
            MsgBox "Error: " & Err.Description & _
             "(" & Err.Number & ")"
    End Select
    Resume ExitHere
End Sub

Sub dhTestOfficeFileOpen()
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.
    
    ' Test the Office file open common dialog.
    Dim gfni As dh_accOfficeGetFileNameInfo
    With gfni
        .hWndOwner = GetActiveWindow()
        .strDlgTitle = "Select a File"
        .strOpenTitle = "Select"
        .strFile = ""
        .strInitialDir = "C:\"
        .strFilter = _
         "Text files (*.txt)|" & _
         "Database files (*.mdb; *.mde; *.mda)|" & _
         "All files (*.*)"
        .lngFilterIndex = 1
        .lngView = dhcGfniViewList
        .lngFlags = dhcGfniNoChangeDir Or _
         dhcGfniInitializeView
    End With
    If dhOfficeGetFileName(gfni, True) = _
     dhcAccErrGFNSuccess Then
        Debug.Print Trim$(gfni.strFile)
    End If
End Sub

Public Function dhFnPtrToLong(lngAddress As Long) As Long
    
    ' Given a function pointer as a Long, return a Long.
    ' Sure looks like this function isn't doing anything,
    ' and in reality, it's not.
    
    ' Call this function like this:
    '
    ' lngPointer = dhFnPtrToLong(AddressOf SomeFunction)
    
    ' and it returns the address you've sent it
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.

    ' In:
    '   lngAddress:
    '       address of a public procedure, passed using
    '       the AddressOf modifier.
    ' Out:
    '   Return value:
    '       The input address, cast as a Long.

    dhFnPtrToLong = lngAddress
End Function
