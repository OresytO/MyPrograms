Attribute VB_Name = "basNetwork"
Option Compare Text
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Network Functions
' Chapter 11

' Resource type constants
Public Enum dhcResourceType
    dhcResourceTypeAny = &H0
    dhcResourceTypeDisk = &H1
    dhcResourceTypePrint = &H2
End Enum

' Resource scope constants
Public Enum dhcResourceScope
    dhcResourceConnected = &H1
    dhcResourceGlobalNet = &H2
    dhcResourceRemembered = &H3
    dhcResourceRecent = &H4
    dhcRecourceContext = &H5
End Enum

' Resource display type constants
Public Enum dhcResourceDisplayType
    dhcResourceDisplayTypeGeneric = &H0
    dhcResourceDisplayTypeDomain = &H1
    dhcResourceDisplayTypeServer = &H2
    dhcResourceDisplayTypeShare = &H3
End Enum

' Resource usage constants
Public Enum dhcResourceUsage
    dhcResourceUsageConnectable = &H1
    dhcResourceUsageContainer = &H2
    dhcResourceUsageAttached = &H10
    dhcResourceUsageAll = &H13
End Enum

Public Enum dhcConnectType
    dhcConnectUpdateProfile = &H1
    dhcConnectDontUpdateProfile = &H0
End Enum

' Error constants
Public Enum dhcNetworkErrors
    dhcNoError = 0&
    dhcDialogCancelled = -1&
    dhcErrorAccessDenied = 5&
    dhcErrorAlreadyAssigned = 85&
    dhcErrorBadDevType = 66&
    dbcErrorInvalidName = 123&
    dhcErrorBadDevice = 1200&
    dhcErrorBadNetName = 67&
    dhcErrorBadProfile = 1206&
    dhcErrorCannotOpenProfile = 1205&
    dhcErrorConnectionUnavailable = 1201&
    dhcErrorDeviceAlreadyRemembered = 1202&
    dhcErrorDeviceInUse = 2404&
    dhcErrorExtendedError = 1208&
    dhcErrorInvalidComputer = 2351&
    dhcErrorInvalidHandle = 6&
    dhcErrorInvalidParameter = 87
    dhcErrorInvalidPassword = 86&
    dhcErrorMoreData = 234
    dhcErrorNoMoreItems = 259
    dhcErrorNoNetOrBadPath = 1203&
    dhcErrorNoNetwork = 1222&
    dhcErrorNotConnected = 2250&
    dhcErrorNotContainer = 1207&
    dhcErrorNotEnoughMemory = 8&
    dhcErrorNotPrimary = 2226&
    dhcErrorOpenFiles = 2401&
    dhcErrorPasswordTooShort = 2245&
    dhcErrorUserNotFound = 2221&
    dhcErrorInvalidComputerName = 2351&
    dhcErrorShareNotFound = 2392&
    dhcErrorDCNotFound = 2453&
End Enum

Public Const dhcMaxComputernameLength = 15
Public Const dhcMaxPath = 260

Public Const dhcUniversalNameInfoLevel = &H1
Public Const dhcRemoteNameInfoLevel = &H2

' LAN Manager Constants
' Specified level 2 for share info
Public Const dhcShareInfo2 = 2
Public Const dhcShareInfo502 = 502
Public Const dhcShareInfo50 = 50

Public Const LM20_NNLEN = 12   ' LM 2.0 Net name length
Public Const SHPWLEN = 8 ' Share password length (bytes)

' Share Types (shi1_type and shi2_type)
Public Const dhcLanManStypeDisktree = 0
Public Const dhcLanManStypePrintq = 1
Public Const dhcLanManStypeDevice = 2
Public Const dhcLanManStypeIpc = 3
Public Const dhcLanManStypeSpecial = &H80000000

' Access Types (shi2_permissions)
Public Const dhcLanManAccessNone = &H0
Public Const dhcLanManAccessRead = &H1
Public Const dhcLanManAccessWrite = &H2
Public Const dhcLanManAccessCreate = &H4
Public Const dhcLanManAccessExec = &H8
Public Const dhcLanManAccessDelete = &H10
Public Const dhcLanManAccessAtrib = &H20
Public Const dhcLanManAccessPerm = &H40
Public Const dhcLanManAccessAll = (dhcLanManAccessRead Or dhcLanManAccessWrite _
 Or dhcLanManAccessCreate Or dhcLanManAccessExec Or _
 dhcLanManAccessDelete Or dhcLanManAccessAtrib Or dhcLanManAccessPerm)
 
 ' shi50 flag types
 Public Const dhcLanManWin9xReadOnly = &H1
Public Const dhcLanManWin9xFull = &H2
Public Const dhcLanManWin9xDependsOn = (dhcLanManWin9xReadOnly Or dhcLanManWin9xFull)
Public Const dhcLanManWin9xAccessMask = (dhcLanManWin9xReadOnly Or dhcLanManWin9xFull)
Public Const dhcLanManWin9xPersist = &H100  ' The share is restored on system startup
Public Const dhcLanManWin9xSystem = &H200 ' The share is not normally visible

' WNet API Types
Public Type UNIVERSAL_NAME_INFO
    ' Pointer to the string
    lpUniversalName As Long
    
    ' Buffer that stores the string contents
    abyt(dhcMaxPath) As Byte
    
    ' Actual location of the final string
    strUniversalName As String
End Type

Public Type REMOTE_NAME_INFO
    ' Pointers to strings
    lpUniversalName As Long
    lpConnectionName As Long
    lpRemainingPath As Long
    
    ' Buffer that contains string data
    abyt(dhcMaxPath * 3) As Byte

    ' Actual location of the final strings
    strUniversalName As String
    strConnectionName As String
    strRemainingPath As String
End Type

