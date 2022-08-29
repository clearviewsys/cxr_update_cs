//%attributes = {}

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		GOTO OBJECT:C206(*; "vAccountNo")
		enableButtonIf(Not:C34(updatewt); "vAccountNo")
		
End case 
