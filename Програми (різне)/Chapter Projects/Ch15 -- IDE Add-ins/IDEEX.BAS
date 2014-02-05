Attribute VB_Name = "basIDEExamples"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 15

Private mobjEvents As New CBarEvents

Sub dhShowVBEVersion()

    ' Displays the current VBE version.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhShowVBEVersion

    Dim objVBE As VBIDE.VBE
    
    Set objVBE = Application.VBE
    MsgBox objVBE.Version, vbInformation
End Sub

Sub dhUndockAllWindows()

    ' Undocks all the docked windows in the VBE.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhUndockAllWindows

    Dim intWindow As Integer
    
    ' Use the LinkedWindows collection of the
    ' VBE object's MainWindow
    With Application.VBE.MainWindow.LinkedWindows
    
        ' Loop backward through each linked
        ' window, removing it from the collection
        For intWindow = .Count To 1 Step -1
            .Remove .Item(intWindow)
        Next
    End With
End Sub

Sub dhDockAllWindows()

    ' Docks all visible, dockable windows in the VBE.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhDockAllWindows

    On Error GoTo HandleError
    
    Dim objWindow As VBIDE.Window
    
    Const conErrCantDock = &H80004005
    
    ' Use the VBE object
    With Application.VBE
    
        ' Loop through all its windows
        For Each objWindow In .Windows
        
            ' If the window is visible, dock it by
            ' adding it to the LinkedWindows collection
            If objWindow.Visible Then
                .MainWindow.LinkedWindows.Add objWindow
            End If
        Next
    End With
    
ExitHere:
    Exit Sub
HandleError:
    Select Case Err.Number
        ' Check for error when adding
        ' a window that can't be docked
        Case conErrCantDock
            Resume Next
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number
            Resume ExitHere
    End Select
End Sub

Sub dhCodePaneInfo()

    ' Displays information on the active code pane.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhCodePaneInfo

    On Error GoTo ExitHere

    Dim lngRowStart As Long
    Dim lngColStart As Long
    Dim lngRowEnd As Long
    Dim lngColEnd As Long

    ' Use the active code pane
    With Application.VBE.ActiveCodePane
        ' Print window caption
        Debug.Print "Information on: " & .Window.Caption
        Debug.Print "=================================="
        
        ' Print visible lines and top line
        Debug.Print "Visible lines: " & .CountOfVisibleLines
        Debug.Print "Top line: " & .TopLine
        
        ' Print selection info
        Call .GetSelection(lngRowStart, lngColStart, _
         lngRowEnd, lngColEnd)
         
        Debug.Print "Selection:"
        Debug.Print "  Start line:   " & lngRowStart
        Debug.Print "  Start column: " & lngColStart
        Debug.Print "  End line:     " & lngRowEnd
        Debug.Print "  End column:   " & lngColEnd
    End With
ExitHere:
End Sub

Sub dhListCommandBars()

    ' Lists the VBA IDE's command bars.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhListCommandBars

    Dim cbr As CommandBar
    
    ' Loop through all command bars
    For Each cbr In Application.VBE.CommandBars
        ' Print the name and a space
        Debug.Print cbr.Name & " ";
        
        ' Print the type of command bar
        Select Case cbr.Type
            Case msoBarTypeMenuBar
                Debug.Print "(menu bar)"
            Case msoBarTypeNormal
                Debug.Print "(normal/toolbar)"
            Case msoBarTypePopup
                Debug.Print "(popup)"
        End Select
    Next
End Sub

Sub dhMoveBarAround()

    ' Moves the Standard command bar around the screen.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhMoveBarAround

    Dim intPos As Integer
    Dim datNow As Date
    
    ' Use the "Standard" command bar
    With Application.VBE.CommandBars("Standard")
        ' Move it around the four sides
        For intPos = msoBarLeft To msoBarBottom
            
            .Position = intPos
            
            ' Wait for a second
            DoEvents
            datNow = Now
            Do Until Now > DateAdd("s", 1, datNow)
            Loop
        Next
    End With
End Sub

Sub dhCreateNewBar()

    ' Creates a new command bar.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhCreateNewBar

    Dim ctlNew As CommandBarButton
    
    ' Built in command bar buttons
    Const dhCBCode = 488
    Const dhCBCascade = 1826
    
    ' Use the CommandBars collection
    With Application.VBE.CommandBars
        ' Delete the "Custom" command bar
        ' If this fails then it doesn't exist
        On Error Resume Next
        .Item("Custom").Delete
        On Error GoTo 0
        
        ' Add a new command bar and use it
        With .Add("Custom", msoBarFloating)
            
            ' Use its Controls collection
            With .Controls
                ' Add a button for "Code"
                Set ctlNew = .Add(msoControlButton, _
                 dhCBCode)
                
                ' Change the default properties
                With ctlNew
                    .Caption = "CodePane Info"
                    .TooltipText = "Print CodePane Info"
                End With
                
                ' Hook up event sink
                Set mobjEvents.CodePaneInfoButton = _
                 Application.VBE.Events. _
                 CommandBarEvents(ctlNew)
                
                ' Add a button for "Cascade"
                Set ctlNew = .Add(msoControlButton, _
                 dhCBCascade)
                
                ' Change the default properties
                With ctlNew
                    .Caption = "Command Bars"
                    .TooltipText = "List Command Bars"
                End With
                
                ' Hook up event sink
                Set mobjEvents.ListCommandBarsButton = _
                 Application.VBE.Events. _
                 CommandBarEvents(ctlNew)
                
            End With
            
            ' Make the command bar visible
            .Visible = True
            
        End With
    End With
