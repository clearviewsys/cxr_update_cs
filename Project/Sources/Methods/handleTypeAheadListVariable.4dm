//%attributes = {}
// handleTypeAheardListVariable(->$selfPtr;->$arrayPtr;$isStrict)
// form events: onAfterKeystroke


C_POINTER:C301($selfPtr; $1)
C_LONGINT:C283($listRef; $2)
C_BOOLEAN:C305($isStrict; $3)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$listRef:=$2
		$isStrict:=True:C214
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$listRef:=$2
		$isStrict:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($array; 0)
LIST TO ARRAY:C288($listRef; $array)
handleTypeAheadArrayVariable($selfPtr; ->$array; $isStrict)