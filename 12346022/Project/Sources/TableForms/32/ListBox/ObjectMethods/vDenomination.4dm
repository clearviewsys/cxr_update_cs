
C_REAL:C285(vDenomination)
C_TEXT:C284(VCURRENCY)

If (Form event code:C388=On Load:K2:1)
	If (Self:C308->=0)
		Self:C308->:=500
	End if 
End if 

If (Form event code:C388=On Data Change:K2:15)
	handleFilterDenomInOuts(VDENOMINATION; VCURRENCY; puSelection)
End if 