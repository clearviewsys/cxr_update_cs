//%attributes = {}
// appendKeyValueToArrays (->keyArray;->valueArray; key: text; value: text; isUnique:bool)
// PRE: both arrays must be of type Text


C_POINTER:C301($keysArrayPtr; $valuesArrayPtr; $1; $2)
C_TEXT:C284($key; $value; $3; $4)
C_BOOLEAN:C305($isKeyUnique; $5)

Case of 
	: (Count parameters:C259=4)
		$keysArrayPtr:=$1
		$valuesArrayPtr:=$2
		$key:=$3
		$value:=$4
		$isKeyUnique:=False:C215
	: (Count parameters:C259=5)
		$keysArrayPtr:=$1
		$valuesArrayPtr:=$2
		$key:=$3
		$value:=$4
		$isKeyUnique:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
If ($isKeyUnique)  // unique Keys should not be duplicated so we find in array first
	If (Find in array:C230($keysArrayPtr->; $key)<0)
		APPEND TO ARRAY:C911($keysArrayPtr->; $key)
		APPEND TO ARRAY:C911($valuesArrayPtr->; $value)
	End if 
Else   // non-unique keys can be added to the array without a search
	APPEND TO ARRAY:C911($keysArrayPtr->; $key)
	APPEND TO ARRAY:C911($valuesArrayPtr->; $value)
End if 
