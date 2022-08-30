//%attributes = {}
// checkNameAgainstPEP($fullName;$internalTableID; $internalRecordID;{$iconPtr;$onHoldField;$onHoldNote})
// check against PEP (will become complicated with setting risk rating
// Author: Wai-Kin

C_TEXT:C284($1; $fullName)
C_LONGINT:C283($2; $internalTableID)
C_TEXT:C284($3; $internalRecordID)
C_POINTER:C301($4; $iconPtr)
C_POINTER:C301($5; $onHoldFieldPtr)
C_POINTER:C301($6; $onHoldNotePtr)

Case of 
	: (Count parameters:C259=3)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=Null:C1517
		$onHoldFieldPtr:=Null:C1517
		$onHoldNotePtr:=Null:C1517
	: (Count parameters:C259=4)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=$4
		$onHoldFieldPtr:=Null:C1517
		$onHoldNotePtr:=Null:C1517
	: (Count parameters:C259=6)
		$fullName:=$1
		$internalTableID:=$2
		$internalRecordID:=$3
		$iconPtr:=$4
		$onHoldFieldPtr:=$5
		$onHoldNotePtr:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($pep)
// #ORDA
$pep:=ds:C1482.SanctionLists.query("IsEnabled = true && ShortName = 'PEP'")
If ($pep.length#0)
	C_TEXT:C284($message)
	$message:=checkNameAgainstSanctionList(True:C214; $fullName; $internalTableID; $internalRecordID; $iconPtr; "PEP")
	If ($message#"")
		$onHoldFieldPtr->:=True:C214
		$onHoldNotePtr->:=$message
	End if 
Else 
	myAlert("PEP is not active")
End if 