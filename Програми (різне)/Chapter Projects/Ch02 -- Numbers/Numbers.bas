Attribute VB_Name = "basNumbers"
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

' Examples from Chapter 2

' need option base 0 for check writing
Option Base 0

' Indicate that a parameter is missing.
Private Const dhcMissing = -1

Public Function dhDegToRad(varDegrees As Variant) As Variant
    ' Converts degrees to radians
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varDegrees:
    '       Degrees to convert
    ' Out:
    '   Return Value:
    '       A Variant representing the Radians
    
    Const PI = 3.14159265358979
    dhDegToRad = (CDec(varDegrees) / 180) * PI
End Function

Public Function dhRadToDeg(varRadians As Variant) As Variant
    ' Converts radians to degrees
     
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
     
    ' In:
    '   varRadians:
    '       Radians to convert
    ' Out:
    '   Return Value:
    '       A Variant representing the Degrees
     
    Const PI = 3.14159265358979
    dhRadToDeg = (CDec(varRadians) / PI) * 180
End Function

Public Function dhLogN(varDecimal As Variant, _
 Optional varLogBase As Variant = 10) As Variant
    ' Converts a decimal number to a Log, Base
    ' specified by the variable varLogBase
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varDecimal:
    '       The decimal number being converted
    '   intLogBase:
    '       The base
    ' Out:
    '   Return Value:
    '       The converted number as a Variant
    
    dhLogN = CDec(Log(varDecimal) / Log(varLogBase))
End Function

Public Function dhHyperbolicSine(ByVal dblNumber As Double) As Variant
    ' Calculates hyperbolic sine using the Exp() fuction
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblNumber:
    '       The number
    ' Out:
    '   Return Value:
    '       the Hyperbolic Sine of the supplied number as a Variant
    dhHyperbolicSine = (CDec(Exp(dblNumber)) - CDec(Exp(-dblNumber))) / 2
End Function

Public Function dhRound( _
 ByVal Number As Variant, NumDigits As Long, _
 Optional UseIEEERounding As Boolean = False) As Double
    ' Rounds a number to a specified number of decimal
    ' places. 0.5 is rounded up
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    
    ' In:
    '   Number:
    '       The number to be rounded
    '   NumDigits:
    '       The number of decimal places to round to
    '   UseIEEERounding:
    '       Round to the nearest even value?
    ' Out:
    '   Return Value:
    '       The rounded number
    
    Dim dblPower As Double
    Dim varTemp As Variant
    Dim intSgn As Integer
    
    If Not IsNumeric(Number) Then
        ' Raise an error indicating that
        ' you've supplied an invalid parameter.
        Err.Raise 5
    End If
    dblPower = 10 ^ NumDigits
    ' Is this a negative number, or not?
    ' intSgn will contain -1, 0, or 1.
    intSgn = Sgn(Number)
    Number = Abs(Number)
    
    ' Do the major calculation.
    varTemp = CDec(Number) * dblPower + 0.5
    
    ' Now round to nearest even, if necessary.
    If UseIEEERounding Then
        If Int(varTemp) = varTemp Then
            ' You could also use:
            ' varTemp = varTemp + (varTemp Mod 2 = 1)
            ' instead of the next If ...Then statement,
            ' but we hate counting on True == -1 in code.
            If varTemp Mod 2 = 1 Then
                varTemp = varTemp - 1
            End If
        End If
    End If
    ' Finish the calculation.
    dhRound = intSgn * Int(varTemp) / dblPower
End Function

Public Function dhRoundSimple( _
 Number As Variant, NumDigits As Long) As Double
    ' Rounds a number to a specified number of decimal
    ' places. 0.5 is rounded up
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    
    ' In:
    '   Number:
    '       The number to be rounded
    '   NumDigits:
    '       The number of decimal places to round to
    ' Out:
    '   Return Value:
    '       The rounded number

    Dim dblPower As Double
    Dim varTemp As Variant
    Dim intSgn As Integer
    
    If Not IsNumeric(Number) Then
        ' Raise an error indicating that
        ' you've supplied an invalid parameter.
        Err.Raise 5
    End If
    dblPower = 10 ^ NumDigits
    
    ' Is this a negative number, or not?
    ' intSgn will contain -1, 0, or 1.
    intSgn = Sgn(Number)
    Number = Abs(Number)
    
    ' Do the major calculation.
    varTemp = CDec(Number) * dblPower + 0.5
    
    ' Finish the calculation.
    dhRoundSimple = intSgn * Int(varTemp) / dblPower
