//%attributes = {}
// Author: Wai-Kin
//sl_runWorkerProcess($signal : Object; $method : Text; $name : Text; \
$isEntity : Boolean; $logId : Object; $options : Object)
var $signal; $1 : Object
var $method; $2 : Text
var $name; $3 : Text
var $isEntity; $4 : Boolean
var $logId; $5 : Object
var $options; $6 : Object
Case of 
	: (Count parameters:C259=6)
		$signal:=$1
		$method:=$2
		$name:=$3
		$isEntity:=$4
		$logId:=$5
		$options:=$6
End case 

Use ($signal)
	$signal.showInterface:=utils_getValueFromObject($options; True:C214; "showInterface")
End use 

var $entity : Object
var $results : Collection

var $pepHandler; $listHandler; $ranHandler : 4D:C1709.Function
$pepHandler:=$options.pepHandler
$listHandler:=$options.listHandler
$ranHandler:=$options.ranHandler

$options.pepHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $pepHandler; This:C1470; $1; $2\
))
$options.listHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $listHandler; This:C1470; $1; $2\
))
$options.ranHandler:=Formula:C1597(\
slold_signalToMainProcess($signal; $ranHandler; This:C1470; $1; $2\
))
$results:=New collection:C1472
EXECUTE METHOD:C1007($method; $results; $name; $isEntity; $logId; $options)

var $entities; $output : Collection
$entities:=New collection:C1472
$output:=New collection:C1472
var $result : Object
For each ($result; $results)
	If ($result.needSave)
		$entities.push($result.entity.toObject(""))
	End if 
	$output.push($result.entity.toObject(""))
End for each 
Use ($signal)
	$signal.entities:=$entities.copy(ck shared:K85:29; $signal)
	$signal.result:=$output.copy(ck shared:K85:29; $signal)
End use 
$signal.trigger()