Public Type NETRESOURCE
    dwScope As dhcResourceScope
    dwType As dhcResourceType
    dwDisplayType As dhcResourceDisplayType
    dwUsage As dhcResourceUsage
    
    ' Pointers to strings
    lpLocalName As Long
    lpRemoteName As Long
    lpComment As Long
    lpProvider As Long

    ' Buffer that contains string data
    abyt(dhcMaxPath * 4) As Byte
    
    ' Actual location of the final strings
    strLocalName As String
    strRemoteName As String
    strComment As String
    strProvider As String
End Type

' LAN Manager types
Public Type SHARE_INFO_2
    shi2_netname As Long  ' Share name of the resource
    shi2_type As Long           ' Type of resource
    shi2_remark As Long   ' Comment for the resource
    shi2_permissions As Long    ' Permissions to the resource
    shi2_max_uses As Long   ' Maximum number of users
    shi2_current_uses As Long  ' current number of users
    shi2_path As Long     ' local path of the resource
    shi2_passwd As Long   ' Password for the resource (share level security only)
End Type

Public Type SHARE_INFO_502
    shi502_netname As Long
    shi502_type As Long
    shi502_remark As Long
    shi502_permissions As Long
    shi502_max_uses As Long
    shi502_current_uses As Long
    shi502_path As Long
    shi502_passwd As Long
    shi502_reserved As Long
    shi502_security_descriptor As Long
End Type

Public Type SHARE_INFO_50
  shi50_netname As String * LM20_NNLEN
  shi50_type As Integer
  shi50_flags As Integer
  shi50_remark As String
  shi50_path As String
  shi50_rw_password As String * SHPWLEN
  shi50_ro_password As String * SHPWLEN
End Type

Public Type TIME_OF_DAY_INFO
    t_elapsedt As Long
    t_msecs As Long
    t_hours As Long
    t_mins As Long
    t_secs As Long
    t_hunds As Long
    t_timezone As Long
    t_tinterval As Long
    t_day As Long
    t_month As Long
    t_year As Long
    t_weekday As Long
End Type


' WNet APIs
Private Declare Function WNetAddConnection Lib "mpr.dll" _
 Alias "WNetAddConnectionA" (ByVal strNetPath As String, _
 ByVal strPassword As String, ByVal strLocalName As String) As Long
 
Private Declare Function WNetAddConnection2 Lib "mpr.dll" _
 Alias "WNetAddConnection2A" (lpNetResource As NETRESOURCE, _
  ByVal strPassword As String, ByVal strUserName As String, _
  ByVal lngFlags As Long) As Long
  
Private Declare Function WNetCancelConnection Lib "mpr.dll" _
 Alias "WNetCancelConnectionA" (ByVal lpszName As String, _
 ByVal bForce As Long) As Long

Private Declare Function WNetCancelConnection2 Lib "mpr.dll" _
 Alias "WNetCancelConnection2A" (ByVal lpName As String, _
 ByVal dwFlags As Long, ByVal fForce As Long) As Long

Private Declare Function WNetConnectionDialog Lib "mpr.dll" _
 (ByVal hWnd As Long, ByVal dwType As Long) As Long

Private Declare Function WNetDisconnectDialog Lib "mpr.dll" _
 (ByVal hWnd As Long, ByVal dwType As Long) As Long
 
Private Declare Function WNetGetLastError Lib "mpr.dll" _
 Alias "WNetGetLastErrorA" (lpError As Long, ByVal lpErrorBuf As String, _
 ByVal nErrorBufSize As Long, ByVal lpNameBuf As String, _
 ByVal nNameBufSize As Long) As Long
Private Declare Function WNetGetConnection Lib "mpr.dll" _
 Alias "WNetGetConnectionA" (ByVal strLocalName As String, _
 ByVal strRemoteName As String, lngRemoteNameLen As Long) As Long

Private Declare Function WNetGetUser Lib "mpr" _
 Alias "WNetGetUserA" (ByVal strName As String, _
 ByVal strUserName As String, lngLength As Long) As Long

Private Declare Function WNetGetUniversalName Lib "mpr" _
 Alias "WNetGetUniversalNameA" (ByVal strLocalPath As String, _
 ByVal lngInfoLevel As Long, lpBuffer As Any, lngBufferSize As Long) As Long

Private Declare Function WNetCloseEnum Lib "mpr.dll" _
 (ByVal hEnum As Long) As Long

Private Declare Function WNetEnumResource Lib "mpr.dll" _
 Alias "WNetEnumResourceA" (ByVal hEnum As Long, _
 lngCount As Long, lpBuffer As Any, lngBufferSize As Long) As Long

Private Declare Function WNetOpenEnum Lib "mpr" _
 Alias "WNetOpenEnumA" (ByVal rsScope As dhcResourceScope, _
 ByVal rtType As dhcResourceType, ByVal rtUsage As dhcResourceUsage, _
 lpNetResource As Any, lngEnum As Long) As Long

' Kernel32 APIs
Private Declare Function GetComputerName Lib "kernel32" _
 Alias "GetComputerNameA" (ByVal strBuffer As String, lngSize As Long) As Long

Private Declare Function SetComputerName Lib "kernel32" _
 Alias "SetComputerNameA" (ByVal strComputerName As String) As Long

' LAN Manager APIs
Private Declare Function NetShareAdd Lib "NETAPI32.DLL" _
 (ByVal strServername As Long, ByVal lngLevel As Long, _
 strbuf As SHARE_INFO_2, lngParamErr As Long) As Long

Private Declare Function NetShareAdd9x Lib "svrapi.dll" _
 Alias "NetShareAdd" (ByVal pszServer As String, _
 ByVal lngLevel As Integer, pbbuffer As SHARE_INFO_50, _
 ByVal cbBuffer As Integer) As Long

Private Declare Function NetShareDel Lib "NETAPI32.DLL" _
 (ByVal lpServername As Long, ByVal lpNetName As Long, _
 ByVal lngReserved As Long) As Long

