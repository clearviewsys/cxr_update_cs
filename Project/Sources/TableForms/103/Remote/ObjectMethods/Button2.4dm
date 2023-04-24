Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (SQL_LOGIN(serverIp; user4d; password4D))
			
			myAlert("4D Connection Successfull")
			
		Else 
			myAlert("The 4D Connection was not possible")
		End if 
		
		
End case 
