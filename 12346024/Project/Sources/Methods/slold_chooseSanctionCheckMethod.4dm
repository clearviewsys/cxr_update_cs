//%attributes = {}
// author: Wai-Kin
//sl_chooseSanctionCheckMethod($name : Text; $isEntity : Boolean; \
$logIdPtr : Pointer; $options : Object; $resultPtr : Pointer)

var $name; $1 : Text
var $isEntity; $2 : Boolean
var $logIdPtr; $3 : Pointer
var $options; $4 : Object
var $resultPtr; $5 : Pointer

Case of 
	: (Count parameters:C259=4)
		$name:=$1
		$isEntity:=$2
		$logIdPtr:=$3
		$options:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($0)

var $logId : Object
If ($logIdPtr#Null:C1517)
	$logId:=New object:C1471("table"; Table:C252($logIdPtr); \
		"field"; Field:C253($logIdPtr); \
		"value"; $logIdPtr->)
Else 
	$logId:=New object:C1471()
End if 

C_TEXT:C284($which)
$which:=getKeyValue("sanctionlist.version"; "v2")

Case of 
	: ($which="KYC2020")
		var $inputOptions : Object
		$inputOptions:=New object:C1471(\
			"showInterface"; $options.options.interface; \
			"autoList"; $options.options.autoList; \
			"list"; $options.options.list; \
			"catGroupName"; $options.kyc2020.catGroupName; \
			"searchThreshold"; $options.kyc2020.searchThreshold; \
			"address"; $options.data.address; \
			"idCard"; $options.data.idNumber; \
			"birthday"; $options.data.birthday\
			)
		var $result : Object
		$result:=slold_k20requestSanctionCheck($name; $isEntity; $logId; $inputOptions)
		If ($result.needSave)
			$result.entity.save()
		End if 
		
		If ($result.entity.CheckResult#0)
			slold_k20DisplaySummary($result.entity)
		End if 
		
	: ($which="v2")
		var $inputOptions : Object
		$inputOptions:=New object:C1471(\
			"list"; $options.options.list; \
			"autoList"; $options.options.autoList; \
			"pepHandler"; $options.functions.pepHandler; \
			"listHandler"; $options.functions.listHandler; \
			"ranHandler"; $options.functions.ranHandler; \
			"isAuto"; $options.options.isAuto; \
			"matchType"; $options.options.matchType\
			)
		
		If ($options.options.useWorker)
			var $id : Real
			Use (Storage:C1525)
				If (Not:C34(OB Is defined:C1231(Storage:C1525; "sanctionCheckSignals")))
					Storage:C1525.sanctionCheckSignals:=New shared object:C1526("ids"; 0; "signals"; \
						New shared collection:C1527)
				End if 
			End use 
			Use (Storage:C1525.sanctionCheckSignals)
				
				var $signal : Object
				$signal:=New signal:C1641
				Use ($signal)
					$signal.id:=Storage:C1525.sanctionCheckSignals.ids
					$id:=$signal.id
					$signal.needSave:=True:C214
					Storage:C1525.sanctionCheckSignals.ids:=Storage:C1525.sanctionCheckSignals.ids+1
					Storage:C1525.sanctionCheckSignals.signals.push($signal)
				End use 
			End use 
			CALL WORKER:C1389("Request Sanction Check"; "slold_runWorkerProcess"; \
				$signal; "sl_requestManySanctionChecks"; $name; \
				$isEntity; $logId; $inputOptions)
			If (OB Is defined:C1231(Form:C1466; $options.pointers.sanctionCheckSignals))
				OB Get:C1224(Form:C1466; $options.pointers.sanctionCheckSignals).push($id)
			Else 
				OB SET:C1220(Form:C1466; $options.pointers.sanctionCheckSignals; New collection:C1472($id))
			End if 
			SET TIMER:C645(1)
			$0:=-2
			
		Else 
			
			var $results : Collection
			$results:=slold_requestManySanctionChecks($name; $isEntity; $logId; $inputOptions)
			
			var $entities : 4D:C1709.EntitySelection
			$entities:=ds:C1482.SanctionCheckLog.newSelection()
			
			var $result : Object
			For each ($result; $results)
				If ($result.needSave)
					$result.entity.save()
				End if 
				$entities.add($result.entity)
			End for each 
			
			$0:=slold_displaySanctionListResult($entities; $options.options.interface; \
				$options.pointers.resultIconPtr; $options.pointers.resultTextPtr; \
				$logIdPtr)
		End if 
End case 