Private Declare Function NetShareDel9x Lib "svrapi.dll" _
 Alias "NetShareDel" (ByVal strServer As String, _
 ByVal strNetName As String, _
 ByVal lngReserved As Long) As Long
 
Private Declare Function NetUserChangePassword Lib "NETAPI32.DLL" _
 (ByVal domainname As Long, ByVal UserName As Long, _
 ByVal OldPassword As Long, ByVal NewPassword As Long) As Long
 
Private Declare Function NetGetDCName Lib "NETAPI32.DLL" _
 (ByVal servername As Long, ByVal domainname As Long, _
  bufptr As Long) As Long
 
Private Declare Function NetGetAnyDCName Lib "NETAPI32.DLL" _
 (ByVal servername As Long, ByVal domainname As Long, _
  bufptr As Long) As Long
 
Private Declare Function NetApiBufferFree Lib "NETAPI32.DLL" _
 (ByVal bufptr As Long) As Long

Private Declare Function NetRemoteTOD Lib "NETAPI32.DLL" _
 (ByVal server As Long, bufptr As Long) As Long

' Miscellaneous (non-Network) APIs
Private Declare Function lstrlen Lib "kernel32" _
 Alias "lstrlenA" (ByVal lpString As Long) As Long

Private Declare Function lstrlenW Lib "kernel32" _
 (ByVal lpString As Long) As Long

Private Declare Function lstrcpyn Lib "kernel32" Alias "lstrcpynA" _
 (ByVal lpString1 As Long, ByVal lpString2 As Long, _
 ByVal iMaxLength As Long) As Long

Private Declare Function lstrcpynW Lib "kernel32" _
 (ByVal lpString1 As Long, ByVal lpString2 As Long, _
 ByVal iMaxLength As Long) As Long

Private Declare Sub RtlMoveMemory Lib "kernel32" _
 (pDest As Any, pSrc As Any, ByVal ByteLen As Long)

Public Declare Function GetVersion Lib "kernel32" () As Long


Public Function dhConnectDlg( _
 Optional ByVal hWnd As Long = 0) As dhcNetworkErrors
    ' Display the dialog to connect to network resources
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   hWnd:
    '       (Optional) Window handle (hwnd) of the parent window for
    '       the dialog. Use the desktop (0) if no value provided.
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError for success, and
    '       dhcDlgCancelled if the dialog is cancelled by the user
    ' Note:
    '       WNetConnectionDialog does not have very much in the
    '       way of return values, so this function will try to get the
    '       extended error information on failure.
    ' Example:
    '   dhConnectDlg
    ' will open the network connection dialog with
    '   no parent window and will return the error code.
    
    Dim lngReturn As dhcNetworkErrors
    Dim lngExtendedError As Long
    
    ' Call the net connection dialog
    lngReturn = WNetConnectionDialog(hWnd, dhcResourceTypeDisk)
    
    ' If the call failed, get error information
    If lngReturn <> dhcNoError Then
        lngExtendedError = dhGetLastNetworkError(True)
        ' If there was an extended error,
        ' return it instead of the standard error
        If lngExtendedError = dhcNoError Then
            dhConnectDlg = lngReturn
        Else
            dhConnectDlg = lngExtendedError
        End If
   End If
End Function

Public Function dhGetLastNetworkError( _
 Optional fDisplayError As Boolean = False) As dhcNetworkErrors
    ' Get error information from the last network operation
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   fDisplayError:
    '       Determines whether error information will be displayed by this
    '       function if info is available. Optional, default value is False.
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError if no error was returned
    ' Note:
    '
    ' Example:
    '   GetLastNetworkError(True) will display a msgbox with the error code
    '   and error text if an error occurred, and will return that error code.
    
    Dim lngReturn As dhcNetworkErrors
    Dim lngError As Long
    Dim strError As String
    Dim lngErrorLen As Long
    Dim strProvider As String
    Dim lngProviderLen As Long
    
    ' Set up buffers for the error info (they should be
    ' at least 256 characters but it does not hurt to
    ' make them longer).
    strError = String$(256, vbNullChar)
    strProvider = String$(256, vbNullChar)
    lngErrorLen = Len(strError)
    lngProviderLen = Len(strProvider)
    
    ' Try to get the last error
    lngReturn = WNetGetLastError(lngError, strError, _
     lngErrorLen, strProvider, lngProviderLen)
    
    If lngReturn = dhcNoError Then
        dhGetLastNetworkError = lngError
        ' If there was extended error info and the calling
        ' procedure wanted it to be displayed here,
        ' then display it.
        If fDisplayError And (lngError <> dhcNoError) Then
            strError = dhTrimNull(strError)
            strProvider = dhTrimNull(strProvider)
            MsgBox "Error " & lngError & ": " & strError, _
             vbInformation, strProvider
        End If
    End If
End Function

Public Function dhDisconnectDlg(Optional ByVal hWnd As Long = 0) _
 As dhcNetworkErrors
    ' Display the dialog to disconnect from network resources
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   hWnd:
    '       Window handle (hwnd) of the parent window for
    '       the dialog. Use the desktop (0) if no value provided.
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError for success, and
    '       dhcDlgCancelled if the dialog is cancelled by the user
    ' Note:
    '       WNetDisconnectDialog does not have very much in the
    '       way of return values, so this function will try to get the
    '       extended error information on failure.
    ' Example:
    '   dhDisconnectDialog
    '   will open the network disconnect dialog
    '   with no parent window and will return the error code.
    
    Dim lngReturn As dhcNetworkErrors
    Dim lngExtendedError As Long
    
    ' Call the net disconnect dialog
    lngReturn = WNetDisconnectDialog(hWnd, dhcResourceTypeDisk)
    
    ' If the call failed, get error information
    If lngReturn <> dhcNoError Then
        lngExtendedError = dhGetLastNetworkError(True)
        ' If there was an extended error, return it instead
        ' of the standard error
        If lngExtendedError = dhcNoError Then
            dhDisconnectDlg = lngReturn
        Else
            dhDisconnectDlg = lngExtendedError
        End If
   End If
