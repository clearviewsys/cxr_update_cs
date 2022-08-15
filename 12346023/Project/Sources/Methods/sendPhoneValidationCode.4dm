//%attributes = {}
C_TEXT:C284($error; $body; $toNumber; $fromNumber; $resetCode; $1; $2; $3)
C_POINTER:C301($pError)
C_BOOLEAN:C305($0)
$error:=""
$pError:=->$error
$0:=True:C214

Case of 
	: (Count parameters:C259=2)
		$resetCode:=$1
		$toNumber:=$2
	: (Count parameters:C259=3)
		$resetCode:=$1
		$toNumber:=$2
		$fromNumber:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$body:="Your CXR validation code is: "+$resetCode
If (Count parameters:C259=2)
	twilioSendSMS($pError; $toNumber; $body)
Else 
	twilioSendSMS($pError; $toNumber; $body; $fromNumber)
End if 

If ($error#"")
	myAlert("Error sending validation text: "+$error)
	$0:=False:C215
End if 

