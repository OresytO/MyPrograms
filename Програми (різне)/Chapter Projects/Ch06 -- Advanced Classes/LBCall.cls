VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ListBoxCallback"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Implements ITextFileCallback

' Property that determines what list box to write to
Public TargetList As MSForms.ListBox

Private Function ITextFileCallback_ReadLine( _
 Text As String) As Boolean

    ' Add a line of text to the list
    If Not TargetList Is Nothing Then
        TargetList.AddItem Text
    
        ' Return success
        ITextFileCallback_ReadLine = True
    End If
End Function

Private Sub ITextFileCallback_AfterOpen()
    ' This method has no implementation
End Sub

Private Function ITextFileCallback_BeforeClose() As Boolean
    ' This method has no implementation--just return True
    ITextFileCallback_BeforeClose = True
End Function

Private Function ITextFileCallback_WriteLine( _
 Text As String) As Boolean

    ' This method has no implementation--just return True
    ITextFileCallback_WriteLine = True
End Function


