VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Clipboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Clipboard class from Chapter 5

Private Declare Function IsClipboardFormatAvailable _
    Lib "user32" _
    (ByVal uFormat As Long) As Long
Private Declare Function OpenClipboard _
    Lib "user32" _
    (ByVal hWnd As Long) As Long
Private Declare Function GetClipboardData _
    Lib "user32" _
    (ByVal uFormat As Long) As Long
Private Declare Function GlobalSize _
    Lib "kernel32" _
    (ByVal hMem As Long) As Long
Private Declare Function GlobalLock _
    Lib "kernel32" _
    (ByVal hMem As Long) As Long
Private Declare Sub MoveMemory _
    Lib "kernel32" Alias "RtlMoveMemory" _
    (ByVal strDest As Any, _
    ByVal lpSource As Any, _
    ByVal Length As Long)
Private Declare Function GlobalUnlock _
    Lib "kernel32" _
    (ByVal hMem As Long) As Long
Private Declare Function CloseClipboard _
    Lib "user32" () As Long
Private Declare Function GlobalAlloc _
    Lib "kernel32" _
    (ByVal uFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function EmptyClipboard _
    Lib "user32" () As Long
Private Declare Function SetClipboardData _
    Lib "user32" _
    (ByVal uFormat As Long, ByVal hData As Long) As Long
Private Declare Function GlobalFree _
    Lib "kernel32" _
    (ByVal hMem As Long) As Long

Private Const GMEM_MOVABLE = &H2&
Private Const GMEM_DDESHARE = &H2000&
Private Const CF_TEXT = 1

'Error return codes
Public Enum ClipClassErrors
     ccClipboardFormatNotAvailable = 1
     ccCannotOpenClipboard = 2
     ccCannotGetClipboardData = 3
     ccCannotGlobalLock = 4
     ccCannotCloseClipboard = 5
     ccCannotGlobalAlloc = 6
     ccCannotEmptyClipboard = 7
     ccCannotSetClipboardData = 8
     ccCannotGlobalFree = 9
End Enum

Function SetText(Text As String) As Variant
    Dim varRet As Variant
    Dim fSetClipboardData As Boolean
    Dim hMemory As Long
    Dim lpMemory As Long
    Dim lngSize As Long

    varRet = False
    fSetClipboardData = False

    ' Get the length, including one extra for a CHR$(0)
    ' at the end.
    lngSize = Len(Text) + 1
    hMemory = GlobalAlloc(GMEM_MOVABLE Or _
        GMEM_DDESHARE, lngSize)
    If Not CBool(hMemory) Then
        varRet = CVErr(ccCannotGlobalAlloc)
        GoTo SetTextDone
    End If

    ' Lock the object into memory
    lpMemory = GlobalLock(hMemory)
    If Not CBool(lpMemory) Then
        varRet = CVErr(ccCannotGlobalLock)
        GoTo SetTextGlobalFree
    End If

    ' Move the string into the memory we locked
    Call MoveMemory(lpMemory, Text, lngSize)

    ' Don't send clipboard locked memory.
    Call GlobalUnlock(hMemory)

    ' Open the clipboard
    If Not CBool(OpenClipboard(0&)) Then
        varRet = CVErr(ccCannotOpenClipboard)
        GoTo SetTextGlobalFree
    End If

    ' Remove the current contents of the clipboard
    If Not CBool(EmptyClipboard()) Then
        varRet = CVErr(ccCannotEmptyClipboard)
        GoTo SetTextCloseClipboard
    End If

    ' Add our string to the clipboard as text
    If Not CBool(SetClipboardData(CF_TEXT, _
        hMemory)) Then
        varRet = CVErr(ccCannotSetClipboardData)
        GoTo SetTextCloseClipboard
    Else
        fSetClipboardData = True
    End If

SetTextCloseClipboard:
    ' Close the clipboard
    If Not CBool(CloseClipboard()) Then
        varRet = CVErr(ccCannotCloseClipboard)
    End If

SetTextGlobalFree:
    If Not fSetClipboardData Then
        'If we have set the clipboard data, we no longer own
        ' the object--Windows does, so don't free it.
        If CBool(GlobalFree(hMemory)) Then
            varRet = CVErr(ccCannotGlobalFree)
        End If
    End If

SetTextDone:
    SetText = varRet
End Function

Public Function GetText() As Variant
    Dim hMemory As Long
    Dim lpMemory As Long
    Dim strText As String
    Dim lngSize As Long
    Dim varRet As Variant

    varRet = ""

    ' Is there text on the clipboard? If not, error out.
    If Not CBool(IsClipboardFormatAvailable _
        (CF_TEXT)) Then
        varRet = CVErr(ccClipboardFormatNotAvailable)
        GoTo GetTextDone
    End If

    ' Open the clipboard
    If Not CBool(OpenClipboard(0&)) Then
        varRet = CVErr(ccCannotOpenClipboard)
        GoTo GetTextDone
    End If

    ' Get the handle to the clipboard data
    hMemory = GetClipboardData(CF_TEXT)
    If Not CBool(hMemory) Then
        varRet = CVErr(ccCannotGetClipboardData)
        GoTo GetTextCloseClipboard
    End If

    ' Find out how big it is and allocate enough space
    ' in a string
    lngSize = GlobalSize(hMemory)
    strText = Space$(lngSize)

    ' Lock the handle so we can use it
    lpMemory = GlobalLock(hMemory)
    If Not CBool(lpMemory) Then
        varRet = CVErr(ccCannotGlobalLock)
        GoTo GetTextCloseClipboard
    End If

    ' Move the information from the clipboard memory
    ' into our string
    Call MoveMemory(strText, lpMemory, lngSize)

    ' Truncate it at the first Null character because
    ' the value reported by lngSize is erroneously large
    strText = Left$(strText, InStr(1, strText, Chr$(0)) - 1)

    ' Free the lock
    Call GlobalUnlock(hMemory)

GetTextCloseClipboard:
    ' Close the clipboard
    If Not CBool(CloseClipboard()) Then
        varRet = CVErr(ccCannotCloseClipboard)
    End If

GetTextDone:
    If Not IsError(varRet) Then
        GetText = strText
    Else
        GetText = varRet
    End If
End Function

Property Get Text() As String
' Wrapper for GetText method
    
    Dim varRet As Variant
    
    varRet = Me.GetText
    If IsError(varRet) Then
        Err.Raise vbObjectError + varRet, , GetErrorText(CLng(varRet))
    Else
        Text = CStr(varRet)
    End If
End Property

Property Let Text(strText As String)
' Warpper for SetText method
    
    Dim varRet As Variant
    
    varRet = Me.SetText(strText)
    If IsError(varRet) Then
        Err.Raise vbObjectError + varRet, , GetErrorText(CLng(varRet))
    End If
End Property

Public Function GetErrorText(ErrorCode As ClipClassErrors) As String
' Returns the text associated with a clipboard errro code

    Select Case ErrorCode
        Case ccClipboardFormatNotAvailable
            GetErrorText = "Clipboard format not available"
        Case ccCannotOpenClipboard
            GetErrorText = "Cannot open clipboard"
        Case ccCannotGetClipboardData
            GetErrorText = "Cannot get clipboard data"
        Case ccCannotGlobalLock
            GetErrorText = "Cannot lock global memory"
        Case ccCannotCloseClipboard
            GetErrorText = "Cannot close clipboard"
        Case ccCannotGlobalAlloc
            GetErrorText = "Cannot allocate global memory"
        Case ccCannotEmptyClipboard
            GetErrorText = "Cannot empty clipboard"
        Case ccCannotSetClipboardData
            GetErrorText = "Cannot set clipboard data"
        Case ccCannotGlobalFree
            GetErrorText = "Cannot free global memory"
        Case Else
            GetErrorText = "unknown error"
    End Select
End Function
