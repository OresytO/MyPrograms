VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsWordEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All Rights Reserved.
    
Option Explicit

Private WithEvents mobjWordApp As Word.Application
Attribute mobjWordApp.VB_VarHelpID = -1

Private Sub Class_Initialize()
    Set mobjWordApp = New Word.Application
    mobjWordApp.Visible = True
End Sub

Private Sub Class_Terminate()
    Set mobjWordApp = Nothing
End Sub

Private Sub mobjWordApp_DocumentBeforeClose(ByVal Doc As Word.Document, Cancel As Boolean)
    Debug.Print "Document being closed: " & Doc.Name
End Sub

Private Sub mobjWordApp_DocumentBeforeSave(ByVal Doc As Word.Document, SaveAsUI As Boolean, Cancel As Boolean)
    Debug.Print "Document being saved: " & Doc.Name
End Sub

Private Sub mobjWordApp_DocumentChange()
    On Error Resume Next
    Debug.Print "Document change. New document is " & _
     mobjWordApp.ActiveDocument.Name
End Sub

Private Sub mobjWordApp_DocumentOpen(ByVal Doc As Word.Document)
    Debug.Print "Document being opened: " & Doc.Name
End Sub

Private Sub mobjWordApp_NewDocument(ByVal Doc As Word.Document)
    Debug.Print "Document being created: " & Doc.Name
End Sub

Private Sub mobjWordApp_Quit()
    Debug.Print "Oh no! Word is quitting!"
End Sub
