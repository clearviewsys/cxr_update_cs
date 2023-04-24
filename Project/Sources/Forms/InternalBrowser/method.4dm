Case of 
	: (Form event code:C388=On Load:K2:1)
		If (OB Is defined:C1231(Form:C1466; "website"))
			WA OPEN URL:C1020(*; "WebArea"; Form:C1466.website)
		Else 
			OBJECT SET ENABLED:C1123(*; "but_open"; False:C215)
		End if 
End case 

