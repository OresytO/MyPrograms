Attribute VB_Name = "basFileIO"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' Type of Get/Put example
Private Type dhEmployee
    ID As Integer
    FirstName As String * 10
    LastName As String * 10
    Department As Integer
    HireDate As Date
    Salary As Currency
End Type

Sub dhTestOpen()

    ' Sample procedure demonstrating the VBA Open statement.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestOpen

    Dim hFile As Long
   
    ' Get a new file handle
    hFile = FreeFile
   
    ' Open a file for sequential access
    Open "C:\TESTPROC.BAS" For Input Access Read _
     Shared As hFile
    
    ' Do something here...
    
    ' Close the file
    Close hFile
End Sub

Sub dhPrintBytes(strFile As String)

    ' Prints the contents of a file, byte by byte.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintBytes("C:\AUTOEXEC.BAT")

    Dim hFile As Long
   
    ' Get a new file handle
    hFile = FreeFile
   
    ' Open the file for sequential access
    Open strFile For Input Access Read Shared As hFile
    
    ' Print the file contents
    Do Until EOF(hFile)
        Debug.Print Input(1, hFile);
    Loop
    
    ' Close the file
    Close hFile
End Sub

Sub dhPrintChunks(strFile As String, intSize As Integer)

    ' Prints the contents of a file, chunk by chunk.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    '   intSize
    '       Chunk size to use in bytes (bigger chunks mean faster execution).
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintChunks("C:\AUTOEXEC.BAT", 16)

    Dim hFile As Long
    Dim lngSize As Long
    Dim intChunk As Integer
    
    ' Get a new file handle
    hFile = FreeFile
   
    ' Open the file for sequential access
    Open strFile For Input Access Read Shared As hFile
    
    ' Get the file size
    lngSize = LOF(hFile)
    
    ' Print the file contents, first in chunks
    For intChunk = 1 To lngSize \ intSize
        Debug.Print Input(intSize, hFile);
    Next
    
    ' Then the remainder
    If (lngSize Mod intSize) > 0 Then
        Debug.Print Input((lngSize Mod intSize), hFile)
    End If
    
    ' Close the file
    Close hFile
End Sub

Sub dhPrintLines(strFile As String)

    ' Prints the contents of a file, line by line.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintLines("C:\AUTOEXEC.BAT")

    Dim hFile As Long
    Dim strLine As String
   
    ' Get a new file handle
    hFile = FreeFile
   
    ' Open the file for sequential access
    Open strFile For Input Access Read Shared As hFile
    
    ' Print the file contents
    Do Until EOF(hFile)
        Line Input #hFile, strLine
        Debug.Print strLine
    Loop
    
    ' Close the file
    Close hFile
End Sub

Sub dhWriteAndInput(strFile As String)

    ' Sample procedure demonstrating the VBA Write and Input statements.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       Path to an existing file.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhWriteAndInput("C:\TESTFILE.TXT")

    Dim hFile As Long
    ReDim varData(1 To 5) As Variant
    Dim i As Integer
    
    ' Open a file for output, write to it, and close it
    hFile = FreeFile
    Open strFile For Output Access Write As hFile
    Write #hFile, "Some Text", "A Date:", Date, "A Number", 100
    Close hFile
    
    ' Now open in back up for reading
    hFile = FreeFile
    Open strFile For Input Access Read As hFile
    Input #hFile, varData(1), varData(2), varData(3), _
     varData(4), varData(5)
    Close hFile
    
    ' Print the data
    For i = 1 To 5
        Debug.Print varData(i)
    Next
End Sub

