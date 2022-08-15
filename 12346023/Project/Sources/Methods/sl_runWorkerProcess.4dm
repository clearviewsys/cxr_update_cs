//%attributes = {}
/** Worker Process to run `sl_checkBySanctionListColl`

#param $signalParam
       process signal#param $nameParam 
       the name to screen
#param $isEntityParam
       is the name a company name?
#param $searchListsParam
       the collection of sanction list name
#param $logIdParam
       the table record assoicated with [SanctionCheckLog] record, with to properties
     - table = the name of the table record
     - field = the name of the table id field
     - value = the value in the field
#param $option
       list of option, see sl_createDefaultOptionsObject for default values and keys
#return an collection of sanctionlist records
#author @wai-kin
*/
#DECLARE($signalParam : Object; $nameParam : Text; $isEntityParam : Boolean; \
$searchListParam : Collection; $logIdParam : Object; $optionsParam : Object)
var $signal : Object
var $name : Text
var $isEntity : Boolean
var $searchList : Collection
var $logId : Object
var $options : Object

$signal:=$signalParam
$name:=$nameParam
$isEntity:=$isEntityParam
$searchList:=$searchListParam
$logId:=$logIdParam
$options:=$optionsParam


//var $pepHandler; $listHandler; $ranHandler : 4D.Function
//$pepHandler:=$options.functions.pepHandler
//$listHandler:=$options.functions.listHandler
//$ranHandler:=$options.functions.ranHandler

//$options.functions.pepHandler:=Formula(\
slold_signalToMainProcess($signal; $pepHandler; This; $1; $2\
))
//$options.functions.listHandler:=Formula(\
slold_signalToMainProcess($signal; $listHandler; This; $1; $2\
))
//$options.functions.ranHandler:=Formula(\
slold_signalToMainProcess($signal; $ranHandler; This; $1; $2\
))

sl_checkBySanctionListColl($name; $isEntity; $searchList; $logId; $options)

$signal.trigger()

