Attribute VB_Name = "basDiskInfo"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 12

' APIs for drive information
Private Declare Function GetLogicalDrives Lib "kernel32" () As Long
Private Declare Function GetLogicalDriveStrings Lib "kernel32" _
 Alias "GetLogicalDriveStringsA" _
 (ByVal nBufferLength As Long, ByVal lpBuffer As String) _
 As Long

' GetDriveType return values
Private Const DRIVE_UNKNOWN = 0
Private Const DRIVE_NOROOT = 1
Private Const DRIVE_REMOVABLE = 2
Private Const DRIVE_FIXED = 3
Private Const DRIVE_REMOTE = 4
Private Const DRIVE_CDROM = 5
Private Const DRIVE_RAMDISK = 6

Private Declare Function GetDriveType Lib "kernel32" _
 Alias "GetDriveTypeA" (ByVal nDrive As String) As Long

Private Declare Function GetDiskFreeSpace Lib "kernel32" _
 Alias "GetDiskFreeSpaceA" _
 (ByVal lpRootPathName As String, _
 lpSectorsPerCluster As Long, _
 lpBytesPerSector As Long, _
 lpNumberOfFreeClusters As Long, _
 lpTotalNumberOfClusters As Long) As Long

Public Declare Function GetDiskFreeSpaceEx Lib "kernel32" _
 Alias "GetDiskFreeSpaceExA" _
 (ByVal lpRootPathName As String, _
 curFreeBytesAvailableToCaller As Currency, _
 curTotalNumberOfBytes As Currency, _
 curTotalNumberOfFreeBytes As Currency) As Boolean

Private Declare Function GetVolumeInformation Lib "kernel32" _
 Alias "GetVolumeInformationA" _
 (ByVal lpRootPathName As String, _
 ByVal lpVolumeNameBuffer As String, _
 ByVal nVolumeNameSize As Long, _
 lpVolumeSerialNumber As Long, _
 lpMaximumComponentLength As Long, _
 lpFileSystemFlags As Long, _
 ByVal lpFileSystemNameBuffer As String, _
 ByVal nFileSystemNameSize As Long) As Long

' Constants for volume information
Private Const FILE_CASE_SENSITIVE_SEARCH = &H1
Private Const FILE_CASE_PRESERVED_NAMES = &H2
Private Const FILE_UNICODE_ON_DISK = &H4
Private Const FILE_PERSISTENT_ACLS = &H8
Private Const FILE_FILE_COMPRESSION = &H10
Private Const FILE_VOLUME_IS_COMPRESSED = &H8000

Private Declare Function SetVolumeLabel Lib "kernel32" _
 Alias "SetVolumeLabelA" (ByVal lpRootPathName As String, _
 ByVal lpVolumeName As String) As Long

Function dhGetDrivesByNum(colDrives As Collection) _
 As Integer

    ' Retrieves a collection of drive numbers (0 = A:, etc.).

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   colDrives
    '       Pointer to VBA Collection object.
    ' Out:
    '   colDrives
    '       Contains one entry for each installed drive.
    '   Return Value:
    '       Number of drives.
    ' Example:
    '   Dim colDrives As New Collection
    '   Dim varDrive As Variant
    '
    '   If dhGetDrivesByNum(colDrives) > 0 Then
    '       For Each varDrive In colDrives
    '           Debug.Print varDrive
    '       Next
    '   End If
 
    Dim lngDrives As Long
    Dim intDrive As Integer
    
    ' Reset the collection
    Set colDrives = New Collection
    
    ' Get the logical drives
    lngDrives = GetLogicalDrives()
    
    ' Do a bitwise compare on the first 26 bits
    For intDrive = 0 To 25
        If (lngDrives And (2 ^ intDrive)) <> 0 Then
            colDrives.Add intDrive, Chr(65 + intDrive)
        End If
    Next
    
    ' Return the number of drives found
    dhGetDrivesByNum = colDrives.Count
    
End Function

