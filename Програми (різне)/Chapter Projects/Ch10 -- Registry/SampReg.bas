Attribute VB_Name = "basRegistrySample"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 10

Type FILETIME
        dwLowDateTime As Long
        dwHighDateTime As Long
End Type

Type SECURITY_ATTRIBUTES
        nLength As Long
        lpSecurityDescriptor As Long
        bInheritHandle As Boolean
End Type

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

Private Declare Function RegQueryValueEx _
 Lib "advapi32.dll" Alias "RegQueryValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Long) As Long
Private Declare Function RegSetValueEx _
 Lib "advapi32.dll" Alias "RegSetValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, ByVal dwType As Long, _
 lpData As Any, ByVal cbData As Long) As Long
 
Private Declare Function RegEnumKeyEx _
 Lib "advapi32.dll" Alias "RegEnumKeyExA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpName As String, lpcbName As Long, _
 lpReserved As Long, ByVal lpClass As String, _
 lpcbClass As Long, lpftLastWriteTime As FILETIME) As Long
Private Declare Function RegEnumValue _
 Lib "advapi32.dll" Alias "RegEnumValueA" _
 (ByVal hKey As Long, ByVal dwIndex As Long, _
 ByVal lpValueName As String, lpcbValueName As Long, _
 lpReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Any) As Long
 
' Registry constants
Private Const dhcSuccess = 0
Private Const dhcRegMaxDataSize = 2048
Private Const dhcRegNone = 0
Private Const dhcRegSz = 1
Private Const dhcRegExpandSz = 2
Private Const dhcRegBinary = 3
Private Const dhcRegDWord = 4
Private Const dhcRegDWordLittleEndian = 4
Private Const dhcRegDWordBigEndian = 5
Private Const dhcRegLink = 6
Private Const dhcRegMultiSz = 7
Private Const dhcRegResourceList = 8
Private Const dhcRegFullResourceDescriptor = 9
Private Const dhcRegResourceRequirementsList = 10
Private Const dhcRegOptionReserved = 0
Private Const dhcRegOptionNonVolatile = 0
Private Const dhcRegOptionVolatile = 1
Private Const dhcRegOptionCreateLink = 2
Private Const dhcRegOptionBackupRestore = 4
Private Const dhcReadControl = &H20000
Private Const dhcKeyQueryValue = &H1
Private Const dhcKeySetValue = &H2
Private Const dhcKeyCreateSubKey = &H4
Private Const dhcKeyEnumerateSubKeys = &H8
Private Const dhcKeyNotify = &H10
Private Const dhcKeyCreateLink = &H20
Private Const dhcKeyRead = dhcKeyQueryValue + dhcKeyEnumerateSubKeys + _
 dhcKeyNotify + dhcReadControl
Private Const dhcKeyWrite = dhcKeySetValue + dhcKeyCreateSubKey + dhcReadControl
Private Const dhcKeyExecute = dhcKeyRead
Private Const dhcKeyAllAccess = dhcKeyQueryValue + dhcKeySetValue + _
 dhcKeyCreateSubKey + dhcKeyEnumerateSubKeys + _
 dhcKeyNotify + dhcKeyCreateLink + dhcReadControl
Private Const dhcHKeyClassesRoot = &H80000000
Private Const dhcHKeyCurrentUser = &H80000001
Private Const dhcHKeyLocalMachine = &H80000002
Private Const dhcHKeyUsers = &H80000003
Private Const dhcHKeyPerformanceData = &H80000004

Sub dhPrintValues(strApp As String, strKey As String)
    Dim varValues As Variant
    Dim cValue As Long
    
    varValues = GetAllSettings(strApp, strKey)
    For cValue = LBound(varValues, 1) To UBound(varValues, 1)
        Debug.Print varValues(cValue, 0), varValues(cValue, 1)
    Next
End Sub

Sub dhCreateNewKey()
    Dim hKeyDesktop As Long
    Dim hKeyNew As Long
    Dim lngResult As Long
    Dim lngDisposition As Long
    
    ' Open the KHEY_CURRENT_USER\Control Panel\Desktop key
    lngResult = RegOpenKeyEx(dhcHKeyCurrentUser, _
     "Control Panel\Desktop", 0&, dhcKeyAllAccess, hKeyDesktop)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
    
        ' Create the new subkey
        lngDisposition = 0&
        lngResult = RegCreateKeyEx(hKeyDesktop, _
         "New Key", 0&, "", dhcRegOptionNonVolatile, _
         dhcKeyAllAccess, ByVal 0&, hKeyNew, lngDisposition)
         
        ' If successful, we're done--close the key
        If lngResult = dhcSuccess Then
            lngResult = RegCloseKey(hKeyNew)
        End If
        
        ' Close the Desktop key
        lngResult = RegCloseKey(hKeyDesktop)
    End If
         
End Sub

