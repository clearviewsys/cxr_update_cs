//%attributes = {}
//**************************************************************
//Method getting the Auth KeyValues for twilio SMS sending
//
//Required Parameters:
//@pAccountSid (pointer): Pointer to a text variable where the Account
//// Sid should be stored
//@pAuthKey (pointer): Pointer to a text variable where the Authentication
// Key should be stored
//Output:
//On Success: AccountSid->@pAccountSid, AuthKey->@pAuthKey
//**************************************************************
C_POINTER:C301($pAccountSid; $pAuthKey; $1; $2)

Case of 
	: (Count parameters:C259=2)
		$pAccountSid:=$1
		$pAuthKey:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$pAccountSid->:=<>twilioAccountSid  //getKeyValue ("twilio.accountSid")
$pAuthKey->:=<>twilioAuthKey  //getKeyValue ("twilio.authKey")