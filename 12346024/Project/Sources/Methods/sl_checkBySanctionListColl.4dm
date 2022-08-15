//%attributes = {}
/** Screens name with PII and return result as a collection of objects

#param $nameParam 
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
#DECLARE($nameParam : Text; $isEntityParam : Boolean; $searchListsParam : Collection; \
$logIdParm : Object; $optionsParam : Object)->$results : Collection

// MARK:- Parameter Setup

var $name : Text
var $isEntity : Boolean
var $searchLists : Collection
var $logId : Object
var $options : Object

Case of 
	: (Count parameters:C259=5)
		$name:=$nameParam
		$isEntity:=$isEntityParam
		$searchLists:=$searchListsParam
		$logId:=$logIdParm
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//MARK:- progress bar setup

var $progressBar; $requestListContinue : Boolean
var $requestListCount; $requestListTotal : Real
var $requestListProgress : Integer
$progressBar:=$options.options.interface
$requestListContinue:=True:C214

If ($progressBar)
	$requestListCount:=0
	$requestListTotal:=$searchLists.length
	$requestListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($requestListProgress; 0)
	Progress SET MESSAGE($requestListProgress; "Completed 0 of "+String:C10($requestListTotal))
	Progress SET BUTTON ENABLED($requestListProgress; True:C214)
End if 

$results:=New collection:C1472

var $list : Text
For each ($list; $searchLists) While ($requestListContinue)
	
	// MARK:- Update $progress bar process
	If ($progressBar)
		C_REAL:C285($requestListPrecent)
		$requestListPrecent:=$requestListCount/$requestListTotal
		Progress SET TITLE($requestListProgress; "Checking on sanction list: "+$list)
		Progress SET PROGRESS($requestListProgress; $requestListPrecent)
		Progress SET MESSAGE($requestListProgress; "Completed "+String:C10($requestListCount)+" of "+String:C10($requestListTotal))
		$requestListCount:=$requestListCount+1
		//DELAY PROCESS(Current process;40)
		$requestListContinue:=Not:C34(Progress Stopped($requestListProgress))
	End if 
	
	// MARK:- Setup entities
	var $searchList : cs:C1710.SanctionListsEntity
	$searchList:=ds:C1482.SanctionLists.query("ShortName=:1"; $list).first()
	
	var $entity : cs:C1710.SanctionCheckLogEntity
	var $server : Text
	$server:=sl_getSanctionSourceForRecord($searchList)
	
	var $entity : cs:C1710.SanctionCheckLogEntity
	$entity:=sl_createSanctionCheckLog($name; $isEntity; $server; \
		$searchList.ShortName; $logId)
	
	//MARK:- Check for similar ran today today
	var $history : Object
	var $query : Text
	$query:="FullName = ':1' & isEntity = :2 & "+\
		"CheckDate = :3 & CheckResult # -1 & "+\
		"UseServer = ':4' & SanctionList = ':5'"
	$history:=ds:C1482.SanctionCheckLog.query($query; $name; $isEntity; Current date:C33(*); \
		$searchList.UseServer; $searchList.ShortName)
	
	If ($history.length#0)
		
		//MARK:- Similar test run, so use this instead
		var $last : cs:C1710.SanctionCheckLog
		$last:=$history.first()
		$entity.isSuccessful:=$last.isSuccessful
		$entity.CheckResult:=$last.CheckResult
		$entity.ResponseJSON:=$last.ResponseJSON
		$entity.Details:=$last.Details
	Else 
		
		//MARK:- Sends the name to a sanction screening server
		$list:=sl_getSanctionSourceForRecord($searchList)
		Case of 
			: ($searchList=Null:C1517)
			: ($list="v1")
				
			: ($list="v2")
				sl_pullCXRBlacklistServer($entity; $searchList; $options)
				
			: ($list="KYC2020")
				sl_pullKYC2020Server($entity; $searchList; $options)
				
				//: ($searchList.UseServer="MemberCheck")
				//
		End case 
		
	End if 
	
	// MARK:- execute method for the result
	If ($options.pointers.handleDetailMethod#"")
		If ($options.options.useWorker)
			If ($options.workers.formRef#0)
				CALL FORM:C1391($options.workers.formRef; $options.pointers.handleDetailMethod; \
					$entity.toObject(); $searchList.toObject(); $options)
			End if 
		Else 
			var $result
			EXECUTE METHOD:C1007($options.pointers.handleDetailMethod; $result; \
				$entity.toObject(); $searchList.toObject(); $options)
		End if 
	End if 
	
	// MARK:- Add to Results
	$results.push($entity)
End for each 

// MARK:- Clean up
If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($requestListProgress)
End if   // $progressBar