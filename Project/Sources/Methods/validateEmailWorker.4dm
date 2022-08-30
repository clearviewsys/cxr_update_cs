//%attributes = {}
// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/05/21, 19:19:36
// ----------------------------------------------------
// Method: validateEmailWorker
// Description:
// This method is used for with CALL WORKER to get the an emails
// validity and add the key value email:result to $sharedObj
// Parameters
var $email; $1 : Text
var $sharedObj; $2 : Object  // **New Shared Object()**
// ----------------------------------------------------
// Variables
var $message : Text
var $res : Object

Case of 
	: (Count parameters:C259=2)
		$email:=$1
		$sharedObj:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Calls CVS backend to get email validity
ON ERR CALL:C155("errorIgnore")
$res:=cvsCloud3_validateEmail($email)
ON ERR CALL:C155("")

// Determine the status message
If (OB Is defined:C1231($res; "response"))
	If (OB Is defined:C1231($res.response; "status"))
		$message:=$res.response.status
	Else 
		$message:="error"
	End if 
Else 
	$message:="error"
End if 

// Add email and message to the shared object
Use ($sharedObj)
	OB SET:C1220($sharedObj; $email; $message)
End use 

KILL WORKER:C1390