VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WavePlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' WavePlayer class from Chapter 13

Private mlngDevID As Long
Private mlngWait As Long

Private Declare Function mciSendCommand _
 Lib "winmm.dll" Alias "mciSendCommandA" _
 (ByVal wDeviceID As Long, ByVal uMessage As Long, _
 ByVal dwParam1 As Long, dwParam2 As Any) As Long

Private Sub Class_Initialize()
    Call OpenDevice
End Sub

Private Sub Class_Terminate()
    Call CloseDevice
End Sub

Property Get Wait() As Boolean
    Wait = (mlngWait = MCI_WAIT)
End Property
Property Let Wait(bWait As Boolean)
    mlngWait = Abs(bWait) * MCI_WAIT
End Property

Private Sub CloseDevice()
    Dim lngRet As Long
    
    If mlngDevID Then
        
        ' Close the device
        lngRet = mciSendCommand(mlngDevID, MCI_CLOSE, 0&, 0&)
        If lngRet = 0 Then
            mlngDevID = 0
        Else
            Err.Raise lngRet, "WavePlayer::CloseDevice", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub OpenFile(WaveFile As String)
    Call OpenDevice(WaveFile)
End Sub

Private Sub OpenDevice(Optional strFile As String = "")
    Dim lngRet As Long
    Dim mwo As MCI_WAVE_OPEN_PARMS
    
    If mlngDevID Then
    
        ' Close the device
        Call CloseDevice
    End If
    
    ' Set member variables
    With mwo
        .strDeviceType = "waveaudio"
        .strElementName = strFile
        .lngBufferSeconds = 10
    End With
    
    ' Load the requested file
    lngRet = mciSendCommand(mlngDevID, MCI_OPEN, _
     MCI_OPEN_ELEMENT Or MCI_OPEN_TYPE, mwo)
    If lngRet = 0 Then
        mlngDevID = mwo.lngDeviceID
    Else
        Err.Raise lngRet, "WavePlayer::OpenDevice", _
         dhMCIError(lngRet)
    End If
End Sub

Public Sub Play(Optional StartTime As Long, _
 Optional StopTime As Long)
 
    Dim mpp As MCI_PLAY_PARMS
    Dim lngLength As Long
    Dim lngRet As Long
    
    If mlngDevID Then
        
        ' Validate inputs
        lngLength = Length()
        If StartTime < 0 Or StartTime > lngLength Then
            StartTime = 0
        End If
        If StopTime <= StartTime Or StopTime > lngLength Then
            StopTime = lngLength
        End If
        
        ' Play the wave file
        mpp.lngFrom = StartTime
        mpp.lngTo = StopTime
        lngRet = mciSendCommand(mlngDevID, MCI_PLAY, _
         MCI_FROM Or MCI_TO Or mlngWait, mpp)
        If lngRet <> 0 Then
            Err.Raise lngRet, "WavePlayer::Play", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub Delete(StartTime As Long, _
 Milliseconds As Long)
 
    Dim mdp As MCI_WAVE_DELETE_PARMS
    Dim lngLength As Long
    Dim lngRet As Long
    
    If mlngDevID Then
        
        ' Validate inputs
        lngLength = Length()
        If StartTime < 0 Or StartTime > lngLength Then
            StartTime = 0
        End If
        
        ' Delete the specified portion
        With mdp
            .lngFrom = StartTime
            .lngTo = StartTime + Milliseconds
            If .lngTo > lngLength Then
                .lngTo = lngLength
            End If
        End With
        lngRet = mciSendCommand(mlngDevID, MCI_DELETE, _
         MCI_FROM Or MCI_TO, mdp)
        If lngRet <> 0 Then
            Err.Raise lngRet, "WavePlayer::Delete", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub Record( _
 Optional Milliseconds As Integer = 0, _
 Optional StartTime As Long = -1, _
 Optional Overwrite As Boolean = False)
 
    Dim mrp As MCI_RECORD_PARMS
    Dim lngLength As Long
    Dim lngFlags As Long
    Dim lngRet As Long
    
    If mlngDevID And Milliseconds >= 0 Then
        
        ' If StartTime is -1, get current position
        lngLength = Length
        If StartTime < 0 Or StartTime > lngLength Then
            StartTime = Position
        End If
        
        ' Set flag values
        If Milliseconds > 0 Then
            lngFlags = MCI_FROM Or MCI_TO Or MCI_WAIT
            If Overwrite Then
                lngFlags = lngFlags Or MCI_RECORD_OVERWRITE
            Else
                lngFlags = lngFlags Or MCI_RECORD_INSERT
            End If
        End If
        
        ' Record for a given number of seconds
        With mrp
            .lngFrom = StartTime
            .lngTo = StartTime + Milliseconds
        End With
        lngRet = mciSendCommand(mlngDevID, MCI_RECORD, _
         lngFlags, mrp)
        If lngRet <> 0 Then
            Err.Raise lngRet, "WavePlayer::Record", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub SaveAs(Filename As String)
    If Filename <> "" Then
        Call SaveFile(Filename)
    End If
End Sub

Public Sub Save()
    Dim strFile As String
    
    ' Use the current filename
    strFile = Me.Filename
    Call SaveAs(strFile)
