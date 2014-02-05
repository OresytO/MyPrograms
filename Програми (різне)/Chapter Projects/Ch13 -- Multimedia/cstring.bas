Attribute VB_Name = "basCommandString"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 13

Private Declare Function mciSendString _
 Lib "winmm.dll" Alias "mciSendStringA" _
 (ByVal lpstrCommand As String, _
 ByVal lpstrReturnString As String, _
 ByVal uReturnLength As Long, _
 ByVal hwndCallback As Long) As Long

Sub dhPlayMIDIFile(strFile As String)

    ' Plays a MIDI file using the MCI command string interface.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Name of MIDI file (must have .MID or .RMI extension).
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPlayMIDIFile("C:\WINDOWS\MEDIA\CANYON.MID")

    Dim strCommand As String
    Dim strRet As String
    Dim lngBytes As Long
    Dim lngRet As Long
    
    ' Open the file (must have a .MID or .RMI extension)
    strCommand = "open " & strFile & " alias seq"
    strRet = Space(255)
    lngRet = mciSendString(strCommand, strRet, lngBytes, 0&)
    
    ' If successful, start playback
    If lngRet = 0 Then
        strCommand = "play seq"
        strRet = Space(255)
        lngRet = mciSendString(strCommand, strRet, lngBytes, 0&)
    End If
    
    ' Close the device
    strCommand = "close seq"
    strRet = Space(255)
    lngRet = mciSendString(strCommand, strRet, lngBytes, 0&)
End Sub
