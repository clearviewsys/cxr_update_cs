C_TEXT:C284($msg)

If ((Form:C1466.destinationCountry#"") & (Form:C1466.city#""))
	
	Form:C1466.points:=mgGetPoints(Form:C1466.destinationCountry; Form:C1466.city; Form:C1466.state)
	
	If (Form:C1466.points#Null:C1517)
		
		If (Form:C1466.points.success)
			
			
		Else 
			
			$msg:=mgGetSOAPErrorDetails(Form:C1466.points.mgerrormsg)
			
			myAlert($msg)
			
		End if 
		
	End if 
	
Else 
	
	myAlert("Please choose destination country and enter first letter(s) of city name. City name can't be empty (MoneyGram API requirement)."\
		)
	
	
End if 
