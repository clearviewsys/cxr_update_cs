C_LONGINT:C283(cbAutoRefresh)
C_LONGINT:C283(vMinutes)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		calculaleHoldingsArrays
		If (vMinutes=0)
			vMinutes:=10  // default
		End if 
		
		setTimerInMinutes(vMinutes)
		
	: (Form event code:C388=On Timer:K2:25)
		If (cbAutoRefresh=1)
			calculaleHoldingsArrays
		End if 
End case 