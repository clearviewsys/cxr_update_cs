//%attributes = {}
//Method for setting the current twilio subaccount
//Required parameter: account sid of subaccount
//outputs: None

C_TEXT:C284($1; $subAccountId)

Case of 
	: (Count parameters:C259=1)
		$subAccountId:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

setKeyValue("twilio.subAccount.sid"; $subAccountId)