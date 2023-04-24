//%attributes = {}
// handleTypeAheadCollectForm($selfPtr;$field;{$value;{$holder}})
// Form events: OnLoad, OnLosingFoucs

C_POINTER:C301($selfPtr; $1)
C_POINTER:C301($field; $2)
C_TEXT:C284($value; $3)
C_TEXT:C284($holder; $4)
C_TEXT:C284($0)
Case of 
	: (Count parameters:C259=2)
		$selfPtr:=$1
		$field:=$2
		$value:=""
		$holder:=""
	: (Count parameters:C259=3)
		$selfPtr:=$1
		$field:=$2
		$value:=$3
		$holder:=""
	: (Count parameters:C259=4)
		$selfPtr:=$1
		$field:=$2
		$value:=$3
		$holder:=""
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$0:=""
C_OBJECT:C1216($data)
Case of 
	: (Form event code:C388=On Load:K2:1)
		$data:=New object:C1471
		$data.value:=$value
		$data.entity:=$field
		$data.placeholder:=$holder
		$selfPtr->:=$data
	: (Form event code:C388=On Getting Focus:K2:7)
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$0:=$selfPtr->value
End case 