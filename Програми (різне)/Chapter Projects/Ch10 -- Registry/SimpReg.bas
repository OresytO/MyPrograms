Attribute VB_Name = "basSimpleRegistry"
Option Explicit

Private Declare Function dh_apiRegOpenKeyEx _
 Lib "advapi32.dll" Alias "RegOpenKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulOptions As Long, ByVal samDesired As Long, _
 phkResult As Long) As Long
Private Declare Function dh_apiRegCloseKey _
 Lib "advapi32.dll" Alias "RegCloseKey" _
 (ByVal hKey As Long) As Long
Private Declare Function dh_apiRegCreateKeyEx _
 Lib "advapi32.dll" Alias "RegCreateKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulReserved As Long, ByVal lpClass As String, _
 ByVal dwOptions As Long, ByVal samDesired As Long, _
 lpSecurityAttributes As Any, phkResult As Long, _
 lpdwDisposition As Long) As Long
Private Declare Function dh_apiRegSetValueEx _
 Lib "advapi32.dll" Alias "RegSetValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, ByVal dwType As Long, _
 lpData As Any, ByVal cbData As Long) As Long
Private Declare Function dh_apiRegQueryValueEx _
 Lib "advapi32.dll" Alias "RegQueryValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Long) As Long
Private Declare Function dh_apiRegEnumValue _
 Lib "advapi32.dll" Alias "RegEnumValueA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpValueName As String, lpcbValueName As Long, _
 lpReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Any) As Long
 
' Registry constants
Global Const dhcHKeyClassesRoot = &H80000000
Global Const dhcHKeyCurrentUser = &H80000001
Global Const dhcHKeyLocalMachine = &H80000002
Global Const dhcHKeyUsers = &H80000003
Global Const dhcHKeyPerformanceData = &H80000004

Global Const dhcSuccess = 0
Global Const dhcRegMaxDataSize = 2048
Global Const dhcRegNone = 0
Global Const dhcRegSz = 1
Global Const dhcRegExpandSz = 2
Global Const dhcRegBinary = 3
Global Const dhcRegDWord = 4
Global Const dhcRegDWordLittleEndian = 4
Global Const dhcRegDWordBigEndian = 5
Global Const dhcRegLink = 6
Global Const dhcRegMultiSz = 7
Global Const dhcRegResourceList = 8
Global Const dhcRegFullResourceDescriptor = 9
Global Const dhcRegResourceRequirementsList = 10
Global Const dhcRegOptionReserved = 0
Global Const dhcRegOptionNonVolatile = 0
Global Const dhcRegOptionVolatile = 1
Global Const dhcRegOptionCreateLink = 2
Global Const dhcRegOptionBackupRestore = 4
Global Const dhcReadControl = &H20000
Global Const dhcKeyQueryValue = &H1
Global Const dhcKeySetValue = &H2
Global Const dhcKeyCreateSubKey = &H4
Global Const dhcKeyEnumerateSubKeys = &H8
Global Const dhcKeyNotify = &H10
Global Const dhcKeyCreateLink = &H20
Global Const dhcKeyRead = dhcKeyQueryValue + dhcKeyEnumerateSubKeys + _
 dhcKeyNotify + dhcReadControl
Global Const dhcKeyWrite = dhcKeySetValue + dhcKeyCreateSubKey + dhcReadControl
Global Const dhcKeyExecute = dhcKeyRead
Global Const dhcKeyAllAccess = dhcKeyQueryValue + dhcKeySetValue + _
 dhcKeyCreateSubKey + dhcKeyEnumerateSubKeys + _
 dhcKeyNotify + dhcKeyCreateLink + dhcReadControl

Function dhReadValue(hkeyRoot As Long, strSubKey As String, _
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
    lngResult = dh_apiRegOpenKeyEx(hkeyRoot, strSubKey, _
     0&, dhcKeyAllAccess, hSubKey)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
    
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
            lngResult = dh_apiRegEnumValue(hSubKey, lngValues, _
            strBuffer, cb, ByVal 0&, lngType, abytData(1), cbData)
            
            ' Print value name to Immediate window
            If lngResult = dhcSuccess Then
                ' See if it's the one we're looking for
                If strValue = Left(strBuffer, cb) Then
                    
                    ' Get data based on type
                    Select Case lngType
                        Case dhcRegDWord
                            ' Set size argument to size of Long
                            cb = Len(lngBuffer)
                            
                            ' Call RegQueryValueEx passing
                            ' address to Long Integer variable
                            lngResult = dh_apiRegQueryValueEx( _
                             hSubKey, strValue, 0&, _
                             lngType, lngBuffer, cb)
                             
                            ' If successful, return value
                            If lngResult = dhcSuccess Then
                                dhReadValue = lngBuffer
                            End If
                        Case dhcRegSz
                            ' Create a string buffer and set the
                            ' size variable to pass
                            strBuffer = Space(dhcRegMaxDataSize)
                            cb = Len(strBuffer)
                            
                            ' Call RegQueryValueEx passing
                            ' address of string buffer
                            lngResult = dh_apiRegQueryValueEx( _
                             hSubKey, strValue, 0&, _
                             lngType, ByVal strBuffer, cb)
                            
                            ' If successful, return portion of
                            ' buffer filled in by the function
                            If lngResult = dhcSuccess Then
                                dhReadValue = Left(strBuffer, cb - 1)
                            End If
                    Case Else
                            dhReadValue = abytData
                    End Select
                End If
            End If

            lngValues = lngValues + 1
        Loop Until lngResult <> 0
        
        ' Close the Desktop key
        lngResult = dh_apiRegCloseKey(hSubKey)
    End If
End Function

Function dhWriteValue(hkeyRoot As Long, strSubKey As String, _
 strValue As String, varValue As Variant) As Boolean
 
    Dim hSubKey As Long
    Dim lngResult As Long
    Dim lngDisp As Long
    
    ' Open the subkey
    lngResult = dh_apiRegCreateKeyEx(hkeyRoot, _
     strSubKey, 0&, "", dhcRegOptionNonVolatile, _
     dhcKeyAllAccess, ByVal 0&, hSubKey, lngDisp)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
        
        ' Save the value
        Select Case VarType(varValue)
            Case vbString
                lngResult = dh_apiRegSetValueEx(hSubKey, strValue, _
                 0&, dhcRegSz, ByVal CStr(varValue), Len(CStr(varValue)))
            Case vbByte, vbInteger, vbLong, vbSingle, vbDouble, vbDecimal
                lngResult = dh_apiRegSetValueEx(hSubKey, strValue, _
                 0&, dhcRegDWord, CLng(varValue), Len(lngDisp))
            Case vbByte + vbArray
                lngResult = dh_apiRegSetValueEx(hSubKey, strValue, _
                 0&, dhcRegBinary, varValue(LBound(varValue)), _
                 UBound(varValue) - LBound(varValue) + 1)
        End Select
        
        dhWriteValue = (lngResult = dhcSuccess)
        
        ' Close the Desktop key
        lngResult = dh_apiRegCloseKey(hSubKey)
    End If
End Function


