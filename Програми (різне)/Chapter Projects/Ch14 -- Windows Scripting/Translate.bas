Attribute VB_Name = "Translate"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Const dhcDelimiters As String = " ,.!:;<>?"

Public Function dhTrimAll(ByVal strText As String, _
 Optional fRemoveTabs As Boolean = True) As String
    
    ' Remove leading and trailing white space, and
    ' reduce any amount of internal white space (including tab
    ' characters) to a single space.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strText:
    '       Input text
    '   fRemoveTabs (Optional, default True):
    '       Should the code remove tabs, too?
    ' Out:
    '   Return Value:
    '       Input text, with leading and trailing white space removed
    ' Example:
    '   dhTrimAll("   this   is a     test ") returns "this is a test"
    ' Requires:
    '   dhTranslate
    ' Used by:
    '   dhCountWords
    
    Dim strTemp As String
    Dim strOut As String
    Dim lngI As Long
    Dim strCh As String * 1
    
    ' Trim off white space from the front and back.
    ' If requested, first convert all tabs into spaces,
    ' or RTrim and LTrim will miss them.
    If fRemoveTabs Then
        strText = dhTranslate(strText, vbTab, " ")
    End If
    strTemp = Trim$(strText)
    For lngI = 1 To Len(strTemp)
        ' Look at each character, in turn.
        strCh = Mid$(strTemp, lngI, 1)
        
        ' If this character a space, and the previous
        ' added character was a space? If not, add it on.
        If Not (strCh = " " And Right$(strOut, 1) = " ") Then
            strOut = strOut & strCh
        End If
    Next lngI
    dhTrimAll = strOut
End Function

Public Function dhTranslate( _
 ByVal strIn As String, _
 ByVal strMapIn As String, _
 ByVal strMapOut As String, _
 Optional lngCompare As VbCompareMethod = vbBinaryCompare) As String
    
    ' Take a list of characters in strMapIn, match them
    ' one-to-one in strMapOut, and perform a character
    ' replacement in strIn.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strIn:
    '       String in which to perform replacements
    '   strMapIn:
    '       Map of characters to find
    '   strMapOut:
    '       Map of characters to replace.  If the length
    '       of this string is shorter than that of strMapIn,
    '       use the final character in the string for all
    '       subsequent matches.
    '       If strMapOut is empty, just delete all the characters
    '       in strMapIn.
    '       If strMapOut is shorter than strMapIn, rightfill strMapOut
    '       with its final character. That is:
    '           dhTranslate(someString, "ABCDE", "X")
    '       is equivalent to
    '           dhTranslate(someString, "ABCDE", "XXXXX")
    '       That makes it simple to replace a bunch of characters with
    '       a single character.
    '   lngCompare (Optional, default is vbCompareBinary):
    '       Indicates how the search should compare values:
    '           vbBinaryCompare: case-sensitive
    '           vbTextCompare: case-insensitive
    '           vbDatabaseCompare (Doesn't work here)
    '           Any LocaleID value: compare as if in the selected locale.
    ' Out:
    '   Return Value:
    '       strIn, with appropriate replacements
    ' Example:
    '   dhTranslate("This is a test", "aeiou", "AEIOU") returns
    '     "ThIs Is A tEst"
    '   dhTranslate(someString, _
    '    "ÀÁÂÃÄÅÆàáâãäåæÈÉÊËèéêëÌÍÎÏìíîïÑñÒÓÔÕÖòóôõöØøÙÚÛÜùúûüÝýÿßÐ", _
    '    "AAAAAAAaaaaaaaEEEEeeeeIIIIiiiiNnOOOOOoooooOoUUUUuuuuYyysD")
    '     returns someString with 8-bit characters flattened
    '
    ' Used by:
    '   dhExtractString
    '   dhExtractCollection
    '   dhTrimAll
    '   dhCountWords
    '   dhCountTokens
    
    Dim lngI As Long
    Dim lngPos As Long
    Dim strChar As String * 1
    Dim strOut As String
    
    ' If there's no list of characters
    ' to replace, there's no point going on
    ' with the work in this function.
    If Len(strMapIn) > 0 Then
        ' Right-fill the strMapOut set.
        If Len(strMapOut) > 0 Then
            strMapOut = Left$(strMapOut & String(Len(strMapIn), _
             Right$(strMapOut, 1)), Len(strMapIn))
        End If
        strOut = strIn
        For lngI = 1 To Len(strOut)
            strChar = Mid$(strIn, lngI, 1)
            lngPos = InStr(1, strMapIn, strChar, lngCompare)
            If lngPos > 0 Then
                ' If strMapOut is empty, this doesn't fail,
                ' because Mid handles empty strings gracefully.
                Mid$(strOut, lngI, 1) = Mid$(strMapOut, lngPos, 1)
            End If
        Next lngI
    End If
    dhTranslate = strOut
End Function

