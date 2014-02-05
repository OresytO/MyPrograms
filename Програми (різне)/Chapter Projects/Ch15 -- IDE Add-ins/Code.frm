VERSION 5.00
Begin VB.Form frmCode 
   Caption         =   "Code"
   ClientHeight    =   4995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7950
   LinkTopic       =   "Form1"
   ScaleHeight     =   4995
   ScaleWidth      =   7950
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtCode 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   120
      Width           =   1695
   End
End
Attribute VB_Name = "frmCode"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Property Let CodeName(strName As String)
    Me.Caption = strName
End Property

Property Let Code(strCode As String)
    txtCode.Text = strCode
End Property

Private Sub Form_Resize()
    txtCode.Move 0, 0, Me.ScaleWidth, Me.ScaleHeight
End Sub

