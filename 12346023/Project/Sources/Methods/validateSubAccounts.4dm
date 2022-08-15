//%attributes = {}


checkMandatoryField(->[SubAccounts:112]SubAccountID:2; True:C214)
checkMandatoryField(->[SubAccounts:112]Description:3; True:C214)
If ([SubAccounts:112]AccountID:4="")
	checkAddWarning("You left the Account blank, so this Sub-Account will be shared for all Accounts")
End if 