Function dhGetDrivesByString(colDrives As Collection) _
 As Integer

    ' Retrieves a collection of drives as string ("a:\", "b:\", etc.).

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   colDrives
    '       Pointer to VBA collection object.
    ' Out:
    '   colDrives
    '       Contains one entry for each installed drive.
    '   Return Value:
    '       Number of drives.
    ' Example:
    '   Dim colDrives As New Collection
    '   Dim varDrive As Variant
    '
    '   If dhGetDrivesByString(colDrives) > 0 Then
    '       For Each varDrive In colDrives
    '           Debug.Print varDrive
    '       Next
    '   End If

    Dim strBuffer As String
    Dim lngBytes As Long
    Dim intPos As Integer
    Dim varArray As Variant
    Dim strDrive As String
    
    ' Reset the collection
    Set colDrives = New Collection
    
    ' Set up a buffer
    strBuffer = Space(255)
    
    ' Get the logical drive string
    lngBytes = GetLogicalDriveStrings( _
     Len(strBuffer), strBuffer)
    
    ' Parse the drive string by looking
    ' for the null delimiter and add each to
    ' the collection
    varArray = Split(strBuffer, Chr$(0))
    Do
        strDrive = varArray(intPos)
        colDrives.Add strDrive, strDrive
        intPos = intPos + 1
    Loop Until Len(varArray(intPos)) = 0
    
    ' Return the number of drives found
    dhGetDrivesByString = colDrives.Count
End Function

Sub dhPrintDrives()

    ' Sample procedure demonstrating drive functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintDrives

    Dim colDrives As New Collection
    Dim varDrive As Variant
    
    ' First by number
    Debug.Print "Drives found: " & _
     dhGetDrivesByNum(colDrives)
    For Each varDrive In colDrives
        Debug.Print varDrive,
    Next
    
    Debug.Print
    
    ' Then by letter
    Debug.Print "Drives found: " & _
     dhGetDrivesByString(colDrives)
    For Each varDrive In colDrives
        Debug.Print varDrive,
    Next
End Sub

Sub dhPrintDriveTypes()

    ' Sample procedure demonstrating GetDriveType API function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintDriveTypes

    Dim colDrives As New Collection
    Dim varDrive As Variant
    Dim lngType As Long
    
    ' Get drive letters
    If dhGetDrivesByString(colDrives) > 0 Then
        For Each varDrive In colDrives
            ' Print drive letter
            Debug.Print varDrive,
            
            ' Print drive type
            lngType = GetDriveType(CStr(varDrive))
            Select Case lngType
                Case DRIVE_UNKNOWN
                    Debug.Print "Unknown"
                Case DRIVE_NOROOT
                    Debug.Print "Unknown"
                Case DRIVE_REMOVABLE
                    Debug.Print "Removable Media"
                Case DRIVE_FIXED
                    Debug.Print "Fixed Disk"
                Case DRIVE_REMOTE
                    Debug.Print "Network Drive"
                Case DRIVE_CDROM
                    Debug.Print "CD-ROM"
                Case DRIVE_RAMDISK
                    Debug.Print "RAM Disk"
            End Select
        Next
    End If
End Sub

Function dhTotalDiskSpace(Optional strDrive As _
 String = vbNullString) As Long

    ' Computes total disk space for a given drive.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       Total disk space in bytes.
    ' Example:
    '   Dim lngBytes As Long
    '
    '   lngBytes = dhTotalDiskSpace("C:\")
 
    Dim lngSectorsPerCluster As Long
    Dim lngBytesPerSector As Long
    Dim lngNumberOfFreeClusters As Long
    Dim lngTotalNumberOfClusters As Long
     
    On Error GoTo HandleError
     
    ' Call GetDiskFreeSpace
    If CBool(GetDiskFreeSpace(strDrive, _
     lngSectorsPerCluster, _
     lngBytesPerSector, _
     lngNumberOfFreeClusters, _
     lngTotalNumberOfClusters)) Then
     
        ' If successful compute total disk space
        dhTotalDiskSpace = _
         lngSectorsPerCluster * _
         lngBytesPerSector * _
         lngTotalNumberOfClusters
    Else
        dhTotalDiskSpace = -1
    End If
ExitHere:
    Exit Function
HandleError:
    If Err.Number = 6 Then  ' Overflow
        dhTotalDiskSpace = (2 ^ 31) - 1
    Else
        dhTotalDiskSpace = -1
    End If
    Resume ExitHere
End Function

