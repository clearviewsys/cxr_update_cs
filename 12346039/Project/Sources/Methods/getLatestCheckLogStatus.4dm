//%attributes = {}
// getLatestCheckLogStatusIcon ($tableNumber; $internalRecordId; $name):  status
// Gets the latest CheckLogStatus from the SanctionList Check Log
// #ORDA  by TB

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_TEXT:C284($3; $name)

C_LONGINT:C283($0; $iStatus)  //-1 webservice down, 0=OK pass, 1=no exact match-caution, 2=exact match alert, -9999=not checked

C_LONGINT:C283($checkResult; $numRecs; $iStatus)

$iStatus:=0

Case of 
	: (Count parameters:C259=0)
		$tableNumber:=Table:C252(->[Customers:3])
		$internalRecordId:="QSCUS1029203"
		$name:="Jaime Alvarez"
		
	: (Count parameters:C259=3)
		$tableNumber:=$1
		$internalRecordId:=$2
		$name:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($entitySel)
$entitySel:=ds:C1482.SanctionCheckLog.query("internalTableID = :1 AND InternalRecordID = :2 AND FullName = :3"; $tableNumber; $internalRecordId; $name)

If ($entitySel#Null:C1517)
	$numRecs:=$entitySel.length
End if 

If ($numRecs>0)
	$iStatus:=$entitySel.orderBy("CheckDate desc")[0].CheckResult  // makes it faster to do this in if statement
	$0:=$iStatus
Else 
	$0:=-9999
End if 