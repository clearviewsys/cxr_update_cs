//%attributes = {}
// allRecords(->[table])
C_POINTER:C301($1; $tablePtr)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Not:C34(Is nil pointer:C315($tablePtr)))
	//If (isUserAuthorizedToView ($1))
	executeMethodName("AllRecords"+Table name:C256($tablePtr))
	//End if   
End if 