Attribute VB_Name = "basAutomation"
' From Visual Basic Language Developer's Handbook
' by Getz and Gilbert. (Sybex)
' Copyright 2000. All Rights Reserved.
    
Option Explicit

Global gobjWordEvents As clsWordEvents

Sub InitWordEvents()
    Set gobjWordEvents = New clsWordEvents
End Sub

' Listing 12.1
Sub TestXL()
    Dim objXL As Excel.Application

    ' Create a new instance of Excel
    Set objXL = New Excel.Application

    ' Reference a few properties
    MsgBox objXL.Name & " " & objXL.Version
    objXL.Visible = True
    objXL.Quit
    Set objXL = Nothing
End Sub

' Listing 12.2
Sub TestXLDelayed()
    Dim objXL As New Excel.Application
    
    ' Excel is started on the next line automatically
    MsgBox objXL.Name & " " & objXL.Version
    objXL.Visible = True
    objXL.Quit
    Set objXL = Nothing
End Sub

' Listing 12.3
Sub TestXLLateBound()
    Dim objXL As Object
    
    ' This creates a new instance
    Set objXL = CreateObject("Excel.Application.9")
    
    ' The rest is pretty much the same as before
    MsgBox objXL.Name & " " & objXL.Version
    objXL.Visible = True
    objXL.Quit
    Set objXL = Nothing
End Sub

Sub TestXLExisting()
    Dim objXL As Excel.Application
    
    ' Use an existing instance (this will fail
    ' if Excel isn't running!)
    Set objXL = GetObject(, "Excel.Application.9")
    
    ' The rest is the same
    MsgBox objXL.Name & " " & objXL.Version
    objXL.Visible = True
    objXL.Quit
    Set objXL = Nothing
End Sub

