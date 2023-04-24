//%attributes = {}
// Author: Wai-Kin
//sl_runWorkerProcess($signal : Object; $name : Text; \
$isEntity : Boolean; $list : Collection;$logId : Object; $options : Object)
var $signal; $1 : Object

var $name; $2 : Text
var $isEntity; $3 : Boolean
var $lists; $4 : Collection
var $logId; $5 : Object
var $options; $6 : Object
Case of 
	: (Count parameters:C259=6)
		$signal:=$1
		$name:=$2
		$isEntity:=$3
		$lists:=$4
		$logId:=$5
		$options:=$6
End case 

Use ($signal)
	$signal.showInterface:=utils_getValueFromObject($options; True:C214; "showInterface")
End use 

var $entity : Object
var $results : Collection

var $pepHandler; $listHandler; $ranHandler : 4D:C1709.Function
$pepHandler:=$options.functions.pepHandler
$listHandler:=$options.functions.listHandler
$ranHandler:=$options.functions.ranHandler

$options.functions.pepHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $pepHandler; This:C1470; $1; $2\
))
$options.functions.listHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $listHandler; This:C1470; $1; $2\
))
$options.functions.ranHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $ranHandler; This:C1470; $1; $2\
))
$results:=New collection:C1472
$results:=sl_screenWithSanctionListCol($name; $isEntity; $lists; $logId; $options)

var $entities; $output : Collection
$entities:=New collection:C1472
$output:=New collection:C1472
var $result : Object
For each ($result; $results)
	If ($result.needSave)
		$entities.push($result.entity)
	End if 
	var $display : Object
	$display:=$result.entity
	OB REMOVE:C1226($display; "UUID")
	$output.push($display)
End for each 
Use ($signal)
	$signal.entities:=$entities.copy(ck shared:K85:29; $signal)
	$signal.result:=$output.copy(ck shared:K85:29; $signal)
End use 
$signal.trigger()