Function dhFreeDiskSpace(Optional strDrive As _
 String = vbNullString) As Long

    ' Computes free disk space for a given drive.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       Free disk space in bytes.
    ' Example:
    '   Dim lngBytes As Long
    '
    '   lngBytes = dhFreeDiskSpace("C:\")
 
    Dim lngSectorsPerCluster As Long
    Dim lngBytesPerSector As Long
    Dim lngNumberOfFreeClusters As Long
    Dim lngTotalNumberOfClusters As Long
     
    On Error GoTo HandleError
     
    ' Call GetDiskFreeSpace
    If CBool(GetDiskFreeSpace(strDrive, _
     lngSectorsPerCluster, _
     lngBytesPerSector, _
     lngNumberOfFreeClusters, _
     lngTotalNumberOfClusters)) Then
     
        ' If successful compute free disk space
        dhFreeDiskSpace = _
         lngSectorsPerCluster * _
         lngBytesPerSector * _
         lngNumberOfFreeClusters
    Else
        dhFreeDiskSpace = -1
    End If
ExitHere:
    Exit Function
HandleError:
    If Err.Number = 6 Then  ' Overflow
        dhFreeDiskSpace = (2 ^ 31) - 1
    Else
        dhFreeDiskSpace = -1
    End If
    Resume ExitHere
End Function

Sub dhPrintDiskSpace()

    ' Sample procedure demonstrating disk space functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintDiskSpace

    Dim colDrives As New Collection
    Dim varDrive As Variant
    
    ' Get drive letters
    If dhGetDrivesByString(colDrives) > 0 Then
    
        ' Print header
        Debug.Print "Drive", "Total Bytes", "Free Bytes"
        
        ' Print drive space for all drives
        For Each varDrive In colDrives
            
            Debug.Print varDrive, _
             dhTotalDiskSpace(CStr(varDrive)), _
             dhFreeDiskSpace(CStr(varDrive))
            
        Next
    End If
End Sub

Function dhTotalDiskSpaceEx(Optional strDrive As _
 String = vbNullString) As Currency

    ' Computes total disk space for a given drive.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       Total disk space in bytes.
    ' Example:
    '   Dim lngBytes As Long
    '
    '   lngBytes = dhTotalDiskSpaceEx("C:\")
 
    Dim curTotal As Currency
    Dim curFree As Currency
    Dim curFreeToMe As Currency
     
    ' Call GetDiskFreeSpaceEx
    If GetDiskFreeSpaceEx(strDrive, _
     curFreeToMe, curTotal, curFree) Then
     
        ' If successful compute total disk space
        dhTotalDiskSpaceEx = curTotal * 10000
    Else
        dhTotalDiskSpaceEx = -1
    End If
End Function

Function dhFreeDiskSpaceEx(Optional strDrive As _
 String = vbNullString) As Currency

    ' Computes free disk space for a given drive.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       Free disk space in bytes.
    ' Example:
    '   Dim lngBytes As Long
    '
    '   lngBytes = dhFreeDiskSpaceEx("C:\")
 
    Dim curTotal As Currency
    Dim curFree As Currency
    Dim curFreeToMe As Currency
     
    ' Call GetDiskFreeSpaceEx
    If GetDiskFreeSpaceEx(strDrive, _
     curFreeToMe, curTotal, curFree) Then
     
        ' If successful compute free disk space
        dhFreeDiskSpaceEx = curFree * 10000
    Else
        dhFreeDiskSpaceEx = -1
    End If
End Function

Function dhMyFreeDiskSpaceEx(Optional strDrive As _
 String = vbNullString) As Currency

    ' Computes free disk space for a given drive
    ' and the current user.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       Free disk space in bytes.
    ' Example:
    '   Dim lngBytes As Long
    '
    '   lngBytes = dhMyFreeDiskSpaceEx("C:\")
 
    Dim curTotal As Currency
    Dim curFree As Currency
    Dim curFreeToMe As Currency
     
    ' Call GetDiskFreeSpaceEx
    If GetDiskFreeSpaceEx(strDrive, _
     curFreeToMe, curTotal, curFree) Then
     
        ' If successful compute free disk space
        dhMyFreeDiskSpaceEx = curFreeToMe * 10000
    Else
        dhMyFreeDiskSpaceEx = -1
    End If
End Function

