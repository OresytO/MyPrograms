VERSION 5.00
Begin VB.Form frmFolder 
   Caption         =   "Folder Information"
   ClientHeight    =   6060
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8580
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
   ScaleHeight     =   6060
   ScaleWidth      =   8580
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   495
      Left            =   7200
      TabIndex        =   24
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label lblCaption 
      Caption         =   "IsRootFolder:"
      Height          =   255
      Index           =   12
      Left            =   120
      TabIndex        =   27
      Top             =   3000
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   12
      Left            =   2040
      TabIndex        =   26
      Top             =   3000
      Width           =   6375
   End
   Begin VB.Label lblFolder 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   120
      TabIndex        =   25
      Top             =   120
      Width           =   6855
   End
   Begin VB.Label lblCaption 
      Caption         =   "ParentFolder:"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   23
      Top             =   3810
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   6
      Left            =   2040
      TabIndex        =   22
      Top             =   3810
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Path:"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   21
      Top             =   4185
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   7
      Left            =   2040
      TabIndex        =   20
      Top             =   4185
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "ShortName:"
      Height          =   255
      Index           =   8
      Left            =   120
      TabIndex        =   19
      Top             =   4560
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   8
      Left            =   2040
      TabIndex        =   18
      Top             =   4560
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "ShortPath:"
      Height          =   255
      Index           =   9
      Left            =   120
      TabIndex        =   17
      Top             =   4935
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   9
      Left            =   2040
      TabIndex        =   16
      Top             =   4935
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Size:"
      Height          =   255
      Index           =   10
      Left            =   120
      TabIndex        =   15
      Top             =   5310
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   10
      Left            =   2040
      TabIndex        =   14
      Top             =   5310
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Type:"
      Height          =   255
      Index           =   11
      Left            =   120
      TabIndex        =   13
      Top             =   5685
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   11
      Left            =   2040
      TabIndex        =   12
      Top             =   5685
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Attributes:"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   11
      Top             =   1080
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   0
      Left            =   2040
      TabIndex        =   10
      Top             =   1080
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateCreated:"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   9
      Top             =   1455
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   1
      Left            =   2040
      TabIndex        =   8
      Top             =   1455
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateLastAccessed:"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   7
      Top             =   1830
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   2
      Left            =   2040
      TabIndex        =   6
      Top             =   1830
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "DateLastModified:"
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   5
      Top             =   2205
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   3
      Left            =   2040
      TabIndex        =   4
      Top             =   2205
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Drive:"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   3
      Top             =   2580
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   4
      Left            =   2040
      TabIndex        =   2
      Top             =   2580
      Width           =   6375
   End
   Begin VB.Label lblCaption 
      Caption         =   "Name:"
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   1
      Top             =   3435
      Width           =   1695
   End
   Begin VB.Label lblData 
      Height          =   255
      Index           =   5
      Left            =   2040
      TabIndex        =   0
      Top             =   3435
      Width           =   6375
   End
End
Attribute VB_Name = "frmFolder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Sub cmdOK_Click()
    Unload Me
End Sub

Public Property Let Folder(Value As String)
    lblFolder.Caption = Value
    Call DisplayInfo
End Property

Private Sub DisplayInfo()
    Dim fld As Scripting.Folder
    Dim fso As Scripting.FileSystemObject
    Dim varInfo As Variant
    Dim i As Integer
    
    Set fso = New Scripting.FileSystemObject
    Set fld = fso.GetFolder(lblFolder.Caption)
    With fld
        For i = 0 To 12
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
                Case 12
                    varInfo = .IsRootFolder
            End Select
            lblData(i) = varInfo
        Next i
    End With
End Sub

