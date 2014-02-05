VERSION 5.00
Begin VB.Form frmFileSystem 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Test the FileSystem Object"
   ClientHeight    =   4530
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5970
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4530
   ScaleWidth      =   5970
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox lstDrives 
      Height          =   3765
      Left            =   60
      TabIndex        =   0
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label12 
      Caption         =   "Select a drive:"
      Height          =   375
      Left            =   60
      TabIndex        =   23
      Top             =   60
      Width           =   1635
   End
   Begin VB.Label Label11 
      Caption         =   "Volume Name:"
      Height          =   315
      Left            =   1260
      TabIndex        =   22
      Top             =   3000
      Width           =   1875
   End
   Begin VB.Label Label10 
      Caption         =   "Total Size:"
      Height          =   315
      Left            =   1260
      TabIndex        =   21
      Top             =   4080
      Width           =   1875
   End
   Begin VB.Label Label9 
      Caption         =   "Share Name:"
      Height          =   315
      Left            =   1260
      TabIndex        =   20
      Top             =   2640
      Width           =   1875
   End
   Begin VB.Label Label8 
      Caption         =   "Serial Number:"
      Height          =   315
      Left            =   1260
      TabIndex        =   19
      Top             =   2280
      Width           =   1875
   End
   Begin VB.Label Label7 
      Caption         =   "Root Folder:"
      Height          =   315
      Left            =   1260
      TabIndex        =   18
      Top             =   1920
      Width           =   1875
   End
   Begin VB.Label Label6 
      Caption         =   "Path:"
      Height          =   315
      Left            =   1260
      TabIndex        =   17
      Top             =   1560
      Width           =   1875
   End
   Begin VB.Label Label5 
      Caption         =   "Is Ready:"
      Height          =   315
      Left            =   1260
      TabIndex        =   16
      Top             =   840
      Width           =   1875
   End
   Begin VB.Label Label4 
      Caption         =   "Free Space:"
      Height          =   315
      Left            =   1260
      TabIndex        =   15
      Top             =   3360
      Width           =   1875
   End
   Begin VB.Label Label3 
      Caption         =   "File System:"
      Height          =   315
      Left            =   1260
      TabIndex        =   14
      Top             =   1200
      Width           =   1875
   End
   Begin VB.Label Label2 
      Caption         =   "Drive Type:"
      Height          =   315
      Left            =   1260
      TabIndex        =   13
      Top             =   480
      Width           =   1875
   End
   Begin VB.Label Label1 
      Caption         =   "Available Space:"
      Height          =   315
      Left            =   1260
      TabIndex        =   12
      Top             =   3720
      Width           =   1875
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   10
      Left            =   3480
      TabIndex        =   11
      Top             =   3000
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Alignment       =   1  'Right Justify
      Height          =   315
      Index           =   9
      Left            =   3480
      TabIndex        =   10
      Top             =   4080
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   8
      Left            =   3480
      TabIndex        =   9
      Top             =   2640
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   7
      Left            =   3480
      TabIndex        =   8
      Top             =   2280
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   6
      Left            =   3480
      TabIndex        =   7
      Top             =   1920
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   5
      Left            =   3480
      TabIndex        =   6
      Top             =   1560
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   4
      Left            =   3480
      TabIndex        =   5
      Top             =   840
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Alignment       =   1  'Right Justify
      Height          =   315
      Index           =   3
      Left            =   3480
      TabIndex        =   4
      Top             =   3360
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   2
      Left            =   3480
      TabIndex        =   3
      Top             =   1200
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Height          =   315
      Index           =   1
      Left            =   3480
      TabIndex        =   2
      Top             =   480
      Width           =   2355
   End
   Begin VB.Label lblDriveInfo 
      Alignment       =   1  'Right Justify
      Height          =   315
      Index           =   0
      Left            =   3480
      TabIndex        =   1
      Top             =   3720
      Width           =   2355
   End
End
Attribute VB_Name = "frmFileSystem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private fso As Scripting.FileSystemObject

Private Sub Form_Load()
    Dim drv As Scripting.Drive
    
    On Error Resume Next
    
    Set fso = New Scripting.FileSystemObject
    
    For Each drv In fso.Drives
        lstDrives.AddItem drv.DriveLetter
    Next drv
    
    ' This will fail if the current
    ' drive is a UNC drive.
    lstDrives.Text = Left$(CurDir, 1)
End Sub

Private Sub lstDrives_Click()
    Dim drv As Scripting.Drive
    
    ' Some drives may not provide all
    ' the requested information. Punt
    ' on those drives.
    On Error Resume Next
    Set drv = fso.Drives(lstDrives.Text)
    
    Dim i As Integer
    Dim strValue As String
    
    For i = 0 To 10
        strValue = ""
        Select Case i
            Case 0
                strValue = Format$(drv.AvailableSpace, _
                 "#,##0")
            Case 1
                strValue = DriveType(drv.DriveType)
            Case 2
                strValue = drv.FileSystem
            Case 3
                strValue = Format$(drv.FreeSpace, "#,##0")
            Case 4
                strValue = IIf(drv.IsReady, "Yes", "No")
            Case 5
                strValue = drv.Path
            Case 6
                strValue = drv.RootFolder
            Case 7
                strValue = FormatHex(drv.SerialNumber)
            Case 8
                strValue = drv.ShareName
            Case 9
                strValue = Format$(drv.TotalSize, "#,##0")
            Case 10
                strValue = drv.VolumeName
        End Select
        lblDriveInfo(i).Caption = strValue
    Next i
End Sub

Private Function DriveType(lngType As Long) As String
    Select Case lngType
        Case CDRom
            DriveType = "CDRom"
        Case Fixed
            DriveType = "Fixed"
        Case RamDisk
            DriveType = "RamDisk"
        Case Remote
            DriveType = "Remote"
        Case Removable
            DriveType = "Removable"
        Case Unknown
            DriveType = "Unknown"
    End Select
End Function

Private Function FormatHex(lngValue As Long) As String
    Dim strTemp As String
    ' This guarantees that the string has 8 characters,
    ' left-padded with 0's.
    strTemp = Right$(String(8, "0") & Hex(lngValue), 8)
    FormatHex = Left$(strTemp, 4) & "-" & _
     Right$(strTemp, 4)
End Function
