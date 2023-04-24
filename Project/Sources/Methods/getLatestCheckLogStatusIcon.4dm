//%attributes = {}
// getLatestCheckLogStatusIcon ($tableNumber; $internalRecordId; ->$iconPtr)
// Gets the latest CheckLogStatusIcon from the SanctionList Check Log
// #ORDA by TB

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_POINTER:C301($3; $iconPtr)
C_TEXT:C284($4; $name)
C_PICTURE:C286($picture)

C_LONGINT:C283($checkResult; $numRecs)

Case of 
	: (Count parameters:C259=0)
		$tableNumber:=Table:C252(->[Customers:3])
		$internalRecordId:="QSCUS1029203"
		$iconPtr:=->$picture
		$name:="Jaime Alvarez"
		
	: (Count parameters:C259=4)
		$tableNumber:=$1
		$internalRecordId:=$2
		$iconPtr:=$3
		$name:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($entitySel)
$entitySel:=ds:C1482.SanctionCheckLog.query("internalTableID = :1 AND InternalRecordID = :2 AND FullName = :3"; $tableNumber; $internalRecordId; $name)

If ($entitySel#Null:C1517)
	$numRecs:=$entitySel.length
End if 

If (Not:C34(Is nil pointer:C315($iconPtr)))
	clearPictureField($iconPtr)
	
	If ($numRecs>0)
		$checkResult:=$entitySel.orderBy("CheckDate desc")[0].CheckResult  // makes it faster to do this in if statement
		sl_setSanctionListCheckIcon($checkResult; $iconPtr)
	End if 
End if 