End Function

Public Function dhSubtract(varVal1 As Variant, _
  varVal2 As Variant) As Double
    ' Uses Decimal Variants to return
    ' the difference between varVal2 and varVal1
    ' while avoiding inaccuracies.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varVal1:
    '       Number to subtract from
    '   varVal2:
    '       Number to subtract
    ' Out:
    '   Return Value:
    '       Difference between values (varVal1 - varVal2)
    
    dhSubtract = CDec(varVal1) - CDec(varVal2)
End Function

Public Function dhRandomShuffle(Optional lngItems As Long = 10) As Long()
    ' Shuffles random numbers.
     
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    Dim alngValues() As Long
    Dim i As Long
    Dim lngPos As Long
    Dim lngTemp As Long
    
    ReDim alngValues(1 To lngItems)

    ' Fill in the original values.
    For i = 1 To lngItems
        alngValues(i) = i
    Next i
    
    ' Loop through all the items except the last one.
    ' Once you get to the last item, there's no point
    ' using Rnd, just get it.
    For i = lngItems To 2 Step -1
        ' Get a random number between 1 and i
        lngPos = Int(Rnd * i) + 1
        lngTemp = alngValues(lngPos)
        alngValues(lngPos) = alngValues(i)
        alngValues(i) = lngTemp
    Next i
    dhRandomShuffle = alngValues()
End Function

Public Function dhNumToStr(ByVal varValue As Variant) As String
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Takes a number and converts it into text for writing
    ' checks. For example, 24.95 gets converted to
    ' Twenty-Four and 95/100
    
    ' In:
    '       varValue contains the number to be converted to text
    ' Out:
    '       Returns the string or an empty string on any error
    
    On Error GoTo HandleErrors
    
    Dim intTemp As Integer
    Dim varNames As Variant
    Dim lngDollars As Long
    Dim intCents As Integer
    Dim strOut As String
    Dim strTemp As String
    Dim intI As Integer
    
    If Not IsNumeric(varValue) Then Exit Function
    
    ' 999,999,999.99 is the largest possible value.
    If varValue > 999999999.99 Then Exit Function
    varNames = Array("", "Thousand", "Million")
    
    varValue = Abs(varValue)
    lngDollars = Int(varValue)
    intCents = (varValue - lngDollars) * 100

    If lngDollars > 0 Then
        ' Loop through each set of three digits,
        ' first the hundreds, then thousands, and then
        ' millions.
        Do
            intTemp = lngDollars Mod 1000
            lngDollars = Int(lngDollars / 1000)
            ' Prepend spelling of new triplet of digits to the
            ' existing output.
            If intTemp <> 0 Then
                strOut = dhHandleGroup(intTemp) & " " & _
                 varNames(intI) & " " & strOut
            End If
            intI = intI + 1
        Loop While lngDollars > 0
        ' Handle the cents.
        strOut = RTrim(strOut) & " and " & _
         Format$(intCents, "00") & "/100"
    End If
    
ExitHere:
    dhNumToStr = strOut
    Exit Function

HandleErrors:
    ' Handle all errors by returning an empty string
    strOut = ""
    Resume ExitHere
End Function

