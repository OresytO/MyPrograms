VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmEvents 
   Caption         =   "Custom Events"
   ClientHeight    =   6570
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9045
   OleObjectBlob   =   "frmEvents.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' WithEvents declaration to establish event hook
Private WithEvents mobjFile As TextFile3
Attribute mobjFile.VB_VarHelpID = -1

Private Sub cmdOpen_Click()
    ' Reinitialize the class instance
    Set mobjFile = New TextFile3
    
    ' Clear the list box
    Me.lstLines.Clear
    
    ' Open the file
    mobjFile.Path = Me.txtFile.Text
    mobjFile.FileOpen
    
    ' Destroy the pointer
    Set mobjFile = Nothing
End Sub

Private Sub mobjFile_ReadLine(ByVal Text As String)
    ' Add the line to the list
    Me.lstLines.AddItem Text
End Sub