End Function

Public Function dhAddConnection1( _
 strNetPath As String, strPwd As String, _
 strLocalName As String) As dhcNetworkErrors
    ' Adds a network connection
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strNetPath:
    '       The UNC path to connect to
    '   strPwd
    '       The password for the network resource
    '   strLocalName
    '       The local name for the resource (such as LPT1: or F:)
    '
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError on success
    ' Note:
    '
    ' Example:
    '   dhAddConnection1("\\middlemarch\setup","password","J:") will
    '   map J: on the local machine to the share \\middlemarch\setup
    '   using the password "password", returning dhcNoError if it
    '   succeeds.
    
    dhAddConnection1 = WNetAddConnection(strNetPath, _
     strPwd, strLocalName)
End Function

Public Function dhAddConnection2( _
 strNetPath As String, strLocalName As String, _
 strUserName As String, strPwd As String, _
 Optional lngConnectType As _
  dhcConnectType = dhcConnectUpdateProfile, _
 Optional fIsDiskResource As Boolean = True) As dhcNetworkErrors
    ' Adds a network connection
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strNetPath:
    '       The UNC path to connect to
    '   strLocalName
    '       The local name for the resource (such as LPT1: or F:)
    '   strUserName
    '       The user whose permissions to log in with
    '   strPwd
    '       The password for the user given by strUserName
    '   lngConnectType
    '       Whether to persist this connection after the user reboots
    '   fIsDiskResource
    '       Whether this is a disk resource (false means it is a print resource)
    '
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError on success
    ' Note:
    '
    ' Example:
    '   dhAddConnection2("\\middlemarch\setup", "K:", "Sam", "", False) will
    '   map J: on the local machine to the share \\middlemarch\setup
    '   with the permissions of "Sam" with no password, returning dhcNoError
    '   if it  succeeds. This connection will not persist after a reboot.

    Dim usrNetResource As NETRESOURCE
    
    With usrNetResource
        If fIsDiskResource Then
            .dwType = dhcResourceTypeDisk
        Else
            .dwType = dhcResourceTypePrint
        End If
        ' Convert the text into ANSI format.
        .strLocalName = StrConv(strLocalName, vbFromUnicode)
        .strRemoteName = StrConv(strNetPath, vbFromUnicode)
        
        ' Get the pointers to the text strings.
        ' Pass a null pointer (0&) for the
        ' provider.
        .lpLocalName = StrPtr(.strLocalName)
        .lpRemoteName = StrPtr(.strRemoteName)
        .lpProvider = 0&
    End With
    dhAddConnection2 = WNetAddConnection2(usrNetResource, _
     strPwd, strUserName, CLng(lngConnectType))
End Function

Public Function dhCancelConnection1(strLocalName As String, _
 Optional fForceDisconnect As Boolean = False) As dhcNetworkErrors
    ' Cancels a network connection
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalName
    '       The local name for the resource (such as LPT1: or F:)
    '   fForceDisconnect
    '       Disconnect even if the resource is in use or files are open
    '
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError on success
    ' Note:
    '
    ' Example:
    '   dhCancelConnection1("J:", True) will disconnect J:. If files are
    ' open or the connection is in use, it will be terminated.

    dhCancelConnection1 = WNetCancelConnection( _
     strLocalName, Abs(fForceDisconnect))
End Function

Public Function dhCancelConnection2(strLocalName As String, _
 Optional fForceDisconnect As Boolean = False, _
 Optional lngConnectType As _
  dhcConnectType = dhcConnectUpdateProfile) As dhcNetworkErrors
    
    ' Cancels a network connection
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalName
    '       The local name for the resource (such as LPT1: or F:)
    '   fForceDisconnect
    '       If True, disconnect even if the resource is in use or files are open
    '   lngConnectType
    '       If dhcConnectUpdateProfile, update the user's profile so that this resource will not be
    '       re-established when the user reboots.
    '
    ' Out:
    '   Return Value:
    '       The error value on failure, dhcNoError on success
    ' Note:
    '
    ' Example:
    '   dhCancelConnection2("J:", True, dhcConnectDontUpdateProfile) will disconnect J:.
    ' If files are open or the connection is in use, the connection will still be terminated.
    ' When the user reboots, the connection will be re-established.
    Dim lngFlags As Long
    
    lngFlags = lngConnectType
    dhCancelConnection2 = _
     WNetCancelConnection2(strLocalName, _
      lngFlags, Abs(fForceDisconnect))
End Function

Public Function dhGetRemoteName(strLocalName As String) As String
    ' Given a mapped network resource, returns the UNC path
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalName
    '       The local name for the resource (such as LPT1: or F:)
    '
    ' Out:
    '   Return Value:
    '       The UNC path on success, a ZLS on failure
    ' Note:
    '
    ' Example:
    '   dhGetRemoteName("L:") will return the UNC path to which L:
    '   is mapped.
    
    Dim lngRemoteNameLen As Long
    Dim strRemoteName As String
    Dim lngReturn As dhcNetworkErrors
    
    Do
        ' Set up the buffer
        strRemoteName = String$(lngRemoteNameLen, vbNullChar)
        
        lngReturn = WNetGetConnection( _
         strLocalName, strRemoteName, lngRemoteNameLen)
        
        ' Continue looping until the call succeeds or the error is
        ' anything besides "there's more data"
    Loop Until lngReturn <> dhcErrorMoreData
    
    If lngReturn = dhcNoError Then
        dhGetRemoteName = dhTrimNull(strRemoteName)
    End If
End Function

