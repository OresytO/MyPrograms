Attribute VB_Name = "Module1"
Option Explicit

Private Declare Function LoadLibrary _
 Lib "kernel32" Alias "LoadLibraryA" _
 (ByVal lpLibFileName As String) As Long
Private Declare Function GetProcAddress _
 Lib "kernel32" _
 (ByVal hModule As Long, ByVal lpProcName As String) As Long

Public Declare Function GetDiskFreeSpaceEx _
 Lib "kernel32" Alias "GetDiskFreeSpaceExA" _
 (ByVal lpRootPathName As String, _
 curFreeBytesAvailableToCaller As Currency, _
 curTotalNumberOfBytes As Currency, _
 curTotalNumberOfFreeBytes As Currency) As Boolean
 
Public Declare Function GetDiskFreeSpace _
 Lib "kernel32" Alias "GetDiskFreeSpaceA" _
 (ByVal lpRootPathName As String, _
 lpSectorsPerCluster As Long, lpBytesPerSector As Long, _
 lpNumberOfFreeClusters As Long, lpTotalNumberOfClusters As Long) As Boolean
 
Public Function IsGetDiskFreeSpaceExOK() As Boolean
    Dim hModule As Long
    Dim lngAddress As Long
    
    hModule = LoadLibrary("kernel32.DLL")
    If hModule <> 0 Then
        lngAddress = GetProcAddress(hModule, "GetDiskFreeSpaceExA")
    End If
    IsGetDiskFreeSpaceExOK = (lngAddress <> 0)
End Function


Sub Test()
    If IsGetDiskFreeSpaceExOK() Then
        Dim curFreeToMe As Currency
        Dim curTotalBytes As Currency
        Dim curFreeBytes As Currency
    
        If GetDiskFreeSpaceEx("C:", _
         curFreeToMe, curTotalBytes, curFreeBytes) Then
            Debug.Print "Free to me : " & curFreeToMe * 10000
            Debug.Print "Total bytes: " & curTotalBytes * 10000
            Debug.Print "Free bytes : " & curFreeBytes * 10000
        End If
    Else
        Dim lngSectorsPerCluster As Long
        Dim lngBytesPerSector As Long
        Dim lngNumberOfFreeClusters As Long
        Dim lngTotalNumberOfClusters As Long
        
        If GetDiskFreeSpace("C:", lngSectorsPerCluster, _
         lngBytesPerSector, lngNumberOfFreeClusters, lngTotalNumberOfClusters) Then
            Debug.Print "Free bytes : " & lngBytesPerSector * lngSectorsPerCluster * lngNumberOfFreeClusters
            Debug.Print "Total bytes: " & lngBytesPerSector * lngSectorsPerCluster * lngTotalNumberOfClusters
        End If
    End If
End Sub