Private Function dhHandleGroup(ByVal intValue As Integer) As String
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Called by dhNumToStr
    Static varOnes As Variant
    Static varTens As Variant
    Dim strOut As String
    Dim intDigit As Integer
    
    If IsEmpty(varOnes) Then
        varOnes = Array("", "One", "Two", "Three", "Four", "Five", _
         "Six", "Seven", "Eight", "Nine", "Ten", _
         "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", _
         "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty")
    End If
    If IsEmpty(varTens) Then
        ' Elements 0 and 1 in this array aren't used.
        varTens = Array("", "", "Twenty", "Thirty", "Forty", _
         "Fifty", "Sixty", "Seventy", "Eighty", "Ninety")
    End If
    
    ' Get the hundreds digit, and then the rest.
    intDigit = intValue \ 100
    intValue = intValue Mod 100
    
    ' If there's a hundreds digit, add that now.
    If intDigit > 0 Then strOut = varOnes(intDigit) & " Hundred"
            
    ' Handle the tens and ones digits.
    Select Case intValue
        Case 1 To 20
            strOut = strOut & varOnes(intValue)
        Case 21 To 99
            intDigit = intValue \ 10
            intValue = intValue Mod 10
            If intDigit > 0 Then
                strOut = strOut & " " & varTens(intDigit)
            End If
            If intValue > 0 Then
                strOut = strOut & "-" & varOnes(intValue)
            End If
    End Select

    dhHandleGroup = strOut
End Function

Public Function dhGreatestCommonFactor(ByVal lngX As Long, _
 ByVal lngY As Long) As Long
    ' Returns the largest number which will evenly
    ' divide into both lngX and lngY
    ' comments
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngX:
    '   lngY:
    '       Numbers to work with
    ' Out:
    '   Return Value:
    '       The greatest common factor

    Dim lngTemp As Long
    lngX = Abs(lngX)
    lngY = Abs(lngY)
    lngTemp = lngX Mod lngY
    Do While lngTemp > 0
        lngX = lngY
        lngY = lngTemp
        lngTemp = lngX Mod lngY
    Loop
    dhGreatestCommonFactor = lngY
End Function

Public Function dhLowestCommonMultiple( _
 ByVal intX As Integer, ByVal intY As Integer) As Long
    ' Returns the smallest number of which both
    ' intX and intY are factors
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngX:
    '   lngY:
    '       Numbers to work with
    ' Out:
    '   Return Value:
    '       The lowest common multiple of lngX and lngY
    
    intX = Abs(intX)
    intY = Abs(intY)
    dhLowestCommonMultiple = _
     intY * (intX \ dhGreatestCommonFactor(intX, intY))
End Function

Public Function dhIsPrime(ByVal lngX As Long) As Boolean
    ' Find out whether a given number is Prime.
    ' Treats negative numbers and positive numbers
    ' the same.
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   lngX:
    '       Number to test if Prime
    ' Out:
    '   Return Value:
    '       Returns TRUE if the number is Prime
    
    Dim intI As Integer
    Dim dblTemp As Double
    dhIsPrime = True
    lngX = Abs(lngX)
    
    If lngX = 0 Or lngX = 1 Then
        dhIsPrime = False
    ElseIf lngX = 2 Then
        ' dhIsPrime is already set to True.
    ElseIf (lngX Mod 2) = 0 Then
        dhIsPrime = False
    Else
        For intI = 3 To Int(Sqr(lngX)) Step 2
            dblTemp = lngX / intI
            If dblTemp = lngX \ intI Then
                dhIsPrime = False
                Exit Function
            End If
        Next intI
    End If
End Function

Public Function dhFactorial(intX As Integer) As Double
    ' Non-recursive factorial
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   intX:
    '       Find Factorial Of
    ' Out:
    '   Return Value:
    '       Factorial
    
    Dim i As Integer
    Dim dblX As Double
    If intX < 0 Or intX > 170 Then
        dhFactorial = 0
    Else
        dblX = 1
        For i = 2 To intX
            dblX = dblX * i
        Next i
        dhFactorial = dblX
    End If
End Function

Public Function dhFactorialRecursive(intX As Integer) As Double
    ' Recursive factorial
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   intX:
    '       Factorial
    ' Out:
    '   Return Value:
    '       Recursive
    
    If intX < 0 Or intX > 170 Then
        dhFactorialRecursive = 0
    ElseIf intX = 0 Then
        dhFactorialRecursive = 1
    Else
        dhFactorialRecursive = intX * _
         dhFactorialRecursive(intX - 1)
    End If
End Function

