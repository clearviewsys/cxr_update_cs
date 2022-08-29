//%attributes = {}
/** Check if the automatic bit is set for a situation. The result is not only
indication of the list is being pick or not.

#param $flagParam
     - the sanction screening situation
#param $bitSet
       [SanctionLists]automaticFlags, use contents with this pattern `sl_@Flag`
#author @wai-kin
#see sl_setAutoScreenForTable
*/
#DECLARE($flagParam : Integer; $bitSetParam : Integer)->$result : Boolean

var $flag : Integer
var $bitSet : Integer
Case of 
	: (Count parameters:C259=1)
		$flag:=$flagParam
		$bitSet:=[SanctionLists:113]automaticFlags:11
	: (Count parameters:C259=2)
		$flag:=$flagParam
		$bitSet:=$bitSetParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$result:=$bitSet ?? $flag
