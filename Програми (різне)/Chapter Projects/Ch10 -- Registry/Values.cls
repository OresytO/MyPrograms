VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Values"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Values class from Chapter 10

' Private variable to store a pointer to the
' Key object that contains this collection
Private mobjParent As Key

' Private collection variable
Private mcolValues As New Collection

' API Functions
Private Declare Function RegEnumValue _
 Lib "advapi32.dll" Alias "RegEnumValueA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpValueName As String, lpcbValueName As Long, _
 lpReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Any) As Long
 
Private Declare Function RegDeleteValue _
 Lib "advapi32.dll" Alias "RegDeleteValueA" _
 (ByVal hKey As Long, ByVal lpValueName As String) As Long

Public Function Add(ByVal Name As String, _
 ByVal DataType As Variant, _
 Optional ByVal Value As Variant) As Value
 
    ' Create new Value instance
    Dim objValue As New Value
    
    ' Set the new Value's Parent property
    ' to point to the collection's Parent
    Set objValue.Parent = mobjParent
    
    ' Set the requisite property values
    objValue.Name = Name
    objValue.DataType = DataType
    
    ' If optional argument was supplied,
    ' set the Value property value
    If Not IsMissing(Value) Then
        objValue.Value = Value
    End If
    
    ' Add new instance to the collection,
    ' using its Name as the unique key
    mcolValues.Add objValue, objValue.Name
    
    ' Set the return value to reference the
    ' new object
    Set Add = objValue
End Function

Public Function Item(ByVal ID As Variant) As Value
    Set Item = mcolValues(ID)
End Function

Public Sub Remove(ByVal ID As Variant)
    Dim lngRet As Long
    
    ' Delete the value from the registry
    lngRet = RegDeleteValue(mobjParent.Handle, _
     mcolValues(ID).Name)
     
    ' If successful, remove it from the collection
    If lngRet = Success Then
        mcolValues.Remove ID
    End If
End Sub

Property Get Count() As Long
    Count = mcolValues.Count
End Property

Property Set Parent(objParent As Key)
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Property Get Parent() As Key
    Set Parent = mobjParent
End Property

Public Sub Refresh()
    Dim cEnum As Long
    Dim lngRet As Long
    Dim strNameBuff As String
    Dim lngLenNameBuff As Long
    Dim lngType As Long
    Dim abytData(1 To 2048) As Byte
    Dim lngLenData As Long
    Dim lngReserved As Long
    Dim objValue As Value
    
    ' Clear out existing values
    Set mcolValues = New Collection
    
    cEnum = 0
    Do
        ' Set up buffers
        strNameBuff = Space$(255)
        lngLenNameBuff = Len(strNameBuff)
        Erase abytData
        lngLenData = UBound(abytData)
        
        ' Call RegEnumValue
        lngRet = RegEnumValue(mobjParent.Handle, _
         cEnum, strNameBuff, lngLenNameBuff, _
         ByVal lngReserved, lngType, _
         abytData(1), lngLenData)

        ' Add new value to new key's Values collection
        If lngRet = Success Then
            Set objValue = Me.Add( _
             Left(strNameBuff, lngLenNameBuff), lngType)
        End If
         
        ' Increment subkey index
        cEnum = cEnum + 1
    Loop Until lngRet <> 0
End Sub
