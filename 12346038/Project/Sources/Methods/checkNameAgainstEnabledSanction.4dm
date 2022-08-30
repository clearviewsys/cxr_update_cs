//%attributes = {}
// checkNameAgainstEnabledSanction($fullName;$internalTableID; $internalRecordID;{$iconPtr;$onHoldField;$onHoldNote})
// check against all enabled sanction list
// Author: Wai-Kin

C_TEXT:C284($1; $fullName)
C_LONGINT:C283($2; $internalTableID)
C_TEXT:C284($3; $internalRecordID)
C_POINTER:C301($4; $iconPtr)
C_POINTER:C301($5; $onHoldFieldPtr)
C_POINTER:C301($6; $onHoldNotePtr)
C_BOOLEAN:C305($7; $isEntity)

Case of 
	: (Count parameters:C259=3)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=Null:C1517
		$onHoldFieldPtr:=Null:C1517
		$onHoldNotePtr:=Null:C1517
		$isEntity:=False:C215
	: (Count parameters:C259=4)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=$4
		$onHoldFieldPtr:=Null:C1517
		$onHoldNotePtr:=Null:C1517
		$isEntity:=False:C215
	: (Count parameters:C259=6)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=$4
		$onHoldFieldPtr:=$5
		$onHoldNotePtr:=$6
		$isEntity:=False:C215
		
	: (Count parameters:C259=7)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=$4
		$onHoldFieldPtr:=$5
		$onHoldNotePtr:=$6
		$isEntity:=$7
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($pep)

// #ORDA
$pep:=ds:C1482.SanctionLists.query("IsEnabled = true && ShortName # 'PEP'")
If ($pep.length#0)
	C_TEXT:C284($message)
	$message:=checkNameAgainstSanctionList(True:C214; $fullName; $internalTableID; $internalRecordID; $iconPtr; ""; $isEntity)
	If ($message#"")
		$onHoldFieldPtr->:=True:C214
		$onHoldNotePtr->:=$message
	End if 
Else 
	myAlert("No sanction lists enabled")
End if 