Attribute VB_Name = "basCommonDialog"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

Private Type OPENFILENAME
     lngStructSize As Long          ' Size of structure
     hWndOwner As Long              ' Owner window handle
     hInstance As Long              ' Template instance handle
     strFilter As String            ' Filter string
     strCustomFilter As String      ' Selected filter string
     intMaxCustFilter As Long       ' Len(strCustomFilter)
     intFilterIndex As Long         ' Index of filter string
     strFile As String              ' Selected filename & path
     intMaxFile As Long             ' Len(strFile)
     strFileTitle As String         ' Selected filename
     intMaxFileTitle As Long        ' Len(strFileTitle)
     strInitialDir As String        ' Directory name
     strTitle As String             ' Dialog title
     lngFlags As Long               ' Dialog flags
     intFileOffset As Integer       ' Offset of filename
     intFileExtension As Integer    ' Offset of file extension
     strDefExt As String            ' Default file extension
     lngCustData As Long            ' Custom data for hook
     lngfnHook As Long              ' LP to hook function
     strTemplateName As String      ' Dialog template name
End Type

Declare Function GetOpenFileName Lib "comdlg32.dll" _
 Alias "GetOpenFileNameA" (ofn As OPENFILENAME) As Boolean
Declare Function GetSaveFileName Lib "comdlg32.dll" _
 Alias "GetSaveFileNameA" (ofn As OPENFILENAME) As Boolean

' Open/Save dialog flags
Global Const OFN_READONLY = &H1
Global Const OFN_OVERWRITEPROMPT = &H2
Global Const OFN_HIDEREADONLY = &H4
Global Const OFN_NOCHANGEDIR = &H8
Global Const OFN_SHOWHELP = &H10
Global Const OFN_NOVALIDATE = &H100
Global Const OFN_ALLOWMULTISELECT = &H200
Global Const OFN_EXTENSIONDIFFERENT = &H400
Global Const OFN_PATHMUSTEXIST = &H800
Global Const OFN_FILEMUSTEXIST = &H1000
Global Const OFN_CREATEPROMPT = &H2000
Global Const OFN_SHAREAWARE = &H4000
Global Const OFN_NOREADONLYRETURN = &H8000
Global Const OFN_NOTESTFILECREATE = &H10000
Global Const OFN_NONETWORKBUTTON = &H20000
Global Const OFN_NOLONGNAMES = &H40000
' Flags for hook functions and dialog templates
'Global Const OFN_ENABLEHOOK = &H20
'Global Const OFN_ENABLETEMPLATE = &H40
'Global Const OFN_ENABLETEMPLATEHANDLE = &H80
' Windows 95 flags
Global Const OFN_EXPLORER = &H80000
Global Const OFN_NODEREFERENCELINKS = &H100000
Global Const OFN_LONGNAMES = &H200000

' Custom flag combinations
Global Const dhOFN_OPENEXISTING = OFN_PATHMUSTEXIST Or OFN_FILEMUSTEXIST Or OFN_HIDEREADONLY
Global Const dhOFN_SAVENEW = OFN_PATHMUSTEXIST Or OFN_OVERWRITEPROMPT Or OFN_HIDEREADONLY
Global Const dhOFN_SAVENEWPATH = OFN_OVERWRITEPROMPT Or OFN_HIDEREADONLY

Private Declare Function GetActiveWindow Lib "user32" () As Long

