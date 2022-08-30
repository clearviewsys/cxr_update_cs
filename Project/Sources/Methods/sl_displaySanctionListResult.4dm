//%attributes = {}
/** From the current selection, display the results

#param $resultParam
the selection to display
#pre the selection has the same name, record and date
#param $logIdPtrParam
the record that has been scan
#param $option
list of option, see sl_createDefaultOptionsObject for default values and keys
*/
#DECLARE($resultParam : Collection; \
$logsIdPtrParam : Pointer; $optionsParam : Object)->$status : Real

// MARK:- Parameter Setup

var $result : Collection
var $logIdPtr : Pointer
var $options; $form : Object
$options:=New object:C1471

$form:=New object:C1471("resultStatus"; 0)  // default value
Case of 
	: (Count parameters:C259=2)
		$result:=$resultParam
		$logIdPtr:=$logsIdPtrParam
	: (Count parameters:C259=3)
		$result:=$resultParam
		$logIdPtr:=$logsIdPtrParam
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARK:- Extract values from options
var $showInterface; $useEmoji; $comfirmReject : Boolean
var $iconPtr; $textPtr : Pointer
$showInterface:=utils_getValueFromObject($options; False:C215; "options"; "interface")
$iconPtr:=utils_getValueFromObject($options; Null:C1517; "pointers"; "resultIconPtr")
$textPtr:=utils_getValueFromObject($options; Null:C1517; "pointers"; "resultTextPtr")
$useEmoji:=utils_getValueFromObject($options; False:C215; "options"; "useEmoji")
$comfirmReject:=utils_getValueFromObject($options; False:C215; "options"; "comfirmReject")

var $v2Only : Collection
var $entity : cs:C1710.SanctionCheckLogEntity
var $kyc2020 : Collection
var $form : Object
var $useCXR : Boolean
var $3rdpartyStatus : Real
var $method : Text

// MARK:- Sort and setup From object by server source
$v2Only:=New collection:C1472
$kyc2020:=New collection:C1472
$useCXR:=False:C215
$3rdpartyStatus:=0
For each ($entity; $result)
	$method:=sl_getSanctionSourceForRecord($entity)
	Case of 
		: ($method="v2")
			$v2Only.push($entity)
			$useCXR:=True:C214
			
		: ($method="KYC2020")
			$kyc2020.push(New object:C1471("shortName"; $entity.SanctionList; \
				"summary"; $entity.ResponseJSON.summary; \
				"details"; $entity.ResponseJSON.details; \
				"fullName"; ds:C1482.SanctionLists.query("ShortName=':1'"; $entity.SanctionList)\
				.first().Description; \
				"date"; $entity.CheckDate; \
				"logId"; $entity.UUID; \
				"tableId"; $entity.internalTableID; \
				"recordId"; $entity.InternalRecordID; \
				"checkResult"; $entity.CheckResult; \
				"responseText"; $entity.ResponseText\
				))
			$3rdpartyStatus:=sl_updateDisplayingLogStatus($3rdpartyStatus; $entity.CheckResult)
			
			//:($method="MemberCheck")
	End case 
End for each 

If ($result.length#0)
	// MARK:- Setup CXRBlacklist server source records
	var $selection : cs:C1710.SanctionCheckLogSelection
	$selection:=ds:C1482.SanctionCheckLog.fromCollection($v2Only)
	$form:=sl_createDisplayResultOptions($selection; $showInterface)
	$selection.drop()  // fromCollection creates unwanted records 
	$form.kyc2020:=$kyc2020
	$form.useCXR:=$useCXR
	$form.resultStatus:=sl_updateDisplayingLogStatus($form.resultStatus; $3rdpartyStatus)
	$entity:=$result[0]
	If ($entity.isEntity)
		$form.titleText:="Entity Matches for "
	Else 
		$form.titleText:="Person Matches for "
	End if 
	
	$form.titleText:=$form.titleText+"\""+$entity.FullName+"\""
	
	// display result
	If ($form.resultStatus#0)
		If ($showInterface)
			C_LONGINT:C283($winRef)
			$winRef:=Open form window:C675("SanctionList")
			DIALOG:C40("SanctionList"; $form)
			CLOSE WINDOW:C154($winRef)
		End if 
		
		// ask for comfirmation as needed
		If ($comfirmReject)
			myConfirm("Sanction check produces a match. Do you want to fix the issue?"; "Ignore and continue"; "Return and Edit")
			If (OK#1)
				REJECT:C38
			End if 
		End if 
	End if 
End if 

// add emoji or image to latest status icon
If ($iconPtr#Null:C1517)
	If ($showInterface)
		sl_setSanctionListCheckIcon($form.resultStatus; $iconPtr; $useEmoji)
	End if 
End if 

// add default message
If ($textPtr#Null:C1517)
	$textPtr->:=sl_getSanctionListResultMsg($form.resultStatus)
End if 

// update [SanctionCheckLog] selection
If ($logIdPtr#Null:C1517)
	QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
	QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
End if 

// return the result status
$status:=$form.resultStatus