Public Function dhArrayMin(varArray As Variant) As Variant
    ' Return the minimum value from an array
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varArray:
    '       A valid array, checked by the IsArray function
    ' Out:
    '   Return Value:
    '       The minimum value in the array
    
    Dim varItem As Variant
    Dim varMin As Variant
    Dim i As Long
    
    If IsArray(varArray) Then
        If UBound(varArray) = -1 Then
            dhArrayMin = Null
        Else
            varMin = varArray(LBound(varArray))
            For i = LBound(varArray) To UBound(varArray)
                varItem = varArray(i)
                If varItem < varMin Then
                    varMin = varItem
                End If
            Next i
            dhArrayMin = varMin
        End If
    Else
        dhArrayMin = varArray
    End If
End Function

Public Function dhArrayMax(varArray As Variant) As Variant
    ' Return the maximum value from an array
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varArray:
    '       A valid array, checked by the IsArray function
    ' Out:
    '   Return Value:
    '       The maximum value in the array
    
    Dim varItem As Variant
    Dim varMax As Variant
    Dim i As Long
    
    If IsArray(varArray) Then
        If UBound(varArray) = -1 Then
            dhArrayMax = Null
        Else
            varMax = varArray(UBound(varArray))
            For i = LBound(varArray) To UBound(varArray)
                varItem = varArray(i)
                If varItem > varMax Then
                    varMax = varItem
                End If
            Next i
            dhArrayMax = varMax
        End If
    Else
        dhArrayMax = Null
    End If
End Function

Public Function dhArrayMedian(varArray As Variant) As Variant
    ' Return the Median value in an array
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varArray:
    '       A valid array, checked by the IsArray function
    ' Out:
    '   Return Value:
    '       The Median value in the array
    
    Dim varItem As Variant
    Dim varTemp As Variant
    Dim varMedian As Variant
    Dim intI As Integer
    Dim lngTemp As Long
    Dim lngLBound As Long
    Dim lngElements As Long
    
    If IsArray(varArray) Then
        ' Sort the array
        Call dhQuickSort(varArray)
        
        ' Compute the number of array elements and the
        ' index of the "middle" one
        lngLBound = LBound(varArray)
        lngElements = (UBound(varArray) - lngLBound + 1)
        
        ' Find the midpoint in the array. For an odd
        ' number of elements, this is easy (it's the
        ' middle one)...
        If (lngElements Mod 2) = 1 Then
            dhArrayMedian = varArray(lngLBound + _
             (lngElements \ 2))
        Else
            ' For an even number of elements, it's the
            ' midpoint between the two middle values...
            lngTemp = ((lngElements - 1) \ 2) + lngLBound
            dhArrayMedian = ((varArray(lngTemp + 1) - _
             varArray(lngTemp)) / 2) + varArray(lngTemp)
        End If
    Else
        dhArrayMedian = Null
    End If
End Function

Public Function dhArrayAverage(varArray As Variant) As Variant
    ' Return the average value from an array
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   varArray:
    '       A valid array, checked by the IsArray function
    ' Out:
    '   Return Value:
    '       The average value in the array
    ' Note: Using For Each slows down this processing
    ' a little, but makes the code easier. We've added
    ' commented out code for using For Next instead, but
    ' this does add some coding overhead.
    
    Dim varItem As Variant
    Dim varSum As Variant
    Dim lngCount As Long
    
    If IsArray(varArray) Then
        For Each varItem In varArray
            varSum = varItem + varSum
            lngCount = lngCount + 1
        Next
        dhArrayAverage = varSum / lngCount
    Else
        dhArrayAverage = Null
    End If
End Function

Public Function dhArrayStandardDeviation(varArray As Variant) As Double
    ' Calculates standard deviation for an array
    ' In:
    '       varArray contains the array
    ' Out:
    '       Returns the standard deviation
  
    Dim lngN As Long
    Dim dblSumX As Double
    Dim dblSumX2 As Double
    Dim dblVar As Double
    Dim intCounter As Integer

    lngN = 0
    dblSumX = 0
    dblSumX2 = 0
    For intCounter = LBound(varArray) To UBound(varArray)
        If Not IsNull(varArray(intCounter)) Then
            lngN = lngN + 1
            dblSumX = dblSumX + varArray(intCounter)
            dblSumX2 = dblSumX2 + varArray(intCounter) ^ 2
        End If
    Next intCounter
    
    dblVar = 0
    If lngN > 0 Then
        dblVar = (lngN * dblSumX2 - dblSumX ^ 2) / (lngN * (lngN - 1))
        If dblVar > 0 Then
            dhArrayStandardDeviation = Sqr(dblVar)
        End If
    End If
