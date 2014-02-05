Attribute VB_Name = "TestStr"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Test procedures from Chapter 1

Public Sub DumpBytes()
    ' Dump the characters, and then bytes, of
    ' the text "Hello" to the Debug window.
    Dim intI As Integer
    Dim strTest As String
    strTest = "Hello"
    For intI = 1 To Len(strTest)
        Debug.Print Asc(Mid(strTest, intI, 1));
    Next intI
    Debug.Print
    For intI = 1 To LenB(strTest)
        Debug.Print AscB(MidB(strTest, intI, 1));
    Next intI
    Debug.Print
End Sub

Public Function WordsContaining( _
 strIn As String, strFind As String) As String
  ' Return a string containing all the words
  ' in the input string containing a supplied substring.
  Dim astrItems() As String
  Dim astrFound() As String
  
  If Len(strIn) > 0 And Len(strFind) > 0 Then
    astrItems = Split(strIn)
    astrFound = Filter(astrItems, strFind, True, vbTextCompare)
    WordsContaining = Join(astrFound)
  Else
    WordsContaining = strIn
  End If
End Function

Public Function ToPigLatin(strText As String) As String
  Dim astrWords() As String
  Dim i As Integer
  If Len(strText) > 0 Then
    ' Break the string up into words.
    astrWords = Split(strText)
    For i = LBound(astrWords) To UBound(astrWords)
      ' Convert each word to pig latin.
      ' Warning: you may not agree with these conversion
      ' rules. We didn't make them up! (And the
      ' exact conversion isn't our point here.)
      
      ' 1. If a word begins with a consonant,
      ' the first letter is moved to the end
      ' of the word, and 'ay' is added.
      ' Example: The word 'bridge' would become 'ridgebay'.

      ' 2. If a word begins with an vowel, the
      ' first letter is moved to the end,
      ' and 'ey' is added.
      ' Example: The word 'anchor' would become 'nchoraey'.

      ' 3. Exception to rule #2: if the vowel is
      ' an 'e', use 'ay' instead of 'ey'.
      ' Example: The word 'elevator' would become 'levatoreay'.
     
      Select Case LCase(Left$(astrWords(i), 1))
        Case "a", "i", "o", "u"
          astrWords(i) = Mid$(astrWords(i), 2) & _
           Left(astrWords(i), 1) & "ey"
        Case "a" To "z"
          ' Most vowels have been caught already, do it doesn't
          ' hurt to have cases for them again. Don't
          ' change the order of the cases, however!
          astrWords(i) = Mid$(astrWords(i), 2) & _
           Left(astrWords(i), 1) & "ay"
      End Select
    Next i
    ToPigLatin = Join(astrWords)
  End If
End Function

Public Function GetLastWord(strText As String) As String
    Dim astrWords() As String
    
    If Len(strText) = 0 Then
        GetLastWord = strText
    Else
        astrWords = Split(strText, " ")
        GetLastWord = astrWords(UBound(astrWords))
    End If
End Function

Public Sub TestFirstAndLast(strText As String)
    Dim strTemp As String
    Dim strResult As String
    strResult = dhFirstWord(strText, strTemp)
    Debug.Print "The first word is: " & strResult & ". The rest is: " & strTemp
    
    strResult = dhLastWord(strText, strTemp)
    Debug.Print "The last word is: " & strResult & ". The rest is: " & strTemp
End Sub

Public Sub TestExtract(strIniText As String)

    ' Test sub for dhExtractString
    Dim intI As Integer
    Dim strText As String
    
    intI = 2
    Do While True
        strText = dhExtractString(strIniText, intI, "=,")
        If Len(strText) = 0 Then
            Exit Do
        End If
        Debug.Print strText
        intI = intI + 1
    Loop
End Sub

Public Sub TestProperMDB()
    ' Test procedure for dhProperLookup
    
    Dim rst As ADODB.Recordset

    Set rst = New ADODB.Recordset
    rst.Open "tblSpecialCase", _
     "Provider=Microsoft.Jet.OLEDB.4.0;" & _
     "Data Source = " & App.Path & "\Proper.MDB", _
     adOpenKeyset
    
    Debug.Print dhProperLookup( _
     "headline: cruella de ville and old macdonald eat dog's food", _
     True, rst, "Lookup")
    rst.Close
    Set rst = Nothing