Public Function dhGetUserName( _
 Optional strLocalName As String = vbNullString) As String
    ' Retrieve the current network user name
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalName (optional)
    '       The local name for the resource (such as LPT1: or F:)
    '
    ' Out:
    '   Return Value:
    '       If strLocalName is a ZLS or not given, the currently logged in user,
    '       otherwise the username specified when the given resource connection
    '       was made
    ' Note:
    '
    ' Example:
    '   dhGetUserName("L:") will return "NORTHEAST\SallyH" if SallyH made the
    '   connection or it was done with her username and password.
    '   dhGetUserName() will return the currently logged in user.
    
    Dim lngUserNameLen As Long
    Dim strUserName As String
    Dim lngReturn As dhcNetworkErrors
    
    Do
        ' Set up the buffer
        strUserName = String$(lngUserNameLen, vbNullChar)
        
        lngReturn = WNetGetUser( _
         strLocalName, strUserName, lngUserNameLen)
    
        ' Continue looping until the call succeeds or the error is not
    Loop Until lngReturn <> dhcErrorMoreData
    
    If lngReturn = dhcNoError Then
        dhGetUserName = dhTrimNull(strUserName)
    End If
End Function

Public Function dhGetComputerName() As String
    ' Return the workstation's computer name
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '
    ' Out:
    '   Return Value:
    '       The computer name of the local workstation
    ' Note:
    '
    ' Example:
    '   dhGetComputerName() will return the computer name
    
    Dim lngReturn As Long
    Dim lngBufferSize As Long
    Dim strBuffer As String
    
    ' Make the buffer big enough for the name plus a vbNullChar
    lngBufferSize = dhcMaxComputernameLength + 1
    strBuffer = String$(lngBufferSize, vbNullChar)
    
    lngReturn = GetComputerName(strBuffer, lngBufferSize)
    
    ' lngReturn will be True on success
    If CBool(lngReturn) Then
        dhGetComputerName = Left(strBuffer, lngBufferSize)
    End If
    
End Function

Public Function dhSetComputerName(strComputerName) As Boolean
    ' Sets the workstation's computer name
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '
    ' Out:
    '   Return Value:
    '       The computer name of the local workstation
    ' Note:
    '
    ' Example:
    '   dhSetComputerName("Darby") will set the computer name
    '   to Darby, effective the next time the computer is rebooted
    
    Dim lngReturn As Long
    
    lngReturn = SetComputerName(strComputerName)
    
    ' lngReturn will be non-zero on success
    dhSetComputerName = CBool(lngReturn)
End Function

Public Function dhGetRemoteInfo( _
 strLocalPath As String, _
 usrRemoteNameInfo As REMOTE_NAME_INFO) As dhcNetworkErrors
   ' Fill a REMOTE_NAME_INFO structure given a local path
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalPath
    '       a local path that includes a network resource such as L:\wizard\setup
    '   usrRemoteNameInfo
    '       a REMOTE_NAME_INFO structure
    
    ' Out:
    '   Return Value:
    '       dhcNoError on success or the error code on failure
    ' Note:
    '
    Dim lngReturn As dhcNetworkErrors
    Dim lngBufferSize As Long
    
    ' Don't include the last three string pointers in the buffer size.
    ' Each pointer takes up four bytes.
    lngBufferSize = Len(usrRemoteNameInfo) - 12
    lngReturn = WNetGetUniversalName( _
     strLocalPath, dhcRemoteNameInfoLevel, _
     usrRemoteNameInfo, lngBufferSize)
    
    If lngReturn = dhcNoError Then
        ' If the call succeeded, fill the strings in the REMOTE_NAME_INFO structure
        With usrRemoteNameInfo
            .strUniversalName = dhStrFromANSIPtr(.lpUniversalName)
            .strConnectionName = dhStrFromANSIPtr(.lpConnectionName)
            .strRemainingPath = dhStrFromANSIPtr(.lpRemainingPath)
        End With
    End If
    
    dhGetRemoteInfo = lngReturn
End Function

Public Function dhGetUniversalInfo( _
 strLocalPath As String, _
 usrUniversalNameInfo As UNIVERSAL_NAME_INFO) As dhcNetworkErrors
   ' Fill a UNIVERSAL_NAME_INFO structure given a local path
   ' This function returns less information than
   ' dhGetRemoteInfo.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strLocalPath
    '       a local path that includes a network resource such as L:\wizard\setup
    '   usrUniversalNameInfo
    '       a UNIVERSAL_NAME_INFO structure
    
    ' Out:
    '   Return Value:
    '       dhcNoError on success or the error code on failure
    ' Note:
    '
    Dim lngReturn As dhcNetworkErrors
    Dim lngBufferSize As Long
    
    ' Don't include the last string pointer in the buffer size.
    lngBufferSize = Len(usrUniversalNameInfo) - 4
    lngReturn = WNetGetUniversalName( _
     strLocalPath, dhcUniversalNameInfoLevel, _
     usrUniversalNameInfo, lngBufferSize)
    
    If lngReturn = dhcNoError Then
        ' If the call succeeded, fill the string in the
        ' UNIVERSAL_NAME_INFO structure.
        With usrUniversalNameInfo
            .strUniversalName = dhStrFromANSIPtr(.lpUniversalName)
        End With
    End If
    
    dhGetUniversalInfo = lngReturn
    
End Function

