Attribute VB_Name = "basTestProcedures"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Sub TestUniversal(strPath As String)
    
    Dim uni As UNIVERSAL_NAME_INFO
    Dim rni As REMOTE_NAME_INFO
    
    If dhGetUniversalInfo(strPath, uni) = dhcNoError Then
        Debug.Print "Universal Name : " & uni.strUniversalName
        Debug.Print
    End If
    If dhGetRemoteInfo(strPath, rni) = dhcNoError Then
        Debug.Print "Connection Path: " & rni.strConnectionName
        Debug.Print "Remaining Path : " & rni.strRemainingPath
        Debug.Print "Universal Name : " & rni.strUniversalName
    End If
End Sub

Public Sub dhEnumPCsInDomain(strDomainName As String)

    ' Retrieve all the servers in the given domain
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strDomainName
    '       The name of the domain to search
  
    Dim col As Collection
    Dim nri As NetResourceInfo
    Dim usrNetResourceStart As NETRESOURCE
    Dim strDomainNameANSI As String
    
    strDomainNameANSI = StrConv(strDomainName, vbFromUnicode)
    
    With usrNetResourceStart
        .dwScope = dhcResourceGlobalNet
        .strRemoteName = strDomainNameANSI
    End With

    Set col = dhGetNetResourceInfo(dhcResourceGlobalNet, _
     dhcResourceTypeDisk, dhcResourceUsageContainer, _
     True, usrNetResourceStart)
    
    If Not (col Is Nothing) Then
        For Each nri In col
            Debug.Print nri.RemoteName
        Next nri
    End If
    
End Sub

Public Sub dhEnumSharesOnPC(Optional ByVal strMachineName As String)

    ' Retrieve all the shares on the given machine
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strMachineName
    '       The name of the machine to search
    
    Dim col As Collection
    Dim nri As NetResourceInfo
    Dim usrNetResourceStart As NETRESOURCE
    Dim strMachineNameANSI As String
    
    If Len(strMachineName) = 0 Then
        strMachineName = dhGetComputerName
    End If
    
    If Left$(strMachineName, 2) <> "\\" Then
        strMachineName = "\\" & strMachineName
    End If
    strMachineNameANSI = StrConv(strMachineName, vbFromUnicode)
    
    With usrNetResourceStart
        .dwScope = dhcResourceGlobalNet
        .strRemoteName = strMachineNameANSI
    End With

    Set col = dhGetNetResourceInfo( _
     dhcResourceGlobalNet, dhcResourceTypeDisk, _
     dhcResourceUsageConnectable, True, _
     usrNetResourceStart)
     
    If Not (col Is Nothing) Then
        For Each nri In col
            Debug.Print nri.RemoteName
        Next nri
    End If
    
End Sub

Public Sub dhEnumConnectedResourcesOnLocalPC()
    
    ' Retrieve all the connections on the current machine
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   (NONE)
        
    Dim col As Collection
    Dim nri As NetResourceInfo
    Dim usrNetResourceStart As NETRESOURCE
    
    Set col = dhGetNetResourceInfo(dhcResourceConnected, _
     dhcResourceTypeDisk, 0, False, usrNetResourceStart)
    If Not (col Is Nothing) Then
        For Each nri In col
            Debug.Print nri.LocalName; _
             " is connected to "; nri.RemoteName
        Next nri
    End If
End Sub

Public Sub dhEnumAvailableNetworks()
    
    ' Retrieve all the network types available (usually this will just be
    ' the 'Microsoft Windows Network' but can also be Novell or other
    ' types when they are available.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   (NONE)
        
    Dim col As Collection
    Dim nri As NetResourceInfo
    Dim usrNetResourceStart As NETRESOURCE
    
    Set col = dhGetNetResourceInfo(dhcResourceGlobalNet, _
     dhcResourceTypeDisk, dhcResourceUsageConnectable, _
     False, usrNetResourceStart)
    If Not (col Is Nothing) Then
        For Each nri In col
            Debug.Print nri.RemoteName
        Next nri
    End If
End Sub

