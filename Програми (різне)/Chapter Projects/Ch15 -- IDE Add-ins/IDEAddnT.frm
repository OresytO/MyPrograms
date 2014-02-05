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
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      Height          =   375
      Left            =   4680
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cl&ose"
      Height          =   375
      Left            =   4680
      TabIndex        =   0
      Top             =   720
      Width           =   1215
   End
End
Attribute VB_Name = "frmAddIn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public IDEInstance As VBIDE.VBE

Private Sub cmdCancel_Click()
    ' Unload the form
    Unload Me
End Sub


Private Sub cmdRefresh_Click()
    ' Your code goes here

End Sub

