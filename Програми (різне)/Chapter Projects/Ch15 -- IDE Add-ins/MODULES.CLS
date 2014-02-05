VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Modules"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Modules class from Chapter 15

Private mcolModules As Collection
Private mvbpProject As VBProject

Private Sub Class_Initialize()
    Set mcolModules = New Collection
End Sub

Property Get Count()
    Count = mcolModules.Count
End Property

Public Function Item(Index As Variant) As Module
    On Error Resume Next
    Set Item = mcolModules(Index)
End Function

Public Function Add(Name As String, Kind As Long, _
 Module As CodeModule) As Module
 
    On Error GoTo HandleError
    
    Dim objNewModule As New Module
        
    objNewModule.Name = Name
    objNewModule.Kind = Kind
    Set objNewModule.Module = Module
    mcolModules.Add objNewModule, objNewModule.Name
    
    Set Add = mcolModules(objNewModule.Name)
ExitHere:
    Exit Function
HandleError:
    Select Case Err.Number
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number
            Resume ExitHere
    End Select
End Function

Public Sub Remove(Index As Variant)
    On Error Resume Next
    mcolModules.Remove Index
End Sub

Property Get Project() As VBProject
    Set Project = mvbpProject
End Property
Property Set Project(vbpProject As VBProject)
    ' Make sure the property hasn't been set
    If mvbpProject Is Nothing Then
        ' Store the object pointer
        Set mvbpProject = vbpProject
        ' Call the Refresh method
        Refresh
    End If
End Property

Public Sub Refresh()
    Dim vbc As VBComponent
    
    ' Clear out any existing objects
    Set mcolModules = New Collection
    
    ' Loop through each component in the
    ' project, adding its module (if it has one)
    For Each vbc In mvbpProject.VBComponents
        If Not vbc.CodeModule Is Nothing Then
            Call Add(vbc.Name, _
             vbc.Type, vbc.CodeModule)
        End If
    Next
End Sub

