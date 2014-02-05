VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmVideo 
   Caption         =   "Play a Video Clip"
   ClientHeight    =   4740
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7335
   OleObjectBlob   =   "frmVideo.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmVideo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' This is required to geta handle to the form
Private Declare Function GetActiveWindow _
 Lib "user32" () As Long

' Private instance of VideoPlayer class
Private vid As VideoPlayer

Private Sub cmdPlay_Click()
    ' Create a new instance
    Set vid = New VideoPlayer
    
    ' Open a file
    vid.OpenFile Me.txtAVI.Text
    
    ' Set the window and caption
    vid.Caption = "Digital Video"
    vid.hWnd = GetActiveWindow()
    
    ' Set the label caption to the file name
    Me.lblFileName.Caption = vid.Filename
    
    ' Center the video in the window and play it
    vid.Center
    vid.Play
End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, _
 CloseMode As Integer)
    
    ' If video is still playing, stop it
    If vid.IsPlaying Then
        vid.StopPlaying
    End If
End Sub

Private Sub UserForm_Terminate()
    ' Terminate the instance
    Set vid = Nothing
End Sub