Sub dhAddLineNumbers(strFileIn As String, strFileOut As String)

    ' Adds lines number to a file by opening it and writing
    ' it back to another file.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFileIn
    '       Path to source file.
    '   strFileOut
    '       Path to destination file.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhAddLineNumbers("C:\AUTOEXEC.BAT", "C:\AUTOEXEC.LIN")

    Dim hFileIn As Long
    Dim hFileOut As Long
    Dim strInput As String
    Dim i As Integer
    
    ' Open first file for input
    hFileIn = FreeFile
    Open strFileIn For Input Access Read As hFileIn
    
    ' Open the second file for output
    hFileOut = FreeFile
    Open strFileOut For Output Access Write As hFileOut
    
    ' Read each line from the input file, add a line
    ' number and write it the the output file
    Do Until EOF(hFileIn)
        i = i + 1
        Line Input #hFileIn, strInput
        Print #hFileOut, i & ":", strInput
    Loop
        
    ' Close the files
    Close hFileIn
    Close hFileOut
End Sub

Function dhSaveEmp(strFile As String, _
 empToSave As dhEmployee) As Boolean

    ' Sample function demonstrating random file access.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       File to save to.
    '   empToSave
    '       Pointer to dhEmployee structure.
    ' Out:
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Dim emp as dhEmployee
    '
    '   With emp
    '       .ID = 1
    '       .FirstName
    '       .LastName
    '   End With
    '
    '   Call dhSaveEmp("C:\EMP.DAT", emp)
 
    Dim hFile As Long
    Dim empIn As dhEmployee
    Dim lngRec As Long

    ' Open the file for random access
    hFile = FreeFile
    Open strFile For Random Access Read Write _
     As hFile Len = Len(empIn)
     
    ' Try to find the employee in existing records
    Do Until EOF(hFile)
        lngRec = lngRec + 1
        
        ' Read in the record
        Get hFile, lngRec, empIn
        
        ' Check IDs
        If empIn.ID = empToSave.ID Then
        
            ' Write the new data and get out
            Put hFile, lngRec, empToSave
            GoTo ExitHere
        End If
    Loop
    
    ' Record doesn't exist so write at end
    Put hFile, , empToSave
    
ExitHere:
    dhSaveEmp = True
    Close hFile
End Function

Function dhReadEmp(strFile As String, _
 emp As dhEmployee) As Boolean

    ' Sample function demonstrating random file access.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strFile
    '       File to read from.
    '   emp
    '       Pointer to dhEmployee structure.
    ' Out:
    '   Return Value:
    '       True if successful, False if not.
    ' Example:
    '   Dim emp As dhEmployee
    '
    '   emp.ID = 1
    '   Call dhReadEmp("C:\EMP.DAT", emp)
    
    Dim hFile As Long
    Dim empIn As dhEmployee
 
    ' Open file for random access
    hFile = FreeFile
    Open strFile For Random Access Read Write _
     As hFile Len = Len(empIn)
     
    ' Try to find the employee in existing records
    Do Until EOF(hFile)
        
        ' Read in the record
        Get hFile, , empIn
        
        ' Check IDs
        If empIn.ID = emp.ID Then
            emp = empIn
            dhReadEmp = True
            Exit Do
        End If
    Loop
    
    Close hFile
End Function

Sub dhTestRandom()

    ' Sample procedure demonstrating random file access.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhTestRandom

    Dim emp As dhEmployee
    
    Const dhcFile = "C:\EMP.DB"
    
    ' Save one employee record
    With emp
        .ID = 1
        .FirstName = "Mike"
        .LastName = "Gilbert"
        .Department = 100
        .Salary = 100000
        .HireDate = #1/1/1997#
    End With
    Call dhSaveEmp(dhcFile, emp)
    
    ' Save a second employee
    With emp
        .ID = 2
        .FirstName = "Ken"
        .LastName = "Getz"
        .Department = 200
        .Salary = 150000
        .HireDate = #1/1/1996#
    End With
    Call dhSaveEmp(dhcFile, emp)
    
    ' Read back the first record
    emp.ID = 1
    If dhReadEmp(dhcFile, emp) Then
    
        ' Raise salary and save again
        emp.Salary = emp.Salary * 1.1
        Call dhSaveEmp(dhcFile, emp)
    End If
End Sub

