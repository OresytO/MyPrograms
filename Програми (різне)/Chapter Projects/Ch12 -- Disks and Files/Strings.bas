Attribute VB_Name = "basStringFunctions"
Option Explicit

Function dhTrimNull(ByVal strValue As String) As String
    ' Find the first vbNullChar in a string, and return
    ' everything prior to that character. Extremely
    ' useful when combined with the Windows API function calls.
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
            dhTrimNull = ""
        Case Is > 1
            ' Found in the string, so return the portion
            ' up to the null character.
            dhTrimNull = Left$(strValue, intPos - 1)
    End Select
End Function

Function dhCountTokens(ByVal strText As String, _
 ByVal strDelimiter As String) As Integer

    ' Return the number of tokens, given a set of delimiters,
    ' in a string

    Dim strChar As String * 1

    ' If there's no search text, there can't be any tokens.
    If Len(strText) = 0 Then
        dhCountTokens = 0
    Else
        strChar = Left$(strDelimiter, 1)

        ' Flatten all the delimiters to just the first one in
        ' the list.
        If Len(strDelimiter) > 1 Then
            strText = dhTranslate(strText, strDelimiter, strChar)
        End If
        ' Count the tokens.
        dhCountTokens = dhCountIn(strText, strChar) + 1
    End If
End Function

Function dhCountIn(strText As String, strFind As String, _
 Optional fCaseSensitive As Boolean = False) As Integer
    ' Determine the number of times strFind appears in strText

    Dim intCount As Integer
    Dim intPos As Integer
    Dim intMode As Integer

    ' If there's nothing to find, there surely can't be any
    ' found, so return 0.
    If Len(strFind) > 0 Then
        ' Set up the comparison mode.
        If fCaseSensitive Then
            intMode = vbBinaryCompare
        Else
            intMode = vbTextCompare
        End If
        intPos = 1
        Do
            intPos = InStr(intPos, strText, strFind, intMode)
            If intPos > 0 Then
                intCount = intCount + 1
                intPos = intPos + Len(strFind)
            End If
        Loop While intPos > 0
    Else
        intCount = 0
    End If
    dhCountIn = intCount
End Function

Function dhTranslate(ByVal strIn As String, _
 ByVal strMapIn As String, ByVal strMapOut As String, _
 Optional fCaseSensitive As Boolean = True) As String
    ' Take a list of characters in strMapIn, match them
    ' one-to-one in strMapOut, and perform a character
    ' replacement in strIn.

    Dim intI As Integer
    Dim intPos As Integer
    Dim strChar As String * 1
    Dim strOut As String
    Dim intMode As Integer

    ' If there's no list of characters
    ' to replace, there's no point going on
    ' with the work in this function.
    If Len(strMapIn) > 0 Then
        ' Set up the comparison mode.
        If fCaseSensitive Then
            intMode = vbBinaryCompare
        Else
            intMode = vbTextCompare
        End If

        ' Right-fill the strMapOut set.
        If Len(strMapOut) > 0 Then
            strMapOut = Left$(strMapOut & String(Len(strMapIn), _
             Right$(strMapOut, 1)), Len(strMapIn))
        End If

        For intI = 1 To Len(strIn)
            strChar = Mid$(strIn, intI, 1)
            intPos = InStr(1, strMapIn, strChar, intMode)
            If intPos > 0 Then
                ' If strMapOut is empty, this doesn't fail,
                ' because Mid handles empty strings gracefully.
                strOut = strOut & Mid$(strMapOut, intPos, 1)
            Else
                strOut = strOut & strChar
            End If
        Next intI
    End If
    dhTranslate = strOut
End Function
    
Function dhFixPath(strPath As String) As String
    ' Make sure path name includes a trailing backslash.
    
    ' Get rid of any extraneous spaces
    strPath = Trim(strPath)
    ' Stick a backslash on the end of the path
    If Right(strPath, 1) <> "\" Then
        dhFixPath = strPath & "\"
    Else
        dhFixPath = strPath
    End If
End Function