Public Function dhGetTopLevelEnumHandle( _
 rsScope As dhcResourceScope, rtType As dhcResourceType, _
 rtUsage As dhcResourceUsage) As dhcNetworkErrors
    ' Opens a top-level network resource enumeration handle
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   rsScope:
    '       The scope flag (a dhcResource)
    '   rtType:
    '       The type flag (a dhcResourceType)
    '   rtUsage:
    '       The usage flag (a dhcResourceUsage)
    '
    ' Out:
    '   Return Value:
    '       An enumeration handle on success, 0 on failure
    ' Note:
    '
    ' Example:
    ' dhGetTopLevelEnumHandle(dhcResourceConnected, dhcResourceTypeDisk, 0)
    ' will return a handle to enumerate all of the connected disk resources on the
    ' current machine.
    
    Dim lngReturn As dhcNetworkErrors
    Dim hEnum As Long
    
    ' Since this is a top level item, pass in the
    ' fourth parameter as the value 0.
    lngReturn = WNetOpenEnum(rsScope, rtType, rtUsage, _
     ByVal 0&, hEnum)
    
    If lngReturn = dhcNoError Then
        dhGetTopLevelEnumHandle = hEnum
    End If
    
End Function

Public Function dhGetNetResourceEnumHandle( _
 rsScope As dhcResourceScope, rtType As dhcResourceType, _
 rtUsage As dhcResourceUsage, usrNetResource As NETRESOURCE) As dhcNetworkErrors
    ' Opens a resource enumeration handle for a given NETRESOURCE
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   rsScope:
    '       The scope flag (a dhcResource)
    '   rtType:
    '       The type flag (a dhcResourceType)
    '   rtUsage:
    '       The usage flag (a dhcResourceUsage)
    '   usrNetResource:
    '       a valid NETRESOURCE container
    '
    ' Out:
    '   Return Value:
    '       An enumeration handle on success, 0 on failure
    ' Note:
    '
    ' Example:
    ' dhGetNetResourceEnumHandle(dhcResourceGlobalNet, dhcResourceTypeDisk, _
    '   dhcResourceUsageConnectable, usrNetResource)  will return a handle to
    ' enumerate all of the resources you can connect to for the given network
    ' resource
    
    Dim lngReturn As dhcNetworkErrors
    Dim hEnum As Long
    
    lngReturn = WNetOpenEnum(rsScope, rtType, _
     rtUsage, usrNetResource, hEnum)
    
    If lngReturn = dhcNoError Then
        dhGetNetResourceEnumHandle = hEnum
    End If
    
End Function

Public Function dhCloseEnum(hEnum As Long) As dhcNetworkErrors
    ' Closes a resource enumeration handle
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   hEnum:
    '       The enum handle to close
    '
    ' Out:
    '   Return Value:
    '       dhcNoError on success, an error value on failure
    ' Note:
    '
    ' Example:
    '   dhCloseEnum(hEnum) will close the enumeration handle
    '   specified by hEnum.
    
    dhCloseEnum = WNetCloseEnum(hEnum)
End Function

Public Function dhEnumNext(hEnum As Long, _
 usrNetResource As NETRESOURCE) As dhcNetworkErrors
    ' Enumerate the next resource in hEnum and put the info in usrNetResource
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   hEnum:
    '       The enum handle
    '   usrNetResource:
    '       A NETRESOURCE type that this function will fill in
    '
    ' Out:
    '   Return Value:
    '       dhcNoError on success, an error value on failure
    ' Note:
    '
    ' Example:
    '   dhEnumNext(hEnum, usrNetResource) will get the next
    '   NETRESOURCE in the enumeration and fill in usrNetResource
    '   with the information that is obtained
    
    Dim lngReturn As dhcNetworkErrors
    Dim lngBufferLength As Long
    
    ' Don't include the last four string pointers in the buffer size
    lngBufferLength = Len(usrNetResource) - 16
    lngReturn = WNetEnumResource(hEnum, 1, _
     usrNetResource, lngBufferLength)
           
    If lngReturn = dhcNoError Then
        ' If the call succeeded, there are several pointers to data.
        ' Use the pointers to get the actual strings
            With usrNetResource
                .strLocalName = dhStrFromANSIPtr(.lpLocalName)
                .strRemoteName = dhStrFromANSIPtr(.lpRemoteName)
                .strComment = dhStrFromANSIPtr(.lpComment)
                .strProvider = dhStrFromANSIPtr(.lpProvider)
            End With
    End If

    dhEnumNext = lngReturn
End Function

Public Function dhGetNetResourceInfo(rsScope As dhcResourceScope, _
 rtType As dhcResourceType, rtUsage As dhcResourceUsage, _
 fSpecifyStart As Boolean, usrNetResourceStart As NETRESOURCE) _
 As Collection
    ' Retrieve all the net resources specified by the parameters
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   rsScope:
    '       The scope flag (a dhcResource constant)
    '   rtType:
    '       The type flag (a dhcResourceType constant)
    '   rtUsage:
    '       The usage flag (a dhcResourceUsage constant)
    '   fSpecifyStart
    '       A boolean that tells the function whether the next parameter
    '       (usrNetResourceStart) is going to be passed; it should be False
    '       if you want to use the network root to start your enumeration, or
    '       True if you wish to pass in usrNetResourceStart as the root of
    '       the enumeration
    '   usrNetResourceStart
    '       A NETRESOURCE Type; this must be passed in even if fSpecifyStart
    '       is False, but in that case it can be empty since it will not be used.
    '
    ' Out:
    '   Return Value:
    '       Collection, filled in with all the resources.
    '       If the function fails, it raises an error back to
    '       the caller, indicating the error.
    '
    
    Dim lngReturn As dhcNetworkErrors
    Dim hEnum As Long
    Dim nri As NetResourceInfo
    Dim usrNetResource As NETRESOURCE
    Dim colNetResource As Collection
    
    On Error GoTo HandleErrors
    
    ' If fSpecifyStart is selected use the usrNetResourceStart
    ' info as the root for the enumeration. Otherwise, assume
    ' the top level.
    If fSpecifyStart Then
        With usrNetResourceStart
            ' In case strings were specified, set them
            ' into the pointers now
            If Len(.strComment) > 0 Then
                .lpComment = StrPtr(.strComment)
            End If
            If Len(.strLocalName) > 0 Then
                .lpLocalName = StrPtr(.strLocalName)
            End If
            If Len(.strProvider) > 0 Then
                .lpProvider = StrPtr(.strProvider)
            End If
            If Len(.strRemoteName) > 0 Then
                .lpRemoteName = StrPtr(.strRemoteName)
            End If
        End With
        hEnum = dhGetNetResourceEnumHandle( _
         rsScope, rtType, rtUsage, usrNetResourceStart)
    Else
        hEnum = dhGetTopLevelEnumHandle(rsScope, rtType, rtUsage)
    End If
    
    If hEnum <> 0 Then
        ' init the collection
        Set colNetResource = New Collection
        
        Do While lngReturn = dhcNoError
            
            lngReturn = dhEnumNext(hEnum, usrNetResource)
            ' lngReturn will be dhcErrorNoMoreItems when we are done.
            If lngReturn <> dhcErrorNoMoreItems Then
                Set nri = New NetResourceInfo
                
                With usrNetResource
                    nri.Comment = .strComment
                    nri.LocalName = .strLocalName
                    nri.Provider = .strProvider
                    nri.RemoteName = .strRemoteName
                End With
                
                colNetResource.Add nri
            End If
        Loop
    
        lngReturn = dhCloseEnum(hEnum)
    End If
    ' If there was an error, colNetResource
    ' (and the return value) will be Nothing.
    
