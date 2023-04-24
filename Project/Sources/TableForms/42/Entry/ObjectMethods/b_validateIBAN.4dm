C_TEXT:C284($errorCode; $checkSum)

If ([WireTemplates:42]AccountNo:6#"")
	validateIBAN([WireTemplates:42]AccountNo:6; ->$errorCode; ->[WireTemplates:42]BankName:3; ->[WireTemplates:42]BankCountryCode:35; ->[WireTemplates:42]BankCity:11; ->[WireTemplates:42]BankAddress:10; ->[WireTemplates:42]SWIFT:8; ->$checkSum)
	If ($errorCode#"")
		myAlert("Error Code"+$errorCode)
	End if 
Else 
	myAlert("Please enter an IBAN to check. E.g. (FR8630004003200001019471670)")
End if 
