VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Win32Registry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Enum regConstants
    Success = 0 ' Success indicator
    RegMaxDataSize = 2048 ' Maximum size of string and binary data
End Enum

Enum regDataTypes
    RegNone = 0 ' No defined value type.
    RegSz = 1    ' A null-terminated string. It will be a Unicode or ANSI string, depending on whether you use the Unicode or ANSI functions.
    RegExpandSz = 2    ' A null-terminated string that contains unexpanded references to environment variables (for example, "%PATH%"). It will be a Unicode or ANSI string depending on whether you use the Unicode or ANSI functions.
    RegBinary = 3    ' Free form binary
    RegDWord = 4    ' 32-bit number
    RegDWordLittleEndian = 4    ' A 32-bit number in little-endian format (same as RegDWord).
    RegDWordBigEndian = 5 ' A 32-bit number in big-endian format.
    RegLink = 6 ' A Unicode symbolic link.
    RegMultiSz = 7 ' An array of null-terminated strings, terminated by two null characters.
    RegResourceList = 8 ' A device-driver resource list.
    RegFullResourceDescriptor = 9
    RegResourceRequirementsList = 10    ' Resource list in the hardware description
    RegOptionReserved = 0    ' Parameter is reserved
End Enum

Enum regOptions
    RegOptionNonVolatile = 0    ' Key is preserved when system is rebooted
    RegOptionVolatile = 1       ' Key is not preserved when system is rebooted
    RegOptionCreateLink = 2     ' Created key is a symbolic link
    RegOptionBackupRestore = 4  ' Open for backup or restore
End Enum

Enum regAccessFlags
    ReadControl = &H20000
    KeyQueryValue = &H1
    KeySetValue = &H2
    KeyCreateSubKey = &H4
    KeyEnumerateSubKeys = &H8
    KeyNotify = &H10
    KeyCreateLink = &H20
    KeyRead = &H20019
    KeyWrite = &H20006
    KeyExecute = &H20019
    KeyAllAccess = &H2003F
End Enum

Public Enum regHandles
    HKeyClassesRoot = &H80000000
    HKeyCurrentUser = &H80000001
    HKeyLocalMachine = &H80000002
    HKeyUsers = &H80000003
    HKeyPerformanceData = &H80000004
End Enum

' Private declares for simple registry functions
Private Declare Function RegOpenKeyEx _
 Lib "advapi32.dll" Alias "RegOpenKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulOptions As Long, ByVal samDesired As Long, _
 phkResult As Long) As Long
Private Declare Function RegCloseKey _
 Lib "advapi32.dll" _
 (ByVal hKey As Long) As Long
Private Declare Function RegCreateKeyEx _
 Lib "advapi32.dll" Alias "RegCreateKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulReserved As Long, ByVal lpClass As String, _
 ByVal dwOptions As Long, ByVal samDesired As Long, _
 lpSecurityAttributes As Any, phkResult As Long, _
 lpdwDisposition As Long) As Long
Private Declare Function RegSetValueEx _
 Lib "advapi32.dll" Alias "RegSetValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, ByVal dwType As Long, _
 lpData As Any, ByVal cbData As Long) As Long
Private Declare Function RegQueryValueEx _
 Lib "advapi32.dll" Alias "RegQueryValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Long) As Long
Private Declare Function RegEnumValue _
 Lib "advapi32.dll" Alias "RegEnumValueA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpValueName As String, lpcbValueName As Long, _
 lpReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Any) As Long

' Set this to False if you just want to use the
' simple functionality
#If True Then
Private mkeyMachine As Key
Private mkeyUser As Key
Private mkeyUsers As Key
Private mkeyClasses As Key

Private Sub Class_Initialize()
    ' Open the machine and user root keys
    Set mkeyMachine = New Key
    mkeyMachine.Handle = HKeyLocalMachine
    mkeyMachine.OpenKey
    
    Set mkeyUser = New Key
    mkeyUser.Handle = HKeyCurrentUser
    mkeyUser.OpenKey
    
    Set mkeyUsers = New Key
    mkeyUsers.Handle = HKeyUsers
    mkeyUsers.OpenKey
    
    Set mkeyClasses = New Key
    mkeyClasses.Handle = HKeyClassesRoot
    mkeyClasses.OpenKey
End Sub

Private Sub Class_Terminate()
    Set mkeyMachine = Nothing
    Set mkeyUser = Nothing
    Set mkeyUsers = Nothing
    Set mkeyClasses = Nothing
End Sub

