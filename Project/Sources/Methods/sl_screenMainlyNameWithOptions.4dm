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
#DECLARE($isForced : Boolean; $name : Text; $isEntity : Boolean; $logIdPtr : Pointer\
; $options : cs:C1710.SanctionScreeningOptions)->$result : cs:C1710.SanctionListResult

//MARK:- Parameter setup

//C_TEXT($sanctionCheckResult; $name; $tip)

var $pointers; $more : Object

C_POINTER:C301($resultIcon)
C_OBJECT:C1216($more; $pointers)
// $resultIcon:=->latestCheckStatus1

Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
		$isEntity:=False:C215
		$logIdPtr:=->[Customers:3]CustomerID:1
		$options:=cs:C1710.SanctionScreeningOptions.new()
		
	: (Count parameters:C259=1)
		$name:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
		$isEntity:=False:C215
		$logIdPtr:=->[Customers:3]CustomerID:1
		$options:=cs:C1710.SanctionScreeningOptions.new()
		
	: (Count parameters:C259=2)
		$isEntity:=False:C215
		$logIdPtr:=->[Customers:3]CustomerID:1
		$options:=cs:C1710.SanctionScreeningOptions.new()
		
	: (Count parameters:C259=3)
		$logIdPtr:=->[Customers:3]CustomerID:1
		$options:=cs:C1710.SanctionScreeningOptions.new()
		
	: (Count parameters:C259=4)
		$options:=cs:C1710.SanctionScreeningOptions.new()
		
	: (Count parameters:C259=5)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$options.isAuto:=Not:C34($isForced)

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
	$runCheck:=$options.isScreenReady
End if 

If ($runCheck)
	// We must make sure that sanction List checks don't apply for customers that are on Whitelist unless the Whitelisting is expired.
	If ($logIdPtr#Null:C1517)
		$runCheck:=sl_isCustomerSubjectToScreening($logIdPtr->)
	End if 
End if 

If ($runCheck)
	If (Not:C34($isForced))
		$runCheck:=Not:C34($options.hadAutoScreened)
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
	
	
	If ($options.useWorker)
		If ($options.signalName#"")
			//MARK:- Run Screening in a worker process `Request Sanction Check`
			var $signalName : Text
			$signalName:=$options.signalName
			OB SET:C1220(Form:C1466; $signalName; New signal:C1641)
			var $tmp : Object
			$tmp:=OB Get:C1224(Form:C1466; $signalName)
			Use ($tmp)
				$tmp.messages:=New shared collection:C1527
			End use 
			CALL WORKER:C1389("Request Sanction Check"; "sl_runWorkerProcess"; \
				$tmp; $name; $isEntity; $lists; $logId; $options)
		End if 
		
	Else 
		// MARK:- Run Screening in the same process
		var $results : Collection
		$results:=sl_screenWithSanctionListCol($name; $isEntity; $lists; $logId; $options)
		
		// MARK:- Displaying Result
		
		//$match:=slol2_displaySanctionListResult($results; $logIdPtr; $options)
		$result:=cs:C1710.SanctionListResult.new($results)
	End if 
End if 
