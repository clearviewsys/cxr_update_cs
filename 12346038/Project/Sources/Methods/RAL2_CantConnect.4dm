//%attributes = {}
//Check and set the Connection expiry date if a RAL service 
//returns a 1,3,911,or cannot connect code
//prevents the user from using teh application if the connection expiry is up

C_DATE:C307($expiryDate)
C_BOOLEAN:C305($continue; $expiryNotSet)

$expiryDate:=[CompanyInfo:7]ConnectionExpiry:29

$expiryNotSet:=($expiryDate=!00-00-00!)
If ($expiryDate>=Current date:C33)
	$continue:=True:C214
Else 
	$continue:=False:C215 | $expiryNotSet  // if expiry date is null it is okay
End if 

If ($continue)
	If ($expiryNotSet)
		$expiryDate:=Add to date:C393(Current date:C33; 0; 1; 0)
		myAlert("Cannot connect to Licensing server. A grace period has been assigned to this license."+Char:C90(Carriage return:K15:38)+\
			"You will be locked out after "+String:C10($expiryDate)+" if a connection is not made before then."+\
			Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
			"Please check your internet connection or contact CXR support if you believe you should not be seeing this error.")
		[CompanyInfo:7]ConnectionExpiry:29:=$expiryDate
		SAVE RECORD:C53([CompanyInfo:7])
	Else 
		myAlert("Cannot connect to Licensing server."+Char:C90(Carriage return:K15:38)+\
			"You will be locked out after "+String:C10($expiryDate)+" if a connection is not made before then."+\
			Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
			"Please check your internet connection or contact CXR support if you believe you should not be seeing this error.")
	End if 
Else 
	myAlert("Grace period for connecting to the regisration server has expired."+Char:C90(Carriage return:K15:38)+\
		"Please contact CXR support.")
	If (Not:C34(isUserSupport))
		If (getKeyValue("ral.terminate")="true")
			forceQuit
		End if 
	End if 
End if 