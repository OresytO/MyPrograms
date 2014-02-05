Attribute VB_Name = "basTestFunctions"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 10

Sub TestRegClasses()

    ' Declarations for Listing 10.12
    Dim objRegistry As Win32Registry
    Dim objKey As Key
    
    ' Declarations for Listing 10.13
    Dim objSubKey As Key
    Dim objValue As Value
    Dim cObject As Long
    
    ' Declarations for Listing 10.14
    Dim objNewKey As Key
    Dim objNewValue As Value

    ' Code for Listing 10.12
    ' ----------------------
    ' Open the registry
    Set objRegistry = New Win32Registry
    
    ' Open the Control Panel\Desktop subkey
    Set objKey = objRegistry.KeyUser.OpenSubKey( _
     "Control Panel\Desktop")

    ' Print the key's full path
    Debug.Print "Opened: " & objKey.FullPath

    ' Code for Listing 10.13
    ' ----------------------
    ' List any subkeys
    Debug.Print "Subkeys:"
    For cObject = 1 To objKey.SubKeys.Count
        Set objSubKey = objKey.SubKeys.Item(cObject)
        Debug.Print objSubKey.Name, objSubKey.Handle
    Next
    
    ' List any values
    Debug.Print "Values:"
    For cObject = 1 To objKey.Values.Count
        Set objValue = objKey.Values.Item(cObject)
        Debug.Print objValue.Name, objValue.Value
    Next
    
    ' Code for Listing 10.14
    ' ----------------------
    ' Check to see if it exists and, if so, delete it
    If objKey.SubKeyExists("CustomOptions") Then
        objKey.SubKeys.Remove "CustomOptions"
    End If
    
    ' Add a new subkey beneath ...\Desktop
    Set objNewKey = objKey.SubKeys.Add("CustomOptions")
    Debug.Print "Added: " & objNewKey.FullPath
    
    ' Set the default value
    objNewKey.Values.Item("").Value = "Default"
    
    ' Add a string value
    Set objNewValue = objNewKey.Values. _
     Add("SomeString", RegSz)
    objNewValue.Value = "This is great fun!"
    Debug.Print "Added: " & objNewValue.FullPath
    
    ' Add a DWORD (long) value
    Set objNewValue = objNewKey.Values. _
     Add("SomeDWORD", RegDWord)
    objNewValue.Value = 1024
    Debug.Print "Added: " & objNewValue.FullPath
    
    ' Add a binary value
    Set objNewValue = objNewKey.Values. _
     Add("SomeBinary", RegBinary)
    objNewValue.Value = Array(0, 1, 2, 4, 8, 16, 32, 64, 128)
    Debug.Print "Added: " & objNewValue.FullPath

    ' Cleanup
    Set objRegistry = Nothing
    Set objKey = Nothing
    Set objSubKey = Nothing
    Set objValue = Nothing
    Set objNewKey = Nothing
    Set objNewValue = Nothing
End Sub

Sub TestSimpleReadWrite()
    Dim objReg As Win32Registry
    
    Set objReg = New Win32Registry
    objReg.WriteValue HKeyCurrentUser, "Control Panel", "Custom", 1024
    Debug.Print objReg.ReadValue(HKeyCurrentUser, "Control Panel", "Custom")
End Sub