Property Get KeyUser() As Key
    ' Return HKEY_CURRENT_USER
    Set KeyUser = mkeyUser
End Property
Property Get KeyMachine() As Key
    ' Return HKEY_LOCAL_MACHINE
    Set KeyMachine = mkeyMachine
End Property
Property Get KeyUsers() As Key
    ' Return HKEY_USERS
    Set KeyUsers = mkeyUsers
End Property
Property Get KeyClasses() As Key
    ' Return HKEY_CLASSES_ROOOT
    Set KeyClasses = mkeyClasses
End Property
#End If

Function ReadValue(hkeyRoot As regHandles, strSubKey As String, _
 strValue As String, Optional lngType As Long) As Variant
 
    Dim hSubKey As Long
    Dim lngResult As Long
    Dim lngValues As Long
    Dim lngBuffer As Long
    Dim strBuffer As String
    Dim cb As Long
    Dim abytData(1 To 2048) As Byte
    Dim cbData As Long
    
    ' Open the key
    lngResult = RegOpenKeyEx(hkeyRoot, strSubKey, _
     0&, KeyAllAccess, hSubKey)
    
    ' Make sure the call succeeded
    If lngResult = Success Then
    
        ' Find the value (necessary cause we
        ' don't know the data type)
        Do
            ' Set up buffers
            strBuffer = Space(255)
            cb = Len(strBuffer)
            Erase abytData
            cbData = UBound(abytData)
            lngType = 0
            
            ' Call RegEnumValue
            lngResult = RegEnumValue(hSubKey, lngValues, _
            strBuffer, cb, ByVal 0&, lngType, abytData(1), cbData)
            
            ' Print value name to Immediate window
            If lngResult = Success Then
                ' See if it's the one we're looking for
                If strValue = Left(strBuffer, cb) Then
                    
                    ' Get data based on type
                    Select Case lngType
                        Case RegDWord
                            ' Set size argument to size of Long
                            cb = Len(lngBuffer)
                            
                            ' Call RegQueryValueEx passing
                            ' address to Long Integer variable
                            lngResult = RegQueryValueEx( _
                             hSubKey, strValue, 0&, _
                             lngType, lngBuffer, cb)
                             
                            ' If successful, return value
                            If lngResult = Success Then
                                ReadValue = lngBuffer
                            End If
                        Case RegSz
                            ' Create a string buffer and set the
                            ' size variable to pass
                            strBuffer = Space(RegMaxDataSize)
                            cb = Len(strBuffer)
                            
                            ' Call RegQueryValueEx passing
                            ' address of string buffer
                            lngResult = RegQueryValueEx( _
                             hSubKey, strValue, 0&, _
                             lngType, ByVal strBuffer, cb)
                            
                            ' If successful, return portion of
                            ' buffer filled in by the function
                            If lngResult = Success Then
                                ReadValue = Left(strBuffer, cb - 1)
                            End If
                    Case Else
                            ReadValue = abytData
                    End Select
                End If
            End If

            lngValues = lngValues + 1
        Loop Until lngResult <> 0
        
        ' Close the Desktop key
        lngResult = RegCloseKey(hSubKey)
    End If
End Function

Function WriteValue(hkeyRoot As regHandles, strSubKey As String, _
 strValue As String, varValue As Variant) As Boolean
 
    Dim hSubKey As Long
    Dim lngResult As Long
    Dim lngDisp As Long
    
    ' Open the subkey
    lngResult = RegCreateKeyEx(hkeyRoot, _
     strSubKey, 0&, "", RegOptionNonVolatile, _
     KeyAllAccess, ByVal 0&, hSubKey, lngDisp)
    
    ' Make sure the call succeeded
    If lngResult = Success Then
        
        ' Save the value
        Select Case VarType(varValue)
            Case vbString
                lngResult = RegSetValueEx(hSubKey, strValue, _
                 0&, RegSz, ByVal CStr(varValue), Len(CStr(varValue)))
            Case vbByte, vbInteger, vbLong, vbSingle, vbDouble, vbDecimal
                lngResult = RegSetValueEx(hSubKey, strValue, _
                 0&, RegDWord, CLng(varValue), Len(lngDisp))
            Case vbByte + vbArray
                lngResult = RegSetValueEx(hSubKey, strValue, _
                 0&, RegBinary, varValue(LBound(varValue)), _
                 UBound(varValue) - LBound(varValue) + 1)
        End Select
        
        WriteValue = (lngResult = Success)
        
        ' Close the Desktop key
        lngResult = RegCloseKey(hSubKey)
    End If
End Function

