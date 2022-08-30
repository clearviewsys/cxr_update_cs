C_REAL:C285(vExchangeRate; vOurExchangeRate)

If ((Form event code:C388=On Getting Focus:K2:7) | (Form event code:C388=On Losing Focus:K2:8))
	If (vExchangeRate=0)
		vExchangeRate:=vOurExchangeRate
	End if 
End if 

If (Form event code:C388=On Data Change:K2:15)
	If (isRateOffRange(vOurExchangeRate; vExchangeRate))
		CONFIRM:C162("This range "+String:C10(vExchangeRate; "|Rates")+" is very off from "+String:C10(vOurExchangeRate; "|Rates"); "Cancel"; "Accept")
		If (OK=1)
			// Cancel was pressed
			Self:C308->:=vOurExchangeRate
		End if 
	End if 
End if 
calcCalculatorVars
//If ((vFromAmount#0) & (vExchangeRate#0) & (vToAmount#0))
//vToAmount:=Round(vFromAmount*vExchangeRate;2)
//End if 