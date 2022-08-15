Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If ([DB_Translations:110]Translation:4="")
			ALERT:C41("Tanslation is empty. Please review. Record updated")
		End if 
		
		
End case 
