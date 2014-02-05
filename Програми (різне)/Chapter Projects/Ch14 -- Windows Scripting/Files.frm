VERSION 5.00
Begin VB.Form frmFiles 
   Caption         =   "Investigate Files"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8565
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   12
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   5325
   ScaleWidth      =   8565
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtFile 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   240
      Width           =   6015
   End
   Begin VB.CommandButton cmdChooseFile 
      Caption         =   "&Choose a File"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6240
      TabIndex        =   0
      Top             =   240
      Width           =   2175
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   5
      Left            =   2040
      TabIndex        =   25
      Top             =   2715
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Name:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   24
      Top             =   2715
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   4
      Left            =   2040
      TabIndex        =   23
      Top             =   2340
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Drive:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   22
      Top             =   2340
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   3
      Left            =   2040
      TabIndex        =   21
      Top             =   1965
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateLastModified:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   20
      Top             =   1965
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   2
      Left            =   2040
      TabIndex        =   19
      Top             =   1590
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateLastAccessed:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   18
      Top             =   1590
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   2040
      TabIndex        =   17
      Top             =   1215
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateCreated:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   16
      Top             =   1215
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   0
      Left            =   2040
      TabIndex        =   15
      Top             =   840
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Attributes:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   14
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   11
      Left            =   2040
      TabIndex        =   13
      Top             =   4965
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Type:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   11
      Left            =   120
      TabIndex        =   12
      Top             =   4965
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   10
      Left            =   2040
      TabIndex        =   11
      Top             =   4590
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Size:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   10
      Left            =   120
      TabIndex        =   10
      Top             =   4590
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   9
      Left            =   2040
      TabIndex        =   9
      Top             =   4215
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "ShortPath:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   9
      Left            =   120
      TabIndex        =   8
      Top             =   4215
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   8
      Left            =   2040
      TabIndex        =   7
      Top             =   3840
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "ShortName:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   8
      Left            =   120
      TabIndex        =   6
      Top             =   3840
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   7
      Left            =   2040
      TabIndex        =   5
      Top             =   3465
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Path:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   4
      Top             =   3465
      Width           =   1695
   End
   Begin VB.Label lblData 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Index           =   6
      Left            =   2040
      MousePointer    =   10  'Up Arrow
      TabIndex        =   3
      Top             =   3090
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "ParentFolder:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   2
      Top             =   3090
      Width           =   1695
   End
End
Attribute VB_Name = "frmFiles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Sub cmdChooseFile_Click()
    Dim cdlg As CommonDlg
    Set cdlg = New CommonDlg
    With cdlg
        .hWndOwner = Me.hWnd
        .Filter = "All Files (*.*)|*.*"
        .ShowOpen
        txtFile.Text = .FileName
    End With
    If Len(txtFile.Text) > 0 Then
        Call DisplayInfo
    End If
End Sub

Private Sub DisplayInfo()
    Dim fil As Scripting.File
    Dim fso As Scripting.FileSystemObject
    Dim varInfo As Variant
    Dim i As Integer
    
    Set fso = New Scripting.FileSystemObject
    Set fil = fso.GetFile(txtFile.Text)
    With fil
        For i = 0 To 11
            Select Case i
                Case 0
                    varInfo = .Attributes
                Case 1
                    varInfo = .DateCreated
                Case 2
                    varInfo = .DateLastAccessed
                Case 3
                    varInfo = .DateLastModified
                Case 4
                    varInfo = .Drive
                Case 5
                    varInfo = .Name
                Case 6
                    varInfo = .ParentFolder
                Case 7
                    varInfo = .Path
                Case 8
                    varInfo = .ShortName
                Case 9
                    varInfo = .ShortPath
                Case 10
                    varInfo = .Size
                Case 11
                    varInfo = .Type
            End Select
            lblData(i) = varInfo
        Next i
    End With
End Sub

Private Sub lblData_Click(Index As Integer)
    If Index = 6 Then   ' The ParentFolder property
        frmFolder.Folder = lblData(6).Caption
        frmFolder.Show vbModal
    End If
End Sub
