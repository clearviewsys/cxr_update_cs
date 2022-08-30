//%attributes = {}
//Method for updating the internal balance of texts 
//Queries the account balance, and calculates the number of texts left

C_TEXT:C284($error)
C_REAL:C285($balance)
C_LONGINT:C283($numTexts)
C_POINTER:C301($pError)
$pError:=->$error
$error:=""

$balance:=twilioGetBalance($pError)

If ($error="")
	$numTexts:=$balance/0.0075
	setKeyValue("twilio.accountTextBalance"; String:C10($numTexts))
Else 
	myAlert("Error getting twilio account balance, please see below Error message"+\
		Char:C90(Carriage return:K15:38)+\
		$error)
End if 