ExitHere:
    Set dhGetNetResourceInfo = colNetResource
    Exit Function
    
HandleErrors:
    ' Raise the error back out.
    Err.Raise Err.Number, Err.Source, Err.Description
End Function

Public Function dhAddNetworkShare( _
 ByVal strServer As String, _
 strShareName As String, _
 strPath As String, _
 Optional strRemarks As String, _
 Optional fIsDiskResource As Boolean = True, _
 Optional lngMaxUsers As Long = -1, _
 Optional ByVal lngPermissions As Long = -1, _
 Optional strRwPassword As String = "", _
 Optional strRoPassword As String = "") As Long
 
    ' Adds a network share
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strServer:
    '       The server on which to add the share
    '   strShareName:
    '       The name of the share to be created
    '   strPath:
    '       The local path of the share to be created
    '   strRemarks: (optional)
    '       Comment for this share (appears in the Windows explorer)
    '   fIsDiskResource: (optional)
    '       Whether this is a disk share or a print share (True means a disk share)
    '   lngMaxUsers: (optional)
    '       The maximum number of users (-1 means no limit)
    '   lngPermissions: (optional)
    '       An optional flag that specifies permissions (this is ignored if user-level
    '       security is enabled, but not if share level security is specified)
    '       Note that the default for NT/2000 will be dhcLanManAccessAll, and on
    '       95/98 it will be dhcLanManWin9xAccessMask
    '   strRwPassword: (optional)
    '       Password for the share (like lngPermissions, this value is ignored unless
    '       share level security is specified)
    '   strRoPassword: (optional)
    '       R/O Password for the share (like lngPermissions, this value is ignored unless
    '       share level security is specified)
    '       THIS PARAM IS IGNORED ON NT/2000
    '
    ' Out:
    '   Return Value:
    '       dhcNoError on success, an error value on failure
    
    Dim si2 As SHARE_INFO_2
    Dim si50 As SHARE_INFO_50
    Dim lngParamError As Long
        
    If IsWinNT() Then
        If lngPermissions = -1 Then
            lngPermissions = dhcLanManAccessAll
        End If
        
        ' Place all strings in the structure as needed
        With si2
            .shi2_netname = StrPtr(strShareName)
            If fIsDiskResource Then
                .shi2_type = dhcLanManStypeDisktree
            Else
                .shi2_type = dhcLanManStypePrintq
            End If
            .shi2_remark = StrPtr(strRemarks)
            .shi2_permissions = lngPermissions
            .shi2_max_uses = lngMaxUsers
            .shi2_path = StrPtr(strPath)
            .shi2_passwd = StrPtr(strRwPassword)
        End With

        dhAddNetworkShare = _
         NetShareAdd(StrPtr(strServer), _
         dhcShareInfo2, si2, lngParamError)
    Else
        If lngPermissions = -1 Then
            lngPermissions = dhcLanManWin9xAccessMask
        End If
        
        ' Place all strings in the structure as needed
        With si50
            .shi50_netname = strShareName & vbNullChar
            If fIsDiskResource Then
                .shi50_type = dhcLanManStypeDisktree
            Else
                .shi50_type = dhcLanManStypePrintq
            End If
            .shi50_remark = strRemarks & vbNullChar
            .shi50_path = strPath & vbNullChar
            .shi50_ro_password = strRwPassword & vbNullChar
            .shi50_rw_password = strRoPassword & vbNullChar
        End With
    
        dhAddNetworkShare = NetShareAdd9x( _
         strServer, dhcShareInfo50, si50, LenB(si50))
    End If
End Function

Public Function dhDeleteNetworkShare( _
 ByVal strServer As String, ByVal strShareName As String) As Long
    
    ' Deletes a network share
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strServer:
    '       The server on which to add the share
    '   strShareName:
    '       The name of the share to be created
    '
    ' Out:
    '   Return Value:
    '       dhcNoError on success, an error value on failure
    ' Note:
    '
    If IsWinNT() Then
        dhDeleteNetworkShare = NetShareDel( _
         StrPtr(strServer), StrPtr(strShareName), 0&)
    Else
        dhDeleteNetworkShare = NetShareDel9x( _
         strServer, strShareName, 0&)
    End If
End Function

