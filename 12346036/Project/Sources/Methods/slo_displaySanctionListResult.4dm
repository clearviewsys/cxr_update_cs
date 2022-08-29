//%attributes = {}
//displaySanctionListResults($sanctionList)
//
// Parameters:
// $sanctionList      (C_OBJECT)
// Returns: (C_TEXT)
//     The reason to hold the Customer
// Author: Wai-Kin
//sl_displaySanctionListResult($selection : cs.SanctionCheckLogSelection; $showInterface : Boolean; \
$iconPtr : Pointer; $textPtr : Pointer; \
$logIdPtr : Pointer)->$status : Real
C_OBJECT:C1216($form)

var $selection; $1 : 4D:C1709.EntitySelection
var $showInterface; $2 : Boolean
var $iconPtr; $3 : Pointer
var $textPtr; $4 : Pointer
var $logIdPtr; $5 : Pointer
var $status; $0 : Real

Case of 
	: (Count parameters:C259=1)
		$selection:=$1
	: (Count parameters:C259=2)
		$selection:=$1
		$showInterface:=$2
	: (Count parameters:C259=3)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
	: (Count parameters:C259=4)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
		$textPtr:=$4
	: (Count parameters:C259=5)
		$selection:=$1
		$showInterface:=$2
		$iconPtr:=$3
		$textPtr:=$4
		$logIdPtr:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $v2Only : 4D:C1709.EntitySelection
var $entity : cs:C1710.SanctionCheckLog
$v2Only:=ds:C1482.SanctionCheckLog.newSelection()
var $kyc2020 : Collection
$kyc2020:=New collection:C1472
var $form : Object
var $useCXR : Boolean
$useCXR:=False:C215
var $3rdpartyStatus : Real
$3rdpartyStatus:=0
For each ($entity; $selection)
	var $method : Text
	$method:=sl_getSanctionSourceForRecord($entity)
	Case of 
		: ($method="v2")
			$v2Only.add($entity)
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
	End case 
End for each 

If ($selection.length#0)
	
	$form:=sl_createDisplayResultOptions($v2Only; $showInterface)
	$form.kyc2020:=$kyc2020
	$form.useCXR:=$useCXR
	$form.resultStatus:=sl_updateDisplayingLogStatus($form.resultStatus; $3rdpartyStatus)
	$entity:=$selection.first()
	If ($entity.isEntity)
		$form.titleText:="Entity Matches for "
	Else 
		$form.titleText:="Person Matches for "
	End if 
	
	$form.titleText:=$form.titleText+"\""+$entity.FullName+"\""
	
	If ($form.resultStatus#0)
		If ($showInterface)
			C_LONGINT:C283($winRef)
			$winRef:=Open form window:C675("SanctionList")
			DIALOG:C40("SanctionList"; $form)
			CLOSE WINDOW:C154($winRef)
		End if 
	End if 
End if 

If ($iconPtr#Null:C1517)
	If ($showInterface)
		sl_setSanctionListCheckIcon($form.resultStatus; $iconPtr)
	End if 
End if 

If ($textPtr#Null:C1517)
	$textPtr->:=$form.result
End if 

If ($logIdPtr#Null:C1517)
	QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
	QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
End if 
$0:=$status