End Function

Public Function dhAreaofCircle(ByVal dblRadius As Double) As Double
    ' Return the area of a circle
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblRadius:
    '       The radius of the circle
    ' Out:
    '   Return Value:
    '       The area of the circle as a Double
  
    Const PI = 3.14159265358979
    dhAreaofCircle = PI * dblRadius ^ 2
  
End Function

Public Function dhAreaOfSphere(ByVal dblRadius As Double) As Double
    ' Return the area of a sphere
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblRadius:
    '       The radius of the sphere
    ' Out:
    '   Return Value:
    '       The area of the sphere
  
    Const PI = 3.14159265358979
    dhAreaOfSphere = 4 * PI * dblRadius ^ 2
  
End Function

Public Function dhAreaOfRectangle(ByVal dblLength As Double, _
 ByVal dblWidth As Double) As Double
    ' Return the area of a rectangle
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblLength:
    '       The length of the rectangle
    '   dblWidth:
    '       The width of the rectangle
    ' Out:
    '   Return Value:
    '       The area of the rectangle
  
    dhAreaOfRectangle = dblLength * dblWidth
  
End Function

Public Function dhAreaOfTrapezoid(ByVal dblHeight As Double, ByVal _
 dblSide1 As Double, ByVal dblSide2 As Double) As Double
    ' Return the area of a trapezoid
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblHeight:
    '       The height of the trapezoid
    '   dblSide1:
    '       The length of the first side
    '   dblSide2:
    '       The length of the second side
    ' Out:
    '   Return Value:
    '       The area of the trapezoid
    dhAreaOfTrapezoid = dblHeight * (dblSide1 + dblSide2) / 2
  
End Function

Public Function dhVolOfPyramid(ByVal dblHeight As Double, _
 ByVal dblBaseArea As Double) As Double
    ' Return the volume of a pyramid
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblHeight:
    '       Height of the pyramid
    '   dblBaseArea:
    '       Base area of the pyramid
   ' Out:
    '   Return Value:
    '       Volume of a pyramid
  
    dhVolOfPyramid = dblHeight * dblBaseArea / 3
  
End Function


Public Function dhVolOfSphere(ByVal dblRadius As Double) As Double
    ' Return the volume of a sphere
    
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   dblRadius:
    '       The radius of the sphere
    ' Out:
    '   Return Value:
    '       The volume of a sphere
  
    Const PI = 3.14159265358979
    dhVolOfSphere = PI * (dblRadius ^ 3) * 4 / 3
  
End Function

Public Function dhAssetDepreciation(ByVal curCost As Currency, _
 ByVal curSalvage As Currency, ByVal intLife As Integer, _
 ByVal intPeriod As Integer) As Double
    ' Calculates Asset Depreciation
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   curCost:
    '       Initial cost of asset
    '   curSalvage:
    '       Asset value at the end of its life
    '   intLife:
    '       Asset's useful lifetime. Must be same units
    '       (months or years) as period and > than
    '       period.
    '   intPeriod:
    '       The period for depreciation calculation. Must
    '       be same units (months or years) as period.
    ' Out:
    '   Return Value:
    '       The depreciation as a Double

    dhAssetDepreciation = DDB(CDbl(curCost), CDbl(curSalvage), _
     CDbl(intLife), CDbl(intPeriod))
     
End Function

