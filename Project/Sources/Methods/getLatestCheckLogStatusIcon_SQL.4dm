//%attributes = {}
// getLatestCheckLogStatusIcon ($tableNumber; $internalRecordId; ->$iconPtr)
// Gets the latest CheckLogStatusIcon from the SanctionList Check Log

C_LONGINT:C283($1; $tableNumber)
C_TEXT:C284($2; $internalRecordId)
C_POINTER:C301($3; $iconPtr)
C_TEXT:C284($4; $name)

C_TEXT:C284($sql)
C_LONGINT:C283($checkResult; $numRecs)

Case of 
		
	: (Count parameters:C259=4)
		$tableNumber:=$1
		$internalRecordId:=$2
		$iconPtr:=$3
		$name:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (False:C215)  // this code is buggy throwing errors
	Begin SQL
		SELECT COUNT(*) FROM SanctionCheckLog
		WHERE internalTableID = :$tableNumber AND InternalRecordID = :$internalRecordId  AND FullName = :$name
		INTO :$numRecs
	End SQL
	
	Begin SQL
		SELECT CheckResult FROM SanctionCheckLog
		WHERE internalTableID = :$tableNumber AND InternalRecordID = :$internalRecordId AND FullName = :$name
		ORDER BY CheckDate DESC, CheckResult DESC LIMIT 1
		INTO :$checkResult
	End SQL
	
	clearPictureField($iconPtr)
	
	If ($numRecs>0)
		sl_setSanctionListCheckIcon($checkResult; $iconPtr)
	End if 
End if 








