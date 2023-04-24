//%attributes = {}
// author: Wai-Kin
//sl_chooseSanctionCheckMethod($name : Text; $isEntity : Boolean; \
$logIdPtr : Pointer; $options : Object)

var $name; $1 : Text
var $isEntity; $2 : Boolean
var $logIdPtr; $3 : Pointer
var $options; $4 : Object

Case of 
	: (Count parameters:C259=4)
		$name:=$1
		$isEntity:=$2
		$logIdPtr:=$3
		$options:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $0 : Collection

var $logId : Object
If ($logIdPtr#Null:C1517)
	$logId:=New object:C1471("table"; Table:C252($logIdPtr); \
		"field"; Field:C253($logIdPtr); \
		"value"; $logIdPtr->)
Else 
	$logId:=New object:C1471()
End if 

var $searchLists : cs:C1710.SanctionCheckLogSelection
Case of 
	: ($options.options.manualList="PEP")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = true")
		
	: ($options.options.manualList="SL")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = false")
		
	: ($options.options.list#"")
		$searchLists:=ds:C1482.SanctionLists.query(\
			"ShortName = :1 and IsEnabled = true"; $options.options.list)
		
	: (($options.options.autoType#sl_NoFlag) & ($options.options.isAuto))
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
		C_LONGINT:C283($value)
		C_OBJECT:C1216($remove)
		$remove:=ds:C1482.SanctionLists.newSelection()
		var $entity : cs:C1710.SanctionCheckLogEntity
		For each ($entity; $searchLists)
			If ($entity.isManual)
				C_LONGINT:C283($flags)
				$flags:=$entity.automaticFlags
				If (Not:C34(slold_setOrGetSanctionFlag(->$flags; $options.options.autoType)))
					
					$searchLists:=$searchLists.minus($entity)
				End if 
			End if 
		End for each 
		
	: ($options.options.isAuto)
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true & isManual = false")
		
	Else 
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
End case 

If ($isEntity)
	$searchLists:=$searchLists.query("isPEP = false")
End if 

var $lists : Collection
$lists:=$searchLists.ShortName

var $logId : Object
If ($logIdPtr#Null:C1517)
	$logId:=New object:C1471("table"; Table:C252($logIdPtr); \
		"field"; Field:C253($logIdPtr); \
		"value"; $logIdPtr->)
Else 
	$logId:=New object:C1471()
End if 


If ($options.options.useWorker)
	If ($options.pointers.signalName#"")
		$name:=$options.pointers.signalName
		If (OB Is defined:C1231(Form:C1466; $name))
			
		End if 
		OB SET:C1220(Form:C1466; $name; New signal:C1641)
		var $tmp : Object
		$tmp:=OB Get:C1224(Form:C1466; $name)
		Use ($tmp)
			$tmp.messages:=New shared collection:C1527
		End use 
		CALL WORKER:C1389("Request Sanction Check"; "sl_runWorkerProcess"; \
			$tmp; $name; $isEntity; $lists; $logId; $options)
		$0:=New collection:C1472
	End if 
	//var $id : Real
	//Use (Storage)
	//If (Not(OB Is defined(Storage; "sanctionCheckSignals")))
	//Storage.sanctionCheckSignals:=New shared object("ids"; 0; "signals"; \
														New shared collection)
	//End if
	//End use
	//Use (Storage.sanctionCheckSignals)
	
	//var $signal : Object
	//$signal:=New signal
	//Use ($signal)
	//$signal.id:=Storage.sanctionCheckSignals.ids
	//$id:=$signal.id
	//$signal.needSave:=True
	//Storage.sanctionCheckSignals.ids:=Storage.sanctionCheckSignals.ids+1
	//Storage.sanctionCheckSignals.signals.push($signal)
	//End use
	//End use
	
	//CALL WORKER("Request Sanction Check"; "sl_runWorkerProcess"; \
														$signal; $name; $isEntity; $lists; $logId; $options)
	//If (OB Is defined(Form; $options.pointers.sanctionCheckSignals))
	//OB Get(Form; $options.pointers.sanctionCheckSignals).push($id)
	//Else
	//OB SET(Form; $options.pointers.sanctionCheckSignals; New collection($id))
	//End if
	//SET TIMER(1)
Else 
	var $results : Collection
	$results:=sl_screenWithSanctionListCol($name; $isEntity; $lists; $logId; $options)
	
	// used in old method slold_k20requestSanctionCheck
	//var $data : Collection
	//$data:=New collection
	
	//var $result : Object
	//For each ($result; $results)
	//If ($result.needSave)
	//$entity:=ds.SanctionCheckLog.new()
	//$entity.fromObject($result.entity)
	//$entity.save()
	//End if
	//$data.push($result)
	//End for each
	
	$0:=$results
End if 