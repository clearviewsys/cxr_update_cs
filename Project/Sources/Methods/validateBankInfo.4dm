//%attributes = {}
//validateBankInfo

C_TEXT:C284($checkSum; $vAddress; $vCountryCode; $vBankCity; $errorCode)
If (Undefined:C82(vAccountNo)=False:C215)
	checkIfNullString(->vAccountNo; "Bank Account Number")
	checkIfNullString(->vBankName; "Bank Name")
	checkIfNullString(->vAccountName; "Account Name")
	checkIfNullString(->vSwift; "SWIFT Number")  // not required per Lotus
	
	//If (vSwift#"")
	//validateIBAN (vAccountNo;->$errorCode;->vBankName;->$vCountryCode;->$vBankCity;->$vAddress;->vSwift;->$checkSum)
	//If ($errorCode#"")
	//checkAddErrorOnTrue (True;$errorCode)
	//End if 
	
	//End if 
End if 

