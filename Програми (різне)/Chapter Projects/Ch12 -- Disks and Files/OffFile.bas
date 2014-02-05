Attribute VB_Name = "basOfficeFileOpen"
Option Explicit

' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All rights reserved.
    
Private Declare Function dh_accOfficeGetFileName _
 Lib "msaccess.exe" Alias "#56" _
 (gfni As dh_accOfficeGetFileNameInfo, fOpen As Integer) As Long

' Common Dialogs
' OfficeGetFileName errors
Public Const dhcAccErrGFNSuccess = 0
Public Const dhcAccErrGFNCantOpenDialog = -301
Public Const dhcAccErrGFNUserCancelledDialog = -302

' OfficeGetFileName flags
Public Const dhcGfniConfirmReplace = &H1              ' Prompt if overwriting a file?
Public Const dhcGfniNoChangeDir = &H2                 ' Don't change to the directory the user selected?
Public Const dhcGfniAllowMultiSelect = &H8            ' Allow multiple-selection?
Public Const dhcGfniDirectoryOnly = &H20              ' Open as directory picker?
Public Const dhcGfniInitializeView = &H40             ' Initialize the view to the lView member or use last selected view?

' Views in the Office Find File dialog
Public Const dhcGfniViewDetails = 0                  ' Details
Public Const dhcGfniViewPreview = 1                  ' Preview
Public Const dhcGfniViewProperties = 2               ' Properties
Public Const dhcGfniViewList = 3                     ' List (typical)

Public Type dh_accOfficeGetFileNameInfo
    hWndOwner As Long
    strAppName As String * 255
    strDlgTitle As String * 255
    strOpenTitle As String * 255
    strFile As String * 4096
    strInitialDir As String * 255
    strFilter As String * 255
    lngFilterIndex As Long
    lngView As Long
    lngFlags As Long
End Type

Public Function dhOfficeGetFileName( _
 gfni As dh_accOfficeGetFileNameInfo, _
 ByVal fOpen As Integer) As Long
 
    ' Use the Office file selector common dialog
    ' exposed by Access.
    
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.
    
    Dim lngReturn As Long
    With gfni
        .strAppName = RTrim$(.strAppName) & vbNullChar
        .strDlgTitle = RTrim$(.strDlgTitle) & vbNullChar
        .strOpenTitle = RTrim$(.strOpenTitle) & vbNullChar
        .strFile = RTrim$(.strFile) & vbNullChar
        .strInitialDir = RTrim$(.strInitialDir) & vbNullChar
        If Len(dhTrimNull(RTrim$(.strFilter))) = 0 Then
            .strFilter = "All Files (*.*)"
            .lngFilterIndex = 1
        End If
        .strFilter = RTrim$(.strFilter) & vbNullChar
        lngReturn = dh_accOfficeGetFileName(gfni, fOpen)
        
        .strAppName = dhTrimNull(.strAppName)
        .strDlgTitle = dhTrimNull(.strDlgTitle)
        .strOpenTitle = dhTrimNull(.strOpenTitle)
        .strFile = dhTrimNull(.strFile)
        .strInitialDir = dhTrimNull(.strInitialDir)
        .strFilter = dhTrimNull(.strFilter)
    End With
    dhOfficeGetFileName = lngReturn
End Function

Private Function dhTrimNull(strVal As String) As String
    ' From Visual Basic Language Developer's Handbook
    ' by Getz and Gilbert. (Sybex)
    ' Copyright 2000. All rights reserved.
    
    ' Trim the end of a string, stopping at the first
    ' null character.
    
    Dim intPos As Integer
    intPos = InStr(1, strVal, vbNullChar)
    Select Case intPos
        Case Is > 1
            dhTrimNull = Left$(strVal, intPos - 1)
        Case 0
            dhTrimNull = strVal
        Case 1
            dhTrimNull = vbNullString
    End Select
End Function
