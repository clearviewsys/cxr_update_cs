//%attributes = {}
// Author Wai-Kin
//sl_handleCheckCompleteEvent($logIdPtr : Pointer; $iconPtr : Pointer; $textPtr : Pointer; $options : Object\
)->$completed: Boolean
var $logIdPtr; $1 : Pointer
var $iconPtr; $2 : Pointer
var $textPtr; $3 : Pointer
var $options; $4 : Object
var $completed; $0 : Boolean

$logIdPtr:=->[Customers:3]CustomerID:1
$options:=New object:C1471

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$logIdPtr:=$1
	: (Count parameters:C259=2)
		$logIdPtr:=$1
		$iconPtr:=$2
	: (Count parameters:C259=3)
		$logIdPtr:=$1
		$iconPtr:=$2
		$textPtr:=$3
	: (Count parameters:C259=4)
		$logIdPtr:=$1
		$iconPtr:=$2
		$textPtr:=$3
		$options:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $signalList : Text
var $saveButton : Pointer
var $showInterface : Boolean
$signalList:=utils_getValueFromObject($options; "sanctionCheckSignals"; "sanctionCheckSignals")
$saveButton:=utils_getValueFromObject($options; OBJECT Get pointer:C1124(Object named:K67:5; "b_save"); "save")
$showInterface:=utils_getValueFromObject($options; True:C214; "interface")

$completed:=True:C214
If (OB Is defined:C1231(Form:C1466; $signalList))
	var $signal : Object
	var $notDone : Collection
	$notDone:=New collection:C1472
	var $id : Real
	For each ($id; OB Get:C1224(Form:C1466; $signalList))
		Use (Storage:C1525.sanctionCheckSignals)
			$signal:=Storage:C1525.sanctionCheckSignals.signals.find("sl_findSignalById"; $id; True:C214)
		End use 
		If (OB Is defined:C1231($signal))
			Use ($signal)
				If (OB Is defined:C1231($signal; "messages"))
					While ($signal.messages.length>0)
						var $message : Object
						$message:=OB Copy:C1225($signal.messages.pop())
						$options:=$message.options
						
						var $entity : cs:C1710.SanctionCheckLogEntity
						$entity:=ds:C1482.SanctionCheckLog.new()
						$entity.fromObject($message.entity)
						
						var $searchList : cs:C1710.SanctionListsEntity
						$searchList:=ds:C1482.SanctionLists.query("ShortName = :1"; $message.searchList)
						$message.caller.call($options; $entity; $searchList)
					End while 
				End if 
				
				If ($signal.signaled)
					var $entities : cs:C1710.SanctionCheckLogSelection
					$entities:=ds:C1482.SanctionCheckLog.fromCollection($signal.entities)
					var $entity1 : 4D:C1709.Entity
					For each ($entity1; $entities)
						$entity1.save()
					End for each 
					// #todo buggy
					If ($signal.result.length>0)
						$entities:=ds:C1482.SanctionCheckLog.fromCollection($signal.result)
						slo_displaySanctionListResult($entities; \
							$signal.showInterface; $iconPtr; $textPtr; $logIdPtr)
					End if 
					
					Use (Storage:C1525.sanctionCheckSignals.signals)
						Storage:C1525.sanctionCheckSignals.signals:=Storage:C1525.sanctionCheckSignals.signals.filter("sl_findSignalById"; $id; False:C215)
					End use 
					
				Else 
					$notDone.push($id)
				End if 
			End use 
		End if 
	End for each 
	OB SET:C1220(Form:C1466; $signalList; $notDone)
	
	If (OB Get:C1224(Form:C1466; $signalList).length>0)
		$completed:=False:C215
	Else 
		SET TIMER:C645(0)
	End if 
End if 


If ($saveButton#Null:C1517)
	If ($completed)
		OBJECT SET TITLE:C194($saveButton->; "Save")
	Else 
		OBJECT SET TITLE:C194($saveButton->; "Checks running...")
	End if 
	OBJECT SET ENABLED:C1123($saveButton->; $completed)
End if 
$0:=$completed