//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/28/19, 21:26:55
// ----------------------------------------------------
// Method: getLatestCheckLogStatus
// Description
// 
//
// Parameters
// ----------------------------------------------------



// getLatestCheckLogStatusIcon ($tableNumber; $internalRecordId; ->$iconPtr)
// Gets the latest CheckLogStatusIcon from the SanctionList Check Log

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_TEXT:C284($3; $name)

C_LONGINT:C283($0; $iStatus)  //-1 webservice down, 0=OK pass, 1=no exact match-caution, 2=exact match alert, -9999=not checked

C_TEXT:C284($sql)
C_LONGINT:C283($checkResult; $numRecs)

$iStatus:=0

Case of 
		
	: (Count parameters:C259=3)
		$tableNumber:=$1
		$internalRecordId:=$2
		$name:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


Begin SQL
	SELECT COUNT(*) FROM SanctionCheckLog
	WHERE internalTableID = :$tableNumber AND InternalRecordID = :$internalRecordId  AND FullName = :$name 
	INTO :$numRecs
End SQL

Begin SQL
	SELECT CheckResult FROM SanctionCheckLog
	WHERE internalTableID = :$tableNumber AND InternalRecordID = :$internalRecordId AND FullName = :$name 
	ORDER BY CheckDate DESC, CheckResult DESC LIMIT 1
	INTO :$iStatus
End SQL



If ($numRecs>0)
	$0:=$iStatus
Else 
	$0:=-9999
End if 