Attribute VB_Name = "basCodeExamples"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 15

Sub dhListProcs(modAny As CodeModule)

    ' Lists all the procedures in the given code module.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   modAny
    '       Pointer to a VBE CodeModule object.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhListProcs(Application.VBE.ActiveVBProject. _
    '    VBComponents(1).CodeModule)

    Dim cLines As Long
    Dim lngType As Long
    Dim strProc As String
    
    ' Use the passed CodeModule
    With modAny
        ' Loop through all the code lines,
        ' looking for a procedure
        For cLines = 1 To .CountOfLines
        
            ' Get the name of the procedure
            ' on the current line
            strProc = .ProcOfLine(cLines, lngType)
            
            ' If non-blank we've found a proc
            If strProc <> "" Then
            
                ' Print the line number, proc
                ' name, and type
                Debug.Print "Line " & cLines, _
                 strProc & "(" & lngType & ")"
                
                ' Skip the code lines by adding the
                ' number lines in the proc (less one)
                ' to the current line number
                cLines = cLines + _
                 .ProcCountLines(strProc, lngType) - 1
            End If
        Next
    End With
End Sub

Sub dhNewModule()

    ' Creates a new stndard module in the active project.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Note:
    '   Call dhNewModule

    ' Use the active project
    With Application.VBE.ActiveVBProject
    
        ' Create and use a new module
        With .VBComponents.Add(vbext_ct_StdModule)
        
            ' Change the module name
            .Name = "basTest"
            
            ' Use the code module
            With .CodeModule
                
                ' Add a variable declaration
                .AddFromString "Global gintText As Integer"
                
                ' Add the contents of a file
                .AddFromFile "C:\TESTPROC.BAS"
            End With
        End With
    End With
End Sub

Sub dhAddCommentBlock()

    ' Adds a block of comments to a code module.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Note:
    '       Depends on the existence of a module called "basTest".
    ' Example:
    '   Call dhAddCommentBlock

    ' Use the sample module
    With Application.VBE.ActiveVBProject. _
     VBComponents("basTest").CodeModule
     
        ' Add a comment block
        .InsertLines 1, "'========================"
        .InsertLines 2, "' Created by me, " & Date
        .InsertLines 3, "'========================"
    End With
End Sub

Sub dhRemoveCommentBlock()

    ' Removes the comments added in dhAddCommentBlock.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhRemoveCommentBlock

    ' Remove comment block
    Application.VBE.ActiveVBProject. _
     VBComponents("basTest").CodeModule. _
     DeleteLines 1, 3
End Sub

Sub dhSampleEventProc()

    ' Creates an event procedure for a class module.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhSampleEventProc

    Dim lngStart As Long
    Dim strQuotes As String
    
    strQuotes = Chr(34)
    
    ' Create a new class module
    With Application.VBE.ActiveVBProject. _
     VBComponents.Add(vbext_ct_ClassModule).CodeModule
     
        ' Add a new event proc
        lngStart = .CreateEventProc("Initialize", "Class")
        
        ' Add some code
        .InsertLines lngStart + 1, "    ' This is a test"
        .InsertLines lngStart + 2, "    MsgBox " & _
         strQuotes & "Test" & strQuotes & ", " & _
         "vbInformation"
    End With
End Sub

Sub dhFindAndReplace(modAny As CodeModule)

    ' Example of replacing text in a module.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   modAny
    '       Pointer to a VBE CodeModule object.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhFindAndReplace(Application.VBE.ActiveVBProject. _
    '    VBComponents(1).CodeModule)

    Dim lngStartLine As Long
    Dim lngStartCol As Long
    Dim lngEndLine As Long
    Dim lngEndCol As Long
    Dim strLine As String
    
    Const dhcFind = "Copyright 2000"
    Const dhcReplace = "Copyright © 2000"
    
    ' Use the passed code module
    With modAny
    
        ' Set initial parameters
        lngStartLine = 1
        lngStartCol = 1
        lngEndLine = .CountOfLines
        lngEndCol = Len(.Lines(.CountOfLines, 1))
    
        ' Keep searching until no other
        ' occurrences are found
        Do While .Find(dhcFind, lngStartLine, _
         lngStartCol, lngEndLine, lngEndCol, True)
         
            ' Replace the line that contains
            ' the text with a new one
            strLine = .Lines(lngStartLine, 1)
            strLine = Left(strLine, lngStartCol - 1) & _
             dhcReplace & Mid(strLine, lngEndCol)
            .ReplaceLine lngStartLine, strLine
            
            ' Reset parameters
            lngStartLine = lngEndLine + 1
            lngStartCol = 1
            lngEndLine = .CountOfLines
            lngEndCol = Len(.Lines(.CountOfLines, 1))
        Loop
    End With
End Sub