End Sub

Public Sub CreateProperXML()
    ' Create XML file for recordset.
    
    Dim rst As ADODB.Recordset
    Dim strPath As String
    Dim strFile As String

    strPath = App.Path
    Set rst = New ADODB.Recordset
    rst.Open "tblSpecialCase", _
     "Provider=Microsoft.Jet.OLEDB.4.0;" & _
     "Data Source = " & strPath & "\Proper.MDB", _
     adOpenKeyset
         
    On Error Resume Next
    strFile = strPath & "\Proper.xml"
    Kill strFile
    rst.Save strFile, adPersistXML
    
    rst.Close
    Set rst = Nothing
End Sub

Public Sub TestProperXML()
    ' Test procedure for dhProperLookup
    
    Dim rst As ADODB.Recordset
    Dim strText As String

    ' You don't even need a database. You can use a
    ' saved XML file.
    Set rst = New ADODB.Recordset
    rst.Open App.Path & "\Proper.xml", , _
    adOpenKeyset, adLockReadOnly, Options:=adCmdFile
    
    strText = _
     "headline: cruella de ville and old macdonald " & _
     "eat dog's food"
    Debug.Print dhProperLookup(strText, True, rst, "Lookup")
    
    rst.Close
    Set rst = Nothing
End Sub

Public Function TestExtractCollection() As Integer

    ' Test function for dhExtractCollection
    Dim varText As Variant
    Dim colText As Collection
    
    Set colText = dhExtractCollection( _
     "This string contains a bunch of words")
    For Each varText In colText
        Debug.Print varText
    Next varText
    TestExtractCollection = colText.Count
End Function

Public Sub StringToByteArray()
    Dim strText As String
    Dim aByt() As Byte
    Dim intI As Integer
    strText = "Hello"
    ' VBA allows you to assign a string into
    ' a byte array and then back again.
    aByt() = strText
    For intI = LBound(aByt) To UBound(aByt)
        Debug.Print aByt(intI);
    Next intI
    Debug.Print
    strText = aByt()
    Debug.Print strText
End Sub

Public Function Extract( _
 ByVal strIn As String, _
 ByVal intPiece As Integer, _
 Optional ByVal strDelimiter As String = " ") As String

    Dim astrItems() As String

    On Error GoTo HandleErrors

    If Len(strDelimiter) = 0 Then
        ' No delimiter supplied. Return
        ' the entire input string.
        Extract = strIn
    Else
        ' Split the string into
        ' an array, and return the requested piece.
        ' Don't forget that the array returned by Split
        ' is always 0-based.
        astrItems = Split( _
         Expression:=strIn, _
         Delimiter:=strDelimiter, _
         Compare:=vbTextCompare)
        Extract = astrItems(intPiece - 1)
    End If

ExitHere:
    Exit Function

HandleErrors:
    Select Case Err.Number
        Case 9    ' Subscript out of range.
            ' The caller asked for a token that doesn't
            ' exist. Simply return an empty string.
            Resume ExitHere
        Case Else
            Err.Raise Err.Number, Err.Source, _
            Err.Description, Err.HelpFile, Err.HelpContext
    End Select
End Function

Public Function CountVowels(ByVal strIn As String) As Long
    ' An alternative way to calculate vowels in a piece of text.
    Dim astrItems() As String
    
    strIn = dhTranslate(strIn, "AEIOU", "A", vbTextCompare)
    astrItems = Split(strIn, "A")
    CountVowels = UBound(astrItems) - LBound(astrItems)
End Function

Public Function CountVowels2(ByVal strIn As String) As Long
    ' An alternative way to calculate vowels in a piece of text.
    CountVowels2 = dhCountTokens(strIn, "aeiou", vbTextCompare) - 1
End Function

Public Function IsPalindrome(strTest As String) As Boolean
  ' Is strTest a palindrome (the same forwards as backwards)?
    IsPalindrome = (StrComp( _
     strTest, StrReverse(strTest), vbTextCompare) = 0)
End Function