Function dhFileDialog( _
 Optional strInitDir As String, _
 Optional strFilter As String = _
  "All files (*.*)" & vbNullChar & "*.*" & _
  vbNullChar & vbNullChar, _
 Optional intFilterIndex As Integer = 1, _
 Optional strDefaultExt As String = "", _
 Optional strFilename As String = "", _
 Optional strDialogTitle As String = "Open File", _
 Optional hWnd As Long = -1, _
 Optional fOpenFile As Boolean = True, _
 Optional ByRef lngFlags As Long = _
  dhOFN_OPENEXISTING) As Variant

    ' Wrapper function for the GetOpenFileName API function.
    ' Displays the common open/save as dialog and returns
    ' the file(s) selected by the user.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strInitDir (Optional)
    '       Inital directory.
    '   strFilter (Optional)
    '       File filter as null delimited/double-null
    '       terminated string.
    '   intFilterIndex (Optional, default = 1)
    '       Initial filter index.
    '   strDefaultExt (Optional)
    '       Default file extension if none specified.
    '   strFilename (Optional)
    '       Initial file name for dialog.
    '   strDialogTitle (Optional, default = "Open File")
    '       Dialog title.
    '   hwnd (Optional, default = -1)
    '       Handle of dialog owner window.
    '   fOpenFile (Optional, default = True)
    '       If True, displays Open dialog, if False,
    '       displays Save As dialog.
    '   lngFlags (Optional)
    '       Flags for API function (see declarations section).
    ' Out:
    '   lngFlags
    '       Returns flags set by the API function after closing
    '       the dialog.
    '   Return Value:
    '       Name of the file or files chosen by the user.
    ' Note:
    '       If you allow multi-select, returned string will
    '       be the directory name followed by a space-delimited
    '       list of files.
    ' Example:
    '   strFile = dhFileDialog(strFilter:="All files" & _
    '    vbNullChar & "*.*" & vbNullChar & vbNullChar)

    Dim ofn As OPENFILENAME
    Dim strFileTitle As String
    Dim fResult As Boolean

    ' Fill in some of the missing arrguments
    If strInitDir = "" Then
        strInitDir = CurDir
    End If
    If hWnd = -1 Then
        hWnd = GetActiveWindow()
    End If

    ' Set up the return buffers
    strFilename = strFilename & String(255 - Len(strFilename), 0)
    strFileTitle = String(255, 0)

    ' Fill in the OPENFILENAME structure members
    With ofn
        .lngStructSize = Len(ofn)
        .hWndOwner = hWnd
        .strFilter = strFilter
        .intFilterIndex = intFilterIndex
        .strFile = strFilename
        .intMaxFile = Len(strFilename)
        .strFileTitle = strFileTitle
        .intMaxFileTitle = Len(strFileTitle)
        .strTitle = strDialogTitle
        .lngFlags = lngFlags
        .strDefExt = strDefaultExt
        .strInitialDir = strInitDir
        .hInstance = 0
        .strCustomFilter = String(255, 0)
        .intMaxCustFilter = 255
        .lngfnHook = 0
    End With

    ' Call the right function
    If fOpenFile Then
        fResult = GetOpenFileName(ofn)
    Else
        fResult = GetSaveFileName(ofn)
    End If

    ' If successful, return the filename,
    ' otherwise return Null
    If fResult Then
        ' Return any flags to the calling procedure
        lngFlags = ofn.lngFlags
        
        ' Return the result
        If (ofn.lngFlags And OFN_ALLOWMULTISELECT) = 0 Then
            dhFileDialog = dhTrimNull(ofn.strFile)
        Else
            dhFileDialog = ofn.strFile
        End If
    Else
        dhFileDialog = Null
    End If
End Function

Sub dhTestDialog()

    ' Test function for dhFileDialog function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestDialog()

    ' Open a file in the current directory
    Debug.Print dhFileDialog()
    
    ' Open multiple files in the Windows directory
    Debug.Print dhFileDialog(strInitDir:="C:\WINDOWS", _
     lngFlags:=dhOFN_OPENEXISTING Or OFN_ALLOWMULTISELECT _
     Or OFN_EXPLORER)
    
    ' Save a file as a text file
    Debug.Print dhFileDialog(strFilter:="Text Files" & _
     vbNullChar & "*.txt" & vbNullChar & vbNullChar, _
     strDialogTitle:="Save As", lngFlags:=dhOFN_SAVENEW, _
     fOpenFile:=False)
End Sub
