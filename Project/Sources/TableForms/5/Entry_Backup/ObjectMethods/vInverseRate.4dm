//handleFocusBorder ("focus_vInverseRate")
applyFocusRect

If (Form event code:C388=On Data Change:K2:15)
	vRate:=calcSafeDivide(1; vInverseRate)
	setvRate
	vRate:=Round:C94(calcSafeDivide(1; vInverseRate); [Currencies:6]RoundDigit:27)
	
End if 

