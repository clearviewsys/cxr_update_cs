//%attributes = {}
// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/21/21, 20:57:40
// ----------------------------------------------------
// Method: checkSingleEmail
// Description
// Takes in an email and returns whether the email is 0 (unknown), 1 (valid), 2 (invalid)
//
// Parameters
var $email; $1 : Text
// ----------------------------------------------------

var $output; $0 : Integer
var $validCriteria : Collection
var $res : Object
var $message : Text

Case of 
	: (Count parameters:C259=2)
		$email:=$1
		$validCriteria:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$res:=New object:C1471()
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


Case of 
	: (($message="unknown") | ($message="error"))
		$output:=0
		If ($message="error")
			myAlert("There was an error, the validity of the email is unknown")
		End if 
	: (($validCriteria.indexOf($message)#-1))
		$output:=1
	Else 
		$output:=2
End case 

$0:=$output