VERSION 5.00
Begin VB.Form frmFileFolderNames 
   Caption         =   "Manipulate File and Folder Names"
   ClientHeight    =   4935
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8880
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   4935
   ScaleWidth      =   8880
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Height          =   1455
      Left            =   60
      TabIndex        =   17
      Top             =   3420
      Width           =   8775
      Begin VB.Label Label8 
         Caption         =   "GetSpecialFolder"
         Height          =   255
         Left            =   60
         TabIndex        =   24
         Top             =   180
         Width           =   2295
      End
      Begin VB.Label lblSpecial 
         Caption         =   "WindowsFolder"
         Height          =   255
         Index           =   0
         Left            =   2580
         TabIndex        =   23
         Top             =   240
         Width           =   1935
      End
      Begin VB.Label lblSpecial 
         Caption         =   "SystemFolder"
         Height          =   255
         Index           =   1
         Left            =   2580
         TabIndex        =   22
         Top             =   660
         Width           =   1935
      End
      Begin VB.Label lblSpecial 
         Caption         =   "TemporaryFolder"
         Height          =   255
         Index           =   2
         Left            =   2580
         TabIndex        =   21
         Top             =   1080
         Width           =   1935
      End
      Begin VB.Label lblSpecialValue 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   0
         Left            =   4620
         TabIndex        =   20
         Top             =   180
         Width           =   3975
      End
      Begin VB.Label lblSpecialValue 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   1
         Left            =   4620
         TabIndex        =   19
         Top             =   600
         Width           =   3975
      End
      Begin VB.Label lblSpecialValue 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   2
         Left            =   4620
         TabIndex        =   18
         Top             =   1020
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2415
      Left            =   60
      TabIndex        =   6
      Top             =   960
      Width           =   8775
      Begin VB.CommandButton cmdSelect 
         Caption         =   "Select a File"
         Height          =   375
         Left            =   1020
         TabIndex        =   7
         Top             =   240
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "GetBaseName"
         Height          =   255
         Left            =   120
         TabIndex        =   16
         Top             =   720
         Width           =   2295
      End
      Begin VB.Label Label4 
         Caption         =   "GetDriveName"
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   1140
         Width           =   2295
      End
      Begin VB.Label Label5 
         Caption         =   "GetExtensionName"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   1560
         Width           =   2295
      End
      Begin VB.Label Label6 
         Caption         =   "GetParentFolderName"
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   1980
         Width           =   2295
      End
      Begin VB.Label lblFilePart 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   1
         Left            =   2580
         TabIndex        =   12
         Top             =   660
         Width           =   3975
      End
      Begin VB.Label lblFilePart 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   2
         Left            =   2580
         TabIndex        =   11
         Top             =   1080
         Width           =   3975
      End
      Begin VB.Label lblFilePart 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   3
         Left            =   2580
         TabIndex        =   10
         Top             =   1500
         Width           =   3975
      End
      Begin VB.Label lblFilePart 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   4
         Left            =   2580
         TabIndex        =   9
         Top             =   1920
         Width           =   3975
      End
      Begin VB.Label lblFilePart 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Index           =   0
         Left            =   2580
         TabIndex        =   8
         Top             =   240
         Width           =   6075
      End
   End
   Begin VB.CommandButton cmdTemp 
      Caption         =   "New Temp Name"
      Height          =   375
      Left            =   2580
      TabIndex        =   4
      Top             =   480
      Width           =   1995
   End
   Begin VB.CommandButton cmdFileVersion 
      Caption         =   "Select a File"
      Height          =   375
      Left            =   2580
      TabIndex        =   2
      Top             =   60
      Width           =   1995
   End
   Begin VB.Label lblTempName 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   4620
      TabIndex        =   5
      Top             =   480
      Width           =   3975
   End
   Begin VB.Label lblVersion 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   4620
      TabIndex        =   3
      Top             =   60
      Width           =   1935
   End
   Begin VB.Label Label9 
      Caption         =   "GetTempName"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   2295
   End
   Begin VB.Label Label7 
      Caption         =   "GetFileVersion"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2295
   End
End
Attribute VB_Name = "frmFileFolderNames"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private fso As Scripting.FileSystemObject

Private Sub cmdFileVersion_Click()
    Dim cdl As CommonDlg
    Dim strFile As String
    
    Set cdl = New CommonDlg
    
    cdl.Filter = "All files (*.*)|*.*"
    cdl.hWndOwner = Me.hWnd
    cdl.ShowOpen
    strFile = cdl.FileName
    If Len(strFile) > 0 Then
        lblVersion.Caption = fso.GetFileVersion(strFile)
    End If
    Set cdl = Nothing
End Sub

Private Sub cmdSelect_Click()
    Dim cdl As CommonDlg
    Dim strFile As String
    
    Set cdl = New CommonDlg
    
    cdl.Filter = "All files (*.*)|*.*"
    cdl.hWndOwner = Me.hWnd
    cdl.ShowOpen
    strFile = cdl.FileName
    lblFilePart(0).Caption = strFile
    Set cdl = Nothing
    
    lblFilePart(1).Caption = fso.GetBaseName(strFile)
    lblFilePart(2).Caption = fso.GetDriveName(strFile)
    lblFilePart(3).Caption = fso.GetExtensionName(strFile)
    lblFilePart(4).Caption = fso.GetParentFolderName(strFile)
    
End Sub

Private Sub cmdTemp_Click()
    lblTempName.Caption = fso.GetTempName
End Sub

Private Sub Form_Load()
    Set fso = New Scripting.FileSystemObject
    
    Me.lblSpecialValue(0) = fso.GetSpecialFolder(WindowsFolder)
    Me.lblSpecialValue(1) = fso.GetSpecialFolder(SystemFolder)
    Me.lblSpecialValue(2) = fso.GetSpecialFolder(TemporaryFolder)
    lblTempName.Caption = fso.GetTempName
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set fso = Nothing
End Sub
