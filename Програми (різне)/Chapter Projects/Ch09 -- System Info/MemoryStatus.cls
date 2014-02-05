VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "MemoryStatus"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' Memory information class.

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Type MemoryStatus
    dwLength As Long
    dwMemoryLoad As Long
    dwTotalPhys As Long
    dwAvailPhys As Long
    dwTotalPageFile As Long
    dwAvailPageFile As Long
    dwTotalVirtual As Long
    dwAvailVirtual As Long
End Type
Private ms As MemoryStatus

Private Type MEMORYSTATUSEX
    dwLength As Long
    dwMemoryLoad As Long
    ullTotalPhys As Currency
    ullAvailPhys As Currency
    ullTotalPageFile As Currency
    ullAvailPageFile As Currency
    ullTotalVirtual As Currency
    ullAvailVirtual As Currency
    ullAvailExtendedVirtual As Currency
End Type
Private msEx As MEMORYSTATUSEX

Private Declare Sub GlobalMemoryStatus _
 Lib "kernel32" _
 (lpBuffer As MemoryStatus)
 
Private Declare Sub GlobalMemoryStatusEx _
 Lib "kernel32" _
 (lpBuffer As MEMORYSTATUSEX)

' 5113 is arbitrary.
Private Const dhcErrBase = vbObjectError + 5113
Private Const ERR_STRING = "Invalid for this operating system."
Private Const ERR_INVALID_OS = dhcErrBase + 1

Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type
Private osvi As OSVERSIONINFO

Private Declare Function GetVersionEx _
 Lib "kernel32" Alias "GetVersionExA" _
 (lpVersionInformation As Any) As Long

Private mblnIsWin2000 As Boolean

' Should this class raise errors if the
' operating system doesn't support the
' requested operation, or should it silently fail?
Public RaiseErrors As Boolean

Public Property Get MemoryLoad() As Long
    ' Number between 0 and 100 that gives a general idea
    ' of current memory utilization, in which 0 indicates
    ' no memory use and 100 indicates full memory use.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        MemoryLoad = msEx.dwMemoryLoad
    Else
        Call GlobalMemoryStatus(ms)
        MemoryLoad = ms.dwMemoryLoad
    End If
End Property

Public Property Get TotalPhysical() As Long
    ' Indicates the total number of bytes of physical memory.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        TotalPhysical = CurrencyToLong(msEx.ullTotalPhys)
    Else
        Call GlobalMemoryStatus(ms)
        TotalPhysical = ms.dwTotalPhys
    End If
End Property

Public Property Get AvailablePhysical() As Long
    ' Indicates the number of bytes of physical memory available.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        AvailablePhysical = CurrencyToLong(msEx.ullAvailPhys)
    Else
        Call GlobalMemoryStatus(ms)
        AvailablePhysical = ms.dwAvailPhys
    End If
End Property

Public Property Get TotalPageFile() As Long
    ' Indicates the total number of bytes that can be stored
    ' in the paging file, not the size of the paging file on disk.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        TotalPageFile = CurrencyToLong(msEx.ullTotalPageFile)
    Else
        Call GlobalMemoryStatus(ms)
        TotalPageFile = ms.dwTotalPageFile
    End If
End Property

Public Property Get AvailablePageFile() As Long
    ' Indicates the number of bytes available in the paging file.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        AvailablePageFile = CurrencyToLong(msEx.ullAvailPageFile)
    Else
        Call GlobalMemoryStatus(ms)
        AvailablePageFile = ms.dwAvailPageFile
    End If

End Property

Public Property Get TotalVirtual() As Long
    ' Indicates the total number of bytes
    ' that can be described in the user mode
    ' portion of the virtual address space
    ' of the calling process.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        TotalVirtual = CurrencyToLong(msEx.ullTotalVirtual)
    Else
        Call GlobalMemoryStatus(ms)
        TotalVirtual = ms.dwTotalVirtual
    End If
End Property

Public Property Get AvailableVirtual() As Long
    ' Indicates the number of bytes of unreserved and
    ' uncommitted memory in the user mode portion
    ' of the virtual address space of the calling process.
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        AvailableVirtual = CurrencyToLong(msEx.ullAvailVirtual)
    Else
        Call GlobalMemoryStatus(ms)
        AvailableVirtual = ms.dwAvailVirtual
    End If
End Property

Public Property Get AvailableExtendedVirtual() As Long
    ' Indicates the number of bytes of unreserved and
    ' uncommitted memory in the VLM portion of the
    ' virtual address space of the calling process. The
    ' total memory available in VLM space is 28 GB.
    ' Win2000 only
    If mblnIsWin2000 Then
        Call GlobalMemoryStatusEx(msEx)
        AvailableExtendedVirtual = CurrencyToLong(msEx.ullAvailExtendedVirtual)
    Else
        Call HandleErrors(ERR_INVALID_OS)
    End If
End Property

Private Function CurrencyToLong(curValue As Currency) As Long
    ' Converts a 64-bit Currency value to a Long value
    '
    CurrencyToLong = curValue * 10000
End Function

Private Sub HandleErrors( _
 lngErrCode As Long, _
 Optional strErrMsg As String)
    ' Centralized error handler to raise
    ' the errors to the client
    
    With Err
        If RaiseErrors Then
            If Len(strErrMsg) > 0 Then
                .Raise .Number, _
                 "MemoryStatus", .Description, _
                 .HelpFile, .HelpContext
            Else
                .Raise lngErrCode, "MemoryStatus", ERR_STRING
            End If
        End If
    End With
End Sub

Private Sub Class_Initialize()
    Const VER_PLATFORM_WIN32_NT = 2
    
    ' Set the flag to true so that an error is raised
    ' if a non-applicable Public Property is used for a particular
    ' operating system
    RaiseErrors = True
    
    ' First, confirm whether the OS is Win2000.
    osvi.dwOSVersionInfoSize = Len(osvi)
    If CBool(GetVersionEx(osvi)) Then
        With osvi
            mblnIsWin2000 = _
            (.dwPlatformId = VER_PLATFORM_WIN32_NT _
             And .dwMajorVersion = 5)
        End With
    End If
    
    ' ms and msEx are declared at the module level.
    If mblnIsWin2000 Then
        ' On Win2000, the recommended
        ' extended version of the function
        ' will be called.
        msEx.dwLength = Len(msEx)
    Else
        ' Other platforms use the original version.
        ms.dwLength = Len(ms)
    End If
End Sub


