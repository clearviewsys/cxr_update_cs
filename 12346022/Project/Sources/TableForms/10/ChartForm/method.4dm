C_LONGINT:C283(vYear)
C_TEXT:C284(vCurrency)


If (Form event code:C388=On Load:K2:1)
	If (vYear=0)
		vYear:=Year of:C25(Current date:C33)-1
	End if 
	
	//If (vCurrency="")
	//vCurrency:=<>BASECURRENCY
	//End if 
	
	handleDrawChartButton
End if 
