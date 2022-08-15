//%attributes = {}
// isValidationConfirmed (duringLogin:boolean) --> boolean
// returns true if form is ready to be validated after warnings and errors have been confirmed



C_BOOLEAN:C305($0; $1; $duringLogin; $success)
$success:=True:C214

Case of 
	: (Count parameters:C259=0)
		$duringLogin:=False:C215
	: (Count parameters:C259=1)
		$duringLogin:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34($duringLogin))
	checkAddErrorIf(getApplicationUser=""; "User is not logged in!")
	checkAddErrorIf(getApplicationUser="LOCKED"; "Please login to access modules!")
End if 

If (checkErrorExist)
	myAlert(checkGetErrorString; "Please fix the errors before proceeding.")
	$success:=False:C215
Else 
	If (checkWarningExist)  // if there is a warning
		myConfirm(checkGetWarningString; "Back to form"; "Ignore and Continue"; "Please be cautious before you continue!")
		If (OK=1)  // user wants to go back to form 
			$success:=False:C215
		Else 
			$success:=True:C214
		End if 
	Else 
		$success:=True:C214
	End if 
End if 

$0:=$success

