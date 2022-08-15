//%attributes = {}
// isValidationConfirmed --> boolean
// returns true if form is ready to be validated after warnings and errors have been confirmed

C_BOOLEAN:C305($0; $success)
$success:=True:C214


C_TEXT:C284($webErrorMessage)
C_LONGINT:C283($webMessageType)
//checkAddErrorIf (getApplicationUser ="";"User is not logged in")
//checkAddErrorIf (getApplicationUser ="LOCKED";"Please login to access modules. User is LOCKED.")


If (checkErrorExist)
	//myAlert (checkGetErrorString ;"Please fix the errors before proceeding.")
	$webErrorMessage:=<>CHECKERRORS
	$webMessageType:=4  //danger
	WAPI_setAlertMessage($webErrorMessage; $webMessageType)
	
	$success:=False:C215
Else 
	If (checkWarningExist)  // if there is a warning
		//myConfirm (checkGetWarningString ;"Back to form";"Ignore and Continue";"Please be cautious before you continue!")
		//If (OK=1)  // user wants to go back to form 
		//$success:=False
		//Else 
		//$success:=True
		//End if 
		$webErrorMessage:=<>CHECKERRORS
		$webMessageType:=3  //warning
		WAPI_setAlertMessage($webErrorMessage; $webMessageType)
		
		$success:=True:C214
	Else 
		$success:=True:C214
	End if 
End if 

$0:=$success

