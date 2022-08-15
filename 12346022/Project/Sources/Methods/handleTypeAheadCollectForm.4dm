//%attributes = {}
// handleTypeAheadCollectForm($selfPtr;$collection;{$value;{$holder}})
// Form events: OnLoad, OnLosingFoucs

C_POINTER:C301($selfPtr; $1)
C_COLLECTION:C1488($collection; $2)
C_TEXT:C284($value; $3)
C_TEXT:C284($holder; $4)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$collection:=$2
		$value:=""
		$holder:=""
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$collection:=$2
		$value:=$3
		$holder:=""
	: (Count parameters:C259=4)
		$selfPtr:=$1
		$collection:=$2
		$value:=$3
		$holder:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$0:=$value
C_OBJECT:C1216($data)
Case of 
	: (Form event code:C388=On Load:K2:1)
		$data:=New object:C1471
		$data.value:=$3
		$data.collection:=$collection
		$data.placeholder:=$holder
		$selfPtr->:=$data
		$0:=$data.value
	: (Form event code:C388=On Losing Focus:K2:8)
		$0:=$selfPtr->value
End case 