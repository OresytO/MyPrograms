VERSION 5.00
Begin VB.Form frmAddIn 
   Caption         =   "VB IDE Add In"
   ClientHeight    =   5760
   ClientLeft      =   2190
   ClientTop       =   1950
   ClientWidth     =   6015
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   5760
   ScaleWidth      =   6015
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdRefresh 
      Caption         =   "&Refresh"
      Height          =   375
      Left            =   4680
      TabIndex        =   7
      Top             =   240
      Width           =   1215
   End
   Begin VB.ListBox lstMembers 
      Height          =   2400
      Left            =   120
      TabIndex        =   5
      Top             =   3240
      Width           =   4335
   End
   Begin VB.ListBox lstComponents 
      Height          =   1815
      Left            =   120
      TabIndex        =   3
      Top             =   1080
      Width           =   4335
   End
   Begin VB.ComboBox cboProjects 
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   360
      Width           =   4335
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cl&ose"
      Height          =   375
      Left            =   4680
      TabIndex        =   0
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "&Members (double-click to view):"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   3000
      Width           =   3255
   End
   Begin VB.Label Label2 
      Caption         =   "&Components:"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "&Projects:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "frmAddIn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public IDEInstance As VBIDE.VBE

Private mprjCurrent As Project
Private mmodCurrent As Module

Private Sub cboProjects_Click()
    ' Updates the list of components for the selected project

    Dim modAny As Module
    Dim strTemp As String

    ' Declare a new project as the current one
    ' and set it equal to the selected VB project
    Set mprjCurrent = New Project
    Set mprjCurrent.VBProject = IDEInstance. _
     VBProjects(cboProjects.ListIndex + 1)
    
    ' Clear the list box and restock it with a list
    ' of the modules in the project
    lstComponents.Clear
    For Each modAny In mprjCurrent.Modules
        lstComponents.AddItem modAny.Name & _
         " (" & modAny.KindName & ")"
    Next
    
    ' If there are modules, select the first one
    ' in the list (this will trigger the Click event)
    If lstComponents.ListCount > 0 Then
        lstComponents.ListIndex = 0
    End If
End Sub

Private Sub cmdCancel_Click()
    ' Unload the form
    Unload Me
End Sub

Public Sub RefreshLists()
    ' Resets the list of projects
    
    Dim vbp As VBIDE.VBProject
    
    ' Clear the combo box and restock it with
    ' a list of loaded projects
    cboProjects.Clear
    For Each vbp In IDEInstance.VBProjects
        cboProjects.AddItem vbp.Name & " (" & _
         GetFileName(vbp) & ")"
    Next
    
    ' If there are projects, select the first one
    ' in the list (this will trigger the Click event)
    If cboProjects.ListCount > 0 Then
        cboProjects.ListIndex = 0
    End If
End Sub

Private Function GetFileName(vbp As VBIDE.VBProject) As String
    ' Returns the filename of a project--this is necessary
    ' because the FileName property raises an error for
    ' unsaved projects
    
    On Error Resume Next
    GetFileName = vbp.FileName
    If Err.Number <> 0 Then
        GetFileName = "unknown"
    End If
End Function

Private Sub cmdRefresh_Click()
    ' Refresh the project list
    Call RefreshLists
End Sub

Private Sub lstComponents_Click()
    ' Updates the list of procedures in a module
    
    Dim prcAny As Procedure
    
    ' Set the current module to the selected on
    Set mmodCurrent = mprjCurrent.Modules( _
     lstComponents.ListIndex + 1)
    
    ' Clear the list box and restock it a list of
    ' procedures in the current module
    lstMembers.Clear
    
    ' make sure to include declarations
    lstMembers.AddItem "<declarations> (" & _
     mmodCurrent.Module.CountOfDeclarationLines & _
     " lines)"
    For Each prcAny In mmodCurrent.Procedures
        lstMembers.AddItem prcAny.Name & _
         " (" & prcAny.KindName & ", " & _
         prcAny.Lines & " lines)"
    Next
    
    ' If there are procedures, select the first one
    If lstMembers.ListCount > 0 Then
        lstMembers.ListIndex = 0
    End If
End Sub

Private Sub lstMembers_DblClick()
    ' Opens a new form displaying code from the module
    
    Dim frmNewCode As frmCode
    
    ' Create a new form and load the code from the
    ' selected procedure or declarations section
    Set frmNewCode = New frmCode
    If lstMembers.ListIndex > 0 Then
        With mmodCurrent.Procedures(lstMembers.ListIndex)
            frmNewCode.Code = .Code
            frmNewCode.CodeName = .Name & " (" & _
             .KindName & ")"
        End With
    Else
        frmNewCode.Code = mmodCurrent.Declarations
        frmNewCode.CodeName = "<declarations>"
    End If
    frmNewCode.Show
End Sub
