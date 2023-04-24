//%attributes = {}
//handleSaveBankInfoButton

checkInit
validateBankInfo


If (isValidationConfirmed)
	saveBankInfo
Else 
	REJECT:C38
	GOTO OBJECT:C206(*; "vAccountNo")
End if 
