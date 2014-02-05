Attribute VB_Name = "basRegistryDeclares"
Option Explicit

Declare Function RegOpenKeyEx _
 Lib "advapi32.dll" Alias "RegOpenKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulOptions As Long, ByVal samDesired As Long, _
 phkResult As Long) As Long
Declare Function RegCloseKey _
 Lib "advapi32" _
 (ByVal hKey As Long) As Long
Private Declare Function RegCreateKeyEx _
 Lib "advapi32.dll" Alias "RegCreateKeyExA" _
 (ByVal hKey As Long, ByVal lpSubKey As String, _
 ByVal ulReserved As Long, ByVal lpClass As String, _
 ByVal dwOptions As Long, ByVal samDesired As Long, _
 lpSecurityAttributes As Any, phkResult As Long, _
 lpdwDisposition As Long) As Long

Declare Function RegQueryValueEx _
 Lib "advapi32.dll" Alias "RegQueryValueExA" _
 (ByVal hKey As Long, ByVal lpValueName As String, _
 ByVal dwReserved As Long, lpType As Long, _
 lpData As Any, lpcbData As Long) As Long
 
' Registry constants
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
Global Const dhcHKeyClassesRoot = &H80000000
Global Const dhcHKeyCurrentUser = &H80000001
Global Const dhcHKeyLocalMachine = &H80000002
Global Const dhcHKeyUsers = &H80000003
Global Const dhcHKeyPerformanceData = &H80000004

