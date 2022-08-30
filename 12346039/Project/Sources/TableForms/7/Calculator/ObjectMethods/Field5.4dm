C_REAL:C285(vInverseRate; vExchangeRate)

If (Self:C308->#0)
	vExchangeRate:=1/vInverseRate
	If (isRateOffRange(vOurExchangeRate; vExchangeRate))
		CONFIRM:C162("This range "+String:C10(vInverseRate; "|Rates")+" is very off from "+String:C10(1/vOurExchangeRate; "|Rates"); "Cancel"; "Accept")
		If (OK=1)
			// Cancel was pressed
			vInverseRate:=1/vOurExchangeRate
			vExchangeRate:=vOurExchangeRate
		End if 
	End if 
End if 