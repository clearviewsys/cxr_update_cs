//%attributes = {}
//Method: checkUsedPassword
//Purpose: Checks if a password has been used on the system before
//Parameters: $password =  password to check (string)
//Returns: True if password has been used before, false otherwise

//Unit test: @Zoya


C_TEXT:C284($1; $password)
C_BOOLEAN:C305($0; $retVal)

Case of 
	: (Count parameters:C259=1)
		$password:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$retVal:=False:C215

If (<>passwordCheckUsed)
	READ ONLY:C145([UserPasswords:145])
	ALL RECORDS:C47([UserPasswords:145])
	FIRST RECORD:C50([UserPasswords:145])
	If (Records in selection:C76([UserPasswords:145])>0)
		Repeat 
			If (Verify password hash:C1534($password; [UserPasswords:145]Password:1))
				$retVal:=True:C214
				
			End if 
			NEXT RECORD:C51([UserPasswords:145])
		Until ((End selection:C36([UserPasswords:145]) | ($retVal=True:C214)))
		UNLOAD RECORD:C212([UserPasswords:145])
	End if 
	$0:=$retVal
Else 
	$0:=False:C215
End if 
