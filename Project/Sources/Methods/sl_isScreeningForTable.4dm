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
#DECLARE($moduleFlag : Integer; $option : Integer)->$result : Boolean

Case of 
	: (Count parameters:C259=1)
		$option:=[SanctionLists:113]automaticFlags:11
	: (Count parameters:C259=2)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$result:=($option ?? $moduleFlag)
