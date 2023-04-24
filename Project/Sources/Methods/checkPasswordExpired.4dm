//%attributes = {}
//Method: checkPasswordExpired
//Purpose: Checks if the user's force password reset date is before the current date
//Returns: True if force reset date is in the past, False otherwise
// Unit Test is written by @Zoya 

C_BOOLEAN:C305($0)
C_DATE:C307($1; $forceResetDate)
C_LONGINT:C283($dateDif)



Case of 
	: (Count parameters:C259=1)
		$forceResetDate:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=False:C215



$dateDif:=Int:C8($forceResetDate-Current date:C33)
If ($dateDif<0)
	$0:=True:C214
End if 
