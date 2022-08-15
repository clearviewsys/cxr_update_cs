C_TEXT:C284(vTellerName)

If (Form event code:C388=On Load:K2:1)
	initTPArrays
	C_DATE:C307(vDate)
	C_REAL:C285(vTotalDiscrValue)
	C_LONGINT:C283(cbDisplayDraft)
	
	vDate:=Current date:C33
	cbDisplayDraft:=0
	vTotalDiscrValue:=0
	vTellerName:=getApplicationUser
	
	If (isUserController)
		
		//vTellerName:=Request("Name of teller:";getApplicationUser ;"Continue";"Cancel")
		pickUser(->vTellerName)
	End if 
	
	TP_refreshListbox
End if 

vTotalDiscrValue:=Sum:C1(arrDiscrValue)
