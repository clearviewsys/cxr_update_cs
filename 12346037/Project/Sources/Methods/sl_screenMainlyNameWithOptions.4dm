//%attributes = {}
/* handle name with other optional PII screening. 
#param $isForceParam
        check no matter what or check only as server prefs
#param $nameParam
        name to be screen
#param $logIdPtrParam
       the assoicated table record with the [SanctionCheckLog] record
#param $optionsParam
       list of option, see sl_createDefaultOptionsObject for default values and keys
#return the result status
#author @Wai-Kin
*/
#DECLARE($isForcedParam : Boolean; $nameParam : Text; $isEntityParam : Boolean; $logIdPtrParam : Pointer\
; $optionsParam : Object)->$match : Integer

//MARK:- Parameter setup

//C_TEXT($sanctionCheckResult; $name; $tip)

var $isForced; $isEntity : Boolean
var $name : Text
var $logIdPtr : Pointer
var $options; $pointers; $more : Object

C_LONGINT:C283($match)
C_BOOLEAN:C305($isForced)
C_TEXT:C284($name)
C_BOOLEAN:C305($isEntity)
C_POINTER:C301($logIdPtr; $resultIcon)
C_OBJECT:C1216($more; $options; $pointers)
$isForced:=False:C215
$logIdPtr:=->[Customers:3]CustomerID:1
$isEntity:=False:C215
$resultIcon:=->latestCheckStatus1

$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)

$options:=sl_createDefaultOptionsObject($isForced)
Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
		
	: (Count parameters:C259=1)
		$isForced:=$isForcedParam
		
	: (Count parameters:C259=2)
		$isForced:=$isForcedParam
		$name:=$nameParam
		
	: (Count parameters:C259=3)
		$isForced:=$isForcedParam
		$name:=$nameParam
		$isEntity:=$isEntityParam
		
	: (Count parameters:C259=4)
		$isForced:=$isForcedParam
		$name:=$nameParam
		$isEntity:=$isEntityParam
		$logIdPtr:=$logIdPtrParam
		
	: (Count parameters:C259=5)
		$isForced:=$isForcedParam
		$name:=$nameParam
		$isEntity:=$isEntityParam
		$logIdPtr:=$logIdPtrParam
		$options:=utils_setupObjectProperties($options; $optionsParam)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$tip:=""
//clearPictureField ($resultIcon)
//OBJECT SET HELP TIP(*;"latestCheckStatus1";$tip)

//C_TEXT($resultWithoutPEP)
//$resultWithoutPEP:=""

//MARK:- See if screening is needed

var $runCheck : Boolean

$runCheck:=($isForced | <>doCheckSanctionLists)

If ($runCheck)
	$runCheck:=stringHasMinimumLength($name; 3)
End if 

If ($runCheck)
	$runCheck:=utils_getValueFromObject($options; True:C214; "options"; "namePartsFilled")
End if 

If ($runCheck)
	// We must make sure that sanction List checks don't apply for customers that are on Whitelist unless the Whitelisting is expired.
	If ($logIdPtr#Null:C1517)
		$runCheck:=sl_isCustomerSubjectToScreening($logIdPtr->)
	End if 
End if 

var $data : Collection
If ($runCheck)
	
	//MARK:- Name Screening Setup
	var $lists : Collection
	$lists:=sl_chooseSLCollByOption($isEntity; $options)
	
	// convert field into an object for worker process
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
			//MARK:- Run Screening in a worker process `Request Sanction Check`
			var $signalName : Text
			$signalName:=$options.pointers.signalName
			If (OB Is defined:C1231(Form:C1466; $signalName))
				
			End if 
			OB SET:C1220(Form:C1466; $signalName; New signal:C1641)
			var $tmp : Object
			$tmp:=OB Get:C1224(Form:C1466; $signalName)
			Use ($tmp)
				$tmp.messages:=New shared collection:C1527
			End use 
			CALL WORKER:C1389("Request Sanction Check"; "sl_runWorkerProcess"; \
				$tmp; $name; $isEntity; $lists; $logId; $options)
			$match:=0
		End if 
	Else 
		
		// MARK:- Run Screening in the same process
		var $results : Collection
		$results:=sl_checkBySanctionListColl($name; $isEntity; $lists; $logId; $options)
		
		// MARK:- Displaying Result
		$match:=sl_displaySanctionListResult($results; $logIdPtr; $options)
	End if 
End if 
