//%attributes = {}
// slold_signalToMainProcess($signal : Object; $caller : 4D.Function; \
$options : Object; $entity : cs.SanctionCheckLogEntity; \
$searchList : cs.SanctionListsEntity)
// Author Wai-Kin
var $1; $signal : Object
var $2; $caller : 4D:C1709.Function
var $3; $options : Object
var $4; $entity : cs:C1710.SanctionCheckLogEntity
var $5; $searchList : cs:C1710.SanctionListsEntity

Case of 
	: (Count parameters:C259=5)
		$signal:=$1
		$caller:=$2
		$options:=$3
		$entity:=$4
		$searchList:=$5
End case 

var $message : Object
$message:=New object:C1471(\
"caller"; $caller; \
"options"; $options; \
"entity"; $entity; \
"searchList"; $searchList.toObject()\
)
Use ($signal)
	If (OB Is defined:C1231($signal; "messages"))
		$signal.messages.push(OB Copy:C1225($message; ck shared:K85:29; $signal))
	Else 
		var $collection : Collection
		$collection:=New collection:C1472(OB Copy:C1225($message; ck shared:K85:29; $signal))
		$signal.messages:=$collection.copy(ck shared:K85:29; $signal)
	End if 
End use 