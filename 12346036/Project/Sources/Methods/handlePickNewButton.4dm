//%attributes = {}
// handlePickNewButton
// This object method shall be called from the Pick form 'New...' Button
// this will create a new record 

C_POINTER:C301($tablePtr; $1; $2; $fieldPtr)
Case of 
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$fieldPtr:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

bNewRecord($tablePtr)
If (OK=1)
	vSearchText:=$fieldPtr->
	ACCEPT:C269
End if 