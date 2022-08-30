//%attributes = {}
// handleTypeAheardArrayVariable(->$selfPtr;->$arrayPtr;$isStrict)
// form events: onAfterKeystroke

C_POINTER:C301($selfPtr; $1)
C_POINTER:C301($arrayPtr; $2)
C_BOOLEAN:C305($isStrict; $3)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$arrayPtr:=$2
		$isStrict:=True:C214
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$arrayPtr:=$2
		$isStrict:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_COLLECTION:C1488($collection)
$collection:=New collection:C1472
ARRAY TO COLLECTION:C1563($collection; $arrayPtr->)
handleTypeAheadCollectVariable($selfPtr; $collection; $isStrict)