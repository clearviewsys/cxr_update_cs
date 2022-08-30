Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (SQL_LOGIN(serverIP; user4D; password4D))
			C_TEXT:C284($developer)
			$developer:=popDevelopers{popDevelopers}
			searchMethodVersions(vfromDate; vtoDate; $developer)
			FORM GOTO PAGE:C247(1)
			
		Else 
			myAlert("The 4D Connection was not possible")
		End if 
		
		
End case 