End Sub

Private Sub SaveFile(strFile As String)
    Dim lngRet As Long
    Dim msp As MCI_SAVE_PARMS
    
    If mlngDevID Then
        
        ' Save the file
        msp.lpFileName = strFile
        lngRet = mciSendCommand(mlngDevID, MCI_SAVE, _
         MCI_SAVE_FILE Or MCI_WAIT, msp)
        If lngRet <> 0 Then
            Err.Raise lngRet, "WavePlayer::SaveFile", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Property Get Filename() As String
    Filename = dhMCIInfo(mlngDevID, MCI_INFO_FILE)
End Property

Property Get Length() As Long
    Length = dhMCIStatus(mlngDevID, MCI_STATUS_LENGTH)
End Property

Property Get Channels() As Byte
    Channels = CByte(dhMCIStatus(mlngDevID, MCI_WAVE_STATUS_CHANNELS))
End Property
Property Let Channels(bytChan As Byte)
    Select Case bytChan
        Case 1, 2
            Call ChangeSetting(MCI_WAVE_STATUS_CHANNELS, CLng(bytChan))
    End Select
End Property

Property Get FormatTag() As Long
    FormatTag = dhMCIStatus(mlngDevID, MCI_WAVE_STATUS_FORMATTAG)
End Property
Property Let FormatTag(lngTag As Long)
    Call ChangeSetting(MCI_WAVE_STATUS_FORMATTAG, lngTag)
End Property

Property Get SampleRate() As Long
    SampleRate = dhMCIStatus(mlngDevID, MCI_WAVE_STATUS_SAMPLESPERSEC)
End Property
Property Let SampleRate(lngRate As Long)
    Select Case lngRate
        Case 11025, 22050, 44100
            Call ChangeSetting(MCI_WAVE_STATUS_SAMPLESPERSEC, lngRate)
    End Select
End Property

Property Get BitsPerSample() As Byte
    BitsPerSample = dhMCIStatus(mlngDevID, MCI_WAVE_STATUS_BITSPERSAMPLE)
End Property
Property Let BitsPerSample(bytBits As Byte)
    Select Case bytBits
        Case 8, 16
            Call ChangeSetting(MCI_WAVE_STATUS_BITSPERSAMPLE, CLng(bytBits))
    End Select
End Property

Property Get AvgBytesPerSecond()
    AvgBytesPerSecond = dhMCIStatus(mlngDevID, MCI_WAVE_STATUS_AVGBYTESPERSEC)
End Property

Private Sub ChangeSetting(lngSetting As Long, lngNewValue As Long)
    Dim mws As MCI_WAVE_SET_PARMS
    Dim lngRet As Long
    
    ' Make sure device ID is valid
    If mlngDevID Then
    
        ' Use the MCI_WAVE_SET_PARMS structure
        With mws
        
            ' Get the existing values
            .intFormatTag = Me.FormatTag
            .intBitsPerSample = Me.BitsPerSample
            .intChannels = Me.Channels
            .lngSamplesPerSec = Me.SampleRate
            
            ' Change the desired setting
            Select Case lngSetting
                Case MCI_WAVE_STATUS_FORMATTAG
                    .intFormatTag = lngNewValue
                Case MCI_WAVE_STATUS_CHANNELS
                    .intChannels = lngNewValue
                Case MCI_WAVE_STATUS_SAMPLESPERSEC
                    .lngSamplesPerSec = lngNewValue
                Case MCI_WAVE_STATUS_BITSPERSAMPLE
                    .intBitsPerSample = lngNewValue
            End Select
            
            ' Compute derived settings
            .lngAvgBytesPerSec = ((.intBitsPerSample / 8) * _
             .intChannels * .lngSamplesPerSec)
            .intBlockAlign = ((.intBitsPerSample / 8) * _
             .intChannels)
            
            ' Call mciSendCommand
            lngRet = mciSendCommand(mlngDevID, MCI_SET, _
             MCI_WAIT Or MCI_WAVE_SET_FORMATTAG Or _
             MCI_WAVE_SET_BITSPERSAMPLE Or _
             MCI_WAVE_SET_CHANNELS Or _
             MCI_WAVE_SET_SAMPLESPERSEC Or _
             MCI_WAVE_SET_AVGBYTESPERSEC Or _
             MCI_WAVE_SET_BLOCKALIGN, mws)
             
            If lngRet <> 0 Then
                Err.Raise lngRet, "WavePlayer::ChangeSetting", _
                 dhMCIError(lngRet)
            End If
        End With
    End If
End Sub

Property Get Position() As Long
    Position = dhMCIStatus(mlngDevID, MCI_STATUS_POSITION)
End Property

Public Sub StopRecording()
    Dim lngRet As Long
    
    If mlngDevID Then
        ' Stop recording by issuing the MCI_STOP command
        lngRet = mciSendCommand(mlngDevID, MCI_STOP, 0&, 0&)
        If lngRet <> 0 Then
            Err.Raise lngRet, "WavePlayer::StopRecording", _
             dhMCIError(lngRet)
        End If
    End If
End Sub

Public Sub Reset()
    OpenDevice
End Sub
