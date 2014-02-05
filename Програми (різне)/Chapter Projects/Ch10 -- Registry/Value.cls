VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Value"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Value class from Chapter 10

' Private variables for property values
Private mobjParent As Key
Private mstrName As String
Private mlngDataType As Long

' API Functions
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
 
Property Get Value() As Variant
    Dim strBuffer As String
    Dim lngBuffer As Long
    Dim lngRet As Long
    Dim abytData() As Byte
    Dim cb As Long

    ' To return a value we need to figure out
    ' what data type the value is and then call
    ' RegQueryValueEx using an appropriate lpData
    ' argument
    Select Case mlngDataType
        
        ' String
        Case RegSz
        
            ' Create a string buffer and set the
            ' size variable to pass
            strBuffer = Space(RegMaxDataSize)
            cb = Len(strBuffer)
            
            ' Call RegQueryValueEx passing
            ' address of string buffer
            lngRet = RegQueryValueEx( _
             mobjParent.Handle, mstrName, 0&, _
             mlngDataType, ByVal strBuffer, cb)
            
            ' If successful, return portion of
            ' buffer filled in by the function
            If lngRet = Success Then
                Value = Left(strBuffer, cb - 1)
            End If
        
        ' Long Integer
        Case RegDWord
        
            ' Set size argument to size of Long
            cb = Len(lngBuffer)
            
            ' Call RegQueryValueEx passing
            ' address to Long Integer variable
            lngRet = RegQueryValueEx( _
             mobjParent.Handle, mstrName, 0&, _
             mlngDataType, lngBuffer, cb)
             
            ' If successful, return value
            If lngRet = Success Then
                Value = lngBuffer
            End If
        
        ' Binary
        Case RegBinary
        
            ' Create an array of bytes
            ReDim abytData(1 To RegMaxDataSize)
            cb = UBound(abytData)
            
            ' Call RegQueryValueEx passing
            ' address of first array element
            lngRet = RegQueryValueEx( _
             mobjParent.Handle, mstrName, 0&, _
             mlngDataType, abytData(1), cb)
             
            ' If successful, resize array and
            ' return a pointer to it
            If lngRet = Success And cb > 0 Then
                ReDim Preserve abytData(1 To cb)
                Value = abytData
            End If
    End Select
End Property

Property Let Value(varData As Variant)
    Dim strBuffer As String
    Dim lngBuffer As Long
    Dim lngRet As Long
    Dim abytData() As Byte
    Dim lngElements As Long
    Dim cElement As Long
    Dim cArray As Long
    Dim cb As Long

    Select Case mlngDataType
        ' Long integer
        Case RegDWord
            ' Convert data to long integer
            lngBuffer = varData
            ' Set buffer size
            cb = Len(lngBuffer)
            ' Set value
            lngRet = RegSetValueEx(mobjParent.Handle, _
             mstrName, 0&, mlngDataType, lngBuffer, cb)
        
        ' String
        Case RegSz
            ' Convert data to string
            strBuffer = varData
            ' Size buffer
            cb = Len(strBuffer) + 1
            ' Set value
            lngRet = RegSetValueEx(mobjParent.Handle, _
             mstrName, 0&, mlngDataType, ByVal strBuffer, cb)
             
        ' Binary
        Case RegBinary
            ' Determine number of bytes
            lngElements = UBound(varData) - LBound(varData) + 1
            ' Resize Byte array
            ReDim abytData(1 To lngElements)
            ' Set buffer size
            cb = lngElements
            ' Put data into array
            For cElement = LBound(varData) To UBound(varData)
                cArray = cArray + 1
                abytData(cArray) = varData(cElement)
            Next
            ' Set value
            lngRet = RegSetValueEx(mobjParent.Handle, _
             mstrName, 0&, mlngDataType, abytData(1), cb)
    End Select
    
End Property

Property Get Name() As String
    Name = mstrName
End Property
Property Let Name(ByVal strName As String)
    Static bNameSet As Boolean
    
    If Not bNameSet Then
        mstrName = strName
        bNameSet = True
    End If
End Property

Property Get Parent() As Key
    Set Parent = mobjParent
End Property
Property Set Parent(objParent As Key)
    If mobjParent Is Nothing Then
        Set mobjParent = objParent
    End If
End Property

Property Get DataType() As Long
    DataType = mlngDataType
End Property
Property Let DataType(lngDataType As Long)
    mlngDataType = lngDataType
End Property

Property Get FullPath() As String
    Dim objParent As Key
    Dim strTemp As String

    ' Set starting point
    Set objParent = mobjParent
    
    ' Loop until objParent is Nothing (at the root)
    Do
        strTemp = objParent.Name & "\" & strTemp
        Set objParent = objParent.Parent
    Loop Until objParent Is Nothing
    
    ' Add value name
    strTemp = strTemp & mstrName

    ' Set return value
    FullPath = strTemp
End Property

