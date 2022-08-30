
C_POINTER:C301($ptrVar)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		SET TIMER:C645(-1)
		
	: (Form event code:C388=On Timer:K2:25)
		AMLB_handleFilterList(On Timer:K2:25)
		SET TIMER:C645(0)
		
		
	: (Form event code:C388=On Unload:K2:2)
		AMLB_handleFilterList(On Unload:K2:2)
		
	Else 
		
		
End case 