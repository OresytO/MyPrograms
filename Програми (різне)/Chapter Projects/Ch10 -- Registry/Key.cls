VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Key"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Key class from Chapter 10

' Private variables to hold property values
Private mstrName As String
Private mlngHandle As Long
Private mobjParent As Key

' Private references to collection classes
Private mobjSubKeys As New Keys
Private mobjValues As New Values

' API Functions
Private Declare Function RegCloseKey _
 Lib "advapi32" _
 (ByVal hKey As Long) As Long
Private Declare Function RegOpenKeyEx _
 Lib "advapi32.dll" Alias "RegOpenKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulOptions As regOptions, ByVal samDesired As _
 regAccessFlags, phkResult As Long) As Long

Property Get SubKeys() As Keys
    Set SubKeys = mobjSubKeys
End Property
Property Get Values() As Values
    Set Values = mobjValues
End Property

Property Let Name(ByVal strName As String)
    ' Write-once property for the key's name
    If Len(mstrName) = 0 Then
        mstrName = strName
        
        ' Set Handle property for special root keys
        Select Case strName
            Case "HKEY_CLASSES_ROOT"
                mlngHandle = HKeyClassesRoot
            Case "HKEY_CURRENT_USER"
                mlngHandle = HKeyCurrentUser
            Case "HKEY_LOCAL_MACHINE"
                mlngHandle = HKeyLocalMachine
            Case "HKEY_USERS"
                mlngHandle = HKeyUsers
            Case "HKEY_PERFORMANCE_DATA"
                mlngHandle = HKeyPerformanceData
        End Select
    End If
End Property

Property Get Name() As String
    ' Return Private variable value
    Name = mstrName
End Property

Property Let Handle(ByVal hKey As regHandles)
    ' Write-once property for the key's handle
    If mlngHandle = 0 Then
        mlngHandle = hKey
        
        ' Set Name property for special root keys
        Select Case hKey
            Case HKeyClassesRoot
                mstrName = "HKEY_CLASSES_ROOT"
            Case HKeyCurrentUser
                mstrName = "HKEY_CURRENT_USER"
            Case HKeyLocalMachine
                mstrName = "HKEY_LOCAL_MACHINE"
            Case HKeyUsers
                mstrName = "HKEY_USERS"
            Case HKeyPerformanceData
                mstrName = "HKEY_PERFORMANCE_DATA"
        End Select
    End If
End Property

Property Get Handle() As regHandles
    ' Return Private variable value
    Handle = mlngHandle
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

Public Function OpenKey() As Boolean
    Dim hKey As Long

    ' Attempt to open the key specified by mlngHandle
    If RegOpenKeyEx(mlngHandle, "", 0, _
     KeyAllAccess, hKey) = 0 Then
        
        ' Enumeric subkeys
        mobjSubKeys.Refresh
            
        ' Enumeric values
        mobjValues.Refresh
        
        OpenKey = (mlngHandle = hKey)
    End If
End Function

Public Function OpenSubKey(ByVal SubKey As Variant) As Key
    Dim hKey As Long
    Dim objKey As Key
    Dim lngAccessDesired  As Long
    
    ' Call RegOpenKeyEx to open the registry key
    If RegOpenKeyEx(mlngHandle, SubKey, 0, _
     KeyAllAccess, hKey) <> 0 Then
     
        Set OpenSubKey = Nothing
    Else
        ' Create new Key instance and set properties
        Set objKey = New Key
        objKey.Handle = hKey
        objKey.Name = SubKey
        Set objKey.Parent = Me
                        
        ' Enumeric subkeys
        objKey.SubKeys.Refresh
            
        ' Enumeric values
        objKey.Values.Refresh

        ' Set return value to new key
        Set OpenSubKey = objKey
    End If
End Function

Private Sub Class_Initialize()
    ' Set the Parent properties of the
    ' SubKeys and Values collections to point
    ' to this instance (using Me)
    Set SubKeys.Parent = Me
    Set Values.Parent = Me
End Sub

Private Sub Class_Terminate()
    ' If the key was opened then close it
    If mlngHandle > 0 Then
        Call RegCloseKey(mlngHandle)
    End If
End Sub

Public Function SubKeyExists(SubKey As String) As Boolean
    Dim hKey As Long
    
    If RegOpenKeyEx(mlngHandle, SubKey, 0, _
     KeyAllAccess, hKey) = 0 Then
        SubKeyExists = True
        Call RegCloseKey(hKey)
    End If
End Function

Property Get FullPath() As String
    Dim objParent As Key
    Dim strTemp As String
    
    ' Set starting point
    Set objParent = mobjParent
    
    ' Loop until objParent is Nothing (at the root)
    Do Until objParent Is Nothing
        strTemp = objParent.Name & "\" & strTemp
        Set objParent = objParent.Parent
    Loop
    
    ' Add this key's name
    strTemp = strTemp & mstrName

    ' Set return value
    FullPath = strTemp
End Property

Public Function DeleteSubkeys() As Boolean
    Dim objSubKey As Key
    Dim cSubKeys As Long

    ' Remove all the keys' subkeys
    For cSubKeys = mobjSubKeys.Count To 1 Step -1
        Set objSubKey = mobjSubKeys.Item(cSubKeys)
    
        ' Call DeleteSubkeys recursively
        objSubKey.DeleteSubkeys
        
    Next
End Function

