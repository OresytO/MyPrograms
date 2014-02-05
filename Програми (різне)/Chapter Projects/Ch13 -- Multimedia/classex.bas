Attribute VB_Name = "basClassExamples"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 13

Sub dhTestCD()

    ' Test procedure to demonstrate CDPlayer class.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a

    Dim cd As CDPlayer
    Dim bytTrack As Byte
    
    ' Create a new instance
    Set cd = New CDPlayer
    With cd
    
        ' Make sure the device is ready
        If .IsReady Then
            
            ' Print CD and track information
            Debug.Print "Media ID: " & .MediaID
            Debug.Print .Tracks & " tracks"
            Debug.Print "=========="
            For bytTrack = 1 To .Tracks
                Debug.Print "Track " & bytTrack & ": " & _
                Format(.TrackTime(bytTrack), "nn:ss")
            Next
            
            ' Start playback
            .Play
            
            ' Print the current position
            Debug.Print .Track & " " & .Minute & _
             ":" & Format(.Second, "00")
            
            ' Move to second track
            .Position Track:=2
            
            ' Pause playback
            .Pause
            
            ' Skip ahead to the 1 minute mark
            .Position Minute:=1
            
            ' Restart playback
            .Play
            
            ' Stop playback
            .StopPlaying
        End If
    End With
    
    ' Terminate instance
    Set cd = Nothing
End Sub

Sub dhTestWave()

    ' Test procedure to demonstrate WavePlayer class.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a

    Dim wav As WavePlayer
    
    ' Create new instance
    Set wav = New WavePlayer
    With wav
    
        ' Open and play a saved .WAV file
        .OpenFile "C:\Windows\Media\Chord.wav"
        .Play
    
        ' Reset the device and record for 3 seconds
        .Reset
        .SampleRate = 22050
        .BitsPerSample = 16
        .Record Milliseconds:=3000
        
        ' Play the recorded sound
        .Play
        
        ' Now remove the middle 1 second
        .Delete StartTime:=1000, Milliseconds:=1000
        
        ' Play it again and then save it
        .Play
        .SaveAs "C:\NEWWAVE.WAV"
    End With

    ' Terminate instance
    Set wav = Nothing
End Sub

