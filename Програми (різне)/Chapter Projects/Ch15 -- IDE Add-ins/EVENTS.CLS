VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CBarEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' CBarEvents class from Chapter 15

' Create event sinks for the two buttons
Public WithEvents CodePaneInfoButton As CommandBarEvents
Attribute CodePaneInfoButton.VB_VarHelpID = -1
Public WithEvents ListCommandBarsButton As CommandBarEvents
Attribute ListCommandBarsButton.VB_VarHelpID = -1

Private Sub CodePaneInfoButton_Click( _
 ByVal CommandBarControl As Object, _
 handled As Boolean, CancelDefault As Boolean)

    Call dhCodePaneInfo
End Sub

Private Sub ListCommandBarsButton_Click( _
 ByVal CommandBarControl As Object, _
 handled As Boolean, CancelDefault As Boolean)

    Call dhListCommandBars
End Sub
