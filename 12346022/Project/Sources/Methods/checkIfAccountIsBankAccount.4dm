//%attributes = {}
// checkifAccountisBankAccount( string:AccountID;wewantaBankAccount;{errormessage})
// POST: adds error if we want a bank account but it's not 
// post : also error if we don't want a bank account and it is 


C_TEXT:C284($1; $account)
C_BOOLEAN:C305($2)
$account:=$1

READ ONLY:C145([Accounts:9])
CREATE SET:C116([Accounts:9]; "$currentSetAccounts")
QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$1)

If ($account="")
	$account:="Account ID"
End if 

Case of 
	: ($2=True:C214)  // we want a bank account so error is if record is not a bank account
		If (Not:C34([Accounts:9]isBankAccount:7))  // is not a bank account
			checkAddWarningOnTrue((Count parameters:C259=2); $account+" is not a valid bank acccount. ")
		End if 
	: ($2=False:C215)  // we don't want a bank account so give the error if it is a bank account
		If ([Accounts:9]isBankAccount:7)  // is not a bank account
			checkAddWarningOnTrue((Count parameters:C259=2); $account+" is a bank account. Integrity warning. ")
		End if 
End case 



USE SET:C118("$currentSetAccounts")
CLEAR SET:C117("$currentSetAccounts")