Public Function dhCalcPayment(ByVal dblRate As Double, _
 ByVal intNoPmts As Integer, _
 ByVal curPresentValue As Currency, _
 Optional varFutureVal As Variant = 0, _
 Optional varWhenDue As Variant = 0) As Double

    ' Calculates payments using Pmt function
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dblRate:
    '       Yearly interest rate. Is divided by 12 when passed
    '       to Pmt function.
    '   intNoPmts:
    '       Total number of payment periods.
    '   curPresentValue:
    '       Present value (or lump sum) that a series of payments
    '       is worth now
    '   varFutureVal:
    '       Future value or cash balance you want after
    '       you've made the final payment. Default is 0.
    '   varWhenDue:
    '       Can be 0 for payment due at end of period or 1
    '       for payment due at beginning of period. Default is 0.
    ' Out:
    '   Return Value:
    '       The payment as a Double
    
    If varWhenDue <> 0 Then
        ' set to only other possible value
        ' of 1 indicating payment to occur
        ' at beginning of period
        varWhenDue = 1
    End If

    dhCalcPayment = Pmt((dblRate / 12), intNoPmts, _
     -CDbl(curPresentValue), varFutureVal, varWhenDue)
End Function

Public Function dhNetPresentValue(ByVal dblRate As Double, _
 ParamArray varCashFlows()) As Double
    ' Calculates net present value
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dblRate:
    '       Discount rate over the length of the period as
    '       a decimal fraction
    '   varCashFlows():
    '       ParamArray of the cash flows. First element should
    '       be negative number for a payment, other elements
    '       should reflect incoming receipts or cash flows
    ' Out:
    '   Return Value:
    '       The net present value for the series of cash flows
    '       contained in the array

    Dim varElement As Variant
    Dim i As Integer
    Dim lngUBound As Long
    Static dblValues() As Double
    
    ' get upper bound of ParamArray
    lngUBound = UBound(varCashFlows)
    ' size array to ParamArray
    ReDim dblValues(lngUBound)
    i = 0
    ' place elements of ParamArray into Array
    For Each varElement In varCashFlows
        dblValues(i) = varElement
        i = i + 1
    Next
    dhNetPresentValue = NPV(dblRate, dblValues())
End Function

Public Function dhBinaryToDec(ByVal strNumber As String) As Long
    ' Converts floating-point decimal number to hex
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' In:
    '   strNumber:
    '       The binary number to be converted
    ' Out:
    '   Return Value:
    '       The binary value as a long
    
    dhBinaryToDec = CLng("&H" & dhBinarytoHex(strNumber))
End Function

Public Function dhDecToHex(ByVal dblNumber As Double) As String
    ' Converts floating-point decimal number to hex
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   dblNumber:
    '       The number to be converted
    ' Out:
    '   Return Value:
    '       The hex value as a string
    
    Dim strTemp As String
    Dim i As Integer
    strTemp = Hex(Int(dblNumber)) & "."
    dblNumber = dblNumber - Int(dblNumber)
    For i = 1 To 16
          dblNumber = dblNumber * 16
          strTemp = strTemp & Hex(dblNumber)
          dblNumber = dblNumber - Int(dblNumber)
    Next i
    dhDecToHex = strTemp
End Function

Public Function dhBinarytoHex(ByVal strNumber As String) As String
    ' Converts Binary to Hex
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strNumber:
    '       Binary number as a String
    ' Out:
    '   Return Value:
    '       The Hex number as a String
    
    Dim strTemp As String
    Dim intI As Integer
    Dim intLen As Integer
    Dim strOut As String
    
    ' First, pad the value to the left, with "0".
    ' To do this, find the length of the string
    ' rounded to the next highest multiple of 4.
    intLen = Len(strNumber)
    
    ' Find the next higher multiple of 4:
    intLen = Int((intLen - 1) / 4 + 1) * 4
    strNumber = Right$(String(intLen, "0") & strNumber, intLen)
    
    ' Now walk through each group of 4 digits, converting each to hex.
    For intI = 1 To intLen Step 4
        Select Case Mid(strNumber, intI, 4)
            Case "0000"
                strTemp = "0"
            Case "0001"
                strTemp = "1"
            Case "0010"
                strTemp = "2"
            Case "0011"
                strTemp = "3"
            Case "0100"
                strTemp = "4"
            Case "0101"
                strTemp = "5"
            Case "0110"
                strTemp = "6"
            Case "0111"
                strTemp = "7"
            Case "1000"
                strTemp = "8"
            Case "1001"
                strTemp = "9"
            Case "1010"
                strTemp = "A"
            Case "1011"
                strTemp = "B"
            Case "1100"
                strTemp = "C"
            Case "1101"
                strTemp = "D"
            Case "1110"
                strTemp = "E"
            Case "1111"
                strTemp = "F"
        End Select
        strOut = strOut & strTemp
    Next intI
    dhBinarytoHex = strOut
