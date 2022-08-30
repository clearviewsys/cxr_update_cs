If (Form event code:C388=On Clicked:K2:4)
	If ([Customers:3]Email:17#"")
		OPEN URL:C673("mailto:"+[Customers:3]Email:17)
	End if 
End if 