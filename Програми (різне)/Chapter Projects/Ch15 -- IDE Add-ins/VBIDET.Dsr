VERSION 5.00
Begin {AC0714F6-3D04-11D1-AE7D-00A0C90F26F4} Addin 
   ClientHeight    =   9900
   ClientLeft      =   1740
   ClientTop       =   1545
   ClientWidth     =   11160
   _ExtentX        =   19685
   _ExtentY        =   17463
   _Version        =   393216
   Description     =   "VB IDE Add-In that lists projects, modules, and procedures"
   DisplayName     =   "VB IDE Add-In"
   AppName         =   "Visual Basic"
   AppVer          =   "6.0"
   LoadName        =   "Startup"
   LoadBehavior    =   1
   RegLocation     =   "HKEY_CURRENT_USER\Software\Microsoft\Visual Basic\6.0"
   CmdLineSupport  =   -1  'True
End
Attribute VB_Name = "Addin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Public IDEInstance As VBIDE.VBE

Private mfrmAddin As frmAddIn
Private WithEvents mcbeAddin As VBIDE.CommandBarEvents
Attribute mcbeAddin.VB_VarHelpID = -1
Private mcbbAddin As Office.CommandBarControl

Const conAddinMenuName = "IDE Add-in"

'------------------------------------------------------
' This method adds the Add-In to the IDE
'------------------------------------------------------
Private Sub AddinInstance_OnConnection( _
 ByVal Application As Object, _
 ByVal ConnectMode As ext_ConnectMode, _
 ByVal AddInInst As Object, _
 custom() As Variant)
 
    On Error GoTo HandleErrors
    
    Dim cbrAddins As Object
    Dim cbbNew As Office.CommandBarControl
    
    ' Store a pointer to the IDE
    Set IDEInstance = Application
    
    ' Create a new command bar button
    Set mcbbAddin = IDEInstance.CommandBars("Add-ins"). _
     Controls.Add(msoControlButton)
    mcbbAddin.Caption = conAddinMenuName
    
    ' Set its event hook
    Set mcbeAddin = IDEInstance.Events.CommandBarEvents(mcbbAddin)
    
    ' If launched from an external source (e.g. the
    ' wizard toolbar) show the form right away
    ' (VB IDE only)
    If ConnectMode = ext_cm_External Then
        Me.Show
    End If

ExitHere:
    Exit Sub
HandleErrors:
    Select Case Err.Number
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number & Err.Number & _
             " in Addin::OnConnection"
    End Select
    Resume ExitHere
End Sub

'------------------------------------------------------
'this method removes the Add-In from the IDE
'------------------------------------------------------
Private Sub AddinInstance_OnDisconnection( _
 ByVal RemoveMode As ext_DisconnectMode, _
 custom() As Variant)
 
    On Error Resume Next
    
    ' Delete the command bar button
    mcbbAddin.Delete
    
    ' Unload the form
    Unload mfrmAddin
End Sub

Public Sub Show()
    ' Load the form, give it a pointer to the IDE
    ' and show the form
    On Error GoTo HandleErrors
    
    Set mfrmAddin = New frmAddIn
    Set mfrmAddin.IDEInstance = Me.IDEInstance
        
    mfrmAddin.Show
ExitHere:
    Exit Sub
HandleErrors:
    Select Case Err.Number
        Case Else
            MsgBox Err.Description, vbExclamation, _
             "Error " & Err.Number & " in Addin::Show"
    End Select
    Resume ExitHere
End Sub

Public Sub Hide()
    ' Unload the form
    On Error Resume Next
    Unload mfrmAddin
End Sub

Private Sub mcbeAddin_Click( _
 ByVal CommandBarControl As Object, _
 handled As Boolean, _
 CancelDefault As Boolean)

    ' Show the form
    Me.Show
End Sub
