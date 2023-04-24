C_TEXT:C284($errorCode; $checkSum; $country; $state; $address; $check; $fulladdress; $city)

If ([Links:17]BankAccountNo:31#"")
	validateIBAN([Links:17]BankAccountNo:31; ->$errorCode; ->[Links:17]BankName:28; ->$country; ->$state; ->$address; ->[Links:17]BankTransitCode:29; ->$checkSum)
	If ($errorCode#"")
		myAlert("Error Code"+$errorCode)
	Else 
		$fulladdress:=env_makeAddressText($address; $city; $state; ""; $country)
		[Links:17]BankAddress:30:=$fulladdress
	End if 
Else 
	myAlert("Please enter an IBAN to check. E.g. (FR8630004003200001019471670)")
End if 
