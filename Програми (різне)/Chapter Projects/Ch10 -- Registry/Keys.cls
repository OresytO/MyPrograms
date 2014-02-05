VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Keys"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Keys class from Chapter 10

' Private variable for parent key
Private mobjParent As Key

' Private collection variable
Private mcolKeys As New Collection

' API Functions
Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Boolean
End Type

Private Declare Function RegEnumKeyEx _
 Lib "advapi32.dll" Alias "RegEnumKeyExA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpName As String, lpcbName As Long, _
 lpReserved As Long, ByVal lpClass As String, _
 lpcbClass As Long, lpftLastWriteTime As Any) As Long
 
Private Declare Function RegDeleteKey _
 Lib "advapi32.dll" Alias "RegDeleteKeyA" _
 (ByVal hKey As Long, ByVal lpSubKey As String) As Long

Private Declare Function RegCreateKeyEx _
 Lib "advapi32.dll" Alias "RegCreateKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulReserved As Long, ByVal lpClass As String, _
 ByVal dwOptions As Long, ByVal samDesired As Long, _
 lpSecurityAttributes As Any, _
 phkResult As Long, lpdwDisposition As Long) As Long

Public Function Add(ByVal Name As String) As Key
    Dim objKey As New Key
    Dim lngRet As Long
    Dim lngDisp As Long
    Dim hKey As Long
    
    ' Call RegCreateKey--for existing keys this will
    ' open them--for non-existant keys this will
    ' create them
    lngRet = RegCreateKeyEx(hKey:=mobjParent.Handle, _
     lpSubKey:=Name, ulReserved:=0&, _
     lpClass:="", dwOptions:=RegOptionNonVolatile, _
     samDesired:=KeyAllAccess, _
     lpSecurityAttributes:=0&, phkResult:=hKey, _
     lpdwDisposition:=lngDisp)
     
    ' If successful add key to the collection and
    ' set the return value to point to it
    If lngRet = Success Then
        objKey.Name = Name
        objKey.Handle = hKey
        Set objKey.Parent = mobjParent
        
        ' Add item for default value
        objKey.Values.Add "", RegSz
        
        mcolKeys.Add objKey, objKey.Name
        Set Add = objKey
    End If
End Function

Public Function Item(ByVal ID As Variant) As Key
    ' Return a pointer to the selected item
    Set Item = mcolKeys(ID)
End Function

Public Sub Remove(ByVal ID As Variant)
    Dim lngRet As Long
    Dim objSubKey As Key
    Dim lngSubKeys As Long
    Dim cSubKeys As Long

    ' This code removes all of the current key's
    ' subkeys by calling the Remove method recursively
    ' First refresh the subkeys
    mcolKeys(ID).SubKeys.Refresh
    
    ' Get a count (because the property will change)
    lngSubKeys = mcolKeys(ID).SubKeys.Count
    
    ' Loop through all the subkeys
    For cSubKeys = lngSubKeys To 1 Step -1
        ' Call Remove recursively
        mcolKeys(ID).SubKeys.Remove cSubKeys
    Next
    
    ' Call RegDeleteKey to delete the subkey
    lngRet = RegDeleteKey(mobjParent.Handle, _
     mcolKeys(ID).Name)
    ' If successful then remove it from the collection
    If lngRet = Success Then
        mcolKeys.Remove ID
    End If
    
End Sub

Property Get Count() As Long
    ' Return the Collection object's Count property
    Count = mcolKeys.Count
End Property

Property Set Parent(objParent As Key)
    ' Write once property for key's Parent key
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Property Get Parent() As Key
    ' Return value of private variable
    Set Parent = mobjParent
End Property

Public Sub Refresh()
    Dim cEnum As Long
    Dim hKey As Long
    Dim lngAccessDesired  As Long
    Dim lngRet As Long
    Dim strNameBuff As String
    Dim lngLenNameBuff As Long
    Dim strClassBuff As String
    Dim lngLenClassBuff As Long
    Dim lngReserved As Long
    
    ' Clear out existing subkeys
    Set mcolKeys = New Collection
    
    cEnum = 0
    Do
        ' Set up buffers
        strNameBuff = Space$(255)
        lngLenNameBuff = Len(strNameBuff)
        strClassBuff = Space$(255)
        lngLenClassBuff = Len(strClassBuff)
        
        ' Call RegEnumKeyEx
        lngRet = RegEnumKeyEx(mobjParent.Handle, _
         cEnum, strNameBuff, lngLenNameBuff, _
         ByVal lngReserved, strClassBuff, lngLenClassBuff, ByVal 0&)

        ' Add the subkey to the collection
        If lngRet = Success Then
            Me.Add Left(strNameBuff, lngLenNameBuff)
        End If
         
        ' Increment subkey index
        cEnum = cEnum + 1
    Loop Until lngRet <> 0
End Sub

