//%attributes = {}
// checkIfAccountIDExists (->fieldAccountID; { fieldLabel})

C_POINTER:C301($1; $accountIDPtr)
C_TEXT:C284($2; $fieldLabel)


Case of 
	: (Count parameters:C259=1)
		$accountIDPtr:=$1
		checkifRecordExists(->[Accounts:9]; ->[Accounts:9]AccountID:1; $accountIDPtr; "The Account ID "+$accountIDPtr->)
	: (Count parameters:C259=2)
		$accountIDPtr:=$1
		$fieldLabel:=$2
		checkifRecordExists(->[Accounts:9]; ->[Accounts:9]AccountID:1; $accountIDPtr; $fieldLabel+" "+$accountIDPtr->)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 