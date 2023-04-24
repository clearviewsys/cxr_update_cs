//%attributes = {}
//Method for activating whether to use the current subaccount or not
//Optional parameter (boolean): Activate sub account or not
//If optional parameter is not passed in, default is True

C_BOOLEAN:C305($1; $subAccountActive)

Case of 
	: (Count parameters:C259=0)
		$subAccountActive:=True:C214
	: (Count parameters:C259=1)
		$subAccountActive:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($subAccountActive)
	setKeyValue("twilio.subAccount.activated"; "True")
Else 
	setKeyValue("twilio.subAccount.activated"; "False")
End if 