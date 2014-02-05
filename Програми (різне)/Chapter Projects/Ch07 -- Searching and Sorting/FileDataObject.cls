VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "FileDataObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' FileDataObject class, used with dhQuickSortObjects

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private Type FileInfo
    FullName As String
    Name As String
    Extension As String
End Type

Private mafiItems() As FileInfo     ' Store the local data.
Private mlngCount As Long           ' Keep track of the number of items.
Private mfiCompare As FileInfo      ' Store away one item for comparisons while sorting.

Public Sub Add(varItem As Variant)
    mlngCount = mlngCount + 1
    ReDim Preserve mafiItems(1 To mlngCount)
    mafiItems(mlngCount).FullName = varItem
    Call SplitFile(mafiItems(mlngCount))
End Sub

Property Get Count() As Long
    ' Not necessary, but it can't hurt.
    Count = mlngCount
End Property

Public Function Item(lngItem As Long) As String
    ' This will raise an error if you
    ' attempt to retrieve a value out of
    ' range. Make sure and use the LowerBound
    ' and UpperBound properties to determine
    ' the correct range of values.
    Item = mafiItems(lngItem).FullName
End Function

Public Sub DumpItems(strText As String, _
 Optional lngStart As Long = -1, _
 Optional lngEnd As Long = -1, _
 Optional blnNumber As Boolean = True)
 
    Dim lngI As Long
    Dim strOut As String
    
    If lngStart = -1 Then
        lngStart = LBound(mafiItems)
    End If
    If lngEnd = -1 Then
        lngEnd = UBound(mafiItems)
    End If
    
    For lngI = lngStart To lngEnd
        If blnNumber Then
            strOut = strOut & Right$(Space(4) & lngI, 4) & ": "
        End If
        strOut = strOut & mafiItems(lngI).FullName & vbCrLf
    Next lngI
    Debug.Print strText
    Debug.Print strOut
End Sub
 
Private Sub SplitFile(fi As FileInfo)
    ' Given a file name, fill in the FullName
    ' and Extension fields in the structure.
    Dim lngPos As Long
    
    lngPos = InStrRev(fi.FullName, ".")
    ' If there was an extension, split the file name.
    ' If not, just use the full file name as the first portion.
    If lngPos > 0 Then
        fi.Name = Left$(fi.FullName, lngPos - 1)
        fi.Extension = Mid$(fi.FullName, lngPos + 1)
    Else
        fi.Name = fi.FullName
        fi.Extension = ""
    End If
End Sub

Public Sub SetCompareValue(lngItem As Long)
    mfiCompare = mafiItems(lngItem)
End Sub

Public Function Compare(lngItem As Long) As Long
    
    ' Compare two FileInfo structures, so you can sort
    ' first by extension, and then by name.
    ' First, compare the extensions. If they're not
    ' the same, return the comparison value.
    ' If they're the same, compare the names
    ' and return the comparison value of those.
    
    Dim lngResult As Long
    
    ' Compare extensions.
    lngResult = StrComp( _
     mafiItems(lngItem).Extension, _
     mfiCompare.Extension, vbTextCompare)
     
    Select Case lngResult
        Case -1, 1
            Compare = lngResult
        Case 0
            ' Extensions are the same, so compare file names.
            Compare = StrComp( _
             mafiItems(lngItem).Name, _
             mfiCompare.Name, vbTextCompare)
    End Select
End Function

Public Sub Swap(lngItem1 As Long, lngItem2 As Long)
    Dim fiTemp As FileInfo

    fiTemp = mafiItems(lngItem2)
    mafiItems(lngItem2) = mafiItems(lngItem1)
    mafiItems(lngItem1) = fiTemp
End Sub

Public Property Get LowerBound() As Long
    LowerBound = LBound(mafiItems)
End Property

Public Property Get UpperBound() As Long
    UpperBound = UBound(mafiItems)
End Property


