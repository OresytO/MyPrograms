Attribute VB_Name = "basClassExamples"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 15

Sub dhUseProjectClass()

    ' Example of using the Project class module.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhUseProjectClass

    Dim objProject As Project
    
    ' Instantiate the project
    Set objProject = New Project

    ' Set the new Project object's
    ' VBProject property to the active project
    Set objProject.VBProject = _
     Application.VBE.ActiveVBProject
     
    ' Print the VBProject's name
    Debug.Print objProject.VBProject.Name
End Sub

Sub dhPrintProjectInfo()

    ' Uses the custom class modules to print information
    ' on the activeproject to the Immediate window.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintProjectInfo

    Dim objProject As Project
    Dim cModule As Long
    Dim cProc As Long

    Set objProject = New Project

    ' Set the new Project object's
    ' VBProject property to the active project
    Set objProject.VBProject = _
     Application.VBE.ActiveVBProject
      
    ' Print project information
    With objProject.VBProject
        Debug.Print "Information for: " & .Name
        Debug.Print " Description: " & .Description
        Debug.Print " HelpFile: " & .HelpFile
        Debug.Print " HelpContext: " & .HelpContextID
        Debug.Print " Reference count: " & .References.Count
    End With
    
    ' Print module and procedure info
    With objProject.Modules
        Debug.Print " Module count: " & .Count
        
        ' Loop through each module
        For cModule = 1 To .Count
        
            ' Print module info
            With .Item(cModule)
                Debug.Print " Module: " & .Name
                Debug.Print "  Type: " & .KindName
                
                ' Print procedure info
                With .Procedures
                    Debug.Print "  Procedures: " & .Count
                    
                    ' Loop through each procedure
                    For cProc = 1 To .Count
                    
                        ' Print procedure info
                        With .Item(cProc)
                            Debug.Print "   " & .Name & _
                             " (" & .KindName & ", " & _
                             .Lines & " lines)"
                        End With
                    Next
                End With
            End With
        Next
    End With
End Sub
