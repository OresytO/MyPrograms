VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VideoPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' VideoPlayer class from Chapter 13

Private mlngDevID As Long
Private mHwnd As Long
Private mstrCaption As String
Private mfStretch As Boolean

Private Declare Function mciSendCommand _
 Lib "winmm.dll" Alias "mciSendCommandA" _
 (ByVal wDeviceID As Long, ByVal uMessage As Long, _
 ByVal dwParam1 As Long, dwParam2 As Any) As Long

Private Declare Function GetClientRect Lib "user32" _
 (ByVal hWnd As Long, lpRect As RECT) As Long

Private Sub Class_Initialize()
    Call OpenDevice
End Sub

Private Sub OpenDevice(Optional strFile As String)
    Dim lngRet As Long
    Dim mop As MCI_OPEN_PARMS
    Dim lngFlags As Long
    
    ' If we're already open then close
    If mlngDevID Then
        Call CloseDevice
    End If
    
    ' Set device type and alias
    mop.strDeviceType = "avivideo"
    mop.strElementName = strFile
    
    ' Open the device
    lngFlags = MCI_OPEN_TYPE
    If Len(strFile) Then
        lngFlags = lngFlags Or MCI_OPEN_ELEMENT
    End If
    lngRet = mciSendCommand(0&, MCI_OPEN, lngFlags, mop)
    If lngRet = 0 Then
        
        ' Store the device id
        mlngDevID = mop.lngDeviceID
                
    Else
        Err.Raise lngRet, "VideoPlayer::OpenDevice", _
         dhMCIError(lngRet)
    End If
End Sub

Private Sub Class_Terminate()
    Call CloseDevice
End Sub

Private Sub CloseDevice()
    Dim lngRet As Long
    Dim rc As RECT
    
    If mlngDevID Then
        ' If the Video is playing, stop it
        If IsPlaying Then
            StopPlaying
        End If
        
        ' Close the device
        lngRet = mciSendCommand(mlngDevID, MCI_CLOSE, 0&, 0&)
        If lngRet = 0 Then
            mlngDevID = 0
        Else
            Err.Raise lngRet, "VideoPlayer::CloseDevice", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Property Get Filename() As String
    Filename = dhMCIInfo(mlngDevID, MCI_INFO_FILE)
End Property

Public Sub OpenFile(AVIFile As String)
    Call OpenDevice(AVIFile)
End Sub

Public Sub Play()
    Dim lngRet As Long
    Dim mpp As MCI_PLAY_PARMS
    
    If mlngDevID Then
    
        lngRet = mciSendCommand(mlngDevID, MCI_PLAY, _
         0&, 0&)
        
        If lngRet <> 0 Then
            Err.Raise lngRet, "VideoPlayer::Play", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub StopPlaying()
    Dim lngRet As Long
    
    If mlngDevID Then
        lngRet = mciSendCommand(mlngDevID, MCI_STOP, 0&, 0&)
        If lngRet <> 0 Then
            Err.Raise lngRet, "VideoPlayer::StopPlaying", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Property Get IsPlaying() As Boolean
    IsPlaying = (dhMCIStatus(mlngDevID, MCI_STATUS_MODE) = MCI_MODE_PLAY)
End Property

Property Get Length() As Long
    Length = (dhMCIStatus(mlngDevID, _
     MCI_STATUS_LENGTH) / 30) * 1000
End Property

Property Get hWnd() As Long
    hWnd = mHwnd
End Property
Property Let hWnd(hWnd As Long)
    Dim mow As MCI_OVLY_WINDOW_PARMS
    Dim lngFlags As Long
    Dim lngRet As Long
    
    If mlngDevID Then
        ' Set default flags
        lngFlags = MCI_OVLY_WINDOW_HWND
        
        ' Set stretch flag
        If mfStretch Then
            lngFlags = lngFlags Or _
             MCI_OVLY_WINDOW_ENABLE_STRETCH
        Else
            lngFlags = lngFlags Or _
             MCI_OVLY_WINDOW_DISABLE_STRETCH
        End If
        
        ' Set the window handle and, optionally, the caption
        mow.hWnd = hWnd
        If Len(mstrCaption) Then
            mow.strText = mstrCaption
            lngFlags = lngFlags Or _
             MCI_OVLY_WINDOW_TEXT
        End If
        
        ' Issue the MCI_WINDOW command
        lngRet = mciSendCommand(mlngDevID, MCI_WINDOW, _
         lngFlags, mow)
        
        ' If successful, store the window handle
        If lngRet = 0 Then
            mHwnd = hWnd
        Else
            mHwnd = 0
            Err.Raise lngRet, "VideoPlayer::hWnd (Let)", _
             dhMCIError(lngRet)
        End If
    End If
End Property

Property Get Caption() As String
    Caption = mstrCaption
End Property
Property Let Caption(strCaption As String)
    mstrCaption = strCaption
End Property

Public Sub Center()
    Dim morSource As MCI_OVLY_RECT_PARMS
    Dim morDest As MCI_OVLY_RECT_PARMS
    Dim rc As RECT
    Dim lngRet As Long
    
    ' Make sure we've got something loaded and that
    ' the user has specified a window
    If mlngDevID And Len(Me.Filename) > 0 And _
     CBool(mHwnd) Then
    
        ' Issue the MCI_WHERE command to get the
        ' size of the current .AVI file
        lngRet = mciSendCommand(mlngDevID, MCI_WHERE, _
         MCI_OVLY_WHERE_SOURCE, morSource)
        If lngRet = 0 Then
        
            ' Get the available client area
            If CBool(GetClientRect(mHwnd, rc)) Then
            
                ' Do the math to center the image
                With rc
                    morDest.rc.Top = (.Bottom - .Top - _
                     morSource.rc.Bottom) / 2
                    morDest.rc.Left = (.Right - .Left - _
                    morSource.rc.Right) / 2
                End With
                
                ' Issue the MCI_PUT command to place the
                ' output at the computed position in the
                ' destination window
                lngRet = mciSendCommand(mlngDevID, _
                 MCI_PUT, MCI_OVLY_PUT_DESTINATION Or _
                 MCI_OVLY_RECT, morDest)
                If lngRet <> 0 Then
                    Err.Raise lngRet, "VideoPlayer::Center", _
                     dhMCIError(lngRet)
                End If
            Else
                Err.Raise lngRet, "VideoPlayer::Center", _
                 dhMCIError(lngRet)
            End If
        Else
            Err.Raise lngRet, "VideoPlayer::Center", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Property Get Stretch() As Boolean
    Stretch = mfStretch
End Property
Property Let Stretch(fStretch As Boolean)
    mfStretch = fStretch
End Property

