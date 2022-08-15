C_TEXT:C284(subAccount; subAccountDescription)
checkInit
//checkMandatoryField (->vSubAccount;True;getLocalizedKeyword ("subaccount"))
checkAddErrorIf((subAccount=""); "<X> cannot be left blank"; getLocalizedKeyword("subaccount"))
If (isValidationConfirmed)
	CREATE RECORD:C68([SubAccounts:112])
	[SubAccounts:112]AccountID:4:=[Accounts:9]AccountID:1
	[SubAccounts:112]SubAccountID:2:=subAccount
	[SubAccounts:112]Description:3:=subAccountDescription
	SAVE RECORD:C53([SubAccounts:112])
	subAccount:=""
	subAccountDescription:=""
	GOTO OBJECT:C206(*; "subAccount")  // to simplify the data entry
End if 