End Function

Public Function dhDecToBinary(ByVal lngNumber As Long) As String
    ' Converts Dec to Binary
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   lngNumber:
    '       The number to be converted
    ' Out:
    '   Return Value:
    '       The Binary number as a String
  
    Dim strTemp As String
    Dim intI As Integer
    
    strTemp = Hex(lngNumber)
    strTemp = dhHexToBinary(strTemp)
    ' Rip off leading "0"s.
    Do While Left(strTemp, 1) = "0"
        strTemp = Mid(strTemp, 2)
    Loop
    dhDecToBinary = strTemp
End Function

Public Function dhHexToBinary(strNumber As String) As String
    ' Converts Hex to Binary
    '
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.

    ' In:
    '   strNumber:
    '       The Hex number to be converted
    ' Out:
    '   Return Value:
    '       The Binary number as a String
  
    Dim strTemp As String
    Dim strOut As String
    Dim i As Integer
    
    For i = 1 To Len(strNumber)
        Select Case Mid(strNumber, i, 1)
            Case "0"
                strTemp = "0000"
            Case "1"
                strTemp = "0001"
            Case "2"
                strTemp = "0010"
            Case "3"
                strTemp = "0011"
            Case "4"
                strTemp = "0100"
            Case "5"
                strTemp = "0101"
            Case "6"
                strTemp = "0110"
            Case "7"
                strTemp = "0111"
            Case "8"
                strTemp = "1000"
            Case "9"
                strTemp = "1001"
            Case "A"
                strTemp = "1010"
            Case "B"
                strTemp = "1011"
            Case "C"
                strTemp = "1100"
            Case "D"
                strTemp = "1101"
            Case "E"
                strTemp = "1110"
            Case "F"
                strTemp = "1111"
            Case Else
                ' This can't happen, right?
                strTemp = ""
        End Select
        strOut = strOut & strTemp
    Next i
    dhHexToBinary = strOut
End Function

Public Function dhArrayMode(varArray As Variant) As Variant
    ' From "Visual Basic Language Developer's Handbook"
    ' by Ken Getz and Mike Gilbert
    ' Copyright 2000; Sybex, Inc. All rights reserved.
    
    ' Returns the Mode or most common value of an array
    
    ' In:
    '   varArray():
    '       The array
    ' Out:
    '       The mode as a Variant. In the case of a tie, the
    '       smallest number is the mode.
    
    Dim varItem As Variant
    Dim varLast As Variant
    Dim lngCount As Long
    Dim lngOccur As Long
    Dim lngLastOccur As Long
    Dim lngTotalOccur As Long

    If IsArray(varArray) Then
        ' Sort the array so elements are in order
        Call dhQuickSort(varArray)
        
        ' Capture the first item
        varItem = varArray(LBound(varArray))
        
        ' Loop through all the elements
        For lngCount = LBound(varArray) To UBound(varArray)
            ' Increment the occurrence counter
            lngOccur = lngOccur + 1
            
            ' If the value is not the same as the last one,
            ' see if the occurrences of the last value
            ' exceed the current maximum
            If varArray(lngCount) <> varLast Then
                If lngLastOccur >= lngTotalOccur Then
                    ' If so, make it the new maximum and
                    ' capture the prior value
                    lngTotalOccur = lngLastOccur
                    varItem = varArray(lngCount - 1)
                End If
                
                ' Record this element as the last one visited
                varLast = varArray(lngCount)
                
                ' Reset the counter
                lngOccur = 0
            End If
            
            lngLastOccur = lngOccur
        Next
        
        ' Return the value with the most occurrences
        ' (make sure to check the final value)
        If lngOccur > lngTotalOccur Then
            dhArrayMode = varArray(lngCount - 1)
        Else
            dhArrayMode = varItem
        End If
    Else
        dhArrayMode = Null
    End If
End Function

