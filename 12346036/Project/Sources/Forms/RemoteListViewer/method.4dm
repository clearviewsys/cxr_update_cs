

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		SET TIMER:C645(120)
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
	Else 
		
End case 
