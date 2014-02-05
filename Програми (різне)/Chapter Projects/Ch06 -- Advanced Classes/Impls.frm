VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmImplements 
   Caption         =   "Custom Callback"
   ClientHeight    =   6570
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9045
   OleObjectBlob   =   "frmImplements.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmImplements"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Sub cmdOpen_Click()
    Dim objFile As TextFile4
    Dim objLBCallback As ListBoxCallback

    ' Initialize the text file class
    Set objFile = New TextFile4
    
    ' Initialze and set up the callback class
    Set objLBCallback = New ListBoxCallback
    Set objLBCallback.TargetList = Me.lstLines
        
    ' Set TextFile4's callback object
    Set objFile.Callback = objLBCallback
    
    ' Clear the list box
    Me.lstLines.Clear
    
    ' Open the file
    objFile.Path = Me.txtFile.Text
    objFile.FileOpen
    
    ' Destroy the pointer
    Set objFile = Nothing
End Sub

