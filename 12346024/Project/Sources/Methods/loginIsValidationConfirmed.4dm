//%attributes = {}
// isValidationConfirmed --> boolean
// returns true if form is ready to be validated after warnings and errors have been confirmed

C_BOOLEAN:C305($0; $success)
$success:=True:C214


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