Public Function dhChangeUserPassword( _
 ByVal strOldPwd As String, ByVal strNewPwd As String, _
 Optional strUser As String = vbNullString, _
 Optional strDomain As String = vbNullString) As Long
    
    ' Change a user's password
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strOldPwd:
    '       The user's old password
    '   strNewPwd:
    '       The user's new password
    '   strUser: (optional)
    '       The user name (uses the current user, by default)
    '   strDomain: (optional)
    '       The domain to change the password on (uses the current domain, by default)
    '
    ' Out:
    '   Return Value:
    '       dhcNoError on success, an error value on failure
    ' Note:
    '   THIS FUNCTION WORKS ONLY IN NT/2000.
    '
    
    dhChangeUserPassword = NetUserChangePassword( _
     StrPtr(strDomain), StrPtr(strUser), _
     StrPtr(strOldPwd), StrPtr(strNewPwd))
End Function

Public Function dhGetPDC( _
 Optional ByVal strServer As String = vbNullString, _
 Optional ByVal strDomainName As String = vbNullString) _
 As String
    
    ' Gets the name of the primary domain controller
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strServer:
    '       The name of the server (uses the current computer by default)
    '   strDomainName:
    '       The domain name (uses the current domain by default)
    '
    ' Out:
    '   Return Value:
    '       The PDC on success, a zero-length-string on failure
    ' Note:
    '   THIS FUNCTION WORKS ONLY IN NT/2000.
    '
    
    Dim lngBufptr As Long
    
    If NetGetDCName( _
     StrPtr(strServer), StrPtr(strDomainName), _
     lngBufptr) = dhcNoError Then
        dhGetPDC = dhStrFromPtr(lngBufptr)
        Call NetApiBufferFree(lngBufptr)
    End If
End Function

Public Function dhGetTimeFromServer( _
 Optional ByVal strServer As String = vbNullString) As Date
    ' Gets the time of day from the specified server
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strServer:
    '       The name of the server (the current computer if the
    '       name is a zero-length string)
    '
    ' Out:
    '   Return Value:
    '       The date/time on success, a zero-length-string on failure
    ' Note:
    '   THIS FUNCTION WORKS ONLY IN NT/2000.
    '
    Dim tdi As TIME_OF_DAY_INFO
    Dim lngBufptr As Long
    
    If NetRemoteTOD(StrPtr(strServer), lngBufptr) = 0 Then
        Call RtlMoveMemory(tdi, ByVal lngBufptr, Len(tdi))
        
        ' Convert to a real date/time, allowing for the
        ' time zone shift
        dhGetTimeFromServer = _
         DateSerial(tdi.t_year, tdi.t_month, tdi.t_day) + _
         TimeSerial(tdi.t_hours, tdi.t_mins, tdi.t_secs) - _
         (tdi.t_timezone / 60 / 24)
         
        Call NetApiBufferFree(lngBufptr)
    End If
End Function

' Misc. utility functions

Private Function dhTrimNull(ByVal strValue As String) As String
    ' Find the first vbNullChar in a string, and return
    ' everything prior to that character. Extremely
    ' useful when combined with the Windows API function calls.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strValue:
    '       Input text, possibly containing a null character
    '       (chr$(0), or vbNullChar)
    ' Out:
    '   Return Value:
    '       strValue trimmed on the right, at the location
    '       of the null character, if there was one.
    
    Dim intPos As Integer
    
    intPos = InStr(strValue, vbNullChar)
    Select Case intPos
        Case 0
            ' Not found at all, so just
            ' return the original value.
            dhTrimNull = strValue
        Case 1
            ' Found at the first position, so return
            ' an empty string.
            dhTrimNull = vbNullString
        Case Is > 1
            ' Found in the string, so return the portion
            ' up to the null character.
            dhTrimNull = Left$(strValue, intPos - 1)
    End Select
End Function

Private Function dhStrFromANSIPtr(lngPtr As Long) As String
    ' Takes a long pointer to an ANSI string and returns
    ' the actual string
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   ptr:
    '       The string pointer, presumably from an API call
    ' Out:
    '   Return Value:
    '       The actual string to which it was pointing,
    '       converted to Unicode
    
    Dim strTemp As String
    Dim lngLen As Long
    
    lngLen = lstrlen(lngPtr)
    strTemp = String$(lngLen, vbNullChar)
    If lstrcpyn(StrPtr(strTemp), lngPtr, lngLen + 1) <> 0 Then
        dhStrFromANSIPtr = dhTrimNull(StrConv(strTemp, vbUnicode))
    End If
End Function

Private Function dhStrFromPtr(lngPtr As Long) As String
    ' Takes a long pointer to a Unicode string and returns
    ' the actual string
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   ptr:
    '       The string pointer, presumably from an API call
    ' Out:
    '   Return Value:
    '       The actual string to which it was pointing,
    '       converted to Unicode
    
    Dim strTemp As String
    Dim lngLen As Long
    
    lngLen = lstrlenW(lngPtr)
    strTemp = String$(lngLen, vbNullChar)
    If lstrcpynW(StrPtr(strTemp), lngPtr, lngLen + 1) <> 0 Then
        dhStrFromPtr = dhTrimNull(strTemp)
    End If
End Function

Public Function IsWinNT() As Boolean
    '   A simple wrapper that tells whether you are on Windows NT
    '   (and thus should be using the Unicode versions of the
    '   LAN Manager functions)
    
    IsWinNT = HiByte(LoWord(GetVersion)) = 0
End Function

'----------------------------------------------------------
'   HiByte/LoByte/HiWord/LoWord
'----------------------------------------------------------
Private Function HiByte(ByVal intWord As Integer) As Byte
    HiByte = (intWord And &HFF00) \ (2 ^ 8)
End Function

Private Function LoByte(ByVal intWord As Integer) As Byte
    LoByte = intWord And &HFF
End Function

Private Function HiWord(ByVal lngDWord As Long) As Integer
    HiWord = (lngDWord And &HFFFF0000) \ (2 ^ 16)
End Function

Private Function LoWord(ByVal lngDWord As Long) As Integer
    LoWord = lngDWord And &HFFFF&
End Function

