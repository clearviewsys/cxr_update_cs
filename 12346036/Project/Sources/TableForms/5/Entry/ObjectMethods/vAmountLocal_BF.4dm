//handleFocusBorder ("focus_vAmountLocal_BF")
applyFocusRect
If (Form event code:C388=On Data Change:K2:15)
	vAmount:=calcSafeDivide(vAmountLocal_BF; vRate)
	GOTO OBJECT:C206(*; "vAmount")  // go badck to the amount
End if 