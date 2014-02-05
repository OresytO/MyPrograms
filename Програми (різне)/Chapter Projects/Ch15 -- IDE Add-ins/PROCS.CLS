VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Procedures"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Procedures class from Chapter 15

Private mcolProcs As Collection
Private mobjModule As CodeModule

Private Sub Class_Initialize()
    Set mcolProcs = New Collection
End Sub

Property Get Count()
    Count = mcolProcs.Count
End Property

Public Function Item(Index As Variant) As Procedure
    On Error Resume Next
    Set Item = mcolProcs(Index)
End Function

Public Function Add(Name As String, Kind As Long) As Procedure
    On Error GoTo HandleError
    
    Dim objNewProc As New Procedure
    
    objNewProc.Name = Name
    objNewProc.Kind = Kind
    mcolProcs.Add objNewProc, Name & Kind
    
    Set Add = mcolProcs(Name & Kind)
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
    mcolProcs.Remove Index
End Sub

Property Get Module() As CodeModule
    Set Module = mobjModule
End Property
Property Set Module(objModule As CodeModule)
    ' Make sure the property hasn't been set
    If mobjModule Is Nothing Then
        ' Store the object pointer
        Set mobjModule = objModule
        ' Call the Refres method
        Refresh
    End If
End Property

Public Sub Refresh()
    Dim cLines As Long
    Dim lngType As Long
    Dim strProc As String
    Dim objProc As Procedure
    
    ' Clear out any existing objects
    Set mcolProcs = New Collection
    
    ' Use the private code module
    With mobjModule
        ' Loop through all the lines
        For cLines = 1 To .CountOfLines
        
            ' If a procedure is on this line
            ' add it to the collection
            strProc = .ProcOfLine(cLines, lngType)
            If strProc <> "" Then
                
                ' Add a new Procedure object
                Set objProc = Add(strProc, lngType)
                
                ' Set its Code property
                objProc.Code = .Lines(cLines, _
                 .ProcCountLines(strProc, lngType))
                 
                ' Skip to the next line after
                ' this procedure
                cLines = cLines + _
                 .ProcCountLines(strProc, lngType) - 1
            End If
        Next
    End With
End Sub