Sub dhReadWallpaper()
    Dim hKeyDesktop As Long
    Dim lngResult As Long
    Dim strBuffer As String
    Dim cb As Long
    
    ' Open the KHEY_CURRENT_USER\Control Panel\Desktop key
    lngResult = RegOpenKeyEx(dhcHKeyCurrentUser, _
     "Control Panel\Desktop", 0&, dhcKeyAllAccess, hKeyDesktop)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
        
        ' Create the buffer
        strBuffer = Space(255)
        cb = Len(strBuffer)
        
        ' Read the wallpaper value
        lngResult = RegQueryValueEx(hKeyDesktop, "Wallpaper", _
         0&, dhcRegSz, ByVal strBuffer, cb)
        
        ' Check return value
        If lngResult = dhcSuccess Then
            
            ' Display the current value
            MsgBox Left(strBuffer, cb), vbInformation, _
             "Current Wallpaper"
        End If
        
        ' Close the Desktop key
        lngResult = RegCloseKey(hKeyDesktop)
    End If
End Sub

Sub dhWriteWallpaper(strFile As String)
    Dim hKeyDesktop As Long
    Dim lngResult As Long
    
    ' Open the KHEY_CURRENT_USER\Control Panel\Desktop key
    lngResult = RegOpenKeyEx(dhcHKeyCurrentUser, _
     "Control Panel\Desktop", 0&, dhcKeyAllAccess, hKeyDesktop)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
        
        ' Save the wallpaper value
        lngResult = RegSetValueEx(hKeyDesktop, "Wallpaper", _
         0&, dhcRegSz, ByVal strFile, Len(strFile))
        
        ' Check return value
        If lngResult = dhcSuccess Then
            
            ' Display the success message
            MsgBox "Wallpaper changed to " & strFile, _
             vbInformation, "Wallpaper Changed"
        Else
            ' Displat failure message
            MsgBox "Could not saved wallpaper.", _
             vbExclamation, "Wallpaper Not Changed"
        End If
        
        ' Close the Desktop key
        lngResult = RegCloseKey(hKeyDesktop)
    End If
End Sub

Sub dhListSubkeys(hkeyRoot As Long, strSubKey As String)
    Dim hSubKey As Long
    Dim cEnum As Long
    Dim hKey As Long
    Dim lngResult As Long
    Dim strNameBuff As String
    Dim cbNameBuff As Long
    Dim strClassBuff As String
    Dim cbClassBuff As Long
    Dim typFileTime As FILETIME
    
    ' Open the key passed in
    lngResult = RegOpenKeyEx(hkeyRoot, strSubKey, _
     0&, dhcKeyAllAccess, hSubKey)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
    
        ' Loop through all subkeys
        Do
            ' Set up buffers
            strNameBuff = Space$(255)
            cbNameBuff = Len(strNameBuff)
            strClassBuff = Space$(255)
            cbClassBuff = Len(strClassBuff)
            
            ' Call RegEnumKeyEx
            lngResult = RegEnumKeyEx(hSubKey, cEnum, _
             strNameBuff, cbNameBuff, ByVal 0&, _
             strClassBuff, cbClassBuff, typFileTime)
    
            ' If successful, print subkey name
            If lngResult = dhcSuccess Then
                Debug.Print Left(strNameBuff, cbNameBuff)
            End If
             
            ' Increment subkey index
            cEnum = cEnum + 1
        Loop Until lngResult <> 0
        
        ' Close the subkey
        lngResult = RegCloseKey(hSubKey)
    End If
End Sub

Sub dhListValues(hkeyRoot As Long, strSubKey As String)
    Dim hSubKey As Long
    Dim cEnum As Long
    Dim lngResult As Long
    Dim strNameBuff As String
    Dim cbNameBuff As Long
    Dim lngType As Long
    Dim abytData(1 To 2048) As Byte
    Dim cbData As Long
    
    ' Open the key passed in
    lngResult = RegOpenKeyEx(hkeyRoot, strSubKey, _
     0&, dhcKeyAllAccess, hSubKey)
    
    ' Make sure the call succeeded
    If lngResult = dhcSuccess Then
    
        ' Print header
        Debug.Print "Type", "Name"
        Debug.Print "----", "----"
        
        ' Loop through all values
        Do
            ' Set up buffers
            strNameBuff = Space$(255)
            cbNameBuff = Len(strNameBuff)
            Erase abytData
            cbData = UBound(abytData)
            
            ' Call RegEnumValue
            lngResult = RegEnumValue(hSubKey, cEnum, _
             strNameBuff, cbNameBuff, ByVal 0&, _
             lngType, abytData(1), cbData)
    
            ' Print value name to Immediate Window
            If lngResult = dhcSuccess Then
                Debug.Print lngType, Left(strNameBuff, cbNameBuff)
            End If
             
            ' Increment value index
            cEnum = cEnum + 1
        Loop Until lngResult <> 0
    
        ' Close the key
        lngResult = RegCloseKey(hSubKey)
    End If
End Sub