Sub dhPrintDiskSpaceEx()

    ' Sample procedure demonstrating disk space functions.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintDiskSpaceEx

    Dim colDrives As New Collection
    Dim varDrive As Variant
    
    ' Get drive letters
    If dhGetDrivesByString(colDrives) > 0 Then
    
        ' Print header
        Debug.Print "Drive", "Total Bytes", _
         "Free Bytes", "Free To Me"
        
        ' Print drive space for all drives
        For Each varDrive In colDrives
            
            Debug.Print varDrive, _
             dhTotalDiskSpaceEx(CStr(varDrive)), _
             dhFreeDiskSpaceEx(CStr(varDrive)), _
             dhMyFreeDiskSpaceEx(CStr(varDrive))
            
        Next
    End If
End Sub

Sub dhPrintVolInfo(Optional strDrive As String = vbNullString)

    ' Sample procedure demonstrating GetVolumeInformation API function.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strDrive (Optional, default = vbNullString)
    '       String representing root directory of a drive
    '       (e.g. "C:\") or empty string for current drive.
    ' Out:
    '   Return Value:
    '       n/a
    ' Example:
    '   Call dhPrintVolInfo

    Dim strVolLabel As String
    Dim strFileSystem As String
    Dim lngVolumeSerialNumber As Long
    Dim lngMaximumComponentLength As Long
    Dim lngFileSystemFlags As Long
 
    ' Set up the buffers
    strVolLabel = Space(255)
    strFileSystem = Space(255)
    
    ' Call GetVolumeInformation
    If CBool(GetVolumeInformation(strDrive, _
     strVolLabel, Len(strVolLabel), _
     lngVolumeSerialNumber, _
     lngMaximumComponentLength, _
     lngFileSystemFlags, _
     strFileSystem, Len(strFileSystem))) Then
        
        ' Parse buffers
        strVolLabel = dhTrimNull(strVolLabel)
        strFileSystem = dhTrimNull(strFileSystem)
        
        ' Print information
        Debug.Print strDrive
        Debug.Print strVolLabel
        Debug.Print Hex(lngVolumeSerialNumber)
        Debug.Print lngMaximumComponentLength
        Debug.Print dhFileSystemFlags(lngFileSystemFlags)
        
        ' Print flag results
    End If
End Sub

Function dhFileSystemFlags(lngFlags As Long) As String

    ' Converts file system flags to text description.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   lngFlags
    '       File system flags from GetVolumeInformation.
    ' Out:
    '   Return Value:
    '       Text description of flags.
    ' Example:
    '   Debug.Print dhFileSystemFlags(lngFlags)
    
    Dim strTemp As String
    
    If (lngFlags And FILE_CASE_SENSITIVE_SEARCH) <> 0 Then
        strTemp = strTemp & "/Supports case senstive searches"
    End If
    If (lngFlags And FILE_CASE_PRESERVED_NAMES) <> 0 Then
        strTemp = strTemp & "/Allows case senstive names"
    End If
    If (lngFlags And FILE_UNICODE_ON_DISK) <> 0 Then
        strTemp = strTemp & "/Uses Unicode file names"
    End If
    If (lngFlags And FILE_PERSISTENT_ACLS) <> 0 Then
        strTemp = strTemp & "/Uses ACLs"
    End If
    If (lngFlags And FILE_FILE_COMPRESSION) <> 0 Then
        strTemp = strTemp & "/Supports file compression"
    End If
    If (lngFlags And FILE_VOLUME_IS_COMPRESSED) <> 0 Then
        strTemp = strTemp & "/Volume is compressed"
    End If
    
    dhFileSystemFlags = strTemp
End Function

Sub dhPrintVolumeSummary()

    ' Sample procedure that prints information on all installed drives.

    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   n/a
    ' Out:
    '   n/a
    ' Example:
    '   Call dhPrintVolumeSummary

    Dim colDrives As New Collection
    Dim varDrive As Variant
    
    ' Get drive letters
    If dhGetDrivesByString(colDrives) > 0 Then
    
        ' Print header
        Debug.Print "Drive", "Label", "Serial#", _
         "Max Length", "Flags"
        
        ' Print drive space for all drives
        For Each varDrive In colDrives
            
            Call dhPrintVolInfo(CStr(varDrive))
            
        Next
    End If
End Sub

