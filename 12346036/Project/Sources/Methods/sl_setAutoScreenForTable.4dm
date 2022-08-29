//%attributes = {}
/** Set the table automatic screening flag

#param $flagParam
       which table auto screening to set
#param $bitSetPtrParam
       the table field to set
#param $valueParam
       the value to set, if not for toggling
#author @wai-kin
#see sl_isAutoScreenForTable
*/
#DECLARE($flagParam : Integer; $bitSetPtrParam : Pointer; $valueParam : Boolean)

var $flag : Integer
var $bitSetPtr : Pointer
var $value : Boolean
Case of 
	: (Count parameters:C259=1)
		$flag:=$flagParam
		$bitSetPtr:=->[SanctionLists:113]automaticFlags:11
		$value:=Not:C34(($bitSetPtr->) ?? $flag)
	: (Count parameters:C259=2)
		$flag:=$flagParam
		$bitSetPtr:=$bitSetPtrParam
		$value:=Not:C34(($bitSetPtr->) ?? $flag)
	: (Count parameters:C259=3)
		$flag:=$flagParam
		$bitSetPtr:=$bitSetPtrParam
		$value:=$valueParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($value)
	$bitSetPtr->:=($bitSetPtr->) ?+ $flag
Else 
	$bitSetPtr->:=($bitSetPtr->) ?- $flag
End if 