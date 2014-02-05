VERSION 5.00
Begin VB.Form frmSwitchboard 
   Caption         =   "Scripting Demo"
   ClientHeight    =   1560
   ClientLeft      =   45
   ClientTop       =   270
   ClientWidth     =   3345
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   10.5
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1560
   ScaleWidth      =   3345
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdFileFolderNames 
      Caption         =   "Manipulate File/Folder Names"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   432
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   3060
   End
   Begin VB.CommandButton cmdFiles 
      Caption         =   "Work with Files"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   432
      Left            =   120
      TabIndex        =   1
      Top             =   1080
      Width           =   3060
   End
   Begin VB.CommandButton cmdDrives 
      Caption         =   "Work with Drives"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   432
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   3060
   End
End
Attribute VB_Name = "frmSwitchboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Sub cmdDrives_Click()
    frmDrives.Show
End Sub

Private Sub cmdFileFolderNames_Click()
    frmFileFolderNames.Show
End Sub

Private Sub cmdFiles_Click()
    frmFiles.Show
End Sub

