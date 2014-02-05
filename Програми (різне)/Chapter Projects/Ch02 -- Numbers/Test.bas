Attribute VB_Name = "basTest"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 1999; Sybex, Inc. All rights reserved.

' Examples from Chapter 2

Public Sub TestFloatingPoints()

    Dim intI As Integer
    Dim sngSum As Single
    Dim dblSum As Double
    
    Debug.Print "Both results should be 1.0"
    
    For intI = 1 To 10000
        sngSum = sngSum + 0.0001
    Next intI
    
    'This prints "Single: 1.000054"
    Debug.Print TypeName(sngSum) & ":"; sngSum
    
    For intI = 1 To 10000
        dblSum = dblSum + 0.0001
    Next intI
    'This prints, "Double: .999999999999906"
    Debug.Print TypeName(dblSum) & ":"; dblSum
End Sub

Public Sub TestEquality()
    Dim sng1 As Single
    Dim sng2 As Single
    Dim dbl1 As Double
    Dim dbl2 As Double
    
    sng1 = 69.82
    sng2 = 69.2 + 0.62
    dbl1 = 69.82
    dbl2 = 69.2 + 0.62
    
    'This prints: "sng1 = 69.82, sng2 = 69.82"
    Debug.Print "sng1 = " & sng1 & ", sng2 = " & sng2
    
    'This prints: "dbl1 = 69.82, dbl2 = 69.82"
    Debug.Print "dbl1 = " & dbl1 & ", dbl2 = " & dbl2
   
    'This prints: "dbl1 = sng1: True"
    Debug.Print "dbl1 = sng1: "; (dbl1 = sng1)
    
    'This prints: "sng1 = sng2: True"
    Debug.Print "sng1 = sng2: "; (sng1 = sng2)
    
    'This prints: "sng2 = dbl2: True"
    Debug.Print "sng2 = dbl2: "; (sng2 = dbl2)
    
    'This prints: "dbl1 = dbl2: False" !!!
    Debug.Print "dbl1 = dbl2: "; (dbl1 = dbl2)
    
    ' Strip off the whole number portion.
    dbl1 = dbl1 - 69
    dbl2 = dbl2 - 69
    sng1 = sng1 - 69
    sng2 = sng2 - 69
    
    ' You'll be amazed!
    ' This prints: "sng1:  0.8199997 "
    Debug.Print "sng1: "; sng1
    
    ' This prints: "sng2:  0.8199997"
    ' No wonder the inequality fails!
    Debug.Print "sng2: "; sng2
    ' This prints: "dbl1:  0.819999999999993"
    Debug.Print "dbl1: "; dbl1
    
    ' This prints: "dbl2:  0.820000000000007"
    ' No wonder the inequality fails!
    Debug.Print "dbl2: "; dbl2
End Sub

Public Sub TestCurrency()

    Dim intI As Integer
    Dim dblSum As Double
    Dim curSum As Currency
    
    For intI = 1 To 10000
        dblSum = dblSum + 0.0001
    Next intI
    'This prints, "Double: .999999999999906"
    Debug.Print TypeName(dblSum) & ":"; dblSum
    
    For intI = 1 To 10000
        curSum = curSum + 0.0001
    Next intI
    'This prints, "Currency: 1"
    Debug.Print TypeName(curSum) & ":"; curSum
End Sub

Public Sub TestDecimal()
    Dim intI As Integer
    Dim dblSum As Double
    Dim varDblSum As Variant
    Dim varDecSum As Variant
    
    For intI = 1 To 10000
        dblSum = dblSum + 0.0001
    Next intI
    ' This prints, "Double: .999999999999906"
    Debug.Print TypeName(dblSum) & ":"; dblSum
    
    For intI = 1 To 10000
        varDblSum = varDblSum + 0.0001
    Next intI
    ' This prints, "Variant Double: 0.999999999999906"
    Debug.Print "Variant " & TypeName(varDblSum) & ":"; varDblSum
    
    For intI = 1 To 10000
        varDecSum = varDecSum + CDec(0.0001)
    Next intI
    ' This prints,"Variant Decimal: 1"
    Debug.Print "Variant " & TypeName(varDecSum) & ":"; varDecSum
End Sub

Public Sub TestInt()
    Dim dblNumber As Double
    
    ' Prints: "25"
    Debug.Print Int((2.55 * 10) + 0.5)
    
    dblNumber = (2.55 * 10) + 0.5
    ' Prints: "26"
    Debug.Print Int(dblNumber)
End Sub

Public Sub RandomTest()
    ' Generate a set of random numbers
    Dim i As Integer
    Randomize
    For i = 1 To 10
        Debug.Print Int(Rnd * 10) + 1
    Next i
End Sub

Public Sub TestShuffle()
    Dim alngItems() As Long
    Dim i As Long
    
    alngItems = dhRandomShuffle(10)
    For i = LBound(alngItems) To UBound(alngItems)
        Debug.Print Right$(Space(4) & alngItems(i), 4);
    Next i
    Debug.Print
End Sub

