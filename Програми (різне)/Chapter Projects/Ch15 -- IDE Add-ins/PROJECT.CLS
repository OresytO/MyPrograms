VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Project"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Project class from Chapter 15

Private mvbpProject As VBProject
Private mobjModules As New Modules

Property Get VBProject() As VBProject
    Set VBProject = mvbpProject
End Property
Property Set VBProject(vbpProject As VBProject)
    If mvbpProject Is Nothing Then
        Set mvbpProject = vbpProject
        Set mobjModules.Project = vbpProject
    End If
End Property

Property Get Modules() As Modules
    Set Modules = mobjModules
End Property


