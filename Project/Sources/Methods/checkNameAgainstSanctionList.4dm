//%attributes = {}
//checkNameAgainstSanctionList ($isForced;$name;$internalTableID;$internalRecordID;{$iconPtr;$useList;$isEntity;$queryString}
//
// Check the current selected a name against a sanction list and log it, you should call one of these instead:
// prepCustomerSanctionChecks (which calls handleSanctionListDropDown which call this method)
// checkNameAgainstPEP
// checkNameAgainstEnabledSanction
// automateSanctionChecks
//
// Paramteters:
// $isForced: if false, use <>doCheckSanctionLists to decide if the tests should run, otherwise always run
// $name: the full name to check
// $internalTableID, $internalRecordID: which table and id is being logged
// $iconPtr: the picture icon to display pass, alert or error
// $useList: the name of the list to use (see below for detail)
// $isEntity: true if name is a company, otherwise the name is a person
// $queryString: the ds.SanctionList.query() string to use (see below for detail)
// Author: Wai-Kin

// Example Usages:
// checkNameAgainstSanctionList(true,$fullname,$tableId, $recordId, $icon, "PEP", $isEntity)
// checkNameAgainstSanctionList(true,$fullname,$tableId, $recordId, $icon, "", $isEntity, "IsEnabled = True")

C_TEXT:C284($0; $onHoldMessage)
C_BOOLEAN:C305($1; $isForced)
C_TEXT:C284($2; $name)
C_LONGINT:C283($3; $internalTableID)
C_TEXT:C284($4; $internalRecordID)
C_POINTER:C301($5; $iconPtr)
C_TEXT:C284($6; $useList)
C_BOOLEAN:C305($7; $isEntity)
C_TEXT:C284($8; $queryString)

Case of 
	: (Count parameters:C259=4)
		$isForced:=$1
		$name:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$iconPtr:=Null:C1517
		$useList:=""
		$isEntity:=False:C215
		$queryString:=""
	: (Count parameters:C259=5)
		$isForced:=$1
		$name:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$iconPtr:=$5
		$useList:=""
		$isEntity:=False:C215
		$queryString:=""
	: (Count parameters:C259=6)
		$isForced:=$1
		$name:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$iconPtr:=$5
		$useList:=$6
		$isEntity:=False:C215
		$queryString:=""
	: (Count parameters:C259=7)
		$isForced:=$1
		$name:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$iconPtr:=$5
		$useList:=$6
		$isEntity:=$7
		$queryString:=""
	: (Count parameters:C259=8)
		$isForced:=$1
		$name:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$iconPtr:=$5
		$useList:=""
		$isEntity:=$7
		$queryString:=$8
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($queryString="")
	$queryString:="IsEnabled = True and ShortName # 'PEP'"
End if 

C_BOOLEAN:C305($runTests)
If ($isForced)
	$runTests:=True:C214
Else 
	$runTests:=<>doCheckSanctionLists
End if 

If ($runTests)
	$runTests:=stringHasMinimumLength($name; 3)
End if 

// TODO display the existed version if found

If ($runTests)
	C_OBJECT:C1216($inputs)
	$inputs:=New object:C1471
	$inputs.name:=$name
	$inputs.isEntity:=$isEntity
	C_LONGINT:C283($tableNum)
	$inputs.internalTableId:=$internalTableID
	$inputs.internalRecordId:=$internalRecordID
	
	C_COLLECTION:C1488($lists)
	$lists:=New collection:C1472
	If ($useList#"")
		$lists.push($useList)
	Else 
		C_OBJECT:C1216($entities)
		$entities:=ds:C1482.SanctionLists.query($queryString)
		$lists:=$entities.ShortName
	End if 
	C_REAL:C285($status)
	C_BOOLEAN:C305($onHold)
	C_TEXT:C284($result)
	$result:=checkInputToSanctionLists($inputs; $lists; ->$status; True:C214; ->$onHold)
	$0:=$result
	If ($iconPtr#Null:C1517)
		sl_setSanctionListCheckIcon($status; $iconPtr)
	End if 
	C_TEXT:C284($internalRecordID)
	C_LONGINT:C283($tableNum)
	$internalRecordID:=$internalRecordID
	$tableNum:=$internalTableID
	If ($internalRecordID#"")
		getAllCheckLogByID($tableNum; $internalRecordID)
	End if 
Else 
	clearPictureField($iconPtr)
End if 
