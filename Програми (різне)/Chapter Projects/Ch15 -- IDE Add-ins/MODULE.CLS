VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Module"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Module class from Chapter 15

Private mstrName As String
Private mlngKind As Long
Private mmodModule As CodeModule
Private mobjProcs As New Procedures
Private mstrDeclarations As String

Property Get Name() As String
    Name = mstrName
End Property
Property Let Name(strName As String)
    mstrName = strName
End Property

Property Get Kind() As Long
    Kind = mlngKind
End Property
Property Let Kind(lngKind As Long)
    Select Case lngKind
        Case vbext_ct_StdModule To vbext_ct_MSForm, vbext_ct_Document
            mlngKind = lngKind
    End Select
End Property

Property Get KindName() As String
    Select Case mlngKind
        Case vbext_ct_StdModule
            KindName = "Standard"
        Case vbext_ct_ClassModule
            KindName = "Class"
        Case vbext_ct_MSForm
            KindName = "Form"
        Case vbext_ct_Document
            KindName = "Document"
        Case Else
            KindName = "unknown type"
    End Select
End Property

Property Get Module() As CodeModule
    Set Module = mmodModule
End Property
Property Set Module(modModule As CodeModule)
    ' Make sure property hasn't been set
    If mmodModule Is Nothing Then
    
        ' Store the module pointer
        Set mmodModule = modModule
        
        ' Set the Module property of the
        ' Procedures collection
        Set mobjProcs.Module = modModule
        
        ' Read the declarations section
        mstrDeclarations = modModule. _
         Lines(1, modModule.CountOfDeclarationLines)
    End If
End Property

Property Get Declarations() As String
    Declarations = mstrDeclarations
End Property
Property Let Declarations(strDeclarations As String)
    mstrDeclarations = strDeclarations
End Property

Property Get Procedures() As Procedures
    Set Procedures = mobjProcs
End Property
