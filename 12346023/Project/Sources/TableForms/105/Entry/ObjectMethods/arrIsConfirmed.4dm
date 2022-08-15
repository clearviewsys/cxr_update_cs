Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If ([DB_Translations:110]isConfirmed:5)
			[DB_Translations:110]dateconfirmed:7:=Current date:C33(*)
		Else 
			[DB_Translations:110]dateconfirmed:7:=!00-00-00!
		End if 
		
		
		
		
End case 
