VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Log"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private mstrFile As String
Private mfActive As Boolean
Private mlngOptions As Long
Private mintSeverityLevel As Integer

Private Const conLogDateTime = 1
Private Const conLogSeverity = 2

Public Sub Output(Text As Variant, _
 Optional Severity As Integer = 9)
Attribute Output.VB_Description = "Prints text to the log file"
Attribute Output.VB_HelpID = 100
 
    ' Prints information to the log file
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   Text: The text to print
    '   Severity: Severity level of the information
    ' Out:
    '   Return Value: n/a
    ' Example:
    '   <object>.Output "Beginning process.", 5
    
    Dim hFile As Long
    Dim varText As Variant
    Dim varExisting As Variant
    
    On Error GoTo HandleError
    
    ' Only process this if the log is active
    If mfActive Then
    
        ' Build up text
        varText = Text
        If mlngOptions And conLogDateTime Then
            varText = Now & vbTab & varText
        End If
        If mlngOptions And conLogSeverity Then
            varText = Severity & vbTab & varText
        End If
    
        ' Process the log information if Severity
        ' meets or exceeeds SeverityLevel
        If Severity >= mintSeverityLevel Then
        
            ' If SeverityLevel is -1 then put up a message
            ' rather than writing text to the file
            If mintSeverityLevel = -1 Then
                MsgBox varText, vbInformation, "Log"
            Else
                ' Get file handle
                hFile = FreeFile
            
                ' Open file for append
                Open mstrFile For Append _
                 Access Write As hFile
                
                ' Print the output
                Print #hFile, varText
                
                ' Close the file
                Close hFile
            End If
        End If
    End If
ExitHere:
    Exit Sub
HandleError:
    mfActive = False
    Err.Raise vbObjectError + 8000, "Log::Output", _
     Err.Description
    Resume ExitHere
End Sub

Property Get File() As String
Attribute File.VB_Description = "File name for output file"
    ' Return the file name
    File = mstrFile
End Property
Property Let File(FileName As String)
    ' Store file name
    mstrFile = FileName
    
    ' Set the Active flag
    mfActive = True
End Property

Property Get Active() As Boolean
Attribute Active.VB_Description = "Controls whether or not logging is performed"
    Active = mfActive
End Property
Property Let Active(fActive As Boolean)
    mfActive = mfActive
End Property

Property Get Options() As Long
Attribute Options.VB_Description = "Logging options"
    Options = mlngOptions
End Property
Property Let Options(lngOptions As Long)
    mlngOptions = lngOptions
End Property

Property Get SeverityLevel() As Integer
    SeverityLevel = mintSeverityLevel
End Property
Property Let SeverityLevel(intLevel As Integer)
    mintSeverityLevel = intLevel
End Property

Private Sub Class_Initialize()
    mlngOptions = conLogDateTime + conLogSeverity
End Sub

Public Sub Reset()
Attribute Reset.VB_Description = "Deletes the current log file"
    On Error GoTo HandleError
    
    ' Delete the current log file if it exists
    If Len(Dir$(mstrFile)) > 0 Then
        Kill mstrFile
    End If
    
ExitHere:
    Exit Sub
HandleError:
    mfActive = False
    Err.Raise vbObjectError + 8001, "Log::Reset", _
     Err.Description
    Resume ExitHere
End Sub