End Sub

Sub dhPrintIDs()

    ' Prints the IDs of all the built-in command bar buttons
    ' to a text file.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintIDs

    Dim i As Integer
    Dim hFile As Long
    
    hFile = FreeFile
    Open "C:\CBarNums.txt" For Output Access Write As hFile
    
    With Application.VBE.CommandBars("Custom").Controls
        For i = 2 To 3518
            With .Add(msoControlButton, i)
                Print #hFile, i, .Caption
                .Delete
            End With
        Next
    End With
    Close hFile
End Sub

Sub dhPrintReferences()

    ' Prints reference information to the Immediate window.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintReferences

    Dim ref As Reference
    
    ' Iterate the references of the active project
    For Each ref In Application.VBE. _
     ActiveVBProject.References
     
        ' Use each reference and print:
        ' Name and version
        '    Description
        '    Built-in or custom?
        '    Project or typelib?
        '    Broken or intact?
        '    Full path
        '    GUID
        With ref
            Debug.Print .Name & " " & .Major & "." & .Minor
            If Not .IsBroken Then
                Debug.Print "    " & .Description
            End If
            Debug.Print "    "; IIf(.BuiltIn, "Built-in/", _
             "Custom/");
            Debug.Print IIf(.Type = vbext_rk_Project, _
             "Project/", "TypeLib/");
            Debug.Print IIf(.IsBroken, "Broken!", "Intact")
            Debug.Print "    "; .FullPath
            Debug.Print "    "; IIf(.Type = _
             vbext_rk_TypeLib, .GUID, "")
        End With
    Next
End Sub

Sub dhRemoveAllBadRefs()

    ' Removes all the broken references from a project.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhRemoveAllBadRefs

    Dim ref As Reference
    
    ' Use the active project
    With Application.VBE.ActiveVBProject
    
        ' Iterate through the references
        For Each ref In .References
     
            ' If reference is broken, remove it
            If ref.IsBroken Then
                .References.Remove ref
            End If
        Next
    End With
End Sub

Sub dhDumpComps(vbp As VBProject)

    ' Dumps information on the VBComponents of the given
    ' VBProject to the Immediate window.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   vbp
    '       Reference to a VBProject object.
    '       (E.g. "Application.VBE.ActiveVBProject")
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhDumpComps(Application.VBE.ActiveVBProject)

    Dim vbc As VBComponent
    
    ' Loop through each component in the project
    For Each vbc In vbp.VBComponents
    
        ' Print the component's name
        Debug.Print vbc.Name & " (";
        
        ' Print the component's type
        Select Case vbc.Type
            Case vbext_ct_StdModule
                Debug.Print "Standard Module";
            Case vbext_ct_ClassModule
                Debug.Print "Class Module";
            Case vbext_ct_MSForm
                Debug.Print "User Form";
            Case vbext_ct_Document
                Debug.Print "Document";
            Case 11 'vbext_ct_ActiveXDesigner
                Debug.Print "ActiveX Designer";
            Case Else
                Debug.Print "Unknown"
        End Select
        Debug.Print ")"
    Next
End Sub

Sub dhDumpProps(vbc As VBComponent)

    ' Dumps the property values of the specified VBComponent
    ' object to the Immediate window.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   vbc
    '       Pointer to a VBComponent object.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhDumpProps(Application.VBE.ActiveVBProject. _
    '    VBComponents(1)

    On Error GoTo HandleError

    Dim prp As Property
    Dim var As Variant
    Dim fReadingValue As Boolean
    
    Const dhcPadding = 25
    
    ' Iterate the properties of the given
    ' component and print the names and values
    For Each prp In vbc.Properties
    
        ' Use each property
        With prp
        
            ' Print the property name, padded
            ' with spaces
            If Len(.Name) >= dhcPadding Then
                Debug.Print .Name & " ";
            Else
                Debug.Print .Name & _
                 Space(dhcPadding - Len(.Name));
            End If
            
            ' Set a flag indicating we're about
            ' to try and read the actual value
            fReadingValue = True
            
            ' If this is a indexed property,
            ' print the number of indices
            If .NumIndices > 0 Then
                Debug.Print "<indexed (" & _
                 .NumIndices & ")>"
                 
            ' If the value is an object just print
            ' "<object>"
            ElseIf IsObject(.Value) Then
                Debug.Print "<object (" & _
                 TypeName(prp.Object) & ")>"
            
            ' If the value is an array, print
            ' each element
            ElseIf IsArray(.Value) Then
                For Each var In .Value
                    Debug.Print var,
                Next
                Debug.Print
                
            ' If the value is not an object
            ' or an array, just print it
            Else
                Debug.Print prp.Value
            End If
            
            ' Reset flag
            fReadingValue = False
        End With
NextProp:
    Next
ExitHere:
    Exit Sub
HandleError:
    ' If we were trying to read the value,
    ' print the error we got and move on
    If fReadingValue Then
        Debug.Print "<error " & Err.Number & _
         ": " & Err.Description & ">"
        Resume NextProp
    ' Otherwise, bail out
    Else
        MsgBox Err.Description, vbExclamation, _
         "Error " & Err.Number
        Resume ExitHere
    End If
End Sub

